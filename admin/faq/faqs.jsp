<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

<%@ page import="tengry.northgas.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="java.util.*" %>



<% String pageId = "comp.faq.themes"; %>
<%@ include file="/admin/inc/authorize.jsp"%>




<%
    response.setHeader( "Pragma", "no-cache" );
%>
<%!
	//переменные для постраничного вывода
	private static long	pageSize	= 10;
	private static long	scrollSize	= 10;

	//функция вывода темы форума
	private void drawFolders( JspWriter out, FAQCategory	fc, String lang ) throws IOException
	{
		Connection 			con  	= null;
		PreparedStatement	stmt	= null;
		ResultSet	rs	= null;

		long	newMessages	=	0;
		long	isPublishMessages	= 0;
		long	isntPublishMessages	= 0;
		try
		{
			con	 = WebApp.getConnection();
			stmt = con.prepareStatement( "SELECT COUNT(*) FROM faq_question WHERE faq_category#="+fc.getId()+" AND isPublished='0'" );
			rs	= stmt.executeQuery();
			if ( rs.next() ) {
				newMessages	= rs.getLong( 1 );
			}
			try { rs.close(); } catch (Exception e) {} finally { rs = null; }
			try { stmt.close(); } catch (Exception e) {} finally { stmt = null; }
			
			stmt = con.prepareStatement( "SELECT COUNT(*) FROM faq_question WHERE faq_category#="+fc.getId()+" AND isPublished='1'" );
			rs	= stmt.executeQuery();
			if ( rs.next() )
			{
				isPublishMessages	= rs.getLong( 1 );
			}
			try { rs.close(); } catch (Exception e) {} finally { rs = null; }
			try { stmt.close(); } catch (Exception e) {} finally { stmt = null; }
			
			stmt = con.prepareStatement( "SELECT COUNT(*) FROM faq_question WHERE faq_category#="+fc.getId()+" AND isPublished='2'" );
			rs	= stmt.executeQuery();
			if ( rs.next() )
			{
				isntPublishMessages	= rs.getLong( 1 );
			}
			out.println("<TABLE BORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"1\" WIDTH=\"620\">");
			out.println("<TR BGCOLOR=\"#C0C0C0\">");
			out.println("<TD HEIGHT=\"20\" CLASS=\"titnew\" COLSPAN=\"2\" ALIGN=\"center\"><DIV STYLE=\"padding-left:6px;padding-right:6px\" CLASS=\"titnew\"><B>");
			out.println("Вопросы-Ответы");
			out.println("</B></DIV></TD>");
			out.println("</TR>");

			out.println("<TR>");
			out.println("<TD HEIGHT=\"20\" CLASS=\"c2\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("Папка");
			out.println("</B></DIV></TD>");
			out.println("<TD HEIGHT=\"20\" WIDTH=\"1%\" CLASS=\"c2\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("<NOWRAP>сообщений</NOWRAP>");
			out.println("</B></DIV></TD>");
			out.println("</TR>");

			out.println("<TR>");
			out.println("<TD HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
			out.print( "<A HREF=\"faqs.jsp?id="+fc.getId()+"&mode=folder&folder=new&lang="+lang+"\">Новые сообщения</A>" );
			out.println("</DIV></TD>");
			out.println("<TD HEIGHT=\"20\" WIDTH=\"1%\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
			out.print( newMessages );
			out.println("</DIV></TD>");
			out.println("</TR>");
			out.println("<TR>");
			out.println("<TD HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
			out.print( "<A HREF=\"faqs.jsp?id="+fc.getId()+"&mode=folder&folder=isPublishMessages&lang="+lang+"\">Опубликованные сообщения</A>" );
			out.println("</DIV></TD>");
			out.println("<TD HEIGHT=\"20\" WIDTH=\"1%\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
			out.print( isPublishMessages );
			out.println("</DIV></TD>");
			out.println("</TR>");
			out.println("<TR>");
			out.println("<TD HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
			out.println( "<A HREF=\"faqs.jsp?id="+fc.getId()+"&mode=folder&folder=isntPublishMessages&lang="+lang+"\">Неопубликованные сообщения</A>" );
			out.println("</DIV></TD>");
			out.println("<TD HEIGHT=\"20\" WIDTH=\"1%\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
			out.print( isntPublishMessages );
			out.println("</DIV></TD>");
			out.println("</TR>");

			out.println("</TABLE>");

			out.println( "<BR><A HREF=\"faq_category.jsp?lang="+lang+"\">Темы Вопросов-Ответов</A>" );

		}catch( Exception e ) {
			out.print( "Exception^"+e );
		} finally {
			try	{
				try { rs.close(); } catch (Exception e) {} finally { rs = null; }
				try { stmt.close(); } catch (Exception e) {} finally { stmt = null; }
				if ( con != null ) {
					con.close();
					con = null;
				}
			} catch( Exception e ) {}
		}
		out.println( "" );
	}

	//функция вывода темы форума
	private void showMessage( JspWriter out, String name, String country, String eMail, String answerName, String answerTitle, String question, String answer, String isPublished, java.util.Date askDate, long messageId, long categoryId, long isPublishedMessage, long pageNum, String lang ) throws IOException
	{
		java.util.Calendar	date	= java.util.Calendar.getInstance();
		date.setTime( askDate );
		String	year	= String.valueOf( date.get( java.util.Calendar.YEAR ) );
		String	month	= String.valueOf( date.get( java.util.Calendar.MONTH )+1 );
		if ( month.length() == 1 ) month	= "0"+month;
		String	day		= String.valueOf( date.get( java.util.Calendar.DAY_OF_MONTH ) );
		if ( day.length() == 1 ) day	= "0"+day;
		String	hour		= String.valueOf( date.get( java.util.Calendar.HOUR_OF_DAY ) );
		if ( hour.length() == 1 ) hour	= "0"+hour;
		String	minute		= String.valueOf( date.get( java.util.Calendar.MINUTE ) );
		if ( minute.length() == 1 ) minute	= "0"+minute;
		String	recordDate	= day+"."+month+"."+year+" "+hour+":"+minute;
		
		if ( question.length() > 200 )
		{
			int index	= question.indexOf( " ", 200 );
			if ( index == -1)	index	= 200;
			question	= question.substring( 0, index )+"... ";
		}
		else
		{
			question	+= "... ";
		}
		if ( answer.length() > 200 )
		{
			int index	= answer.indexOf( " ", 200 );
			if ( index == -1)	index	= 200;
			answer	= answer.substring( 0, index )+"... ";
		}
		else
		{
			answer	+= "... ";
		}

		String folder	= "new";
		if ( isPublishedMessage == 1 )
		{
			folder	= "isPublishMessages";
		}
		else if ( isPublishedMessage == 2 )
		{
			folder	= "isntPublishMessages";
		}

		out.println("<TR BGCOLOR=\"#E9E9E9\">");
		out.println("<TD WIDTH=\"1%\" HEIGHT=\"20\" CLASS=\"c2\">");
		out.println("<INPUT TYPE=\"checkbox\" NAME=\"message\" VALUE=\""+messageId+"\">");
		out.println("</TD>");
		out.println("<TD COLSPAN=\"2\" CLASS=\"c2\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
		out.println("<A HREF=\"faqs.jsp?mode=edit_message&id="+categoryId+"&messageId="+messageId+"&folder="+folder+"&pageNum="+pageNum+"&lang="+lang+"\"><B>");
		out.print( recordDate + " " );
		if( eMail!=null && eMail.length()>0 )
			out.print( "("+eMail+") " );
		out.println( name+" Страна: "+country );
		out.println("</B></A>");
		out.println("</DIV></TD>");
//		out.println( "<TD CLASS=\"c2\" WIDTH=\"1%\"><A HREF=\"#\"><IMG SRC=\"/admin/img/ico10.gif\" WIDTH=25 HEIGHT=20 ALT=\"посмотреть страницу\" BORDER=\"0\"></A><BR></TD>" );
		out.println( "<TD CLASS=\"c2\" WIDTH=\"1%\"><A HREF=\"#\"></TD>" );
		out.println("</TR>");
		out.println("<TR BGCOLOR=\"#E9E9E9\">");
		out.println("<TD CLASS=\"c1\">");
		out.println("</TD>");
		out.println("<TD COLSPAN=\"3\" CLASS=\"c1\" HEIGHT=\"20\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
		out.println( WebUtil.convertToBR( question ) );
		out.println("</B></DIV></TD>");
		out.println("</TR>");
		out.println("<TR BGCOLOR=\"#E9E9E9\">");
		out.println("<TD CLASS=\"c1\">");
		out.println("</TD>");
		out.println("<TD WIDTH=\"1%\" CLASS=\"c1\">&nbsp;&nbsp;<BR>");
		out.println("</TD>");
		out.println("<TD COLSPAN=\"2\" CLASS=\"c1\" HEIGHT=\"20\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
		out.println( WebUtil.convertToBR( answer ) );
		out.println("</DIV></TD>");
		out.println("</TR>");
	}

	//функция вывода списка тем форума
	private void showForumCategoryMessages( JspWriter out, FAQCategory fc, long isPublishedMessage, long pageNum, String lang ) throws IOException
	{
		String	folder	= "new";
		if ( isPublishedMessage == 1 )
		{
			folder	= "isPublishMessages";
		}
		else if ( isPublishedMessage == 2 )
		{
			folder	= "isntPublishMessages";
		}
	
		Connection 	con  	= null;
		PreparedStatement	stmt	= null;
		ResultSet	rs	= null;
		BLOB	blob	= null;
		long	size	= 0;
		int	pageQuantity	= 0;

		try	{
			con	 = WebApp.getConnection();
			stmt = con.prepareStatement( "SELECT COUNT(*) FROM faq_question WHERE faq_category#="+fc.getId()+" AND isPublished='"+isPublishedMessage+"'" );
			rs	= stmt.executeQuery();
			
			rs.next();
			
			size	= rs.getLong( 1 );
			pageQuantity	= (int)( size/pageSize );
			
			if ( ((float)size)/((float)pageSize) > pageQuantity )
			{
				pageQuantity++;
			}
			
			if ( pageNum < 1 )	pageNum	= 1;
			if ( pageNum > pageQuantity && pageQuantity > 0 )	pageNum	= pageQuantity;
			
			try { rs.close(); } catch (Exception e) {} finally { rs = null; }
			try { stmt.close(); } catch (Exception e) {} finally { stmt = null; }
			
			stmt = con.prepareCall( "SELECT * FROM ( SELECT rownum rn, ASS.* FROM (SELECT DBMS_LOB.GETLENGTH(question) length1,DBMS_LOB.GETLENGTH(answer) length2,  faq_question.* FROM faq_question WHERE faq_category#="+fc.getId()+" AND isPublished='"+isPublishedMessage+"' ORDER BY askDate DESC) ASS) WHERE rn BETWEEN "+(((pageNum - 1)*pageSize ) + 1)+" AND "+(((pageNum - 1)*pageSize ) + pageSize) );
			rs	= stmt.executeQuery();

			out.println("<SPAN CLASS=\"sm\">Всего сообщений: "+size+"</SPAN><BR>");
			
			//навигация по страницам
			if ( pageQuantity > 1 )
			{
				out.println("<TABLE BORDER=\"0\" CELLPADDING=\"0\" CELLSPACING=\"0\" WIDTH=\"620\">");
				out.println("<TR>");
				if ( pageNum == 1 )
				{
					out.println("<TD><A HREF=\"faqs.jsp?id="+fc.getId()+"&mode=folder&folder="+folder+"&pageNum=1\"><IMG SRC=\"/img/2l/nav/_arr.gif\" WIDTH=6 HEIGHT=9 ALT=\"\" BORDER=\"0\"></A><IMG SRC=\"/img/blank.gif\" WIDTH=5 HEIGHT=1 ALT=\"\" BORDER=\"0\"><BR></TD>");
				}
				else
				{
					out.println("<TD><A HREF=\"faqs.jsp?id="+fc.getId()+"&mode=folder&folder="+folder+"&pageNum="+(pageNum-1)+"\"><IMG SRC=\"/img/2l/nav/_arr.gif\" WIDTH=6 HEIGHT=9 ALT=\"\" BORDER=\"0\"></A><IMG SRC=\"/img/blank.gif\" WIDTH=5 HEIGHT=1 ALT=\"\" BORDER=\"0\"><BR></TD>");
				}
				out.println("<TD NOWRAP>");
				
				long	displacement	= (int)(pageNum-1)/scrollSize;
				for( int i = 1; i <=scrollSize ; i++ )
				{
					long	page	= i+displacement*scrollSize;
					if ( i > 1 ) out.print( " | " );
					if ( pageNum != page )
					{
						out.println("<A CLASS=\"m\" HREF=\"faqs.jsp?id="+fc.getId()+"&mode=folder&folder="+folder+"&pageNum="+page+"\">"+page+"</A>");
					}
					else
					{
						out.println("<A CLASS=\"mcur\">"+page+"</A>");
					}
					if ( page == pageQuantity )	i	= 11;
				}

				long from	= ((pageNum - 1)*pageSize ) + 1;
				long to	= pageNum*pageSize;
				if ( to > size )	to	= size;
				out.println("</TD>");
				if ( pageNum == pageQuantity )
				{
					out.println("<TD><IMG SRC=\"/img/blank.gif\" WIDTH=10 HEIGHT=1 ALT=\"\" BORDER=\"0\"><A HREF=\"faqs.jsp?id="+fc.getId()+"&mode=folder&folder="+folder+"&pageNum="+pageQuantity+"\"><IMG SRC=\"/img/2l/nav/arr.gif\" WIDTH=6 HEIGHT=9 ALT=\"\" BORDER=\"0\"></A><BR></TD>");
				}
				else
				{
					out.println("<TD><IMG SRC=\"/img/blank.gif\" WIDTH=10 HEIGHT=1 ALT=\"\" BORDER=\"0\"><A HREF=\"faqs.jsp?id="+fc.getId()+"&mode=folder&folder="+folder+"&pageNum="+(pageNum+1)+"\"><IMG SRC=\"/img/2l/nav/arr.gif\" WIDTH=6 HEIGHT=9 ALT=\"\" BORDER=\"0\"></A><BR></TD>");
				}
				out.println("<TD ALIGN=\"RIGHT\" CLASS=\"sm\" WIDTH=\"100%\">");
				out.println("с "+from+" по "+to);
				out.println("</TD>");
				out.println("</TR>");
				out.println("</TABLE>");
				out.println("<IMG SRC=\"/img/blank.gif\" WIDTH=1 HEIGHT=6 ALT=\"\" BORDER=\"0\"><BR><IMG SRC=\"/admin/img/grey.gif\" WIDTH=620 HEIGHT=1 ALT=\"\" BORDER=\"0\"><BR><IMG SRC=\"/img/blank.gif\" WIDTH=1 HEIGHT=6 ALT=\"\" BORDER=\"0\"><BR>");
			}

			out.println("<TABLE BORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"1\" WIDTH=\"620\">");
			out.println("<TR BGCOLOR=\"#C0C0C0\">");
			out.println("<TD HEIGHT=\"20\" CLASS=\"titnew\" COLSPAN=\"4\" ALIGN=\"center\"><DIV STYLE=\"padding-left:6px;padding-right:6px\" CLASS=\"titnew\"><B>");
			out.println("Вопросы-Ответы");
			out.println("</B></DIV></TD>");
			out.println("</TR>");
			for ( ; rs.next(); )
			{
				String	name	= rs.getString( "name" );
				String	country	= rs.getString( "country" );
				String	eMail	= rs.getString( "eMail" );
				String	answerName	= rs.getString( "answerName" );
				String	answerTitle	= rs.getString( "answerTitle" );

				byte buf[] = null;
				int length = -1;

				String question = "";
				length = rs.getInt( "length1" );
				blob = (BLOB) rs.getObject( "question" );
				if ( blob != null )
				{
					buf = blob.getBytes( 1, length );
					question = new String( buf, 0, buf.length, "Cp1251" );
				}
				
				String answer = "";
				length = rs.getInt( "length2" );
				blob = (BLOB) rs.getObject( "answer" );
				if ( blob != null )
				{
					buf = blob.getBytes( 1, length );
					answer = new String( buf, 0, buf.length, "Cp1251" );
				}

				String	isPublished	= rs.getString( "isPublished" );
				java.util.Date	askDate	= (java.util.Date)rs.getTimestamp( "askDate" );
				long	id	= rs.getLong( "faq_question#" );

				showMessage( out, name, country,  eMail, answerName, answerTitle, question, answer, isPublished, askDate, id, fc.getId(), isPublishedMessage, pageNum, lang );
			}
			out.println("</TABLE>");
		}catch( Exception e )
		{
			out.print( "Exception^"+e );
		}
		finally {
			try {
				try { rs.close(); } catch (Exception e) {} finally { rs = null; }
				try { stmt.close(); } catch (Exception e) {} finally { stmt = null; }
				if ( con != null ) {
					con.close();
					con = null;
				}
			} catch( Exception e ) {}
		}
	}

	//функция вывода combobox с темами
	private void drawCombo( JspWriter out, String categoryId, String lang ) throws IOException
	{
		Connection 			con  	= null;
		PreparedStatement	stmt	= null;
		ResultSet	rs	= null;

		try
		{
			long	catId	= Long.parseLong( categoryId );
			con	 = WebApp.getConnection();
			stmt = con.prepareStatement( "SELECT * FROM faq_category WHERE lang='"+lang+"' ORDER BY name" );

			rs	= stmt.executeQuery();

			out.println("<TR>");
			out.println("<TD CLASS=\"c2\" HEIGHT=\"20\">");
			out.println("<DIV STYLE=\"padding-left:6px;padding-right:6px\">");
			out.println("<B>Тема:</B>");
			out.println("</DIV>");
			out.println("</TD>");
			out.println("<TD CLASS=\"c1\" HEIGHT=\"20\">");
			out.println("<DIV STYLE=\"padding-left:6px;padding-right:6px\">");
			out.println("<SELECT NAME=\"category\" STYLE=\"width:620\">");
			while( rs.next() )
			{
				String	name	= rs.getString( "name" );
				long	id		= rs.getLong( "faq_category#" );
				out.print("<OPTION VALUE=\""+id+"\"");
				if ( id == catId )
				{
					out.print( " SELECTED" );
				}
				out.print(">");
				out.print( name );
				out.println("</OPTION>");
			}
			out.println("</SELECT>");
			out.println("</DIV>");
			out.println("</TD>");
			out.println("</TR>");
		}catch( Exception e )
		{
			out.print( "Exception^"+e );
		}
		finally {
			try {
				try { rs.close(); } catch (Exception e) {} finally { rs = null; }
				try { stmt.close(); } catch (Exception e) {} finally { stmt = null; }
				if ( con != null ) {
					con.close();
					con = null;
				}
			} catch( Exception e ) {}
		}
	}
%>
<HTML>
<HEAD>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
<META HTTP-EQUIV=Content-language CONTENT=RU>
<META NAME=description CONTENT="">
<META NAME=keywords CONTENT="">
<META NAME=autor CONTENT="">
<!-- "$Revision::                    $" -->
<!-- "$Author::                        $" -->
<!-- "$Date::                           $"-->
<TITLE>Вопрос-Ответ</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">
<SCRIPT>
function form_check( frm )
{
	if( frm.question.value.length==0 )
	{
		frm.question.focus();
		alert( 'Не заполнен текст вопроса' );
		return false;
	}
	if( frm.name.value.length==0 )
	{
		frm.name.focus();
		alert( 'Не заполнен автор' );
		return false;
	}
	if( frm.country.value.length==0 )
	{
		frm.country.focus();
		alert( 'Не заполнена страна' );
		return false;
	}
	

	if(frm.isPublished.checked && frm.answer.value.length==0)
	{
		frm.answer.focus();
		alert( 'Не заполнен ответ. Вопрос не может быть опубликован.' );
		return false;
	}
	return true;
}
</SCRIPT>
</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>


Сообщения
<BR>
<BR>
<A HREF="faq_category.jsp?lang=<%=request.getParameter("lang")%>">назад</A><BR><BR>
<%
	String	lang	= request.getParameter( "lang" );
	if ( lang == null || lang.length() == 0 )	lang	= "Z";

	String	mode	= request.getParameter("mode");
	if ( mode == null ) mode	= "";
	String	pageNum	= request.getParameter( "pageNum" );
	if ( pageNum == null )	pageNum = "1";

	String	categoryId	= request.getParameter("id");
	FAQCategory	fc	= null;
	if ( categoryId == null )
	{
		mode	= "categoryNotFound";
	}
	else
	{
		try
		{
			fc	= new FAQCategory();
			fc.load( Long.parseLong( categoryId ) );
		}catch( Exception e )
		{
			mode	= "categoryNotFound";
		}
	}
	
	
	if  ( mode.equalsIgnoreCase("edit_message") )
	{
		String	messageId	= request.getParameter( "messageId" );
		String	folder	= request.getParameter( "folder" );
		try
		{
			FAQ	fm	= new FAQ();
			fm.load( Long.parseLong( messageId ) );
			if ( fm.isPublished() == 0 )
			{
				fm.setPublished( 2 );
				fm.save();
			}
			%>
<FORM NAME="FORM3" ACTION="xt_faqs.jsp" METHOD="post" ONSUBMIT="return form_check(this);">
<INPUT TYPE="Hidden" NAME="action" VALUE="edit_message">
<INPUT TYPE="Hidden" NAME="id" VALUE="<%=categoryId%>">
<INPUT TYPE="Hidden" NAME="messageId" VALUE="<%=messageId%>">
<INPUT TYPE="Hidden" NAME="folder" VALUE="<%=folder%>">
<INPUT TYPE="Hidden" NAME="pageNum" VALUE="<%=pageNum%>">
<INPUT TYPE="Hidden" NAME="lang" VALUE="<%=lang%>">
<TABLE WIDTH="620" BORDER="0" CELLSPACING="1" CELLPADDING="1">
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Дата получения вопроса:</B>
</DIV>
</TD>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<% out.println(new SimpleDateFormat( "dd.MM.yyyy" ).format(fm.getAskDate()));%>
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Вопрос:</B>
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<TEXTAREA NAME="question" STYLE="width:620" COLS="34" ROWS="7"><%=fm.getQuestion()%></TEXTAREA>
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Автор:</B>
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="name" STYLE="width:620" SIZE="34" VALUE="<%=WebUtil.toHTML( fm.getName() )%>">
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Страна:</B>
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="country" STYLE="width:620" SIZE="34" VALUE="<%=WebUtil.toHTML( fm.getCountry() )%>">
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>e-mail:</B>
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="eMail" STYLE="width:620" SIZE="34" VALUE="<%=WebUtil.toHTML( fm.getEMail() )%>">
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Ответил:</B>
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="answerName" STYLE="width:620" SIZE="34" VALUE="<%=WebUtil.toHTML( fm.getAnswerName() )%>">
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Должность:</B>
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="answerTitle" STYLE="width:620" SIZE="34" VALUE="<%=WebUtil.toHTML( fm.getAnswerTitle() )%>">
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Ответ:</B>
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<TEXTAREA NAME="answer" STYLE="width:620" COLS="34" ROWS="7"><%=fm.getAnswer()%></TEXTAREA>
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Комментарий:</B>
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="comments" STYLE="width:620" SIZE="34" VALUE="<%=WebUtil.toHTML( fm.getComments() )%>">
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="Checkbox" NAME="isPublished" VALUE="1" <%=fm.isPublished()==1? "CHECKED":""%>><B> - автоматическая публикация:</B>
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="Checkbox" NAME="isActual" VALUE="1" <%=fm.isActual()==1? "CHECKED":""%>><B> - актуальный вопрос</B>
</DIV>
</TD>
</TR>
<%
drawCombo( out, categoryId, lang );
%>
<TR>
<TD ALIGN="center" HEIGHT="20" COLSPAN="2">
<INPUT TYPE="submit" VALUE="Сохранить" ONCLICK="return confirm('Сохранить изменения?');">
</TD>
</TR>
</TABLE>
</FORM>
			<%
		}catch( Exception e )
		{
			%>
			<B>Произошла ошибка при чтении сообщения.<%=e%></B><BR>
			<%
		}
	}
	else if  ( mode.equalsIgnoreCase("categoryNotFound") )
	{
		%>
		<B>Тема не найдена.</B><BR>
		<%
	}
	else if  ( mode.equalsIgnoreCase("error") )
	{
		String	reason	= request.getParameter( "reason" );
		if	( reason != null && reason.length() != 0 )
		{
		%>
		<B>Произошла ошибка при отправке сообщения по электронной почте. Ответ не отправлен.</B><BR>
		<%
		}
		else
		{
		%>
		<B>Произошла ошибка. Попробуйте еще раз.</B><BR>
		<%
		}
	}
	else if  ( mode.equalsIgnoreCase("isExist") )
	{
		%>
		<B>Тема с указанным именем уже существует.</B><BR>
		<%
	}
	else if  ( mode.equalsIgnoreCase("folder") )
	{
		String	folder	= request.getParameter( "folder" );
		long	isPublished	= 0;
%>
<B>Тема "<%=fc.getName()%>".</B><BR>
<%
		if ( folder != null && folder.equals( "new" ) )
		{
			isPublished	= 0;
			%>
			<B>Новые сообщения.</B><BR>
			<%
		}
		else if ( folder != null && folder.equals( "isPublishMessages" ) )
		{
			isPublished	= 1;
			%>
			<B>Опубликованные сообщения.</B><BR>
			<%
		}
		else if ( folder != null && folder.equals( "isntPublishMessages" ) )
		{
			isPublished	= 2;
			%>
			<B>Неопубликованные сообщения.</B><BR>
			<%
		}
%>
<FORM NAME="FORM1" ACTION="xt_faqs.jsp" METHOD="post">
<INPUT TYPE="Hidden" NAME="action" VALUE="del_messages">
<INPUT TYPE="Hidden" NAME="id" VALUE="<%=fc.getId()%>">
<INPUT TYPE="Hidden" NAME="folder" VALUE="<%=folder%>">
<INPUT TYPE="Hidden" NAME="pageNum" VALUE="<%=pageNum%>">
<INPUT TYPE="Hidden" NAME="lang" VALUE="<%=lang%>">
<%
	showForumCategoryMessages( out, fc, isPublished, Long.parseLong( pageNum ), lang );
%>
<BR><A HREF="javascript:if (confirm('Вы действительно хотите удалить сообщения?')) {this.FORM1.submit();}">удалить</A><BR>
</FORM>
<%
	}
	else
	{
%>
<B>Тема "<%=fc.getName()%>".</B><BR>
<%
		drawFolders( out, fc, lang );
	}
%>

</BODY>
</HTML>
