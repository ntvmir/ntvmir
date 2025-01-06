<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Product.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%

	SimpleDateFormat sdf = new SimpleDateFormat( "dd.MM.yyyy" );
		
	String orderId = request.getParameter( "orderId" );
	if( "".equals(orderId))
		orderId = null;

	Order order = new Order();

	if(orderId != null )
	{
		try
		{
			order.load(orderId );
		}
		catch( Exception e )
		{
			out.println( "Ошибка при загрузке данных" );
		}
	}
	else if( ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "orders.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
		
	
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Продукция"/>
<jsp:param name="header" value="Редактирование заявки"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	

<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function checkForm( form )
{
	if ( trim(form.organization.value) == '' )
	{
		alert( "Компания не заполнена." );
		form.organization.focus();
		return false;
	}
	
	if ( trim(form.name.value) == '' )
	{
		alert( "Имя не заполнено." );
		form.name.focus();
		return false;
	}

	
	if ( trim(form.title.value) == '' )
	{
		alert( "Должность не заполнена." );
		form.title.focus();
		return false;
	}

	if ( trim(form.country.value) == '' )
	{
		alert( "Страна не выбрана." );
		form.country.focus();
		return false;
	}
	
	if ( trim(form.city.value) == '' )
	{
		alert( "Поле Город не заполнено." );
		form.city.focus();
		return false;
	}


	if ( trim(form.phone.value) == '' )
	{
		alert( "Телефон не заполнен." );
		form.phone.focus();
		return false;
	}

	if (!isEmail(form.email.value) )
	{
		alert( "Неверно заполнен email адресс" );
		form.email.focus();
		return false;
	}

	

	var num = form.f_prod_num.value;
	var pp = 0;

	for(var i = 1; i <= num; i++)
	{
		if(badVol(form['f_volume_' + i].value))
		{
			alert('Не верный формат числа');
			form['f_volume_' + i].focus();
			return false;
		}
		if(form['f_volume_' + i].value != '')
			pp ++;
	}

	if(pp == 0)
	{
		alert('Не выбран ни один продукт');
		return false;
	}
		
	if(confirm('Сохранить изменения?'))
		return true;
	return false;
}

function product_delete()
{
	if ( confirm('Удалить продукты из заявки?') ) 
	{
		document.forms['ORDER'].mode.value = 'order_products_delete';
		document.forms['ORDER'].submit();
	}
}
function badVol(s)
{
	return (s != '' && !isNumber(s));
}
</SCRIPT>
<A HREF="orders.jsp?">назад</A>
 
<FORM NAME="ORDER" ACTION="xt_order.jsp" METHOD="post" ONSUBMIT="return checkForm( document.ORDER )">
<INPUT TYPE="Hidden" NAME="mode" VALUE="<%=request.getParameter("mode")%>">
<INPUT TYPE="Hidden" NAME="orderId" VALUE="<%=orderId%>">

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">

<TR>
<TD HEIGHT="20" CLASS="titnew" ALIGN="center">
<DIV STYLE="padding-left:6px;padding-right:6px" CLASS="titnew">
<B>Редактирование заявки</B>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
Дата заявки:
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<B><%=sdf.format( order.getRecordDate() )%></B>
</DIV>
</TD>
</TR>


<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Компания <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="organization" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getCompany())%>">
</DIV>
</TD>
</TR>



<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Имя <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="name" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getName())%>">
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Должность <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="title" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getPosition())%>">
</DIV>
</TD>
</TR>




<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Страна <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<SELECT NAME="country">
<OPTION VALUE=""<%=order.getCountryId() == null ? " SELECTED":""%>>выберите из списка</OPTION>
<%
	Enumeration countries = CMSApplication.getApplication().getCountries(CMSApplication.LANG_RUS);
	while(countries.hasMoreElements())
	{
		Country cnt = (Country)countries.nextElement();
%>
<OPTION VALUE="<%=cnt.getId()%>"<%=cnt.getId().equals(order.getCountryId()) ? " SELECTED":""%>><%=cnt.getNameEng()%></OPTION>
<%
	}
%>
</SELECT></DIV>
</TD>
</TR>


<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Город <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="city" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getCity())%>">
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Адрес</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="address" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getAddress())%>">
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Телефон <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="phone" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getPhone())%>">
</DIV>
</TD>
</TR>



<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Факс</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="fax" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getFax())%>">
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Email <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="email" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getEmail())%>">
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Адрес в Интернет
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="url" STYLE="width:320" SIZE="34" VALUE="<%=CMSApplication.toHTML(order.getUrl())%>">
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Дополнительные условия
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<TEXTAREA NAME="conditions" STYLE="width:320"><%=CMSApplication.toHTML(order.getConditions())%></TEXTAREA>
</DIV>
</TD>
</TR>



<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Тип компании <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="radio" NAME="comtype" VALUE="P" <%=order.getCompanyType() == Order.COMPANY_PRODUCER ? " CHECKED" : ""%>>производитель
<INPUT TYPE="radio" NAME="comtype" VALUE="T" <%=order.getCompanyType() == Order.COMPANY_TRADER? " CHECKED" : ""%>>трейдер
</DIV>
</TD>
</TR>



