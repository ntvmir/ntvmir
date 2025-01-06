<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="tengry.northgas.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="oracle.sql.*" %>



<% String pageId = "comp.faq.themes"; %>
<%@ include file="/admin/inc/authorize.jsp"%>


<%!
	boolean equal( String s1, String s2, JspWriter out ) throws Exception
	{
		if( s1 == null ) s1 = "";
		if( s2 == null ) s2 = "";
		return s1.equals( s2 );
	}
%>

<%!
	void clearFrontEntries()
	{
		WebApp.getApp().put( "FRONT_NEWS_R", null );
		WebApp.getApp().put( "FRONT_NEWS_E", null );
		WebApp.getApp().put( "FRONT_VOTE_R", null );
		WebApp.getApp().put( "FRONT_VOTE_E", null );
		WebApp.getApp().put( "FRONT_HOT_R", null );
		WebApp.getApp().put( "FRONT_HOT_E", null );
		WebApp.getApp().put( "FRONT_FAQ_R", null );
		WebApp.getApp().put( "FRONT_FAQ_E", null );
	}
%>


<%
// определим все полученные параметры
String lang = request.getParameter( "lang" );
if ( lang == null )	lang	= "";
String action = request.getParameter( "action" );
String folder		= request.getParameter("folder");
String pageNum		= request.getParameter("pageNum");
String categoryId		= request.getParameter("id");
String messageId		= request.getParameter("messageId");
String question	= request.getParameter("question");
String name	= request.getParameter("name");
String country	= request.getParameter("country");
String city	= request.getParameter("city");
String eMail	= request.getParameter("eMail");
String answerName	= request.getParameter("answerName");
String answerTitle	= request.getParameter("answerTitle");
String answer	= request.getParameter("answer");
String comments	= request.getParameter("comments");
String isPublished	= request.getParameter("isPublished");
String isActual	= request.getParameter("isActual");
String category	= request.getParameter("category");
String[] fms	= request.getParameterValues( "message" );

String	href	= "faqs.jsp?mode=error&id="+categoryId+"&lang="+lang;
// инициируем событие определенного типа

