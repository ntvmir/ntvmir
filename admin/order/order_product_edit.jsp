<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Product.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
    response.setHeader( "Pragma", "no-cache" );

	String orderId = request.getParameter( "orderId" );
	String productId = request.getParameter( "productId" );

	SimpleDateFormat sdf = new SimpleDateFormat( "dd.MM.yyyy" );
	
	int quantity = -1;

	if(orderId != null && orderId.length() > 0 && productId != null && productId.length() > 0)
	{
		DBStatement st = new DBStatement("SELECT m_quantity FROM col_order_product WHERE m_order_id=? AND m_product_id=?");
		st.setString(1, orderId);
		st.setString(2, productId);
		RS rs = st.executeQuery();
		if(rs.next())
			quantity = rs.getInt("m_quantity");
	}
	
	if( ! Admin.isW( pageAccessCode ))
	{
		response.sendRedirect( "order_edit.jsp?mode=order_edit&orderId=" + orderId + 
								"&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	

%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Продукция"/>
<jsp:param name="header" value="Редактирование продукта в заказе"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	

<SCRIPT LANGUAGE="JavaScript">
<%@ include file="/admin/inc/functions.js"%>
function checkForm( form )
{
	if ( form.product.selectedIndex == 0 )
	{
		alert( "Выберите товар" );
		form.product.focus();
		return false;
	}
	
	if ( form.quantity.value == '' || !isNumber(form.quantity.value) )
	{
		alert( "Неверно заполнено количества товара" );
		form.quantity.focus();
		return false;
	}

	
	return true;
}
</SCRIPT>
<A HREF="order_edit.jsp?orderId=<%=orderId%>">назад</A>
 
<FORM NAME="ORDER_PRODUCT" ACTION="xt_order.jsp" METHOD="post" ONSUBMIT="if ( !checkForm( document.ORDER_PRODUCT ) ) return false;">
<INPUT TYPE="Hidden" NAME="mode" VALUE="set_product">
<INPUT TYPE="Hidden" NAME="orderId" VALUE="<%=orderId%>">
<INPUT TYPE="Hidden" NAME="productId" VALUE="<%=productId%>">

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="655">

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
Продукт 
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1">
<DIV STYLE="padding-left:6px;padding-right:6px">
<SELECT NAME="product" STYLE="width:500" >
<OPTION VALUE="">-------------</OPTION>
<%
	Enumeration enum = Product.getProducts(CMSApplication.LANG_RUS);
	while(enum.hasMoreElements())
	{
		Product prod = (Product)enum.nextElement();
%>
<OPTION VALUE="<%=prod.getId()%>"<%=prod.getId().equals(productId) ? " SELECTED" : ""%>><%=prod.getTypeRus()%>(<%=prod.getMarkRus()%>)</OPTION>
<%
	}
%>
</SELECT>
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">Заказанное количество (кг)
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="quantity" STYLE="width:120" SIZE="34" VALUE="<%=quantity > 0 ? ""+quantity : ""%>">
</DIV>
</TD>
</TR>

<TR>
<TD HEIGHT="20" ALIGN="center">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5 ALT="" BORDER="0"><BR>
<INPUT TYPE="submit" VALUE="Сохранить">
</TD>
</TR>

</TABLE>

</FORM>

</BODY>
</HTML>
