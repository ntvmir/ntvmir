<%
        String message = null;
        if("auth".equals(request.getParameter("err")))
            message = "Неверный логин/пароль";
        else if("1".equals(request.getParameter("reg_ok")))
            message = "Регистрация прошла успешно. На Ваш e-mail отправлено письмо с логином и паролем.";

%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
<TR VALIGN="top">
<TD WIDTH="55%" class="defFont">

<!---- заголовочек ЗАРЕГЕСТРИРОВАННЫЙ ----->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/authorization/ttl-reg.gif" height="19" alt="Зарегестрированный пользователь" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<!----//заголовочек ЗАРЕГЕСТРИРОВАННЫЙ ----->
<div style="width:100%;padding:10px 0px 0px 16px;">
<P>
Для доступа к страницам защищенной области пользовательской части сайта, пожалуйста пройдите авторизацию:
</P>
<%  if(message != null)
    {
%>
<div align="left" style="color: red; margin-bottom: 10pt;"><%=message%></div>
<%  } %>


<!---- LOGIN FORMZ -----><TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<FORM ACTION="/user/xt_auth.jsp" method="post">
<input type="hidden" name="id" value="<%=pageId%>">
<input type="hidden" name="action" value="login">
<input type="hidden" name="back_page_id" value="<%=backPageId != null ? backPageId : ""%>">
<TD class="defFont" WIDTH="70">Логин:</TD><TD><INPUT TYPE="text" name="login" STYLE="width:85;" SIZE="11"></TD>
</TR>
<tr><td height="7"></td></tr>
<TR>
<TD class="defFont">Пароль:</TD><TD><INPUT TYPE="password" name="password" STYLE="width:85;" SIZE="11"><input type="Image"src="<%=des%>/forum/btn-entr.gif" width="43" height="18" border="0" hspace="10" alt="Вход" align="absbottom"></TD>
</FORM>
</TR>
</TABLE><!----//LOGIN FORMZ----->
<BR>
<BR>
</div>
<!---- заголовочек Забыли пароль? ----->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/authorization/ttl-psw.gif" height="19" alt="Забыли пароль?" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<!----//заголовочек Забыли пароль? ----->
<div style="width:100%;padding:10px 0px 0px 16px;">
<P>
Воспользуйтесь функцией автоматической идентификации зарегистрированного пользователя по e-mail и отсылки Вашего пароля по данному e-mail
</P>
<!---- EMAIL FORMZ ----->
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
	<form action="/user/xt_auth.jsp">
	<input type="hidden" name="id" value="<%=pageId%>">
	<input type="hidden" name="action" value="send_pass">
	<td class="defFont">E-mail:</td>
	</tr>
	<tr>
	<tr><td><input type="text" name="email" style="width:155;" size="11"><input type="Image"src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="10" align="absmiddle"></td>
	
	</form>
	</tr>
	</table>
<!----//EMAIL FORMZ----->
</div>
</TD>
<TD><div style="width:15"><SPACER TYPE="block" WIDTH="15"></div></TD>
<TD BGCOLOR="#DDE6F0"><div style="width:1"><SPACER TYPE="block" WIDTH="1"></div></TD>
<TD><div style="width:15"><SPACER TYPE="block" WIDTH="15"></div></TD>
<TD WIDTH="45%" class="defFont">

<!---- заголовочек НОВЫЙ----->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/authorization/ttl-new.gif" height="19" alt="Новый пользователь" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<!----//заголовочек НОВЫЙ ----->
<div style="width:100%;padding:10px 0px 0px 16px;">
Если вы не зарегестрированы в системе для доступа к страницам защищенной области пользовательской части сайта, пожалуйста заполните <A HREF="/pages/<%=langCode%>/auth?create=1">регистрационную&nbsp;форму</A> нового пользователя.</P>
</div>
</TD>
</TR>
</TABLE>
<!----// CONTENT ----->