// обрабатываем событие и отображаем подходящее представление
if( action != null && action.equals( "edit_message" ) )
{
	FAQ	fm	= new FAQ();
	try
	{
		boolean isModifying = true;
		boolean isPublic = false;
		boolean isUnpubl = false;
		
		boolean	haveToSendEMail	=  false;
		fm.load( Long.parseLong( messageId ) );
		
		if(	equal( fm.getName(), name, out ) &&
			equal( fm.getCountry(), country, out ) &&
			equal( fm.getCity(), city, out ) &&
			equal( fm.getEMail(), eMail, out ) &&
			equal( fm.getAnswerName(), answerName, out ) &&
			equal( fm.getAnswerTitle(), answerTitle, out ) &&
			equal( fm.getComments(), comments, out ) &&
			equal( fm.getQuestion(), question, out ) &&
			equal( fm.getAnswer(), answer, out ) &&
			equal( "" + fm.isActual(), isActual, out ) &&
			fm.getCategory() == Long.parseLong( category ) ) isModifying = false;

		if( isModifying && ! isW( pageAccessCode ))
		{
			response.sendRedirect( "faqs.jsp?id="+categoryId+"&mode=folder&folder="+folder+"&pageNum="+pageNum+"&lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
			
		
		fm.setName( name );
		fm.setCountry( country );
		fm.setCity( city );
		fm.setEMail( eMail );
		fm.setAnswerName( answerName );
		fm.setAnswerTitle( answerTitle );
		fm.setAnswerDate( new java.util.Date() );
		fm.setComments( comments );
		fm.setCategory( Long.parseLong( category ) );
		
		if ( isPublished != null && isPublished.equals( "1" ) )
		{
			if( ! isP( pageAccessCode ))
			{
				response.sendRedirect( "faqs.jsp?id="+categoryId+"&mode=folder&folder="+folder+"&pageNum="+pageNum+"&lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			if ( fm.isPublished() != 1 ){
				haveToSendEMail	= true;
				isPublic = true;
			}
			fm.setPublished( 1 );
		}
		else
		{
			if( ! isP( pageAccessCode ) && fm.isPublished() == 1 )
			{
				response.sendRedirect( "faqs.jsp?id="+categoryId+"&mode=folder&folder="+folder+"&pageNum="+pageNum+"&lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			if( fm.isPublished() == 1 ) isUnpubl = true;
			fm.setPublished( 2 );
		}
		fm.setQuestion( question );
		fm.setAnswer( answer );
		if ( isActual != null && isActual.equals( "1" ) )
		{
			fm.setActual( 1 );
			if ( lang.equals( "E" ) )	FAQ.dropActual( "E" );
				else FAQ.dropActual( "R" );
		}
		else
		{
			fm.setActual( 0 );
		}
		fm.save();
		if( isModifying )
			try{ Journal.newRecord( currentAdmin, fm, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( WebException e ){}
		if( isPublic )
			try{ Journal.newRecord( currentAdmin, fm, pageId, Journal.ACTION_PUBLIC, "" ).save(); }catch( Exception e ){}
		if( isUnpubl )
			try{ Journal.newRecord( currentAdmin, fm, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}
		
		if ( eMail != null && eMail.length() != 0 && haveToSendEMail && answer != null && answer.length() != 0 )
		{
			//здесь отсылка мыла
			Mailer	mail	= new Mailer();
			mail.setRecipient( eMail );
			mail.setSubject( lang.equals( "E" )? "Norilsk Nickel. Answer to your question." : "Норильский никель. Ответ на Ваш вопрос." );
			String body = null;
			
			String weburl = WebApp.getApp().getProperty( "www.address" );
			if( weburl == null || weburl.length() == 0 ) weburl="http://www.ngk.ru/";
			
			if( ! weburl.startsWith( "http://" ))  weburl = "http://" + weburl;
			if( ! weburl.endsWith( "/" )) weburl += "/";
			
			if( lang.equals("E") )
			{
				body = "Your question has been answered and published.<BR><BR>Question:<BR>"+
						question+
						"<BR><BR>Answer:<BR>"+
						answer +
						"<BR><a href=\"" + weburl + "faq/faq.jsp?mode=faq&faqId=" + fm.getId() + "&id=" + categoryId +"&lang=E\" target=\"_blank\">" + weburl + "faq/faq.jsp?mode=faq&amp;faqId=" + fm.getId() + "&amp;id=" + categoryId + "&amp;lang=E</a>" +
						"<BR><BR>\n"+
						"JSC MMC \"Norilsk nickel\" Team";
			}
			else
			{
				body = "Администрация сайта ответила на Ваш вопрос и опубликовала его на сайте<BR><BR>Вопрос:<BR>" +
						question+
						"<BR><BR>Ответ:<BR>\n"+
						answer +
						"<BR><a href=\"" + weburl + "faq/faq.jsp?mode=faq&faqId=" + fm.getId() + "&id=" + categoryId +"\" target=\"_blank\">" + weburl + "faq/faq.jsp?mode=faq&amp;faqId=" + fm.getId() + "&amp;id=" + categoryId + "</a>" +
						"<BR><BR>\n"+
						"Администрация сайта ОАО \"ГМК \"Норильский никель\"";
			}
			mail.setBody( body );
			try
			{
				mail.send();
				href	= "faqs.jsp?id="+categoryId+"&mode=folder&folder="+folder+"&pageNum="+pageNum+"&lang="+lang;
			}catch( Exception e1 )
			{
				href	= "faqs.jsp?mode=error&reason=mail_failed&id="+categoryId+"&lang="+lang;
			}
		}
		else
		{
			href	= "faqs.jsp?id="+categoryId+"&mode=folder&folder="+folder+"&pageNum="+pageNum+"&lang="+lang;
		}
	}catch(Exception e)
	{
		href	= "faqs.jsp?mode=error&id="+categoryId+"&lang="+lang;
	}
}
else if( action != null && action.equals( "del_messages" ) )
{
	try
	{
		if ( fms != null )
		{
			for (int i=0; i< fms.length ;i++)
			{
				if( ! isC( pageAccessCode ))
				{
					response.sendRedirect( "faqs.jsp?id="+categoryId+"&mode=folder&folder="+folder+"&pageNum="+pageNum+"&lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
					return;
				}
				FAQ	fm	= new FAQ();
				fm.load( Long.parseLong( fms[i] ) );
				
				if( fm.isPublished() == 1 && ! isP( pageAccessCode ))
				{
					response.sendRedirect( "faqs.jsp?id="+categoryId+"&mode=folder&folder="+folder+"&pageNum="+pageNum+"&lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
					return;
				}
				question	= fm.getQuestion();
				Journal rec = Journal.newRecord( currentAdmin, fm, pageId, Journal.ACTION_DELETE, "" );
				fm.remove();
				try{ rec.save(); }catch( Exception e ){}
			}
		}
		href	= "faqs.jsp?id="+categoryId+"&mode=folder&folder="+folder+"&pageNum="+pageNum+"&lang="+lang;
	}catch(WebException e)
	{
		href	= "faqs.jsp?err=" + WebApp.PAGE_ERROR_WHILE_REMOVING + "&id="+categoryId+"&lang="+lang;
	}
}
else
{
	// не найдено подходящее событие
	href	= "faqs.jsp?id="+categoryId+"&lang="+lang;
}

// invalidate cached values
clearFrontEntries();

response.sendRedirect( href );
%>