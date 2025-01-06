<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.forum.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>

<%
    String header = CMSApplication.toHTML(request.getParameter("header"));
    String text = request.getParameter("message");
    text = (new ForumText(text)).getText();
%>
<html>
<head>
<title><%=CMSApplication.getSiteName()%> :: Форум :: Предварительный просмотр</title>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251"><link rel="STYLESHEET" type="text/css" href="/inc/css.css">
<style>
.h1{font-size:130%;font-weight:bold;}
</style>
</head>
<body bgcolor="#ffffff" text="#000000">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td align="center"><img src="<%=des%>/logo-prnt.gif" width="53" height="55" alt="" border="0"><br></td>
<td valign="bottom" class="defFont">
<div class="h1"><%=header%></div>
</td>
</tr>

<tr>
<td colspan="2">
<hr noshade width="100%" size="1" color="#b2b2b2">
</td>
</tr>

<tr valign="top">
<td align="center">
<b style="color:#666666;">Пользователь:</b> <%=user != null ? CMSApplication.toHTML(user.getLogin()) : ""%>
<br><br><br><br>
</td>
<td width="80%" class="defFont">
<div style="margin-left: 40pt; margin-top: 10pt; margin-bottom: 10pt; margin-right: 40pt; background: #F1F1F1;">
<div style="margin-left: 10pt; margin-right: 10pt;">
<br>
<%=text%>
<br>&nbsp;
</div>
</div>
</td>
</tr>

<tr>
<td colspan="2">
<hr noshade width="100%" size="1" color="#b2b2b2">
</td>
</tr>

<tr>
<td colspan="2" align="center">
<input type="button" value="Закрыть окно" onClick="javascript: window.close();">
</td>
</tr>


</table>
</body>
</html>
