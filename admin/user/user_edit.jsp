<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%
	// set the Service name for authorization
	String pageId = User.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>
<%
	String id = request.getParameter("id");
	User user = new User();
	user.load(id);
	String country = user.getCountry();
	String header = "Пользователь '"+ user.getLogin() +"'";
	
	String voidPass = "********";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Пользователь"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	var frm = document.main_form;
	if(trim(frm.f_password.value).length < 3)
	{
		alert("Пароль слишком короткий!");
		frm.f_password.focus();
		return;
	}
	if(trim(frm.f_name.value) == "")
	{
		alert("Не заполнено поле Имя!");
		frm.f_name.focus();
		return;
	}
	if(trim(frm.f_email.value) == "")
	{
		alert("Не заполнено поле E-mail!");
		frm.f_email.focus();
		return;
	}
	if(confirm("Сохранить изменения?"))
	{
		if('<%=voidPass%>' == frm.f_password.value)
			frm.f_password.value = '';
		frm.submit();
	}
}
</SCRIPT>


<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<FORM ACTION="xt_user.jsp" METHOD="post" NAME="main_form">
<INPUT TYPE="hidden" NAME="mode" VALUE="save">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=user.getId() != null ? user.getId() : ""%>">
<TR>
	<TD CLASS="c2" HEIGHT="20" COLSPAN="3" ALIGN="center">
		<DIV STYLE="padding-left:6px;padding-right:6px;"><b>Персональные данные</b></DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Логин<FONT COLOR="red">*</FONT></DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<INPUT TYPE="text" NAME="f_login" DISABLED SIZE="70" VALUE="<%=CMSApplication.toHTML( user.getLogin())%>"></DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Пароль<FONT COLOR="red">*</FONT></DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<INPUT TYPE="text" NAME="f_password" SIZE="70" VALUE="<%=voidPass%>"></DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Имя<FONT COLOR="red">*</FONT></DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<INPUT TYPE="text" NAME="f_name" SIZE="70" VALUE="<%=CMSApplication.toHTML( user.getName())%>"></DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Страна</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2"><DIV STYLE="padding-left:6px;padding-right:6px;">
		<SELECT NAME="f_country" STYLE="width:230;margin:0 0 0 0;" width=227>
		<OPTION VALUE=""<%=country == null ? " SELECTED":""%>>Виберите из списка</OPTION>
		<%
			Enumeration countries = CMSApplication.getApplication().getCountries(langCode);
			while(countries.hasMoreElements())
			{
				Country cnt = (Country)countries.nextElement();
		%>
		<OPTION VALUE="<%=cnt.getName()%>"<%=cnt.getName().equals(country) ? " SELECTED":""%>><%=cnt.getName()%></OPTION>
		<%
			}
		%>
		</SELECT>
	</TD>
</TR>


<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Город</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<INPUT TYPE="text" NAME="f_city" SIZE="70" VALUE="<%=CMSApplication.toHTML( user.getCity())%>"></DIV>
	</TD>
</TR>


<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">E-mail<FONT COLOR="red">*</FONT></DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<INPUT TYPE="text" NAME="f_email" SIZE="70" VALUE="<%=CMSApplication.toHTML( user.getEmail())%>"></DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">ICQ</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<INPUT TYPE="text" NAME="f_icq" SIZE="70" VALUE="<%=CMSApplication.toHTML( user.getIcq())%>"></DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">URL</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<INPUT TYPE="text" NAME="f_url" SIZE="70" VALUE="<%=CMSApplication.toHTML( user.getUrl())%>"></DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Дополнительно</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<TEXTAREA NAME="f_extra" cols="70" rows="3"><%=CMSApplication.toHTML( user.getDescription())%></TEXTAREA>
		</DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Подпись</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<TEXTAREA NAME="f_sign" cols="70" rows="3"><%=CMSApplication.toHTML( user.getForumSign())%></TEXTAREA>
		</DIV>
	</TD>
</TR>


<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Участие в форуме</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<INPUT TYPE="checkbox" NAME="f_disabled" VALUE="1"<%=user.isDisabled() ? "" : " CHECKED"%> ID="ccc1"> <LABEL FOR="ccc1">(разрешено/запрещено)</LABEL>
	</TD>
</TR>


<!-- белая полоска --><TR><TD COLSPAN="3"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=1><BR></TD></TR>
<TR>
	<TD CLASS="c2" HEIGHT="20" COLSPAN="3" ALIGN="center">
		<DIV STYLE="padding-left:6px;padding-right:6px;"><b>Подписка</b></DIV>
	</TD>
</TR>



<%---- SUBSCRIBE -----%>
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
    
    RS userSubscriptionRS = user.getSubscriptions();
    while(userSubscriptionRS.next())
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
%>

<%  if(dlvNewsDay != null){ %>
<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;">Новости</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<input type="checkbox" name="subscr_news" value="<%=dlvNewsDay.getId()%>" id="news"<%=isNewsDaySubscribed ? " checked" :""%>>
		</DIV>
	</TD>
</TR>
<%  } %>

<%  if(dlvTvWeek != null){ %>
<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;"><%=dlvTvWeek.getName()%></DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<input type="radio" name="subscr_tv" value="<%=dlvTvWeek.getId()%>" id="weeklyTVp"<%=!isTvDaySubscribed && isTvWeekSubscribed? " checked" :""%>>
		</DIV>
	</TD>
</TR>
<%  } %>

<%  if(dlvTvDay != null){ %>
<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;"><%=dlvTvDay.getName()%></DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<input type="radio" name="subscr_tv" value="<%=dlvTvDay.getId()%>" id="dailyTVp"<%=isTvDaySubscribed && !isTvWeekSubscribed? " checked" :""%>>
		</DIV>
	</TD>
</TR>
<%  } %>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;">Не получать</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<input type="radio" name="subscr_tv" value="" id="dailyTVp"<%=!isTvDaySubscribed && !isTvWeekSubscribed? " checked" :""%>>
		</DIV>
	</TD>
</TR>

<TR>
	<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;">Часовой пояс</DIV>
	</TD>
	<TD CLASS="c3" COLSPAN="2">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
        <SELECT name="show_place_id" style="width:329;font-size:10px;font-family:Tahoma;" width="329">
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
	</TD>
</TR>


<!-- белая полоска --><TR><TD COLSPAN="3"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=1><BR></TD></TR>
<TR ALIGN="center">
	<TD COLSPAN="3">
		<INPUT TYPE="button" VALUE="Сохранить" ONCLICK="submitForm();">
	</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
