<%@ page import="java.util.*"%>
<%@page import="tengry.cms.db.*"%>
<%@page import="tengry.cms.*"%>
<%@page import="tengry.cms.core.*"%>
<%@page import="tengry.northgas.*"%>
<%@page import="tengry.northgas.mailer.*"%>
<%
	String login = request.getParameter("login");
	String pass = request.getParameter("pass");
	if(login != null)
	{
		Admin admin = Admin.authorize(login, pass);
		out.println(Message.SERVICE_CODE + " -- " + admin.getAccessCode(Message.SERVICE_CODE));
	}

%>

<FORM>
<INPUT NAME="login"><br>
<INPUT NAME="pass"><br>
<INPUT TYPE="submit">
</FORM>