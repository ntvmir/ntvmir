<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = FaqCategory.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter("id");
	String loadType = request.getParameter("load_type");
	if(loadType == null)
	    loadType = "";
	FaqQuestion faq = new FaqQuestion();
	faq.load(id);

    FaqCategory theme = new FaqCategory();
    theme.load(faq.getFaqCategoryId());
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm");
	String header = "Редактирование вопроса";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Редактирование вопроса"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<%@ include file="/admin/inc/editor/editor_init.jsp"%>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">

function preview()
{
	window.open('','preview','');
	wysiwygPrepareParams('main_form');
	document.forms.main_form.target = 'preview';
	document.forms.main_form.action = 'preview.jsp';
	document.forms.main_form.submit();
	document.forms.main_form.action = 'xt_tvannounce_edit.jsp';
	document.forms.main_form.target='_self';
}

function submitForm()
{
	var frm = document.main_form;
	wysiwygPrepareParams('main_form');
	
	if(frm.question.value.length == 0)
	{
		alert("Не указан вопрос");
		frm.question.focus();
		return;
	}
	if(frm.user_name.value.length == 0)
	{
		alert("Не указано имя пользователя");
		frm.user_name.focus();
		return;
	}
	if(frm.answer.value.length == 0 && frm.visible.checked)
	{
		alert("Не введен ответ");
		textareaFocus('answer');
		return;
	}
	if(frm.ans_name.value.length == 0)
	{
		alert("Не указано имя отвечавшего");
		frm.ans_name.focus();
		return;
	}

	if(confirm('Сохранить изменения?'))
	{
		frm.submit();
	}
}
</SCRIPT>

&nbsp;<A HREF="questions.jsp?id=<%=theme.getId()%>&load_type=<%=loadType%>">назад к списку вопросов</A><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_question_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id%>">
<INPUT TYPE="hidden" NAME="load_type" VALUE="<%=loadType%>">

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Тема</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<B><%=CMSApplication.toHTML(theme.getName())%></B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Дата вопроса</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<B><%=sdf.format(faq.getCreateDate())%></B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Вопрос</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<TEXTAREA NAME="question" STYLE="width: 700" ROWS="3" MAXLENGTH="1000"><%=CMSApplication.toHTML(faq.getQuestion())%></TEXTAREA>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Имя пользователя</B><BR></TD>
</TR>




<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="user_name" VALUE="<%=faq.getUserName()%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>




<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>E-mail пользователя</B> (<A HREF="mailto:<%=faq.getEmail()%>"><%=faq.getEmail()%></A>)<BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="user_email" VALUE="<%=faq.getEmail()%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Дата ответа</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<B><%=faq.getAnswerDate()!= null ? sdf.format(faq.getAnswerDate()) : "будет установлена текущая дата (" + sdf.format(new Date()) + ")"%></B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Ответ</B></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "answer";
	wysiwygWidth = 700;
	wysiwygHeight = 150;
	wysiwygValue = faq.getAnswer();
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Ответил</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="ans_name" VALUE="<%=faq.getAnswerDate() == null ? currentAdmin.getName() : faq.getAnswerName()%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Публикация</B></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%=faq.isVisible() ? "CHECKED" :""%> ID="ckb1"><LABEL FOR="ckb1">публиковать вопрос на сайте</LABEL><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>



<%--TR>
<TD ALIGN=left>
<BR>
<INPUT TYPE="Button" VALUE="Просмотр" ONCLICK="preview('R');">
</TD>
</TR--%>

<TR>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="Сохранить изменения" ONCLICK="submitForm();">
</TD>
</TR>
</FORM>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
