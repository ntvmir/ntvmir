<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Product.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	Enumeration enum = Product.getProducts(CMSApplication.LANG_RUS);
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="���������"/>
<jsp:param name="header" value="������ ���������"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	
<%
    response.setHeader( "Pragma", "no-cache" );
	String error = request.getParameter("error");
%>

<SCRIPT>
function order_delete()
{
	if ( confirm( '������� ���������?' ) ) 
	{
		document.forms['FORM1'].mode.value = 'order_delete';
		document.forms['FORM1'].submit();
	}
}
</SCRIPT>
</HEAD>

<DIV ALIGN="right">
<A HREF="orders.jsp">������ ������</A>
</DIV>

<%
if( error!=null && error.equals("on_update") )
{
	out.println( "<BR><BR><B>������ ��� ���������� ������. �������� ������ ��� ������������ ���(�����, ��������) ���������.</B>" );
}
else if( error!=null && error.equals("on_delete") )
{
	out.println( "<BR><BR><B>������ ��� �������� ������. �������� ���� ����������� ������� �������� ���� ��������� ������������ � �������</B>" );
}
%>
<BR>
<BR>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR BGCOLOR="#C0C0C0">
<TD HEIGHT="20" CLASS="titnew" COLSPAN="3" ALIGN="center"><DIV STYLE="padding-left:6px;padding-right:6px" CLASS="titnew"><B>������ ���������</B>
<A HREF="product_edit.jsp?mode=add">��������</A></DIV>
</DIV></TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<B>��� ���������</B>
</DIV></TD>
<TD CLASS="c1" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<B>�����</B>
</DIV></TD>
<TD CLASS="c1" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<B>����� ��������</B>
</DIV></TD>
</TR>

<%
	while(enum.hasMoreElements())
	{
		Product prod = (Product)enum.nextElement();
%>
<TR>
<TD CLASS="<%=prod.isVisible()?"c1":"c3"%>" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="product_edit.jsp?prodId=<%=prod.getId()%>"><B><%=prod.getTypeRus()%></B></A>
</DIV></TD>
<TD CLASS="<%=prod.isVisible()?"c1":"c3"%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=prod.getMarkRus()%>
</DIV></TD>
<TD CLASS="<%=prod.isVisible()?"c1":"c3"%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=prod.getDeliveryRus()%>
</DIV></TD>
</TR>
<%
	}
%>
</TABLE>
<BR>

</BODY>
</HTML>