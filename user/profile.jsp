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
        message = "������������ � ����� ������� ��� ���������������.";
    else if("email".equals(err))
        message = "������������ � ����� e-mail ��� ���������������. �������������� �������� <a href=\"/pages/" + langCode + "/auth\">\"������ ������\"</a>.";
    else if("save".equals(err))
        message = "������ ��� ���������� ������.";
    if("1".equals(request.getParameter("reg_ok")))
        message = "����������� ������ �������. �� ��� e-mail ���������� ������ � ������� � �������.";
%>


<%---- ����������� ���������� � ������������-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/registration/ttl-usr-info.gif" height="19" alt="���������� � ������������" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//����������� ���������� � ������������-----%>


<%  if(message != null)
    {
%>
<div align="center" class="smallFont" style="color: red; margin-top: 10pt; margin-bottom; 10pt;"><%=message%></div>
<%  } %>
<%---- ��������� -----%>
	<table border="0" cellpadding="0" cellspacing="8" style="margin-top:38px;" width="180" align="right">
	<tr>
	<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
	<td class="smallFont">
			���� ���������� 
			<SPAN class="str">*</SPAN>
			�������� ������������� ��� ����������
	</td>
	</tr>		
	</table>
<%----//��������� -----%>

<%---- USER INFORMATION -----%>

