<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = News.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>
<%!
	String buildPath(WebTreeNode node)
	{
		if(node == null) return "";
		if(node.getParent() == null)
			return node.getName();
		return buildPath(node.getParent()) + "/" + node.getName();
	}
%>
<%
	String nodeId = request.getParameter("page_id");
	WebTreeNode node = CMSApplication.getApplication().lookup(nodeId);
	if(node == null || !currentAdmin.isR(nodeId))
	{
		response.sendRedirect( "/admin/news/news.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}
	
	int pageNumber = 1;
	int pageSize = 15;
	try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}
	String header = "Лента новостей: \"" + buildPath(node) + "\"";
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	int num = Press.getPressNum(null, null, new News(DBObject.LOAD_LIST), nodeId);
	Enumeration enum = Press.getPress(null, null, pageNumber, pageSize, new News(DBObject.LOAD_LIST), nodeId);
	String message = "";
	String actionDone = request.getParameter("action_done");
	if("del".equals(actionDone))
		message = "Выбранные новости были удалены.";
	else if("add".equals(actionDone))
		message = "Новость добавлена";
	else if("save".equals(actionDone))
		message = "Новость сохранена";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Новости"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	if(confirm("Вы действительно хотите удалить новости?"))
		document.main_form.submit();
}
</SCRIPT>
<%
	if(num > 0)
		printNavigator(pageNumber, pageSize, num, "news_list.jsp?page_id=" + nodeId, "700", out);
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM ACTION="xt_news.jsp" METHOD="post" NAME="main_form">
<INPUT TYPE="hidden" NAME="page_id" VALUE="<%=nodeId%>">
<INPUT TYPE="hidden" NAME="mode" VALUE="del">
<TR>
<TD COLSPAN="3" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Новости</B>
<A HREF="news_edit.jsp?page_id=<%=nodeId%>&id=">добавить новость</A>
</TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		News news = (News)enum.nextElement();
		String style = "c3";
		if(!news.isVisible())
			style = "c1";
		String name = news.getCaption();
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="news" VALUE="<%=news.getId()%>">
</TD>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="news_edit.jsp?id=<%=news.getId()%>"><%=sdf.format(news.getRecordDate())%></A></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><%=name%></TD>
</TR>
<%	
		l++;
	} 
%>
<TR>
<TD COLSPAN="3" HEIGHT="20"><A HREF="javascript: submitForm();">удалить</A><BR></TD>
</TR>
</FORM>
</TABLE>

<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
