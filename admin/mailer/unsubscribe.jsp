<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

<%@ page import="tengry.northgas.*" %>
<%@ page import="java.io.*" %>



<% String pageId = "comp.unsubscribe"; %>
<%@ include file="/admin/inc/authorize.jsp"%>



<%
response.setHeader( "Pragma", "no-cache" );

String email = request.getParameter( "email" );
int deleted = -1;

// отключаем от рассылки
if( email != null )
{
	try
	{
		deleted = (int) DatabaseObject.executeUpdate("DELETE FROM TUSER WHERE email='" + email + "'");
		if( deleted > 0 )
			try{ Journal.newRecord( currentAdmin, null, pageId, Journal.ACTION_DELETE, "отключен e-mail: " + email ).save(); }catch( Exception e ){}
	}
	catch( Exception e )
	{ }
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
<TITLE>Отключение от рассылки</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">

<STYLE>
.titnew
{font-size : 12px;font-weight : bold;background-color :#B5B5B5 ;}
input{font-size : 10px;font-weight : normal;width:180}
</STYLE>


</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" />
<%@ include file="/admin/inc/error.jsp"%>

<BR>
<BR>

<FORM NAME="FORM1" ACTION="unsubscribe.jsp" METHOD="post">
<TABLE WIDTH="620" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<TR ALIGN="center">
<TD CLASS="titnew" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="titnew">Отключение от рассылки</DIV>
</TD>
</TR>
</TABLE>

<%
if(deleted>0) 
	out.println("<B>Пользователь отключен от рассылки</B>");
else if (deleted==0)
	out.println("<B>Пользователь с адресом "+email+" не найден</B>");
%>

<TABLE WIDTH="620" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<TR>
<TD CLASS="c1">
Укажите email адрес для отключения: <INPUT TYPE="text" NAME="email" VALUE="">
</TD>
</TR>
<TR ALIGN="center">
<TD CLASS="c1">
<INPUT TYPE="submit" VALUE="Отключить" ONCLICK="if(confirm('Отключить?')) { if(document.FORM1.email.value.length==0) {alert('Не заполнен email'); return false;} } else { return false;} ">
</TD>
</TR>
</TABLE>

</FORM>


</BODY>
</HTML>