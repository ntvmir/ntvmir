<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%
    String fio = "";
    String email = "";
    String country = "";
    String city = "";
    String icq = "";
    String url = "";
    String extra = "";
    String sign = "";
    boolean visible = true;
    String login = "";
    if(user != null)
    {
        fio = user.getName();
        email = user.getEmail();
        country = user.getCountry();
        city = user.getCity();
        icq = user.getIcq();
        url = user.getUrl();
        extra = user.getDescription();
        sign = user.getForumSign();
        visible = user.isVisible();
        login = user.getLogin();
    }
    Enumeration countryEnum = CMSApplication.getApplication().getCountries(langCode);
    String message = null;
    String err = request.getParameter("err");
    if("login".equals(err))
        message = "Пользователь с таким логином уже зарегистрирован.";
    else if("email".equals(err))
        message = "Пользователь с таким e-mail уже зарегистрирован. Воспользуйтесь функцией <a href=\"/pages/" + langCode + "/auth\">\"Забыли пароль\"</a>.";
    else if("save".equals(err))
        message = "Ошибка при сохранении данных.";
    if("1".equals(request.getParameter("reg_ok")))
        message = "Регистрация прошла успешно. На Ваш e-mail отправлено письмо с логином и паролем.";
%>


<%---- заголовочек Информация о пользователе-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/registration/ttl-usr-info.gif" height="19" alt="Информация о пользователе" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек Информация о пользователе-----%>


<%  if(message != null)
    {
%>
<div align="center" class="smallFont" style="color: red; margin-top: 10pt; margin-bottom; 10pt;"><%=message%></div>
<%  } %>
<%---- пояснения -----%>
	<table border="0" cellpadding="0" cellspacing="8" style="margin-top:38px;" width="180" align="right">
	<tr>
	<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
	<td class="smallFont">
			поля отмеченные 
			<SPAN class="str">*</SPAN>
			являются обязательными для заполнения
	</td>
	</tr>		
	</table>
<%----//пояснения -----%>

<%---- USER INFORMATION -----%>

<script language="JavaScript" src="/inc/func.js"></script>
<script language="JavaScript">
function submitForm()
{
    var frm = document.mainform;
    if(!isEmail(frm.email.value))
    {
        alert("Проверте правильность ввода e-mail");
        frm.email.focus();
        return;
    }
    frm.login.value = trim(frm.login.value);
    if(frm.login.value == "")
    {
        alert("Не указан логин.");
        frm.login.focus();
        return;
    }
<%  if(user != null)
    {
%>
    if(frm.password.value.length < 3)
    {
        alert("Пароль слишком короткий.");
        frm.password.focus();
        return;
    }
    if(frm.password.value != frm.password2.value)
    {
        alert("Введенные пароли не совпадают.");
        frm.password2.focus();
        return;
    }
<%  } %>
    frm.submit();
}
</script>
	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="4" style="margin-top:4px;">
	<TR>
	<form action="/user/xt_auth.jsp" method="post" name="mainform">
	<input type="hidden" name="action" value="save">
	<input type="hidden" name="id" value="<%=pageId%>">
	<input type="hidden" name="back_page_id" value="<%=backPageId%>">
	<td><div style="width:8;"><SPACER TYPE="block" HEIGHT="1" WIDTH="8"></div></td>
	<TD class="defFont"><div style="width:125;"><SPACER TYPE="block" HEIGHT="1" WIDTH="125"></div>ФИО</TD><TD width="240"><INPUT TYPE="text" name="name" value="<%=CMSApplication.toHTML(fio)%>" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">E-mail<SPAN CLASS="str">*</SPAN></TD><TD><INPUT TYPE="text" name="email" value="<%=CMSApplication.toHTML(email)%>" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">Страна</TD><TD>
	<DIV class="SELnn"><SELECT name=country  style="width:220;" width="220">
	<OPTION>Выберите из списка</OPTION>
