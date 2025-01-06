<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="tengry.northgas.*" %>



<% String pageId = "comp.hotlink"; %>
<%@ include file="/admin/inc/authorize.jsp"%>

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

<%!
	boolean equals( String s1, String s2 ) throws Exception
	{
		if( s1 == null ) s1 = "";
		if( s2 == null ) s2 = "";
		return s1.equals( s2 );
	}
%>

<%
String href = "hotlink.jsp?";

HotLink hl = new HotLink();
hl.load();

boolean isModify = false;
boolean isPublic = false;
boolean isUnpubl = false;

String contentRus = request.getParameter( "contentrus" );
String contentEng = request.getParameter( "contenteng" );
String pub = request.getParameter( "published" );
boolean published = false;
if( "1".equals( pub ))
	published = true;

if( ! equals( hl.getContentRus(), contentRus) || ! equals( hl.getContentEng(), contentEng ))
	isModify = true;
if( published && ! hl.isPublished())
	isPublic = true;
if( ! published && hl.isPublished())
	isUnpubl = true;

if( isModify && ! isW( pageAccessCode ))
{
	response.sendRedirect( "hotlink.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
	return;
}

if( ! isP( pageAccessCode ) && (( isModify && published ) || isPublic || isUnpubl ))
{
	response.sendRedirect( "hotlink.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
	return;
}

hl.setContentRus( contentRus );
hl.setContentEng( contentEng );
hl.setPublished( published );
try
{
	hl.save();
	clearFrontEntries();
	if( isModify )
		try{ Journal.newRecord( currentAdmin, hl, pageId, Journal.ACTION_MODIFY, "").save(); }catch( Exception e ){}
	if( isPublic )
		try{ Journal.newRecord( currentAdmin, hl, pageId, Journal.ACTION_PUBLIC, "").save(); }catch( Exception e ){}
	if( isUnpubl )
		try{ Journal.newRecord( currentAdmin, hl, pageId, Journal.ACTION_UNPUBL, "").save(); }catch( Exception e ){}
}
catch( Exception e ){
	href = "hotlink.jsp?err=1";
}

response.sendRedirect( href );
%>