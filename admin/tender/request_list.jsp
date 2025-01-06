<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = TenderRequest.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>
<%!
	String buildPath(WebTreeNode node)
	{
		if(node == null) return "";
		if(node.getParent() == null)
			return node.getNameRus();
		return buildPath(node.getParent()) + "/" + node.getNameRus();
	}
%>
<%
	String nodeId = request.getParameter("page_id");
	WebTreeNode node = CMSApplication.getApplication().lookup(nodeId);
	if(node == null || !currentAdmin.isR(nodeId))
	{
		response.sendRedirect( "/admin/tender/requests.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}
	
	int pageNumber = 1;
	int pageSize = 15;
	try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}
	String header = "Тендер: \"" + buildPath(node) + "\"";
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	int num = TenderRequest.getTenderRequestNum(nodeId);
	Enumeration enum = TenderRequest.getTenderRequests(nodeId, null, pageNumber, pageSize);
	String message = "";
	if("1".equals(request.getParameter("action_done")))
		message = "Выбранные завяки были удалены.";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Тендерные заявки"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	if(confirm("Вы действительно хотите удалить заявки?"))
		document.main_form.submit();
}
</SCRIPT>
<%
	if(num > 0)
		printNavigator(pageNumber, pageSize, num, "tender_list.jsp?page_id=" + nodeId, "700", out);
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM ACTION="xt_requests.jsp" METHOD="post" NAME="main_form">
<INPUT TYPE="hidden" NAME="page_id" VALUE="<%=nodeId%>">
<INPUT TYPE="hidden" NAME="mode" VALUE="del">
<TR>
<TD COLSPAN="4" ALIGN="center"HEIGHT="20">
<B>Тендерные заявки</B>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20"><BR></TD>
<TD CLASS="c2" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<B>Компания</B></DIV></TD>
<TD CLASS="c2" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<B>Объем поставки</B></DIV></TD>
<TD CLASS="c2" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<B>Цена</B></DIV></TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		TenderRequest tenderRequest = (TenderRequest)enum.nextElement();
		String style = "c1";
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="requests" VALUE="<%=tenderRequest.getId()%>">
</TD>
<TD WIDTH="50%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="request_view.jsp?id=<%=tenderRequest.getId()%>"><%=CMSApplication.toHTML(tenderRequest.getCompany())%></DIV>
</TD>
<TD WIDTH="50%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getAmount())%></DIV>
</TD>
<TD CLASS="" WIDTH="1%" VALIGN="middle" CLASS="<%=style%>" >
<DIV STYLE="padding-left:6px;padding-right:6px"><%=CMSApplication.toHTML(tenderRequest.getPrice())%></DIV>
</TD>
</TR>
<%	
		l++;
	} 
%>
<TR>
<TD COLSPAN="4" HEIGHT="20"><A HREF="javascript: submitForm();">удалить</A><BR></TD>
</FORM>
</TABLE>

<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