<%  
    while(countryEnum.hasMoreElements())
    {	
        Country cnt = (Country)countryEnum.nextElement();
%>
	<OPTION value="<%=cnt.getName()%>"<%=cnt.getName().equals(country) ? " selected":""%>><%=cnt.getName()%></OPTION>
<%  } %>
    </SELECT></DIV>
	</TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">Город</TD><TD><INPUT TYPE="text" NAME="city" VALUE="<%=CMSApplication.toHTML(city)%>" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">Номер ICQ</TD><TD><INPUT TYPE="text" name="icq" VALUE="<%=CMSApplication.toHTML(icq)%>" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">Страница Интернет</TD><TD><INPUT TYPE="text" name="url" VALUE="<%=CMSApplication.toHTML(url)%>" STYLE="width:220;" SIZE="28" maxlength="256" value="http://"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD  COLSPAN="2" class="defFont"><div STYLE="margin:3px 0px 0px 0px;">Дополнительная информация</div><div class="SELnn"><TEXTAREA maxlength="1000" name="extra" COLS="47" ROWS="5" STYLE="width:352;margin:3px 0px 0px 0px;" WRAP="ON"><%=CMSApplication.toHTML(extra)%></TEXTAREA></div></TD>
	</TR>	
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

	<TR><td></td>
	<TD  COLSPAN="2" class="defFont"><div STYLE="margin:3px 0px 0px 0px;">Подпись в сообщениях форума</div><div class="SELnn"><TEXTAREA maxlength="256" name="sign" COLS="47" ROWS="3" STYLE="width:352;margin:3px 0px 0px 0px;" WRAP="ON"><%=CMSApplication.toHTML(sign)%></TEXTAREA></div></TD>
	</TR>	


	<TR><td></td>
	<TD  COLSPAN="2"><div STYLE="margin:3px 0px 0px -4px;"><input type="checkbox" name="visible" value="1" id="showInfo"<%=visible ? " checked" : ""%>><LABEL for="showInfo"><SPAN class="XsmallFont">Показывать мои данные пользователям форума</SPAN></LABEL></div></TD>
	</TR>	
	</TABLE>
	<%----//USER  INFORMATION ---%>
	
	<br>
	
	
<%---- заголовочек Регистрационные данные-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/registration/ttl-reg-data.gif" height="19" alt="Регистрационные данные" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек Регистрационные данные-----%>

<%---- пояснения -----%>
<% if(user != null){ %>
	<table border="0" cellpadding="0" cellspacing="8" style="margin-top:38px;" width="180" align="right">
	<tr>
	<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
	<td class="smallFont">
        не менее 3 символов
	</td>
	</tr>		
	</table>
<%  }else{ %>
	<table border="0" cellpadding="0" cellspacing="8" width="180" align="right">
	<tr>
	<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
	<td class="smallFont">
        Пароль будет отправлен на указаный Вами e-mail. Вы сможете поменять его после авторизации.
	</td>
	</tr>		
	</table>
<%  } %>

<%----//пояснения -----%>

<%---- LOGIN  INFORMATION -----%>	
	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="4" style="margin-top:4px;">
	<TR><td><div style="width:8;"><SPACER TYPE="block" HEIGHT="1" WIDTH="8"></div></td>
	<TD class="defFont"><div style="width:125;"><SPACER TYPE="block" HEIGHT="1" WIDTH="125"></div>Логин<SPAN class="str">*</SPAN></TD><TD width="240"><INPUT TYPE="text" name="login" value="<%=CMSApplication.toHTML(login)%>" STYLE="width:220;" <%=user != null ? " disabled" : ""%> SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  if(user != null){ %>
	<TR><td></td>
	<TD class="defFont">Пароль<SPAN CLASS="str">*</SPAN></TD><TD><INPUT TYPE="password" name="password" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>	
	<TR><td></td>
	<TD class="defFont">Подтверждение<SPAN CLASS="str">*</SPAN></TD><TD><INPUT TYPE="password" name="password2" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
<%  } %>
	</table>
<%---- //LOGIN  INFORMATION -----%>	

<br>


<%---- заголовочек Параметры подписки-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/registration/ttl-subs.gif" height="19" alt="Параметры подписки" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек Параметры подписки-----%>

