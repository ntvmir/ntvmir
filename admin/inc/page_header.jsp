<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="tengry.cms.core.Admin" %>
<%
    response.setHeader( "Pragma", "no-cache" );
    String title = request .getParameter("title");
    if(title == null)
		title = "Административная зона";
	Admin admin = (Admin)session.getValue("admin.user");
%>
<HTML>
<HEAD>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
<META HTTP-EQUIV=Content-language CONTENT=RU>
<META NAME=description CONTENT="">
<META NAME=keywords CONTENT="">
<META NAME=autor CONTENT="">
<TITLE><%=title%></TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">
</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="0" CLASS="title">
<TR>
<%	if(admin != null)
	{
%>
<TD WIDTH="1%">
<A HREF="/admin/xt_logout.jsp">Выход</A>
</TD>
<%	} %>

<TD ALIGN="center">
<SPAN CLASS="tit">
НТВ Мир - административная часть
</SPAN>
</TD>
<%	if(admin != null)
	{
%>
<TD WIDTH="1%">
&nbsp;администратор:&nbsp;<B><%=admin.getLogin()%></B>&nbsp;
</TD>
<%	} %>
</TR>
</TABLE>
