<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = FaqCategory.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%!
	String buildPath(WebTreeNode node)
	{
		if(node == null) return "";
		if(node.getParent() == null)
			return "";
		return buildPath(node.getParent()) + "/" + node.getName();
	}
%>
<%
	String message = "";
	String actionDone = request.getParameter("action_done");
	if("del".equals(actionDone))
		message = "Выбранные темы были удалены.";
	if("publ".equals(actionDone))
		message = "Выбранные темы были опубликованы.";
	if("unpub".equals(actionDone))
		message = "Выбранные темы были сняты с публикации.";
	else if("add".equals(actionDone))
		message = "Тема добавлена.";
	else if("save".equals(actionDone))
		message = "Тема сохранена.";
	else if("amount_set".equals(actionDone))
		message = "Значение установлено.";
		
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Темы Вопросов и ответов"/>
<jsp:param name="header" value="Темы Вопросов и ответов"/>
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
        ccc = 'Удалить темы?';
    else if('publ' == s)
        ccc = 'Опубликовать выбранные темы?';
    else 
        ccc = 'Снять с публикации выбранные темы?';
        
	if(confirm(ccc))
		document.main_form.submit();
}


function checkAll(n)
{
    var ch = document.getElementById("fqc_all" + n).checked;
    for(var i = 0; true; i++)
    {
        if(document.getElementById("fqc_id" + n + '_' + i) != null)
            document.getElementById("fqc_id" + n + '_' + i).checked = ch;
        else
            break;
    }
}
</SCRIPT>

<FORM NAME="main_form" ACTION="xt_faq.jsp" METHOD="post">
<INPUT TYPE="hidden" name="mode" ACTION="del">
<%
    Enumeration pages = CMSApplication.getApplication().getNodesByTypeCode(langCode, FaqCategory.SERVICE_CODE);
	int l1 = -1;
	while(pages.hasMoreElements())
	{
	    l1++;
    	WebTreeNode node = (WebTreeNode)pages.nextElement();
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2" VALIGN="middle">
<INPUT TYPE="checkbox" ID="fqc_all<%=l1%>" onClick="checkAll(<%=l1%>);">
</TD>
<TD HEIGHT="20" WIDTH="100%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
Темы на странице "<%=buildPath(node)%>" <A HREF="faq_category_edit.jsp?page_id=<%=node.getId()%>">добавить тему</A>
</B></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>нов.</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>отв.</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>публ.</NOBR></B></DIV>
</TD>
</TR>
<%      
        int l2 = -1;
        Enumeration enum = FaqCategory.getFaqCategories(node.getId()).elements();
        while(enum.hasMoreElements())
        {
            l2++;
            FaqCategory fqc = (FaqCategory)enum.nextElement();
		    String style = fqc.isVisible() ? "c3" : "c1";
%>
<TR>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="fqc_id" ID="fqc_id<%=l1%>_<%=l2%>" VALUE="<%=fqc.getId()%>">
</TD>
<TD HEIGHT="20" CLASS="<%=style%>" WIDTH="100%">
<DIV STYLE="padding-left:6px;padding-right:6px">
<%		    if(currentAdmin.isR(node.getId())) { %>
<A HREF="questions.jsp?id=<%=fqc.getId()%>"><%=CMSApplication.toHTML(fqc.getName())%></A>&nbsp;&nbsp;&nbsp;(<A HREF="faq_category_edit.jsp?id=<%=fqc.getId()%>">редактировать</A>)
<%		    }else{ %>
<%=CMSApplication.toHTML(fqc.getName())%>
<%		    } %>
</DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=fqc.getNewNum()%></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=fqc.getAnswerNum()%></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=fqc.getPublicNum()%></DIV></TD>
</TR>
<%      } %>
</TABLE>
<BR>
<% } %>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD ALIGN="center">
<A HREF="javascript: submitForm('del');">удалить</A>&nbsp;&nbsp;
<A HREF="javascript: submitForm('publ');">опубликовать темы</A>&nbsp;&nbsp;
<A HREF="javascript: submitForm('unpub');">снять с публикации</A><BR></TD>
</TR>
</TABLE>
</FORM>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">тема опубликована в пользовательской части;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">тема не опубликована в пользовательской части;</TD>
</TR>
</TABLE>


<BR><BR>


<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM METHOD="post" ACTION="xt_faq.jsp">
<INPUT TYPE="hidden" NAME="mode" VALUE="set_num">
<TR>
<TD HEIGHT="20" CLASS="c1"><DIV STYLE="padding-left:6px;padding-right:6px">
Количество вопросов на странице:&nbsp;&nbsp;&nbsp;
<INPUT TYPE="text" NAME="faq_num" SIZE="5" VALUE="<%=FaqQuestion.getFaqQuestionAmount()%>"><BR>
</DIV></TD>
</TR>
<TR>
<TD ALIGN="center" COLSPAN="2">
<INPUT TYPE="submit" VALUE="Установить">
</TD>
</TR>
</FORM>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
