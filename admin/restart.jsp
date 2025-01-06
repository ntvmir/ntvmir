<%
	if("1".equals(request .getParameter("restart")))
	{
		System.exit(0);
	}
	else
	{
%>
<a href="restart.jsp?restart=1">Restart!</A>
<%
	}
%>