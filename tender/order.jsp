<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.user.*"%>
<%@ page import="tengry.northgas.*"%>
<%!	String [][] pageTexts = new String [][] {

/*  0 */ {	"Не заполнено поле Компания!",
			"Company field is empty!" },

/*  1 */ {	"Не заполнено поле Имя!",
			"Name field is empty!" },

/*  2 */ {	"Не заполнено поле Должность!",
			"Position field is empty!" },

/*  3 */ {	"Не заполнено поле Страна!",
			"Country field is empty!" },

/*  4 */ {	"Не заполнено поле Город!",
			"City field is empty!" },

/*  5 */ {	"Не заполнено поле Телефон!",
			"Phone field is empty!" },

/*  6 */ {	"Не заполнено поле E-mail!",
			"E-mail field is empty!" },

/*  7 */ {	"Не заполнено поле Объем поставки!",
			"Volume field is empty!" },

/*  8 */ {	"Не заполнено поле Цена!",
			"Price field is empty!" },

/*  9 */ {	"Поля отмеченные ",
			"Fields marked with " },

/* 10 */ {	"являются обязательными для заполнения",
			"are mandatory" },

/* 11 */ {	"Персональная информация",
			"Personal info" },

/* 12 */ {	"Компания",
			"Company" },

/* 13 */ {	"Имя",
			"Name" },

/* 14 */ {	"Должность",
			"Position" },

/* 15 */ {	"Страна",
			"Country" },

/* 16 */ {	"Выберите из списка",
			"Select country" },

/* 17 */ {	"Город",
			"City" },

/* 18 */ {	"Адрес",
			"Address" },

/* 19 */ {	"Телефон",
			"Phone" },

/* 20 */ {	"Факс",
			"Fax" },

/* 21 */ {	"E-mail",
			"E-mail" },

/* 22 */ {	"Адрес в Интернет",
			"URL" },

/* 23 */ {	"Информация о тендере",
			"Tender's info" },

/* 24 */ {	"Объем поставки",
			"Volume" },

/* 25 */ {	"Цена",
			"Price" },

/* 26 */ {	"Дополнительная информация",
			"Extra info" },

/* 27 */ {	"Ваша заявка принята к расмотрению.<BR>Благодарим за сотрудничество.",
			"You request is entertained.<BR>Thank you for cooperation." }
	};
	
	public String text(char lang, int p)
	{
		return text(p, lang);
	}
	public String text(int p, char lang)
	{
		if(lang == CMSApplication.LANG_ENG)
			return pageTexts[p][1];
		else
			return pageTexts[p][0];
	}
%>

<%!
public static final char E = CMSApplication.LANG_ENG;
public static final char R = CMSApplication.LANG_RUS;
%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
char lang = R;
if(("" + E).equals(request .getParameter("lang")))
	lang = E;

String des = CMSApplication.getApplication().getCurrentDesignPath();
des += (lang == E ? "/eng": "/rus");


String pageId = request.getParameter("id");
if("".equals(pageId))
	pageId = null;


User user = (User)session.getAttribute("northgas.user");
if(user == null)
{
	user = new User();
}

