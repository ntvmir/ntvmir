<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%@ page import="tengry.northgas.*" %>
<%
session.removeValue( "admin.user" );
response.sendRedirect( "/admin/login.jsp" );
%>