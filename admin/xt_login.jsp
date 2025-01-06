<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%@ page import="tengry.cms.core.Admin" %>
<%
String login = request.getParameter( "login" );
String password = request.getParameter( "password" );

if( login == null || login.length() == 0 || password == null || password.length() == 0 )
	response.sendRedirect( "/admin/login.jsp?err=1" );
else
{
	Admin admin = Admin.authorize(login, password);
	if( admin == null ) {
		System.err.println( "AUTHORIZATION admin " + login + " login faild" );		
		response.sendRedirect( "/admin/login.jsp?err=1" );
	} else {
		System.out.println( "AUTHORIZATION: admin " + admin.getLogin() + " login at " + (new java.util.Date()) );
		session.putValue( "admin.user", admin );
		response.sendRedirect( "/admin/index.jsp" );
	}
}
%>