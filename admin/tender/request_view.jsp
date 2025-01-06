<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = TenderRequest.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
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
	String id = request .getParameter("id");
	TenderRequest tenderRequest = new TenderRequest();
	tenderRequest.load(id);
	String nodeId = tenderRequest.getWebPageId();

	WebTreeNode node = CMSApplication.getApplication().lookup(nodeId);
	if(node == null || ! currentAdmin.isR(nodeId))
	{
		response.sendRedirect("requests.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm");
	String header = "Заявка в тендере \"" + buildPath(node) + "\"";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Тендерные заявки"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD COLSPAN="2" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Тендерная заявкя</B>
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Дата
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=sdf.format(tenderRequest.getCreateDate())%>
</DIV>
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Компания
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getCompany())%>
</DIV>
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Объем поставки
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getAmount())%>
</DIV>
</TD>
</TR>


<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Цена
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getPrice())%>
</DIV>
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Дополнительная информация
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getDescription())%>
</DIV>
</TD>
</TR>


<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Представитель
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getLastName())%>
</DIV>
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
E-mail
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<A href="mailto:<%=tenderRequest.getEmail()%>"><%=tenderRequest.getEmail()%></A>
</DIV>
</TD>
</TR>


<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Должность
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getPosition())%>
</DIV>
</TD>
</TR>



<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Страна
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.getApplication().getCountry(tenderRequest.getCountryId()).getNameRus()%>
</DIV>
</TD>
</TR>



<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Город
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getCity())%>
</DIV>
</TD>
</TR>



<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Адрес
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getAddress())%>
</DIV>
</TD>
</TR>



<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Телефон
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getPhone())%>
</DIV>
</TD>
</TR>



<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Факс
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=CMSApplication.toHTML(tenderRequest.getFax())%>
</DIV>
</TD>
</TR>



<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR><B>
Адрес в Интернет
</B></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
<%
	if(tenderRequest.getUrl() != null && tenderRequest.getUrl().trim().length() > 0)
	{
		String pre = "";
		if(!tenderRequest.getUrl().trim().startsWith("http://"))
			pre = "http://";
%>
<A TARGET="_blank" HREF="<%=pre+tenderRequest.getUrl().trim()%>"><%=CMSApplication.toHTML(tenderRequest.getUrl())%></A>
<%	} %>
</DIV>
</TD>
</TR>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
