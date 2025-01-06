<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = FaqCategory.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>
<%
    String id = request.getParameter("id");
    FaqCategory theme = new FaqCategory();
    theme.load(id);
    
	int pageNumber = 1;
	int pageSize = 15;
	try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}
    
    int loadType = FaqQuestion.LOAD_NEW;
    try{ loadType = Integer.parseInt(request.getParameter("load_type")); }catch(Exception e){}

    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
    
    int num = FaqQuestion.getFaqQuestionsNum(id, loadType);
    Enumeration enum = FaqQuestion.getFaqQuestions(id, loadType, pageNumber, pageSize).elements();
    
	String message = "";
	String actionDone = request.getParameter("action_done");
	if("del".equals(actionDone))
		message = "Выбранные вопросы были удалены.";
	if("publ".equals(actionDone))
		message = "Выбранные вопросы были опубликованы.";
	if("unpub".equals(actionDone))
		message = "Выбранные вопросы были сняты с публикации.";
	else if("save".equals(actionDone))
		message = "Вопрос сохранен.";
	else if("amount_set".equals(actionDone))
		message = "Значение установлено.";
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Вопросы и ответы"/>
<jsp:param name="header" value="Вопросы и ответы"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="javascript">
function submitForm(s)
{
    document.main_form.mode.value=s;
    var ccc;
    if('del' == s)
        ccc = 'Удалить вопросы?';
    else if('publ' == s)
        ccc = 'Опубликовать выбранные вопросы?';
    else 
        ccc = 'Снять с публикации выбранные вопросы?';
        
	if(confirm(ccc))
		document.main_form.submit();
}


function checkAll()
{
    var ch = document.getElementById("faq_all").checked;
    for(var i = 0; true; i++)
    {
        if(document.getElementById("faq_id" + i) != null)
            document.getElementById("faq_id" + i).checked = ch;
        else
            break;
    }
}
</SCRIPT>

&nbsp;<A HREF="faq.jsp">назад к списку тем</A><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>

<TABLE WIDTH="400" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<FORM ACTION="questions.jsp" METHOD="get" name="filter_form">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id%>">
<TR>
<TD CLASS="c2" HEIGHT="16" ALIGN="center">
	<B>Выбрать вопросы</B>
</TD>
</TR>
<TR>
<TD CLASS="edit" WIDTH="100%">
	<DIV STYLE="padding-left:6px;padding-right:6px;">
	<NOBR><INPUT TYPE="radio" NAME="load_type" VALUE="<%=FaqQuestion.LOAD_NEW%>"<%=loadType == FaqQuestion.LOAD_NEW ? " CHECKED" : ""%> ID="ppp1"><LABEL FOR="ppp1">  все новые</LABEL></NOBR><BR>
	<NOBR><INPUT TYPE="radio" NAME="load_type" VALUE="<%=FaqQuestion.LOAD_ANSWERED%>"<%=loadType == FaqQuestion.LOAD_ANSWERED ? " CHECKED" : ""%> ID="ppp2"><LABEL FOR="ppp2">  с ответом, но неопубликованные</LABEL></NOBR><BR>
	<NOBR><INPUT TYPE="radio" NAME="load_type" VALUE="<%=FaqQuestion.LOAD_PUBLISHED%>"<%=loadType == FaqQuestion.LOAD_PUBLISHED ? " CHECKED" : ""%> ID="ppp3"><LABEL FOR="ppp3"> с ответом, опубликованные</LABEL></NOBR><BR>
	<NOBR><INPUT TYPE="radio" NAME="load_type" VALUE="<%=FaqQuestion.LOAD_ALL%>"<%=loadType == FaqQuestion.LOAD_ALL ? " CHECKED" : ""%> ID="ppp4"><LABEL FOR="ppp4"> все вопросы</LABEL></NOBR><BR>
	</DIV>
</TD>
</TR>


<TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=1><BR></TD></TR>
<TR ALIGN="center">
	<TD COLSPAN="2">
		<INPUT TYPE="submit" VALUE="Показать">
	</TD>
