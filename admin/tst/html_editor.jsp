<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

<HTML>
<HEAD>
<%@ include file="/admin/inc/editor/editor_init.jsp"%>
</HEAD>
<BODY>

<textarea cols=80 rows=5 id=textarea1 name=textarea1>
<%= request.getParameter("txt1") %>
</textarea>
<br>
<textarea cols=80 rows=5 id=textarea1 name=textarea1>
<%= request.getParameter("txt2") %>
</textarea>
<br>
<textarea cols=80 rows=5 id=textarea1 name=textarea1>
<%= request.getParameter("txt3") %>
</textarea>
<br>
<FORM method=post name=frm>


<%
	wysiwygName = "txt1";
	wysiwygWidth = 500;
	wysiwygHeight = 200;
	wysiwygValue = request.getParameter("txt1");
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>

<br>
<%
	wysiwygName = "txt2";
	wysiwygWidth = 500;
	wysiwygHeight = 200;
	wysiwygValue = request.getParameter("txt2");
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>

<br>
<%
	wysiwygName = "txt3";
	wysiwygWidth = 500;
	wysiwygHeight = 200;
	wysiwygValue = request.getParameter("txt3");
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>


<a href="#" onclick="wysiwygPrepareParams('frm'); document.frm.submit();">go!</a>
</FORM>
</BODY>



