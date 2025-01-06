<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = ISIDemon.SERVICE_CODE;
%>
<%@ page import="tengry.northgas.isi.*"%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%
	String sPeriod = CMSApplication.getApplication().getStoredProperty(ISIDemon.ISI_DEMON_PERIOD_PROP);
	String importNodeId = CMSApplication.getApplication().getStoredProperty(ISIDemon.ISI_NEWS_PAGE_ID_PROP);
	String sProcDate = CMSApplication.getApplication().getStoredProperty(ISIDemon.ISI_LAST_PROCESS_PROP);

	long period = -1;
	try{ period = Long.parseLong(sPeriod); }catch(Exception e){}
	if(period < 0)
		period = ISIDemon.ISI_DEFAULT_PERIOD_IN_MILLIS;
	
	period /=  1000*60*60;

	if(sProcDate == null)
		sProcDate = "";

	String error = request.getParameter("error");
	String message = "";
	if("1".equals(error))
		message = "Не верно задан интервал между запусками";
	if("2".equals(error))
		message = "Не выбрана лента для импорта";
	
	if("set".equals(request.getParameter("action_done")))
		message = "Параметры установлены, процесс перезапущен.";

	Enumeration enum = CMSApplication.getApplication().getNodesByTypeCode(News.SERVICE_CODE);
%>
<%!
	String buildPath(WebTreeNode node)
	{
		if(node == null) return "";
		if(node.getParent() == null)
			return node.getNameRus();
		return buildPath(node.getParent()) + "/" + node.getNameRus();
	}
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Импорт новостей"/>
<jsp:param name="header" value="Импорт новостей"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	if(confirm("Сохранить значения и перезапустить процесс импорта?"))
		document.main_form.submit();
}
</SCRIPT>

<FORM ACTION="xt_isi_news.jsp" METHOD="post" NAME="main_form" onSubmit="return confirm('Сохранить значения и перезапустить процесс импорта?');">
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD ALIGN="left" CLASS="c2" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR>
<B>Дата последнего запуска</B>
</NOBR></DIV></TD>
<TD ALIGN="left" WIDTH="100%" CLASS="c1" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=sProcDate%>
</DIV></TD>
</TR>
<TR>
<TD ALIGN="left" CLASS="c2" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR>
<B>Интервал между запусками</B>
</NOBR></DIV></TD>
<TD ALIGN="left" WIDTH="100%" CLASS="c1" HEIGHT="20"><DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="text" NAME="period" VALUE="<%=period%>" SIZE="10"> (в часах)
</DIV></TD>
</TR>
</TABLE>

<BR><BR>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD COLSPAN="2" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Новостная лента для импорта</B>
</TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		WebTreeNode node = (WebTreeNode)enum.nextElement();
		String style = node.isVisible() ? "c1" : "c3";
		String sPrivate = isPagePrivate(node.getId()) ? "<B STYLE=\"color: red;\">*</B>" : "";
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="radio" NAME="news_page_id" VALUE="<%=node.getId()%>"<%=node.getId().equals(importNodeId) ? " CHECKED" : ""%>>
</TD>

<TD HEIGHT="20" CLASS="<%=style%>">
<DIV STYLE="padding-left:6px;padding-right:6px">
<%=sPrivate + buildPath(node)%>
</DIV></TD>
</TR>
<%	
		l++;
	} 
%>
</FORM>
</TABLE>

<BR><BR>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD ROWSPAN="3" WIDTH="10"><IMG SRC="/admin/img/blank.gif" WIDTH="10" HEIGHT="1"><BR></TD>
<TD WIDTH="15" ALIGN="center"><B STYLE="color: red;">*</B></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">просмотр ленты доступен только для зарегистрированных пользователей;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">лента опубликована в пользовательской части;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">лента не опубликована в пользовательской части;</TD>
</TR>
</TABLE>
<BR><BR>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD ALIGN="center">
<INPUT TYPE="button" VALUE="Сохранить значения" onClick="submitForm();">
</TD>
</TR>
</TABLE>
</FORM>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