<%---- SUBSCRIBE -----%>
<div style="margin:6px 0px 0px 0px;">
<%
    Enumeration enum = tengry.cms.mailer.Delivery.getDeliveries(langCode);
    Delivery dlvNewsDay = null;
    Delivery dlvTvDay = null;
    Delivery dlvTvWeek = null;
    boolean isNewsDaySubscribed = false;
    boolean isTvDaySubscribed = false;
    boolean isTvWeekSubscribed = false;
    String  showPlaceId = "";
    
    while(enum.hasMoreElements())
    {
        Delivery dlv = (Delivery)enum.nextElement();
        if(Tvschedule.SERVICE_CODE.equals(dlv.getCode()) && dlv.getFrequency() == Delivery.DAILY)
            dlvTvDay = dlv;
        else if(Tvschedule.SERVICE_CODE.equals(dlv.getCode()) && dlv.getFrequency() == Delivery.WEEKLY)
            dlvTvWeek = dlv;
        else if("news".equals(dlv.getCode()) && dlv.getFrequency() == Delivery.DAILY)
            dlvNewsDay = dlv;
    }
    
    RS userSubscriptionRS = null;
    if(user != null)
        userSubscriptionRS = user.getSubscriptions();
    
    while(userSubscriptionRS != null && userSubscriptionRS.next())
    {
        String dlvId = userSubscriptionRS.getString("m_delivery_id");
        if(dlvId.equals(dlvNewsDay.getId()))
            isNewsDaySubscribed = true;
        else if(dlvId.equals(dlvTvDay.getId()))
        {
            isTvDaySubscribed = true;
            showPlaceId = userSubscriptionRS.getString("m_show_place_id");
        }
        else if(dlvId.equals(dlvTvWeek.getId()))
        {
            isTvWeekSubscribed = true;
            showPlaceId = userSubscriptionRS.getString("m_show_place_id");
        }
    }
    if(showPlaceId == null || showPlaceId.length() == 0)
        showPlaceId = CMSApplication.getCookie(request, "tvschedule.showplace");
%>
<table border="0" cellpadding="2" cellspacing="0" width="375">
<%  if(dlvNewsDay != null){ %>
	<tr><td align="right"><div style="width:30;"><SPACER TYPE="block" HEIGHT="1" WIDTH="30"></div><input type="checkbox" name="subscr_news" value="<%=dlvNewsDay.getId()%>" id="news"<%=isNewsDaySubscribed ? " checked" :""%>></td><td class="defFont" width="100%"><LABEL for="news">Новости</LABEL></td></tr>
<!-- divider --><tr><td height="11" colspan="2" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  } %>
<%  if(dlvTvWeek != null){ %>
	<tr><td align="right"><input type="radio" name="subscr_tv" value="<%=dlvTvWeek.getId()%>" id="weeklyTVp"<%=!isTvDaySubscribed && isTvWeekSubscribed? " checked" :""%>></td><td class="defFont"><LABEL for="weeklyTVp"><%=dlvTvWeek.getName()%></LABEL></td></tr>
<%  } %>
<%  if(dlvTvDay != null){ %>
	<tr><td align="right"><input type="radio" name="subscr_tv" value="<%=dlvTvDay.getId()%>" id="dailyTVp"<%=isTvDaySubscribed && !isTvWeekSubscribed? " checked" :""%>></td><td class="defFont"><LABEL for="dailyTVp"><%=dlvTvDay.getName()%></LABEL></td></tr>
<%  } %>
	<tr><td align="right"><input type="radio" name="subscr_tv" value="" id="noneTVp"<%=!isTvDaySubscribed && !isTvWeekSubscribed? " checked" :""%>></td><td class="defFont"><LABEL for="noneTVp">Не получать</LABEL></td></tr>
<!-- divider --><tr><td height="11" colspan="2" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>		
<tr>
<td></td>
<td class="defFont">
Часовой пояс
<DIV style="margin-top:7px;"><SELECT name="show_place_id" style="width:329;font-size:10px;font-family:Tahoma;" width="329">
<%
    Enumeration spEnum = ShowPlace.getShowPlaces(langCode);
    while(spEnum.hasMoreElements())
    {
        ShowPlace sp = (ShowPlace)spEnum.nextElement();
%>
	<option value="<%=sp.getId()%>"<%=sp.getId().equals(showPlaceId) ? " SELECTED" : ""%>><%=sp.getTimeZone().getName()%> <%=CMSApplication.toHTML(sp.getName())%></option>
<%	} %>
</SELECT>
</DIV>
<div style="margin:5px 0px 0px -6px;">
<table border="0" cellpadding="2" cellspacing="0">
	<tr valign="top">
	<td><input type="checkbox" value="1" name="cookie_gmt" id="GMT" checked></td>
	<td class="XsmallFont" style="padding-top:7px;"><LABEL for="GMT">Запомнить выбранный часовой пояс<br> для отображения телепрограммы на сайте</LABEL></td>
	</tr>
</table>
</div>
</td></tr>
<!-- divider --><tr><td height="11" colspan="2" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>		

<tr>
<td colspan="2"><a href="javascript:submitForm();"><img src="<%=des%>/registration/btn-reggy.gif" height="18" alt="Зарегистрироваться" border="0" hspace="14"></a></td>
</form></tr>		
</table>
</div>
