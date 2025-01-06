<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
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
	// set the Service name for authorization
	String pageId = Vote.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%
	String id = request.getParameter("id");
	Vote vote = new Vote();
	vote.load(id);
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Отчет о голосовании."/>
<jsp:param name="header" value="Отчет о голосовании"/>
<jsp:param name="width" value="700"/>
</jsp:include>

&nbsp;<A HREF="votes.jsp">назад к списку голосований</A><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
				
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<TR>
<TD>
    <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="1" WIDTH="100%">
    <TR>
    <TD CLASS="c2" HEIGHT="16">&nbsp;<B>Дата создания</B><BR></TD>
    <TD CLASS="c2" HEIGHT="16">&nbsp;<B>Проголосовало</B><BR></TD>
    </TR>

    <TR>
    <TD ALIGN="left" CLASS="edit">
    <IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
    &nbsp;<B><%=sdf.format(vote.getCreateDate())%></B><BR>
    <IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
    </TD>
    <TD ALIGN="left" CLASS="edit">
    <IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
    &nbsp;<B><%=vote.getQuantity()%></B><BR>
    <IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
    </TD>
    </TR>
    </TABLE>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Вопрос для голосования</B><BR></TD>
</TR>

<TR>
<TD CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<DIV STYLE="padding-left:6px;padding-right:6px"><B>
<%=CMSApplication.toHTML(vote.getQuestion())%></B></DIV>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Тип голосования</B></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<DIV STYLE="padding-left:6px;padding-right:6px"><%
  if(vote.getSelectorType() ==  Vote.SELECTOR_RADIO){
%>с возможностью голосовать только по одному пункту (radio)<%
  }else{ 
%>с возможностью голосовать по нескольким пунктам (checkbox)<%
  } %></DIV>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

</TABLE>


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="1" WIDTH="700">
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="560">&nbsp;<B>Пункты голосования</B>&nbsp;</TD>
<TD CLASS="c2" HEIGHT="16" WIDTH="100">&nbsp;<B>Голосов</B>&nbsp;</TD>
</TR>

<%
    Enumeration enum = VoteItem.getVoteItems(id);
    while(enum.hasMoreElements())
    {
        VoteItem voteItem = (VoteItem)enum.nextElement();
%>
<TR>
<TD CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<DIV STYLE="padding-left:6px;padding-right:6px"><%=voteItem.getItem()%></DIV>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
<TD CLASS="edit" ALIGN="right"><%=voteItem.getQuantity()%>&nbsp;&nbsp;</TD>
</TR>
<%
    }
%>
</TABLE>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="1" WIDTH="700">
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Размещено на страницах:</B></TD>
</TR>
<%
	enum = CMSApplication.getApplication().getNodesByVoteId(id).elements();
	while(enum.hasMoreElements())
	{
		WebTreeNode node = (WebTreeNode)enum.nextElement();
    	String style = node.isVisible() ? "c3" : "c1";
		String sPrivate = isPagePrivate(node.getId()) ? "<B STYLE=\"color: red;\">*</B>" : "";
%>
<TR>
<TD HEIGHT="20" CLASS="<%=style%>">
<DIV STYLE="padding-left:6px;padding-right:6px">
<%=sPrivate + buildPath(node)%>
</DIV></TD>
</TR>
<%  } %>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>