<script language="JavaScript" src="/inc/func.js"></script>
<script language="JavaScript">
function submitForm()
{
    var frm = document.mainform;
    if(!isEmail(frm.email.value))
    {
        alert("�������� ������������ ����� e-mail");
        frm.email.focus();
        return;
    }
    frm.login.value = trim(frm.login.value);
    if(frm.login.value == "")
    {
        alert("�� ������ �����.");
        frm.login.focus();
        return;
    }
<%  if(user != null)
    {
%>
    if(frm.password.value.length < 3)
    {
        alert("������ ������� ��������.");
        frm.password.focus();
        return;
    }
    if(frm.password.value != frm.password2.value)
    {
        alert("��������� ������ �� ���������.");
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
	<TD class="defFont"><div style="width:125;"><SPACER TYPE="block" HEIGHT="1" WIDTH="125"></div>���</TD><TD width="240"><INPUT TYPE="text" name="name" value="<%=CMSApplication.toHTML(fio)%>" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">E-mail<SPAN CLASS="str">*</SPAN></TD><TD><INPUT TYPE="text" name="email" value="<%=CMSApplication.toHTML(email)%>" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">������</TD><TD>
	<DIV class="SELnn"><SELECT name=country  style="width:220;" width="220">
	<OPTION>�������� �� ������</OPTION>
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
	<TD class="defFont">�����</TD><TD><INPUT TYPE="text" NAME="city" VALUE="<%=CMSApplication.toHTML(city)%>" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">����� ICQ</TD><TD><INPUT TYPE="text" name="icq" VALUE="<%=CMSApplication.toHTML(icq)%>" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont">�������� ��������</TD><TD><INPUT TYPE="text" name="url" VALUE="<%=CMSApplication.toHTML(url)%>" STYLE="width:220;" SIZE="28" maxlength="256" value="http://"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD  COLSPAN="2" class="defFont"><div STYLE="margin:3px 0px 0px 0px;">�������������� ����������</div><div class="SELnn"><TEXTAREA maxlength="1000" name="extra" COLS="47" ROWS="5" STYLE="width:352;margin:3px 0px 0px 0px;" WRAP="ON"><%=CMSApplication.toHTML(extra)%></TEXTAREA></div></TD>
	</TR>	
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

	<TR><td></td>
	<TD  COLSPAN="2" class="defFont"><div STYLE="margin:3px 0px 0px 0px;">������� � ���������� ������</div><div class="SELnn"><TEXTAREA maxlength="256" name="sign" COLS="47" ROWS="3" STYLE="width:352;margin:3px 0px 0px 0px;" WRAP="ON"><%=CMSApplication.toHTML(sign)%></TEXTAREA></div></TD>
	</TR>	


	<TR><td></td>
	<TD  COLSPAN="2"><div STYLE="margin:3px 0px 0px -4px;"><input type="checkbox" name="visible" value="1" id="showInfo"<%=visible ? " checked" : ""%>><LABEL for="showInfo"><SPAN class="XsmallFont">���������� ��� ������ ������������� ������</SPAN></LABEL></div></TD>
	</TR>	
	</TABLE>
	<%----//USER  INFORMATION ---%>
	
	<br>
	
	
<%---- ����������� ��������������� ������-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/registration/ttl-reg-data.gif" height="19" alt="��������������� ������" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//����������� ��������������� ������-----%>

<%---- ��������� -----%>
<% if(user != null){ %>
	<table border="0" cellpadding="0" cellspacing="8" style="margin-top:38px;" width="180" align="right">
	<tr>
	<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
	<td class="smallFont">
        �� ����� 3 ��������
	</td>
	</tr>		
	</table>
<%  }else{ %>
	<table border="0" cellpadding="0" cellspacing="8" width="180" align="right">
	<tr>
	<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
	<td class="smallFont">
        ������ ����� ��������� �� �������� ���� e-mail. �� ������� �������� ��� ����� �����������.
	</td>
	</tr>		
	</table>
<%  } %>

<%----//��������� -----%>

<%---- LOGIN  INFORMATION -----%>	
	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="4" style="margin-top:4px;">
	<TR><td><div style="width:8;"><SPACER TYPE="block" HEIGHT="1" WIDTH="8"></div></td>
	<TD class="defFont"><div style="width:125;"><SPACER TYPE="block" HEIGHT="1" WIDTH="125"></div>�����<SPAN class="str">*</SPAN></TD><TD width="240"><INPUT TYPE="text" name="login" value="<%=CMSApplication.toHTML(login)%>" STYLE="width:220;" <%=user != null ? " disabled" : ""%> SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  if(user != null){ %>
	<TR><td></td>
	<TD class="defFont">������<SPAN CLASS="str">*</SPAN></TD><TD><INPUT TYPE="password" name="password" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>	
	<TR><td></td>
	<TD class="defFont">�������������<SPAN CLASS="str">*</SPAN></TD><TD><INPUT TYPE="password" name="password2" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
<%  } %>
	</table>
<%---- //LOGIN  INFORMATION -----%>	

<br>


<%---- ����������� ��������� ��������-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/registration/ttl-subs.gif" height="19" alt="��������� ��������" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//����������� ��������� ��������-----%>

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
	<tr><td align="right"><div style="width:30;"><SPACER TYPE="block" HEIGHT="1" WIDTH="30"></div><input type="checkbox" name="subscr_news" value="<%=dlvNewsDay.getId()%>" id="news"<%=isNewsDaySubscribed ? " checked" :""%>></td><td class="defFont" width="100%"><LABEL for="news">�������</LABEL></td></tr>
<!-- divider --><tr><td height="11" colspan="2" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  } %>
<%  if(dlvTvWeek != null){ %>
	<tr><td align="right"><input type="radio" name="subscr_tv" value="<%=dlvTvWeek.getId()%>" id="weeklyTVp"<%=!isTvDaySubscribed && isTvWeekSubscribed? " checked" :""%>></td><td class="defFont"><LABEL for="weeklyTVp"><%=dlvTvWeek.getName()%></LABEL></td></tr>
<%  } %>
<%  if(dlvTvDay != null){ %>
	<tr><td align="right"><input type="radio" name="subscr_tv" value="<%=dlvTvDay.getId()%>" id="dailyTVp"<%=isTvDaySubscribed && !isTvWeekSubscribed? " checked" :""%>></td><td class="defFont"><LABEL for="dailyTVp"><%=dlvTvDay.getName()%></LABEL></td></tr>
<%  } %>
	<tr><td align="right"><input type="radio" name="subscr_tv" value="" id="noneTVp"<%=!isTvDaySubscribed && !isTvWeekSubscribed? " checked" :""%>></td><td class="defFont"><LABEL for="noneTVp">�� ��������</LABEL></td></tr>
<!-- divider --><tr><td height="11" colspan="2" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>		
<tr>
<td></td>
<td class="defFont">
������� ����
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
	<td class="XsmallFont" style="padding-top:7px;"><LABEL for="GMT">��������� ��������� ������� ����<br> ��� ����������� ������������� �� �����</LABEL></td>
	</tr>
</table>
</div>
</td></tr>
<!-- divider --><tr><td height="11" colspan="2" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>		

<tr>
<td colspan="2"><a href="javascript:submitForm();"><img src="<%=des%>/registration/btn-reggy.gif" height="18" alt="������������������" border="0" hspace="14"></a></td>
</form></tr>		
</table>
</div>
