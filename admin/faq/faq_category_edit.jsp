<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = FaqCategory.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request .getParameter("id");
	boolean create = id == null || id.length() == 0;
	FaqCategory fqc = new FaqCategory();
	if(!create)
	{
		fqc.load(id);
	}
	
	String nodeId = (create ? request .getParameter("page_id") : fqc.getWebPageId());
	WebTreeNode node = CMSApplication.getApplication().lookup(nodeId);
	if(node == null || ! currentAdmin.isR(nodeId))
	{
		response.sendRedirect("faq.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}


	String header = create ? "Создание темы вопросов и ответов" : "Редактирование темы вопросов и ответов";
%>
<%!
	String buildPath(WebTreeNode node)
	{
		if(node == null) return "";
		if(node.getParent() == null)
			return node.getName();
		return buildPath(node.getParent()) + "/" + node.getName();
	}
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Тема вопросов и ответов"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">


function submitForm()
{
	var frm = document.main_form;
	
	if(frm.name.value.length == 0)
	{
		alert("Не указан заголовок");
		frm.name.focus();
		return;
	}
	if(confirm('Сохранить изменения?'))
	{
		frm.submit();
	}
}
</SCRIPT>


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_faq_category_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id != null ? id : ""%>">
<INPUT TYPE="hidden" NAME="page_id" VALUE="<%=nodeId%>">
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Страница вопросов и ответов</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<B><%=buildPath(node)%></B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Название</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="name" VALUE="<%=CMSApplication.toHTML(fqc.getName())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Краткое описание</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<TEXTAREA NAME="descr" STYLE="width: 700;" ROWS="3" MAXLENGTH="8000"><%=fqc.getDescription()%></TEXTAREA></TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Публикация</B></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%=fqc.isVisible() ? "CHECKED" :""%> ID="ckb2"><LABEL FOR="ckb2">публиковать тему на сайте</LABEL><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>

<TR>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="Сохранить изменения" ONCLICK="submitForm();">
</TD>
</TR>
</FORM>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
