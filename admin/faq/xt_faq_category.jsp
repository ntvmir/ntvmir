<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="tengry.northgas.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="java.util.*" %>



<% String pageId = "comp.faq.themes"; %>
<%@ include file="/admin/inc/authorize.jsp"%>

<%!
	boolean equal( String s1, String s2 )
	{
		if( s1 == null ) s1 = "";
		if( s2 == null ) s2 = "";
		return s1.equals( s2 );
	}
%>


<%
// определим все полученные параметры
String lang = request.getParameter( "lang" );
String action = request.getParameter( "action" );
String	name	= request.getParameter("name");
String	id		= request.getParameter("id");
String	isPublished		= request.getParameter("isPublished");
String[] fcs	= request.getParameterValues( "category" );

String	href	= "faq_category.jsp?mode=error&lang="+lang;

if( action != null && action.equals( "add_category" ) )
{
	if( ! isC( pageAccessCode ))
	{
		response .sendRedirect( "faq_category.jsp?lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	boolean isPublic = false;
	
	FAQCategory	fc	= new FAQCategory();
	try
	{
		fc.setName( name );
		if ( isPublished != null && isPublished.equals( "1" ) )
		{
			if( ! isP( pageAccessCode ))
			{
				response .sendRedirect( "faq_category.jsp?lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			fc.setPublished( 1 );//Публиковать
			isPublic = true;
		}
		else
		{
			fc.setPublished( 2 );//не публиковать
		}
		fc.setLanguage( lang.charAt( 0 ) );
		fc.save();
		try{ Journal.newRecord( currentAdmin, fc, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		if( isPublic )
			try{ Journal.newRecord( currentAdmin, fc, pageId, Journal.ACTION_PUBLIC, "" ).save(); }catch( Exception e ){}
		href	= "faq_category.jsp?lang="+lang;
	}catch(Exception e)
	{
		href	= "faq_category.jsp?err=" + WebApp.PAGE_ERROR_WHILE_SAVING + "&lang="+lang;
	}
}
else if( action != null && action.equals( "edit_category" ) )
{
	
	FAQCategory	fc	= new FAQCategory();
	try
	{
		fc.load( Long.parseLong( id ) );
		
		boolean isModify = false;
		boolean isPublic = false;
		boolean isUnpubl = false;
		
		if( ! equal( fc.getName(), name )) isModify = true;
		if( isModify && ! isW( pageAccessCode ))
		{
			response .sendRedirect( "faq_category.jsp?lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		

		fc.setName( name );
		if ( isPublished != null && isPublished.equals( "1" ) )
		{
			if( ! isP( pageAccessCode ))
			{
				response .sendRedirect( "faq_category.jsp?lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			if( fc.isPublished() != 1 )
				isPublic = true;
			fc.setPublished( 1 );//Публиковать
		}
		else
		{
			if( ! isP( pageAccessCode ) && fc.isPublished() == 1 )
			{
				response .sendRedirect( "faq_category.jsp?lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			if( fc.isPublished() != 2 )
				isUnpubl = true;
			fc.setPublished( 2 );//не публиковать
		}
		fc.save();
		if( isModify )
			try{ Journal.newRecord( currentAdmin, fc, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( isPublic )
			try{ Journal.newRecord( currentAdmin, fc, pageId, Journal.ACTION_PUBLIC, "" ).save(); }catch( Exception e ){}
		if( isUnpubl )
			try{ Journal.newRecord( currentAdmin, fc, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}
		
		href	= "faq_category.jsp?lang="+lang;
	}catch(Exception e)
	{
		href	= "faq_category.jsp?err=" + WebApp.PAGE_ERROR_WHILE_SAVING + "&lang="+lang;
	}
}
else if( action != null && action.equals( "del_categories" ) )
{
	try
	{
		if ( fcs != null )
		{
			for (int i=0; i< fcs.length ;i++)
			{
				if( ! isC( pageAccessCode ))
				{
					response .sendRedirect( "faq_category.jsp?lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
					return;
				}
				FAQCategory	fc	= new FAQCategory();
				fc.load( Long.parseLong( fcs[i] ) );
				
				if( fc.isPublished() == 1 && ! isP( pageAccessCode ))
				{
					response .sendRedirect( "faq_category.jsp?lang="+lang + "&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
					return;
				}
				name	= fc.getName();
				Journal rec = Journal.newRecord( currentAdmin, fc, pageId, Journal.ACTION_DELETE, "" );
				fc.remove();
				try{ rec.save(); }catch( Exception e ){}
			}
		}
		href	= "faq_category.jsp?lang="+lang;	
	}catch(WebException e)
	{
		href	= "faq_category.jsp?err=" + WebApp.PAGE_ERROR_WHILE_REMOVING + "&lang="+lang;
	}
}
else
{
	// не найдено подходящее событие
	href	= "faq_category.jsp?lang="+lang;
}

response.sendRedirect( href );
%>

