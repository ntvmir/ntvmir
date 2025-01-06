<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Product.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>
<%

	int pageNumber = 1;
	int pageSize = 15;
	try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	int num = Order.getOrderNum();
	Enumeration enum = Order.getOrders(pageNumber, pageSize);
	
	String message = "";
	if("save".equals(request.getParameter("action_done")))
		message = "Заказ сохранен.";
	else if("del".equals(request.getParameter("action_done")))
		message = "Выбранные заказы были удалены.";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Продукция"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="header" value="Список заказов"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	



<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	if(confirm("Вы действительно хотите удалить заказы?"))
		document.main_form.submit();
}
</SCRIPT>
<DIV ALIGN="right">
<A HREF="product.jsp">список продукции</A>
</DIV>
<%
	if(num > 0)
		printNavigator(pageNumber, pageSize, num, "orders.jsp?", "700", out);
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM ACTION="xt_order.jsp" METHOD="post" NAME="main_form">
<INPUT TYPE="hidden" NAME="mode" VALUE="del">
<TR>
<TD COLSPAN="5" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Заказы</B>
<A HREF="order_edit.jsp?orderId=&mode=order_add">добавить заказ</A>
</TD>
</TR>
<TR>
<TD ALIGN="center" CLASS="c2" HEIGHT="20">&nbsp;</TD>
<TD ALIGN="center" CLASS="c2" HEIGHT="20">дата</TD>
<TD ALIGN="center" CLASS="c2" HEIGHT="20">Компания</TD>
<TD ALIGN="center" CLASS="c2" HEIGHT="20">Имя</TD>
<TD ALIGN="center" CLASS="c2" HEIGHT="20">E-mail</TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		Order order = (Order)enum.nextElement();
		String style = "c1";
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="orders" VALUE="<%=order.getId()%>">
</TD>
<TD WIDTH="10%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="order_edit.jsp?orderId=<%=order.getId()%>&mode=order_edit"><%=sdf.format(order.getRecordDate())%></DIV>
</TD>
<TD WIDTH="30%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><%=CMSApplication.toHTML(order.getCompany())%></TD>
<TD WIDTH="30%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><%=CMSApplication.toHTML(order.getName())%></TD>
<TD WIDTH="30%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><%=CMSApplication.toHTML(order.getEmail())%></TD>
</TR>
<%	
		l++;
	} 
%>
<TR>
<TD COLSPAN="4" HEIGHT="20"><A HREF="javascript: submitForm();">удалить</A><BR></TD>
</TR>
</FORM>
</TABLE>

<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
