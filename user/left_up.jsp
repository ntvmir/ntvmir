<%
    if(user == null)
    {
        String message = null;
        if("auth".equals(request.getParameter("err")))
            message = "Неверный логин/пароль";
%>
<table width="169" border="0" cellpadding="0" cellspacing="0">
<tr><td width="10"><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td><td colspan="2"><a href="/pages/<%=langCode%>/forum/list"><img src="<%=des%>/forum/btn-usr-list.gif" width="120" height="18" alt="Список пользователей" border="0"></a></td></tr>
<tr><td colspan="3"><img src="<%=des%>/2lev/lft-ln.gif" width="169" height="1" alt="" border="0" vspace="8"></td></tr>
<%---- для авторизованных это не выводим -----%>

<%  if(message != null)
    {
%>
<tr>
<td></td>
<td class="smallFont" style="color: red;" colspan="2"><%=message%><br>&nbsp;</td>
</tr>
<%  } %>


<tr>
<form action="/user/xt_auth.jsp" method="post">
<input type="hidden" name="id" value="<%=pageId%>">
<input type="hidden" name="action" value="login">
<td></td>
<td class="smallFont" colspan="2">Имя:&nbsp;</td>
</tr>

<tr>
<td></td>
<td valign="top" height="20"><input type="text" name="login" style="width:90;font-size:10px;font-family:Tahoma;" size="8"></td>
<td></td>
</tr>

<tr>
<td></td>
<td class="smallFont" colspan="2">Пароль:&nbsp;</td>
</tr>

<tr>
<td></td>
<td width="80"><input type="password" style="width:90;font-size:10px;font-family:Tahoma;" size="8" name="password"></td>
<td width="79"><input type="Image"src="<%=des%>/forum/btn-entr.gif" width="43" height="18" border="0" hspace="10" alt="Вход"></td>
</tr>

<tr>
<td></td>
<td class="smallFont" colspan="2"><input type="checkbox" name="quick_auth" value="1" id="quick_auth_id"> &#151; <label for="quick_auth_id">запомнить пароль</label>&nbsp;</td>
</tr>

<tr><td colspan="3"><img src="<%=des%>/2lev/lft-ln.gif" width="169" height="1" alt="" border="0" vspace="8"></td></tr>
<tr><td></td><td colspan="2"><a href="/pages/<%=langCode%>/auth"><img src="<%=des%>/forum/btn-reg.gif" width="108" height="18" alt="Зарегестрироваться" border="0"></a></td></tr>
</form>
<%----// для авторизованных это не выводим -----%>
</table>
<%  
    }
    else
    {
%>
<table width="169" border="0" cellpadding="0" cellspacing="0">
	<tr><td width="10"><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td><td width="159"><a href="/pages/<%=langCode%>/forum/list"><img src="<%=des%>/forum/btn-usr-list.gif" width="120" height="18" alt="Список пользователей" border="0"></a></td></tr>
	<tr><td colspan="2"><img src="<%=des%>/2lev/lft-ln.gif" width="169" height="1" alt="" border="0" vspace="8"></td></tr>
	<tr><td></td><td class="smallFont">Текущий участник &#151; <b><%=user.getLogin()%></b></td></tr>
	<tr><td></td><td><a href="/pages/<%=langCode%>/auth"><img src="<%=des%>/forum/btn-profile.gif" height="18" alt="Личные данные" border="0" vspace="10"></a></td></tr>
	<tr><td></td><td><a href="/user/xt_auth.jsp?id=<%=pageId%>&action=out"><img src="<%=des%>/forum/btn-out.gif" height="18" alt="Выход" border="0"></a></td></tr>
</table>
<%  } %>