String ok = request.getParameter("ok");
if(ok == null)
{
%>
<!---- CONTENT ----->

<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">
<!--
function isNumber( digit )
{
	var numStr="0123456789";
	var thisChar;
	var len;
	
	len = digit.length;
	if( len == 0 )
		return false;
    
	for (var i=0; i<len; i++)
    {
		thisChar=digit.substring(i,i+1);
	    if (thisChar != "." &&
			numStr.indexOf(thisChar,0) == -1)
        {
			return false;
        }
    }

	return true;
}

function submitOrderForm()
{
	var frm = document.order_form;
	if(trim(frm.f_company.value) == '')
	{
		alert('<%=text(lang, 0)%>');
		frm.f_company.focus();
		return;
	}
	if(trim(frm.f_name.value) == '')
	{
		alert('<%=text(lang, 1)%>');
		frm.f_company.focus();
		return;
	}
	if(trim(frm.f_position.value) == '')
	{
		alert('<%=text(lang, 2)%>');
		frm.f_position.focus();
		return;
	}
	if(trim(frm.f_country.value) == '')
	{
		alert('<%=text(lang, 3)%>');
		frm.f_country.focus();
		return;
	}
	if(trim(frm.f_city.value) == '')
	{
		alert('<%=text(lang, 4)%>');
		frm.f_city.focus();
		return;
	}
	if(trim(frm.f_phone.value) == '')
	{
		alert('<%=text(lang, 5)%>');
		frm.f_phone.focus();
		return;
	}
	if(trim(frm.f_email.value) == '')
	{
		alert('<%=text(lang, 6)%>');
		frm.f_email.focus();
		return;
	}
	if(trim(frm.f_amount.value) == '')
	{
		alert('<%=text(lang, 7)%>');
		frm.f_amount.focus();
		return;
	}
	if(trim(frm.f_price.value) == '')
	{
		alert('<%=text(lang, 8)%>');
		frm.f_price.focus();
		return;
	}
	frm.submit();
}
-->
</SCRIPT>


<SPAN STYLE="font-size:12px;Font-family:verdana;color:#FF0000;"><B>!</B></SPAN>
<%=text(lang, 9)%> 
<SPAN  STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
<%=text(lang, 10)%>
<P>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="380">
<TR>
<FORM ACTION="/tender/xt_order.jsp" METHOD="post" NAME="order_form">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=pageId%>">
<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
<TD COLSPAN="3">
<SPAN CLASS="ttl"><%=text(lang, 11)%></SPAN>
</TD>
</TR>
<TR><TD COLSPAN="3" BACKGROUND="<%=des%>/main/dotz_420.gif" HEIGHT="13"><SPACER TYPE="block" HEIGHT="13" WIDTH="1"></TD></TR>
<TR>
<TD WIDTH="20" ROWSPAN="10"><SPACER TYPE="block" HEIGHT="1" WIDTH="20"></TD><TD VALIGN="bottom" WIDTH="130"><%=text(lang, 12)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_company" VALUE="<%=CMSApplication.toHTML(user.getCompany())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom" WIDTH="130"><%=text(lang, 13)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_name" VALUE="<%=CMSApplication.toHTML(user.getFirstName())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 14)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_position" VALUE="<%=CMSApplication.toHTML(user.getPosition())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 15)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD STYLE="font-size:10px;">
<SELECT NAME="f_country" STYLE="width:230;margin:10 0 0 0;" width=227>
<OPTION VALUE=""<%=user.getCountryId() == null ? " SELECTED":""%>><%=text(lang, 16)%></OPTION>
<%
	Enumeration countries = CMSApplication.getApplication().getCountries(lang);
	while(countries.hasMoreElements())
	{
		Country cnt = (Country)countries.nextElement();
%>
<OPTION VALUE="<%=cnt.getId()%>"<%=cnt.getId().equals(user.getCountryId()) ? " SELECTED":""%>><%=lang == E ? cnt.getNameEng() : cnt.getNameRus()%></OPTION>
<%
	}
%>
</SELECT>
</TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 17)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_city" VALUE="<%=CMSApplication.toHTML(user.getCity())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 18)%></TD><TD><INPUT TYPE="text" NAME="f_address" VALUE="<%=CMSApplication.toHTML(user.getAddress())%>" STYLE="width:230;margin:10 0 0 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 19)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_phone" VALUE="<%=CMSApplication.toHTML(user.getPhone())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 20)%></TD><TD><INPUT TYPE="text" NAME="f_fax" VALUE="<%=CMSApplication.toHTML(user.getFax())%>" STYLE="width:230;margin:10 0 0 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 21)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_email" VALUE="<%=CMSApplication.toHTML(user.getEmail())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 22)%></TD><TD><INPUT TYPE="text" NAME="f_url" VALUE="<%=CMSApplication.toHTML(user.getUrl())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD COLSPAN="3">
<BR><BR>
<SPAN CLASS="ttl"><%=text(lang, 23)%></SPAN>
</TD>
</TR>
<TR><TD COLSPAN="3" BACKGROUND="<%=des%>/main/dotz_420.gif" HEIGHT="13"><SPACER TYPE="block" HEIGHT="13" WIDTH="1"></TD></TR>

<TR>
<TD></TD><TD VALIGN="bottom"><%=text(lang, 24)%> <SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_amount" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>

<TR>
<TD></TD><TD VALIGN="bottom"><%=text(lang, 25)%> <SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_price" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>

<TR>
<TD></TD><TD VALIGN="bottom" COLSPAN="2" HEIGHT="28"><%=text(lang, 26)%></TD>
</TR>

<TR>
<TD></TD><TD VALIGN="bottom" COLSPAN="2">
<TEXTAREA COLS="36" ROWS="5" WRAP="on" NAME="f_descr" STYLE="width:360;" STYLE="margin:5 0 0 0;">
</TEXTAREA>
</TD>
</TR>


<TR>
<TD COLSPAN="3">
<DIV STYLE="margin:20 0 0 40;" ALIGN="center">
<A HREF="javascript: submitOrderForm();"><IMG SRC="<%=des%>/btnz/ok.gif" WIDTH="33" HEIGHT="16" ALT="ok" BORDER="0" HSPACE="0" VSPACE="2"></A><IMG SRC="<%=des%>/main/v_dotz.gif" WIDTH="1" HEIGHT="16" ALT="" BORDER="0" HSPACE="3" VSPACE="2"><A HREF="javascript: document.order_form.reset();"><IMG SRC="<%=des%>/btnz/reset.gif" WIDTH="49" HEIGHT="16" ALT="<%=lang == E ? "reset" : "сброс"%>" BORDER="0" HSPACE="0" VSPACE="2"></A><BR>
</DIV>
</TD>
</FORM>
</TR>
</TABLE>
</P>
<!----// CONTENT ----->
<%



}
else
{
%>
<DIV STYLE="margin:50,0,50,0" ALIGN="center">
<%=text(lang, 27)%>
<DIV>

<% } %>