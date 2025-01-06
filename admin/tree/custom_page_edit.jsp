<%--
Parameters:
	"page_id"
		values:	correct page id
		descr:	the node or parent node id (depend on edit or add mode corresponding)
	"mode"
		values:	"add", "edit"
		descr:	what to do
	"page_type"
		values:	correct page type or null
		desrc:	added page type
--%>
<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%	String pageId = request.getParameter( "page_id" ); %>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%
	String nodeId 	= request.getParameter( "page_id" );
	String mode = request.getParameter("mode");
	String type = request.getParameter("page_type");
	String linkId = null;
	boolean codeEditable = true;
	String header = "";
	String name = "";
	String code = "";
	boolean visible = false;
	boolean isPrivate = false;
	PageType pageType = null;
	if("edit".equals(mode))
	{
		WebTreeNode node = CMSApplication.getApplication().lookup(nodeId);
		if(node == null)
		{
			response.sendRedirect( "/admin/tree/tree.jsp" );
			return;
		}
		if(node.getParent() == null || node.getParent().getParent() == null)
	        codeEditable = false;
	    
		linkId = node.getLinkId();
		pageType = node.getPageType();
		type = pageType.getCode();
		name = node.getName();
		code = node.getCode();
		visible = node.isVisible();
		isPrivate = isPagePrivate(node.getId());
		header = "Редактирование страницы";
	}
	else
	{
		pageType = CMSApplication.getApplication().getPageTypeByCode(type);
		header = "Добавление страницы";
	}
	if(pageType != null)
		header += ": " + pageType.getTypeName();
%>
<%!
	public String path(WebTreeNode node)
	{
		String res = node.getName();
		while(node.getParent() != null)
		{
			res = node.getParent().getName() + "/" + res;
			node = node.getParent();
		}
		return res;
	}
	
	public void printTree(WebTreeNode node, String link, JspWriter out) throws IOException
	{
		if(!node.getPageType().getCode().equals("link"))
			out.println("<OPTION VALUE=\"" + node.getId() + "\" " + (node.getId().equals(link) ? "SELECTED" : "") +  ">" + path(node) + "</OPTION>");
		Enumeration enum = node.getChilds();
		while(enum.hasMoreElements())
		{
			printTree((WebTreeNode)enum.nextElement(), link, out);
		}
	}
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Дерево сайта"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="Javascript">
function submitForm()
{
	if(confirm('Сохранить изменения?'))
	{
		if(document.main_form.name.value == '')
		{
			alert("Не указан заголовок.");
			document.main_form.name.focus();
			return;
		}
		if(document.main_form.code.value == '')
		{
			alert("Не указан код.");
			document.main_form.code.focus();
			return;
		}
		document.main_form.submit();
	}
}
</SCRIPT>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" ALIGN="center">
<FORM ACTION="xt_tree.jsp" NAME="main_form" METHOD="post">
<INPUT TYPE="Hidden" NAME="mode" VALUE="<%=mode%>">
<INPUT TYPE="Hidden" NAME="page_type" VALUE="<%=type%>">
<INPUT TYPE="Hidden" NAME="node" VALUE="<%=nodeId%>">
<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Заголовок</B><BR></TD>
</TR>

<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<INPUT TYPE="text" NAME="name" VALUE="<%=CMSApplication.toHTML(name)%>" STYLE="width:700" SIZE="70"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Код</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<%  if(codeEditable){ %>
<INPUT TYPE="text" NAME="code" VALUE="<%= CMSApplication.toHTML(code) %>" STYLE="width:100%" SIZE="59"><BR>
<%  } else { %>
<INPUT TYPE="hidden" NAME="code" VALUE="<%= CMSApplication.toHTML(code) %>">
<%= CMSApplication.toHTML(code) %><BR>
<%  } %>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<%
	if("link".equals(type))
	{
%>

<TR>
<TD CLASS="c2" HEIGHT="16" ALIGN="center">&nbsp;<B>Ссылка на страницу</B><BR>
</TD>
</TR>

<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<SELECT STYLE="width: 700" SIZE="6" MULTIPLE NAME="link_id">
<%
	WebTreeNode rootNode = CMSApplication.getApplication().getWebRootFor(nodeId);
	printTree(rootNode, linkId == null ? rootNode.getId() : linkId, out);
%>
</SELECT>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>
<%	} %>

<TR>
<TD ALIGN="left">
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1"<%=visible ? " CHECKED" : ""%> ID="ckb_vis"><LABEL FOR="ckb_vis">видимая</LABEL><BR>
<INPUT TYPE="Checkbox" NAME="private" VALUE="1"<%=isPrivate ? " CHECKED" : ""%> ID="ckb_priv"><LABEL FOR="ckb_priv">доступ только для зарегистрированных пользователей</LABEL>
</TD>
</TR>

<TR>
<TD ALIGN=CENTER><BR><BR>
<INPUT TYPE="button" VALUE="Сохранить" ONCLICK="submitForm();">
</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
