<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="java.util.*" %>
<%@ page import="tengry.northgas.*" %>



<% String pageId = request.getParameter( "pageId" ); %>
<%@ include file="/admin/inc/authorize.jsp"%>

<%
	if( ! isC( pageAccessCode ))
	{
		response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
%>


<%--
	Обработки добавления страниц в дерево сайта.
--%>
<%
    response.setHeader("Pragma","no-cache");

	String nodeId 	= request.getParameter( "pageId" );
	String addType	= request.getParameter( "addType" );
	if( addType != null && addType.equals( "static" ) )
	{
		String redirTo = "page_edit.jsp?mode=add&pageId=" + nodeId;
		response.sendRedirect( redirTo );
	}
	else if( addType != null && addType.equals( "news" ) )
	{
		String redirTo = "/admin/news/news_page_add.jsp?pageId=" + nodeId;
		response.sendRedirect( redirTo );
	}
	
	// получим текущую страницу
	WebPage wp = (WebPage) WebApp.getApp().getWebRoot().lookup( nodeId );
	if( wp == null )
	{
		// непредвиденная ситуация, узел должен существовать
		response.sendRedirect( "tree.jsp" );
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>

<TITLE>Добавление страницы</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">

</HEAD>

<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>

Добавление страницы
<BR>
<BR>
<FORM ACTION="page_add.jsp" METHOD="post">

<INPUT TYPE="Hidden" NAME="pageId" VALUE="<%=nodeId%>">

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD ALIGN="CENTER">
<B>Выберите тип добавляемой страницы</B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>

<SELECT NAME="addType" STYLE="width:500">
<%
	for( Iterator i = WebPage.getTypes(); i.hasNext(); )
	{
		String typeName = (String) i.next();
		String userTypeName = null;
		if( typeName.equalsIgnoreCase( "custom" ) )
		{
			continue;
		}
		else if( typeName.equalsIgnoreCase( "static" ) )
		{
			userTypeName = "Статическая страница";
		}
		else if( typeName.equalsIgnoreCase( "news" ) )
		{
			userTypeName = "Страница новостей";
		}
		
		out.print( "<OPTION VALUE=\"" );
		out.print( typeName );
		out.print( "\">" );
		out.print( userTypeName );
		out.println( "</OPTION>" );
	}
%>
</SELECT>
		   		
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>

</TR>

<TR>
<TD ALIGN=CENTER><BR><BR>
<INPUT TYPE="Submit" VALUE="Далее">
</TD>
</TR>

</TABLE>

</FORM>
</BODY>
</HTML>
