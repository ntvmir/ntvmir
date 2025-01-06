<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.user.*"%>
<%@ page import="tengry.cms.product.*"%>
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

/*  7 */ {	"",
			"" },

/*  8 */ {	"",
			"" },

/*  9 */ {	"Поля отмеченные ",
			"Fields marked with" },

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

/* 24 */ {	"Тип компании",
			"Company type" },

/* 25 */ {	"Желаемая периодичность поставок",
			"Frequency of deliveries" },

/* 26 */ {	"Дополнительные условия",
			"Extra conditions" },

/* 27 */ {	"Ваш  заказ принят к расмотрению.<BR>Благодарим за сотрудничество.",
			"Your order is entertained.<BR>Thank you for cooperation." },

/* 28 */ {	"Не верный формат числа",
			"Bad number format" },

/* 29 */ {	"Не выбран ни один продукт",
			"No products selected" },

/* 30 */ {	"Опыт работы с ЗАО \"Нортгаз\"",
			"Work experience with ZAO \"Northgas\"" },

/* 31 */ {	"Тип продукции",
			"Type of product" },

/* 32 */ {	"Марка",
			"Grade" },

/* 33 */ {	"Форма поставки",
			"Form of delivery" },

/* 34 */ {	"Объем закупок",
			"Volume of purchase" },

/* 35 */ {	"Производитель",
			"Manufacturer" },
			
/* 36 */ {	"Трейдер",
			"Trader" },
			
/* 37 */ {	"Регулярные",
			"Regular" },
			
/* 38 */ {	"Разовые",
			"One-time" },

/* 39 */ {	"Есть",
			"Yes" },
			
/* 40 */ {	"Нет",
			"No" }
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

Enumeration enum = Product.getProducts(lang);

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
	    if (numStr.indexOf(thisChar,0) == -1)
        {
			return false;
        }
    }

	return true;
}

function badVol(s)
{
	return (s != '' && !isNumber(s));
}

function submitForm()
{
	
	var frm = document.main_form;

	var num = frm.f_prod_num.value;
	var pp = 0;

	for(var i = 1; i <= num; i++)
	{
		if(badVol(frm['f_volume_' + i].value))
		{
			alert('<%=text(lang, 28)%>');
			frm['f_volume_' + i].focus();
			return;
		}
		if(frm['f_volume_' + i].value != '')
			pp ++;
	}

	if(pp == 0)
	{
		alert('<%=text(lang, 29)%>');
		return;
	}
	
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
	if(trim(frm.f_country_id.value) == '')
	{
		alert('<%=text(lang, 3)%>');
		frm.f_country_id.focus();
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

	frm.submit();
}
-->
</SCRIPT>



<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="500">
<FORM ACTION="/product/xt_order.jsp" NAME="main_form" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=pageId%>">
<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
<TR>
<TD VALIGN="bottom" CLASS="ttl"><%=text(lang, 31)%></TD>
<TD VALIGN="bottom" CLASS="ttl"><%=text(lang, 32)%></TD>
<TD VALIGN="bottom" CLASS="ttl"><%=text(lang, 33)%></TD>
<TD VALIGN="bottom" CLASS="ttl"><%=text(lang, 34)%></TD>
</TR>

<TR><TD COLSPAN="4" BACKGROUND="<%=des%>/main/dotz_420.gif" HEIGHT="13"><SPACER TYPE="block" HEIGHT="13" WIDTH="1"></TD></TR>

<%
	String prevT = "some-unique-name...  bla-bla-bla....";
	String prevM = "some-unique-name...  bla-bla-bla....";
	int ll = 0;
	while(enum.hasMoreElements())
	{
		
		Product prod = (Product)enum.nextElement();
		if(!prod.isVisible())
			continue;
		ll ++;
		String typeName = lang == E ? prod.getTypeEng() : prod.getTypeRus();
		if(typeName.equals(prevT))
			typeName = "&nbsp;";
		else
			prevT = typeName;

		String markName = lang == E ? prod.getMarkEng() : prod.getMarkRus();
		if(markName.equals(prevM))
			markName = "&nbsp;";
		else
			prevM = markName;
%>

<TR>
<INPUT TYPE="hidden" NAME="f_prod_id_<%=ll%>" VALUE="<%=prod.getId()%>">
<TD VALIGN="bottom"><%=typeName%></TD>
<TD VALIGN="bottom"><%=markName%></TD>
<TD VALIGN="bottom"><%=(lang == E ? prod.getDeliveryEng() : prod.getDeliveryRus())%></TD>
<TD ALIGN="right"><INPUT TYPE="text" NAME="f_volume_<%=ll%>" STYLE="width:50;margin:10 0 -1 0;" SIZE="7"></TD>
</TR>
<%	} %>
<INPUT TYPE="hidden" NAME="f_prod_num" VALUE="<%=ll%>">
<TR><TD COLSPAN="4" BACKGROUND="<%=des%>/main/dotz_420.gif" HEIGHT="13"><SPACER TYPE="block" HEIGHT="13" WIDTH="1"></TD></TR>

</TABLE>




<BR><BR><BR>




<SPAN STYLE="font-size:12px;Font-family:verdana;color:#FF0000;"><B>!</B></SPAN>
<%=text(lang, 9)%> 
<SPAN  STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
<%=text(lang, 10)%>
<P>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="380">
<TR>
<TD COLSPAN="3">
<SPAN CLASS="ttl"><%=text(lang, 11)%></SPAN>
</TD>
</TR>
<TR><TD COLSPAN="3" BACKGROUND="<%=des%>/main/dotz_420.gif" HEIGHT="13"><SPACER TYPE="block" HEIGHT="13" WIDTH="1"></TD></TR>
<TR>
<TD WIDTH="20" ROWSPAN="11"><SPACER TYPE="block" HEIGHT="1" WIDTH="20"></TD><TD VALIGN="bottom" WIDTH="130"><%=text(lang, 12)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_company" VALUE="<%=CMSApplication.toHTML(user.getCompany())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom" WIDTH="130"><%=text(lang, 13)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_name" VALUE="<%=CMSApplication.toHTML(user.getFirstName())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 14)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_position" VALUE="<%=CMSApplication.toHTML(user.getPosition())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 15)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD STYLE="font-size:10px;">
<SELECT NAME="f_country_id" STYLE="width:230;margin:10 0 0 0;" width=227>
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
<TD VALIGN="bottom"><%=text(lang, 18)%></TD><TD><INPUT NAME="f_address" VALUE="<%=CMSApplication.toHTML(user.getAddress())%>" TYPE="text" STYLE="width:230;margin:10 0 0 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 19)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_phone" VALUE="<%=CMSApplication.toHTML(user.getPhone())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 20)%></TD><TD><INPUT NAME="f_fax" VALUE="<%=CMSApplication.toHTML(user.getFax())%>" TYPE="text" STYLE="width:230;margin:10 0 0 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 21)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD><TD><INPUT TYPE="text" NAME="f_email" VALUE="<%=CMSApplication.toHTML(user.getEmail())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD VALIGN="bottom"><%=text(lang, 22)%></TD><TD><INPUT TYPE="text" NAME="f_url" VALUE="<%=CMSApplication.toHTML(user.getUrl())%>" STYLE="width:230;margin:10 0 -1 0;" SIZE="23"></TD>
</TR>
<TR>
<TD HEIGHT="44"><%=text(lang, 24)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD>
<TD>
	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="margin:4 0 0 -5;">
		<TR>
		<TD><INPUT NAME="f_company_type" TYPE="radio" VALUE="P" ID="manufacturer" CHECKED STYLE="background:#FFFFFF;"></TD><TD><LABEL FOR="manufacturer"><%=text(lang, 35)%></LABEL></TD>
		<TD WIDTH="10"></TD>
		<TD><INPUT NAME="f_company_type" TYPE="radio" VALUE="T" ID="trader"></TD><TD><LABEL FOR="trader"><%=text(lang, 36)%></LABEL></TD>
		</TR>
	</TABLE>
