<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="tengry.northgas.*" %>



<% String pageId = request.getParameter( "pageId" ); %>
<%@ include file="/admin/inc/authorize.jsp"%>




<%--
	Страница редактирования контента статических страниц сайта.
--%>
<%
String nodeId 	= request.getParameter( "pageId" );
	
// получим текущую страницу
WebPage wp	= null;
wp = (WebPage) WebApp.getApp().getWebRoot().lookup( nodeId );
if( wp == null )
{
	response.sendRedirect( "/admin/tree/tree.jsp" );
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>

<TITLE>Редактирование страницы</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">

</HEAD>

<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>


Редактирование
<BR>
<BR>

<FORM ACTION="xt_tree.jsp" METHOD="post">

<INPUT TYPE="Hidden" NAME="mode" VALUE="edit">
<INPUT TYPE="Hidden" NAME="node" VALUE="<%=nodeId%>">


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD COLSPAN="3" ALIGN="CENTER">
<B>Страница</B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Заголовок</B><BR>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD CLASS="c2">&nbsp;<B>Title</B></TD>
</TD>
</TR>

<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="namerus" VALUE="<%=wp.getNameRus()%>" STYLE="width:350" SIZE="34"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="nameeng" VALUE="<%=wp.getNameEng()%>" STYLE="width:350" SIZE="34"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>
<TD COLSPAN="3" ALIGN="left">
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%=wp.isVisible() ? "CHECKED" : ""%>>видимая
</TD>
</TR>

<TR>
<TD COLSPAN="3" ALIGN=CENTER><BR><BR>
<INPUT TYPE="Submit" VALUE="Сохранить" ONCLICK="return confirm('Сохранить изменения?');">
</TD>
</TR>

</TABLE>

</FORM>
</BODY>
</HTML>