<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Периодичность поставок <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="radio" NAME="periodic" VALUE="Y" <%=order.getFrequency() == Order.FREQUENCY_MANY ? "CHECKED" : ""%>>регулярные
<INPUT TYPE="radio" NAME="periodic" VALUE="N" <%=order.getFrequency() == Order.FREQUENCY_ONE ? "CHECKED" : ""%>>разовые
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Опыт работы с ЗАО "Нортгаз" <B STYLE="color: red;">*</B>
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="radio" NAME="reccurance" VALUE="Y" <%= order.isExperience() ? "CHECKED" : ""%> ONCLICK="this.form.reccurance[1].checked=false;">есть
<INPUT TYPE="radio" NAME="reccurance" VALUE="N" <%=!order.isExperience() ? "CHECKED" : ""%> ONCLICK="this.form.reccurance[0].checked=false;">нет
</DIV>
</TD>
</TR>
</TABLE>
<BR>



<!--#################################################################################################3-->

<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="700">
<TR>
<TD VALIGN="bottom" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px">Тип продукции</DIV></TD>
<TD VALIGN="bottom" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px">Марка</DIV></TD>
<TD VALIGN="bottom" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px">Форма поставки</DIV></TD>
<TD VALIGN="bottom" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px">Объем закупок</DIV></TD>
</TR>


<%
	Hashtable productQuantities = order.getProductQuantities();
	
	String prevT = "some-unique-name...  bla-bla-bla....";
	String prevM = "some-unique-name...  bla-bla-bla....";
	int ll = 0;
	Enumeration enum = Product.getProducts(CMSApplication.LANG_RUS);
	while(enum.hasMoreElements())
	{
		
		Product prod = (Product)enum.nextElement();
		if(!prod.isVisible())
			continue;
		ll ++;
		String typeName = prod.getTypeRus();
		if(typeName.equals(prevT))
			typeName = "&nbsp;";
		else
			prevT = typeName;

		String markName = prod.getMarkRus();
		if(markName.equals(prevM))
			markName = "&nbsp;";
		else
			prevM = markName;
		int quantity = 0;
		Integer quantityObj = (Integer)productQuantities.get(prod.getId());
		if(quantityObj != null)
			quantity = quantityObj.intValue();
%>

<TR>
<INPUT TYPE="hidden" NAME="f_prod_id_<%=ll%>" VALUE="<%=prod.getId()%>">
<TD VALIGN="bottom" CLASS="c1"><DIV STYLE="padding-bottom:6px;padding-left:6px;padding-right:6px"><%=typeName%></DIV></TD>
<TD VALIGN="bottom" CLASS="c1"><DIV STYLE="padding-bottom:6px;padding-left:6px;padding-right:6px"><%=markName%></DIV></TD>
<TD VALIGN="bottom" CLASS="c1"><DIV STYLE="padding-bottom:6px;padding-left:6px;padding-right:6px"><%=prod.getDeliveryRus()%></DIV></TD>
<TD ALIGN="center" WIDTH="1%" CLASS="c1"><INPUT TYPE="text" NAME="f_volume_<%=ll%>" VALUE="<%=quantity > 0 ? ""+quantity : ""%>" STYLE="width:50;margin:10 0 -1 0;" SIZE="7"></TD>
</TR>
<%	} %>
<INPUT TYPE="hidden" NAME="f_prod_num" VALUE="<%=ll%>">
<TR>
<TD HEIGHT="20" ALIGN="center" COLSPAN="4">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5 ALT="" BORDER="0"><BR>
<INPUT TYPE="button" VALUE="Сохранить" ONCLICK="if(checkForm(document.ORDER)) document.ORDER.submit();">
</TD>
</TR>
</TABLE>
<!--#################################################################################################3-->




<%--
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="655">

<%
if( orderId != null )
{%>
<TR>
<TD CLASS="c2" HEIGHT="20" COLSPAN="3">
<DIV STYLE="padding-left:6px;padding-right:6px"><B>Список продукции в заявке</B>
<A HREF="order_product_edit.jsp?mode=order_product_add&orderId=<%=orderId%>&productId=">добавить продукт</A>
</DIV>
</TD>
</TR>

<TD WIDTH="1%" HEIGHT="20" CLASS="c1">
</TD>
<TD WIDTH="380" CLASS="c1" ALIGN="left">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Название продукции</B>
</DIV></TD>
<TD WIDTH="120" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<B>Количество(м<SUP>3</SUP>)</B>
</DIV>
</TD>

<%

Enumeration enum = order.getProducts();

while(enum.hasMoreElements())
{
	Product p = (Product) enum.nextElement();
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="checkbox" NAME="orderproduct" VALUE="<%=p.getId()%>">
</DIV>
</TD>
<TD WIDTH="380" CLASS="c1" ALIGN="left">
<DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="order_product_edit.jsp?mode=order_product_edit&orderId=<%=orderId%>&productId=<%=p.getId()%>"><%=p.getTypeRus()%>, <%=p.getMarkRus()%></A>
</DIV></TD>
<TD WIDTH="120" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=p.getQuantity()%>
</DIV>
</TD>
</TR>
<%
}
%>

<TR>
<TD HEIGHT="20" CLASS="c1" COLSPAN="3">
<DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="javascript:product_delete();">удалить</A><BR>
</DIV>
</TD>
</TR>
<%
}	// if order_edit
%>
</TABLE>
--%>
<BR>
<DIV STYLE="padding-left:6px;padding-right:6px">
Поля отмеченные  <B STYLE="color: red;">*</B> обязательны для заполнения.
</DIV>
</FORM>
</BODY>
</HTML>
