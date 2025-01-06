<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = User.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>
<%
	String ord = request.getParameter("order");
	int pageNum = 1;
	int pageSize = 30;
	try{pageNum = Integer.parseInt(request.getParameter("page_number"));}catch(Exception e){}
	String order = null;
	if(ord == null || ord.length() < 2)
		ord = "1+";
	if(ord.charAt(1) == ' ')
		ord = "" + ord.charAt(0) + "+";

	switch(ord.charAt(0))
	{
		case '1':
			order = "m_login"; break;
		case '2':
			order = "m_email"; break;
		case '3':
			order = "m_name"; break;
		case '4':
			order = "m_country, m_city"; break;
		default: order = "m_login";
	}
	if('-' == ord.charAt(1))
		order += " DESC";
	if("4-".equals(ord))
	    order = "m_country desc, m_city desc";

	String message = "";
	if("1".equals(request.getParameter("ok")))
		message = "Профайл пользователя сохранен.";
	else if("2".equals(request.getParameter("ok")))
		message = "Выбраные пользователи были успешно удалены.";
	

	int itemCount = User.getUserCount();
	Vector users = User.getUsers(order, pageNum, pageSize);
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Пользователи"/>
<jsp:param name="header" value="Пользователи"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	

<%
	if(itemCount > 0)
		printNavigator(pageNum, pageSize, itemCount, "users.jsp?order=" + ord, "700", out);
%>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<INPUT TYPE="hidden" NAME="mode" VALUE="del">
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c2" VALIGN="middle">
<BR>
</TD>


<TD HEIGHT="20" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<A HREF="users.jsp?order=1<%=ord.equals("1+") ? "-" : "+"%>">
Логин<%=ord.charAt(0) == '1' ? ord.charAt(1) : ' '%>
</A>
</B></DIV>
</TD>

<TD HEIGHT="20" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<A HREF="users.jsp?order=2<%=ord.equals("2+") ? "-" : "+"%>">
E-mail<%=ord.charAt(0) == '2' ? ord.charAt(1) : ' '%>
</A>
</B></DIV>
</TD>

<TD HEIGHT="20" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<A HREF="users.jsp?order=3<%=ord.equals("3+") ? "-" : "+"%>">
Имя<%=ord.charAt(0) == '3' ? ord.charAt(1) : ' '%>
</A>
</B></DIV>
</TD>

<TD HEIGHT="20" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<A HREF="users.jsp?order=4<%=ord.equals("4+") ? "-" : "+"%>">
Организация<%=ord.charAt(0) == '4' ? ord.charAt(1) : ' '%>
</A>
</B></DIV>
</TD>
</TR>
<FORM ACTION="xt_user.jsp" METHOD="post" NAME="main_form">
<INPUT TYPE="hidden" NAME="mode" VALUE="del">
<%
	Enumeration enum = users.elements();
	while(enum.hasMoreElements())
	{
		User user = (User)enum.nextElement();
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="users" VALUE="<%=user.getId()%>">
</TD>

<TD HEIGHT="20" CLASS="c3">
<DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="user_edit.jsp?id=<%=user.getId()%>"><%=user.getLogin()%></A>
</DIV>
</TD>

<TD HEIGHT="20" CLASS="c3">
<DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="mailto:<%=user.getEmail()%>"><%=user.getEmail()%></A>
</DIV>
</TD>

<TD HEIGHT="20" CLASS="c3">
<DIV STYLE="padding-left:6px;padding-right:6px">
<%=user.getName()%>
</DIV>
</TD>

<TD HEIGHT="20" CLASS="c3">
<DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(user.getCountry())%>, <%=CMSApplication.toHTML(user.getCity())%> 
</DIV>
</TD>
</TR>
<%	
	} 
%>
<TR>
	<TD COLSPAN="5" ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Submit" VALUE="Удалить" ONCLICK="return confirm('Вы уверены?');">
	</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
