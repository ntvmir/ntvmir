<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = "admin";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter( "id" );
	if("".equals(id))
		id = null;
	
	if( id == null && ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "admins.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}

	Admin admin = new Admin();
	if(id != null)
		admin.load(id);
	if(request.getParameter("login") != null)
		admin.setLogin(request.getParameter("login"));
	if(request.getParameter("name") != null)
		admin.setName(request.getParameter("name"));
	if(request.getParameter("email") != null)
		admin.setEmail(request.getParameter("email"));
	if(request.getParameter("phone") != null)
		admin.setPhone(request.getParameter("phone"));
	
	String message = "";
	if("1".equals(request.getParameter("ununique")))
		message = "Администратор с таким Логином уже зарегистрирован";
	
	String defaultPassword = "********";
	if(id == null) defaultPassword = "";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Пользователи административной зоны"/>
<jsp:param name="header" value="Пользователь административной зоны"/>
<jsp:param name="width" value="620"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function submitForm()
{
	var form = document.main_form;
	
	if( trim(form.login.value) == '' )
	{
		alert( 'Поле "Логин" должно быть заполнено.' );
		form.login.focus();
		return;
	}
	if( '<%=admin.getId() != null ? admin.getId(): ""%>' == '' && trim(form.password.value) == '' )
	{
		alert( 'При регистрации нового пользователя необходимо установить пароль.' );
		form.password.focus();
		return;
	}
	
	if(trim(form.name.value) == '')
	{
		alert( 'Поле "ФИО" должно быть заполнено.' );
		form.name.focus();
		return;
	}
	if(trim(form.email.value) == '')
	{
		alert( 'Поле "email" должно быть заполнено.' );
		form.email.focus();
		return;
	}
	if(!isEmail(form.email.value))
	{
		alert( 'Не корректный email.' );
		form.email.focus();
		return;
	}
	if(trim(form.phone.value) == '')
	{
		alert( 'Поле "Телефон" должно быть заполнено.' );
		form.phone.focus();
		return;
	}
	
	if(confirm('Сохранить изменения?'))
	{
		if( form.password.value == '<%=defaultPassword%>' )
			form.password.value = '';
		form.submit();
	}
}
</SCRIPT>
<FORM NAME="main_form" ACTION="xt_admin.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=admin.getId() != null ? admin.getId() : ""%>">
<INPUT TYPE="hidden" NAME="action" VALUE="save_admin">
<TABLE WIDTH="620" BORDER="0" CELLPADDING="0" CELLSPACING="1">
	<TR>
		<TD COLSPAN="2" ALIGN="left">
			<A HREF="admins.jsp">назад к списку администраторов</A><BR>
			<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
		</TD>
	</TR>

<%	if( id != null && !Admin.ROOT_NAME.equals(admin.getLogin())){ %>
	<TR>
		<TD ALIGN="right" COLSPAN="2" HEIGHT="16">
			<A HREF="permissions.jsp?id=<%=admin.getId()%>">права доступа</a>
		</TD>
	</TR>
<%	} %>
	
	<TR>
		<TD CLASS="c2" HEIGHT="16" COLSPAN="5" ALIGN="center">
			<B>Информация о пользователе</B>
		</TD>
	</TR>
	<TR>
		<TD CLASS="edit" HEIGHT="20" WIDTH="30%">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Login <B STYLE="color: red;">*</B></DIV>
		</TD>
		<TD CLASS="edit">
<%	if( Admin.ROOT_NAME.equals( admin.getLogin()) || admin.getId() != null){ %>
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><B><%=admin.getLogin()%></B></DIV>
			<INPUT TYPE="hidden" NAME="login" VALUE="<%=admin.getLogin()%>">
<%	}else{ %>
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="text" NAME="login" VALUE="<%=admin.getLogin()%>"></DIV>
<%	} %>
		</TD>
	</TR>
	<TR>
		<TD CLASS="edit" HEIGHT="20" WIDTH="30%">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Пароль
			<%	if( admin.getId() == null){ %><B STYLE="color: red;">*</B><% } %></DIV>
		</TD>
		<TD CLASS="edit">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="password" NAME="password" VALUE="<%=defaultPassword%>"></DIV>
		</TD>
	</TR>
	<TR>
		<TD CLASS="edit" HEIGHT="20" WIDTH="30%">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">ФИО <B STYLE="color: red;">*</B></DIV>
		</TD>
		<TD CLASS="edit">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="text" NAME="name" SIZE="70" VALUE="<%=CMSApplication.toHTML( admin.getName())%>"></DIV>
		</TD>
	</TR>
	<TR>
		<TD CLASS="edit" HEIGHT="20" WIDTH="30%">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">E-mail <B STYLE="color: red;">*</B></DIV>
		</TD>
		<TD CLASS="edit">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="text" NAME="email" SIZE="35" VALUE="<%=CMSApplication.toHTML( admin.getEmail())%>"></DIV>
		</TD>
	</TR>
	<TR>
		<TD CLASS="edit" HEIGHT="20" WIDTH="30%">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Телефон <B STYLE="color: red;">*</B></DIV>
		</TD>
		<TD CLASS="edit">
			<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="text" NAME="phone" SIZE="35" VALUE="<%=CMSApplication.toHTML( admin.getPhone())%>"></DIV>
		</TD>
	</TR>
<!-- белая полоска --><TR><TD COLSPAN="2"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=1><BR></TD></TR>
	<TR ALIGN="center">
		<TD COLSPAN="2">
			<INPUT TYPE="button" VALUE="Сохранить" ONCLICK="submitForm();">
		</TD>
	</TR>
</TABLE>
<BR>
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
Поля отмеченные <B STYLE="color: red;">*</B> обязательны для заполнения.
</DIV>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
