<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = "admin";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	Enumeration enum = Admin.getAdmins();
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Пользователи административной зоны"/>
<jsp:param name="header" value="Пользователи административной зоны"/>
<jsp:param name="message" value=""/>
<jsp:param name="width" value="655"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="655">
<TR>
	<TD CLASS="c2" HEIGHT="16" COLSPAN="5" ALIGN="center">
		<B>Администраторы (<A HREF="admin.jsp">зарегистрировать администратора</A>)</B>
	</TD>
</TR>
<TR>
	<TD CLASS="c2" HEIGHT="16" WIDTH="15%">&nbsp;login</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="40%">&nbsp;ФИО</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="25%">&nbsp;E-mail</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="20%">&nbsp;телефон</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">удалить</TD>
</TR>
<FORM ACTION="xt_admins.jsp" METHOD="POST" NAME="FORM">
<%
	while( enum.hasMoreElements()){
		Admin admin = (Admin)enum.nextElement();
%>
<INPUT TYPE="hidden" NAME="id" VALUE="<%=admin.getId()%>">
<TR CLASS="edit">
	<TD>
		&nbsp;<A HREF="admin.jsp?id=<%=admin.getId()%>"><%=CMSApplication.toHTML( admin.getLogin())%></A>
	</TD>
	<TD>
		&nbsp;<%=CMSApplication.toHTML( admin.getName())%>
	</TD>
	<TD>
		&nbsp;<A HREF="mailto:<%=admin.getEmail()%>"><%=CMSApplication.toHTML( admin.getEmail())%></A>
	</TD>
	<TD>
		&nbsp;<%=CMSApplication.toHTML( admin.getPhone())%>
	</TD>
	<TD ALIGN="center">
<%	if( ! Admin.ROOT_NAME.equals( admin.getLogin())){ %>
		<INPUT TYPE="checkbox" NAME="del" VALUE="<%=admin.getId()%>">
<%	} %>
	</TD>
</TR>
<%
	}
%>
<TR>
	<TD COLSPAN="5" ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Submit" VALUE="Удалить" ONCLICK="return confirm('Удалить?');">
	</TD>
</TR>
</TABLE>
<BR>
</FORM>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
