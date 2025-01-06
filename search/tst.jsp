<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>

<%
	String [] vals = request.getParameterValues("txt");
	if(vals != null)
		for(int i = 0; i < vals.length; i++)
			out.println(vals[i]);
	else
		out.println("NO VALS");
	
	String txt = request.getParameter("txt");
	if(txt == null)
		txt = "";
%>

<FORM ACTION="tst.jsp" METHOD="post">
<INPUT TYPE="text" NAME="txt" VALUE="<%=txt%>"><INPUT TYPE="submit" VALUE="go">
</FORM>