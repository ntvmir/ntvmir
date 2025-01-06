<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Article.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
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
	String nodeId = request .getParameter("page_id");
	String id = request .getParameter("id");
	boolean create = id == null || id.length() == 0;
	Article article = new Article(DBObject.LOAD_FULL);
	if(!create)
	{
		article.load(id);
		nodeId = article.getWebPageId();
	}
	WebTreeNode node = CMSApplication.getApplication().lookup(nodeId);
	if(node == null || ! currentAdmin.isR(nodeId))
	{
		response.sendRedirect("articles.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	String header = create ? "Создание статьи" : "Редактирование статьи";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Публикации"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<%@ include file="/admin/inc/editor/editor_init.jsp"%>

<SCRIPT LANGUAGE="javascript">

function preview()
{
	window.open('','preview','');
	wysiwygPrepareParams('main_form');
	document.forms.main_form.target = 'preview';
	document.forms.main_form.action = 'preview.jsp';
	document.forms.main_form.submit();
	document.forms.main_form.action = 'xt_article_edit.jsp';
	document.forms.main_form.target='_self';
}

function submitForm()
{
	var frm = document.main_form;
	wysiwygPrepareParams('main_form');
	if(frm.caption.value.length == 0)
	{
		alert("Не указан заголовок");
		frm.caption.focus();
		return;
	}
		
	if(frm.ckb.checked && frm.brief.value.length == 0)
	{
		alert("Не указан анонс у публикуемой статьи");
		texareaFocus('brief');
		return;
	}
	if(frm.ckb.checked && frm.content.value.length == 0)
	{
		alert("Не указан текст у публикуемой статьи");
		texareaFocus('content');
		return;
	}
		
	if(confirm('Сохранить изменения?'))
	{
		frm.submit();
	}
}
</SCRIPT>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_article_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="page_id" VALUE="<%=nodeId%>">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id != null ? id : ""%>">
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Лента публикаций</B><BR></TD>
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
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Дата</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="recorddate" VALUE="<%=article.getRecordDate() != null ? sdf.format(article.getRecordDate()) : sdf.format(new Date())%>" SIZE="25" MAXLENGTH="10">
например 31.12.2001<BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Заголовок</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="caption" VALUE="<%=CMSApplication.toHTML(article.getCaption())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Автор</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="author" VALUE="<%=CMSApplication.toHTML(article.getAuthor())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Издатель</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="publisher" VALUE="<%=CMSApplication.toHTML(article.getPublisher())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Одной строкой</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="short" VALUE="<%=CMSApplication.toHTML(article.getAnnounce())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>



<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>URL издателя</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="puburl" VALUE="<%=CMSApplication.toHTML(article.getPublisherurl())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>



<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Ссылки на доп. информацию</B><BR></TD>
</TR>


<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "ref";
	wysiwygWidth = 700;
	wysiwygHeight = 100;
	wysiwygValue = article.getExtrainfourl();
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Ссылки на web-страницы</B><BR></TD>
</TR>


<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "webpages";
	wysiwygWidth = 700;
	wysiwygHeight = 100;
	wysiwygValue = article.getWebpagesurl();

%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Анонс статьи</B></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "brief";
	wysiwygWidth = 700;
	wysiwygHeight = 150;
	wysiwygValue = article.getBrief();
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Текст статьи</B></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "content";
	wysiwygWidth = 700;
	wysiwygHeight = 400;
	wysiwygValue = article.getContent();
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Публикация</B></TD>
</TR>


<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%=article.isVisible() ? "CHECKED" :""%> ID="ckb"><LABEL FOR="ckb">публикация на сайте</LABEL><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>


<TR>
<TD ALIGN=left>
<BR>
<INPUT TYPE="Button" VALUE="Просмотр" ONCLICK="preview('R');">
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