</TR>
</FORM>
</TABLE>
<BR>


<%
	if(num > 0)
		printNavigator(pageNumber, pageSize, num, "questions.jsp?id=" + id + "&load_type=" + loadType, "700", out);
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_questions.jsp" METHOD="post">
<INPUT TYPE="hidden" name="mode" VALUE="del">
<INPUT TYPE="hidden" name="id" VALUE="<%=id%>">
<INPUT TYPE="hidden" name="load_type" VALUE="<%=loadType%>">
<TR>
<TD HEIGHT="20" WIDTH="100%" CLASS="c2" COLSPAN="5"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
Вопросы в теме "<%=theme.getName()%>"
</B></DIV></TD>
</TR>

<TR>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2" VALIGN="middle">
<INPUT TYPE="checkbox" ID="faq_all" onClick="checkAll();">
</TD>
<TD HEIGHT="20" CLASS="c2" WIDTH="1%">
<DIV STYLE="padding-left:6px;padding-right:6px"><B><NOBR>Дата вопроса</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" CLASS="c2" WIDTH="1%">
<DIV STYLE="padding-left:6px;padding-right:6px"><B><NOBR>Дата ответа</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" CLASS="c2" WIDTH="1%">
<DIV STYLE="padding-left:6px;padding-right:6px"><B><NOBR>Автор</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" CLASS="c2" WIDTH="100%">
<DIV STYLE="padding-left:6px;padding-right:6px"><B><NOBR>Вопрос</NOBR></B></DIV>
</TD>
</TR>
<%
    int l = -1;
    while(enum.hasMoreElements())
    {
        l++;
        FaqQuestion faq = (FaqQuestion)enum.nextElement();
        String style = faq.isVisible() ? "c3" : "c1";
        String quest = CMSApplication.toHTML(faq.getQuestion());
        if(quest.length() > 200)
            quest = quest.substring(0, 200) + "...";
%>
<TR>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="faq_id" ID="faq_id<%=l%>" VALUE="<%=faq.getId()%>">
</TD>
<TD HEIGHT="20" CLASS="<%=style%>" WIDTH="1%">
<DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="question_edit.jsp?id=<%=faq.getId()%>&load_type=<%=loadType%>"><%=sdf.format(faq.getCreateDate())%></A>
</DIV>
</TD>

<TD HEIGHT="20" CLASS="<%=style%>" WIDTH="1%">
<DIV STYLE="padding-left:6px;padding-right:6px">
<NOBR><%=faq.getAnswerDate() != null ? sdf.format(faq.getAnswerDate()) : "без ответа"%></NOBR>
</DIV>
</TD>

<TD HEIGHT="20" CLASS="<%=style%>" WIDTH="1%">
<DIV STYLE="padding-left:6px;padding-right:6px">
<NOBR><A HREF="mailto:<%=CMSApplication.toHTML(faq.getEmail())%>"><%=CMSApplication.toHTML(faq.getUserName())%></A></NOBR>
</DIV>
</TD>

<TD HEIGHT="20" CLASS="<%=style%>" WIDTH="100%">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B><%=quest%></B>
</DIV>
</TD>

</TR>
<%  } %>

<TR>
<TD ALIGN="center" COLSPAN="5">
<A HREF="javascript: submitForm('del');">удалить</A>&nbsp;&nbsp;
<% if(loadType != FaqQuestion.LOAD_NEW && loadType != FaqQuestion.LOAD_PUBLISHED){%><A HREF="javascript: submitForm('publ');">опубликовать вопросы</A>&nbsp;&nbsp;<% } %>
<% if(loadType != FaqQuestion.LOAD_NEW && loadType != FaqQuestion.LOAD_ANSWERED){%><A HREF="javascript: submitForm('unpub');">снять с публикации</A><% } %><BR></TD>
</TR>
</FORM>
</TABLE>

<BR>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">Вопрос опубликован в пользовательской части;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">тема не опубликована в пользовательской части;</TD>
</TR>
</TABLE>

<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