</TD>
</TR>

<TR><TD COLSPAN="3" BACKGROUND="<%=des%>/main/dotz_420.gif" HEIGHT="13"><SPACER TYPE="block" HEIGHT="13" WIDTH="1"></TD></TR>

<TR>
<TD><BR></TD>
<TD VALIGN="bottom"><%=text(lang, 26)%></TD>
<TD><TEXTAREA NAME="f_conditions" STYLE="width:230;margin:10 0 -1 0;" COLS="23" ROWS="2"></TEXTAREA></TD>
</TR>

<TR><TD COLSPAN="3" BACKGROUND="<%=des%>/main/dotz_420.gif" HEIGHT="13"><SPACER TYPE="block" HEIGHT="13" WIDTH="1"></TD></TR>

<TR>
<TD></TD><TD VALIGN="bottom" COLSPAN="2">
	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
		<TR>
		<TD HEIGHT="30" WIDTH="215"><%=text(lang, 25)%><SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD>
		<TD STYLE="padding-top:4;"><INPUT NAME="f_frequency" TYPE="radio" VALUE="many" ID="regular" CHECKED STYLE="background:#FFFFFF;"></TD><TD STYLE="padding-top:4;"><LABEL FOR="regular"><%=text(lang, 37)%></LABEL></TD>
		</TR>
		<TR>		
		<TD></TD>
		<TD><INPUT NAME="f_frequency" TYPE="radio" VALUE="one" ID="once"></TD><TD><LABEL FOR="once"><%=text(lang, 38)%></LABEL></TD>
		</TR>
	</TABLE>
</TD>
</TR>

<TR>
<TD></TD><TD VALIGN="bottom" COLSPAN="2">
	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
		<TR>
		<TD HEIGHT="30" WIDTH="215"><%=text(lang, 30)%>  <SPAN><SUP STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SUP></SPAN></TD>
		<TD STYLE="padding-top:4;"><INPUT NAME="f_experience" TYPE="radio" VALUE="yes" CHECKED ID="yes"  STYLE="background:#FFFFFF;"></TD><TD STYLE="padding-top:4;"><LABEL FOR="yes"><%=text(lang, 39)%></LABEL></TD>
		</TR>
		<TR>		
		<TD></TD>	
		<TD><INPUT NAME="f_experience" TYPE="radio" VALUE="no" ID="no"></TD><TD><LABEL FOR="no"><%=text(lang, 40)%></LABEL></TD>
		</TR>
	</TABLE>
</TD>
</TR>

<TR>
<TD COLSPAN="3">
<DIV STYLE="margin:20 0 0 40;" ALIGN="center">
<A HREF="javascript: submitForm();"><IMG SRC="<%=des%>/btnz/ok.gif" WIDTH="33" HEIGHT="16" ALT="ok" BORDER="0" HSPACE="0" VSPACE="2"></A><IMG SRC="<%=des%>/main/v_dotz.gif" WIDTH="1" HEIGHT="16" ALT="" BORDER="0" HSPACE="3" VSPACE="2"><A HREF="javascript: document.main_form.reset();"><IMG SRC="<%=des%>/btnz/reset.gif" WIDTH="49" HEIGHT="16" ALT="сброс" BORDER="0" HSPACE="0" VSPACE="2"></A><BR>
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