<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Product.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%

	Product product = new Product();
	String mode		= request.getParameter( "mode" );
	String prodId = request.getParameter( "prodId" );
	if("".equals(prodId))
		prodId = null;
	if( mode == null )
	{
		mode = "edit";
	}
	
	if( prodId == null  && ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "product.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	if( mode.equals( "edit" ) )
	{
		// загружаем товар
		try
		{
			product.load(prodId);
		}
		catch( Exception we )
		{
			out.println( we);
		}
	}
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Продукция"/>
<jsp:param name="header" value="Продукция"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	

<SCRIPT LANGUAGE="JavaScript">
function form_check( frm )
{
	if( frm.typerus.value.length==0 || frm.typeeng.value.length==0 )
	{
		frm.typerus.focus();
		alert('Не заполнен тип продукции');
		return false;
	}
}

function product_delete( frm )
{
	if( confirm('Удалить?') )
	{
		frm.mode.value = "delete";
		frm.submit();
	}
}
</SCRIPT>

</HEAD>

<A HREF="product.jsp">назад</A>
<BR>
<BR>
<FORM NAME="FRM_PROD" ACTION="xt_product.jsp" METHOD="post" ONSUBMIT="return form_check(this);">

<INPUT TYPE="Hidden" NAME="mode" VALUE="<%=mode%>">
<INPUT TYPE="Hidden" NAME="prodId" VALUE="<%=prodId==null? "" : prodId%>">

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<TR>
<TD COLSPAN="3" ALIGN="CENTER">
<B>Продукт</B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Тип продукции</B><BR>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD CLASS="c2">&nbsp;<B>Type of product</B></TD>
</TD>
</TR>

<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="typerus" VALUE="<%= mode.equals( "edit" ) ? CMSApplication.toHTML(product.getTypeRus()) : "" %>" STYLE="width:350" SIZE="34"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="typeeng" VALUE="<%= mode.equals( "edit" ) ? CMSApplication.toHTML(product.getTypeEng()) : "" %>" STYLE="width:350" SIZE="34"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Марка</B>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Mark</B>
</TD>
</TR>

<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="markrus" VALUE="<%= mode.equals( "edit" ) ? CMSApplication.toHTML(product.getMarkRus()) : "" %>" STYLE="width:350" SIZE="34"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="markeng" VALUE="<%= mode.equals( "edit" ) ? CMSApplication.toHTML(product.getMarkEng()) : "" %>" STYLE="width:350" SIZE="34"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Форма поставки</B>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Form of delivery</B>
</TD>
</TR>

<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="shiprus" VALUE="<%= mode.equals( "edit" ) ? CMSApplication.toHTML(product.getDeliveryRus()) : "" %>" STYLE="width:350" SIZE="34"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="shipeng" VALUE="<%= mode.equals( "edit" ) ? CMSApplication.toHTML(product.getDeliveryEng()) : "" %>" STYLE="width:350" SIZE="34"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>
<TD COLSPAN="3"><BR>
<INPUT TYPE="checkbox" NAME="isVisible" VALUE="1" <%=product.isVisible()? "CHECKED" : ""%>> включение в список продукции<BR><BR>
</TD>
</TR>

<TR>
<TD ALIGN=CENTER>
<INPUT TYPE="Submit" VALUE="Сохранить" ONCLICK="return confirm('Сохранить изменения?');">
</TD>
<TD>
</TD>
<TD ALIGN=CENTER>
<%if(!mode.equals("add")) {%>
<INPUT TYPE="Button" VALUE="Удалить" ONCLICK="product_delete(this.form);">
<%}%>
</TD>
</TR>

</TABLE>
</FORM>

</BODY>
</HTML>
