<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
    int MAX_NAMES_LENGTH = 160;
    
	// set the Service name for authorization
	String pageId = News.SERVICE_CODE;
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
	News news = new News(DBObject.LOAD_FULL);
	if(!create)
	{
		news.load(id);
		nodeId = news.getWebPageId();
	}
	WebTreeNode node = CMSApplication.getApplication().lookup(nodeId);
	if(node == null || ! currentAdmin.isR(nodeId))
	{
		response.sendRedirect("news.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	String header = create ? "Создание новости" : "Редактирование новости";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Новости"/>
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
	document.forms.main_form.action = 'xt_news_edit.jsp';
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
		alert("Не указан анонс у публикуемой новости");
		textareaFocus('brief');
		return;
	}
	if(frm.ckb.checked && frm.content.value.length == 0)
	{
		alert("Не указан текст у публикуемой новости");
		textareaFocus('content');
		return;
	}

	var namesLength = frm.caption.value.length + frm.brief.value.length;
    if(namesLength > <%=MAX_NAMES_LENGTH%>)
    {
        if(!confirm('Внимание!\n\nОбщее количество символов в заголовке и анонсе новости превышено на ' + 
                   (namesLength - <%=MAX_NAMES_LENGTH%> ) +
                   '. Возможно некорректное отображение новости на главной странице.\n\n' +
                   'Продолжить?'))
        {
            return;
        }
    }	

	if(confirm('Сохранить изменения?'))
	{
		frm.submit();
	}
}
</SCRIPT>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_news_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="page_id" VALUE="<%=nodeId%>">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id != null ? id : ""%>">
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Новостная лента</B><BR></TD>
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
<TD CLASS="c2" HEIGHT="16" WIDTH="50%" ALIGN="left">&nbsp;<B>Дата</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="recorddate" VALUE="<%=news.getRecordDate() != null ? sdf.format(news.getRecordDate()) : sdf.format(new Date())%>" SIZE="25" MAXLENGTH="10">
например 31.12.2001<BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Заголовок</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="caption" VALUE="<%=CMSApplication.toHTML(news.getCaption())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Источник</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="source" VALUE="<%=CMSApplication.toHTML(news.getSource())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Анонс новости</B></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "brief";
	wysiwygWidth = 700;
	wysiwygHeight = 150;
	wysiwygValue = news.getBrief();
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Текст новости</B></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "content";
	wysiwygWidth = 700;
	wysiwygHeight = 400;
	wysiwygValue = news.getContent();
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
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%=news.isVisible() ? "CHECKED" :""%> ID="ckb"><LABEL FOR="ckb">публикация на сайте</LABEL><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>



<TR>
<TD ALIGN=left>
<BR>
<INPUT TYPE="Button" VALUE="Просмотр" ONCLICK="preview();">
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
