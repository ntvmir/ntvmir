<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%@ page import="tengry.cms.*"%>

<%
	CMSApplication app = CMSApplication.getApplication();
	out.println(app.getWebRoot().getNameRus());

%>