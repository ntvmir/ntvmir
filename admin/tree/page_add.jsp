<%--
Parameters:
	"page_id"
		values:	correct page id
		descr:	the parent node id
--%>
<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<% String pageId = request.getParameter( "page_id" ); %>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	if(!Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Дерево сайта"/>
<jsp:param name="header" value="Добавление страницы"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	if(document.main_form.page_type.value == "static")
	{
		document.main_form.action = "page_edit.jsp";
	}
	return true;
}
</SCRIPT>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" ALIGN="center">
<FORM ACTION="custom_page_edit.jsp" METHOD="post" NAME="main_form" onSubmit="submitForm();">
<INPUT TYPE="hidden" NAME="page_id" VALUE="<%=pageId%>">
<INPUT TYPE="hidden" NAME="mode" VALUE="add">
<TR>
<TD ALIGN="CENTER">
<B>Выберите тип добавляемой страницы</B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>
<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<SELECT NAME="page_type" STYLE="width:500">
<%
	Enumeration enum = CMSApplication.getApplication().getPageTypes();
	while(enum.hasMoreElements())
	{
		PageType type = (PageType)enum.nextElement();

		if(type.getCode().equals("release"))
			continue;


		if(!type.isVisible())
			continue;
		out.print("<OPTION VALUE=\"" + type.getCode() + "\">" );
		out.print(type.getTypeName());
		out.println("</OPTION>");
	}
%>
</SELECT>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>
<TR>
<TD ALIGN=CENTER><BR><BR>
<INPUT TYPE="Submit" VALUE="Далее">
</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
