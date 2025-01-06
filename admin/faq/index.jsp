<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

<%@ page import="tengry.northgas.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>



<% String pageId = "comp.faq.themes"; %>
<%@ include file="/admin/inc/authorize.jsp"%>




<%
    response.setHeader( "Pragma", "no-cache" );
// получим текущую страницу
WebPage wp	= null;
wp = (WebPage) WebApp.getApp().getWebRoot().lookup( "faq" );
if( wp == null )
{
	response.sendRedirect( "/admin/tree/tree.jsp" );
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

</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="655">
<TR>
	<TD COLSPAN="1" ALIGN="CENTER">
		<B>Вопрос-Ответ</B><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
	</TD>
</TR>
<TR>
<TD HEIGHT="20" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
Папка
</B></DIV></TD>
</TR>
<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="faq_category.jsp?lang=R">Вопросы-Ответы на русском</A></DIV></TD>
</TR>
<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="faq_category.jsp?lang=E">Вопросы-Ответы на английском</A></DIV></TD>
</TR>
</TABLE>
</BODY>
</HTML>
