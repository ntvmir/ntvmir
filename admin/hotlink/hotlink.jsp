<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

<%@ page import="tengry.northgas.*" %>



<% String pageId = "comp.hotlink"; %>
<%@ include file="/admin/inc/authorize.jsp"%>




<%
    response.setHeader( "Pragma", "no-cache" );
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
<TITLE>Горячая ссылка</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">
</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>

<%
	HotLink hl = new HotLink();
	hl.load();
	
	if( "1".equals( request.getParameter( "err" ))){
		out.println( "Ошибка при сохранении" );
	}
%>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
<TR>
<TD COLSPAN="3" ALIGN="CENTER">
<B>Блок "Горячая ссылка"</B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Содержание</B>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR></TD>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Content</B>
</TD>
</TR>
<!-- белая полоска --><TR><TD COLSPAN="3"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>
<FORM ACTION="xt_hotlink.jsp" METHOD="POST" NAME="FORM">
<TR BGCOLOR="#F0F7FF">
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<TEXTAREA NAME="contentrus" ROWS=15 STYLE="width:100%" COLS="58" WRAP="PHYSICAL"><%=hl.getContentRus()%></TEXTAREA><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=10><BR>
	</TD>
	<TD>
		<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
	</TD>
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<TEXTAREA NAME="contenteng" ROWS=15 STYLE="width:100%" COLS="58" WRAP="PHYSICAL"><%=hl.getContentEng()%></TEXTAREA><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=10><BR>
	</TD>
</TR>

<TR>
<TD COLSPAN="3" ALIGN="center" HEIGHT="30">
<INPUT TYPE="Checkbox" NAME="published" VALUE="1" <%=hl.isPublished() ? "CHECKED" : ""%>>публиковать на главной странице
<BR><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="Submit" VALUE="Сохранить изменения" ONCLICK="return confirm('Сохранить изменения?');">
</TD>
</TR>
</TABLE>
<BR>
</FORM>

</BODY>
</HTML>
