<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.forum.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%@include file="/inc/pagebar.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String backPageId = request.getParameter("back_page_id");
%>
<%@ include file="/inc/path_init.jsp"%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign="top" class="XsmallFont">
<div style="margin-top:8px">
<a href="/pages/<%=langCode%>/forum">Форум</a> / Регистрация
</div>
</td>
<!--заголовок страницы--><td align="right"><img src="<%=des%>/<%=sectionImg%>/ttl.gif" height="47" alt="<%=sectionName%>" border="0"></td>
</tr>
</table>



<%
    String create = request.getParameter("create");
    if(user != null || "1".equals(create))
    {
%>
<%@ include file="/user/profile.jsp"%>
<%
    }
    else
    {
%>
<%@ include file="/user/login.jsp"%>
<%
    }
%>
