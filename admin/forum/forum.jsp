<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Forum.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>

<%
	String message = "";
	String actionDone = request.getParameter("action_done");
	if("del".equals(actionDone))
		message = "��������� ������� ���� �������.";
	if("publ".equals(actionDone))
		message = "��������� ������� ���� ������������.";
	if("unpub".equals(actionDone))
		message = "��������� ������� ���� ����� � ����������.";
	else if("group_add".equals(actionDone))
		message = "������ ��������.";
	else if("group_save".equals(actionDone))
		message = "������ ��������.";
	else if("forum_add".equals(actionDone))
		message = "��������� ��������.";
	else if("forum_save".equals(actionDone))
		message = "��������� ��������.";
	else if("moder_add".equals(actionDone))
		message = "���������� ���������.";
	else if("moder_del".equals(actionDone))
		message = "���������� ����������.";
		
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="������� ������"/>
<jsp:param name="header" value="������� ������"/>
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
        ccc = '������� �������?';
    else if('publ' == s)
        ccc = '������������ ��������� �������?';
    else 
        ccc = '����� � ���������� ��������� �������?';
        
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

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_forum.jsp" METHOD="post">
<INPUT TYPE="hidden" name="mode" ACTION="del">
<%
    Hashtable forumHash = Forum.getForums(langCode, false);
    
    Enumeration groups = ForumGroup.getForumGroups(langCode, false).elements();
	int l1 = -1;
	while(groups.hasMoreElements())
	{
	    l1++;
    	ForumGroup group = (ForumGroup)groups.nextElement();
    	String ss = group.isVisible() ? "c2" : "c1";
%>
<TR>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=ss%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="group_id" VALUE="<%=group.getId()%>" ID="fqc_all<%=l1%>" onClick="checkAll(<%=l1%>);">
</TD>
<TD HEIGHT="20" WIDTH="100%" CLASS="<%=ss%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<B>"<%=CMSApplication.toHTML(group.getName())%>"</B> <A HREF="fgroup_edit.jsp?id=<%=group.getId()%>">�������������</A> <A HREF="forum_edit.jsp?group_id=<%=group.getId()%>">�������� ���������</A>
</B></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=ss%>"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>���.</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=ss%>"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>�����.</NOBR></B></DIV>
</TD>
</TR>
<%
        int l2 = -1;
        Vector vf = (Vector)forumHash.get(group.getId());
        if(vf == null)
            vf = new Vector();
        Enumeration enum = vf.elements();
        while(enum.hasMoreElements())
        {
            l2++;
            Forum forum = (Forum)enum.nextElement();
		    String style = forum.isVisible() ? "c3" : "c1";
%>
<TR>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="forum_id" ID="fqc_id<%=l1%>_<%=l2%>" VALUE="<%=forum.getId()%>">
</TD>
<TD HEIGHT="20" CLASS="<%=style%>" WIDTH="100%">
<DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="forum_edit.jsp?id=<%=forum.getId()%>"><%=CMSApplication.toHTML(forum.getName())%></A>&nbsp;&nbsp;&nbsp;
(<A HREF="forum_moderator.jsp?mode=moder&id=<%=forum.getId()%>">����������</A>)
</DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%= forum.getThemeAmount()%></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%= forum.getMessageAmount()%></DIV></TD>
</TR>
<%      } %>
<!-- ����� ������� --><TR><TD COLSPAN="4"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<% } %>
</TABLE>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD ALIGN="center">
<A HREF="javascript: submitForm('del');">�������</A>&nbsp;&nbsp;
<A HREF="javascript: submitForm('publ');">������������</A>&nbsp;&nbsp;
<A HREF="javascript: submitForm('unpub');">����� � ����������</A><BR></TD>
</TR>
<TR>
<TD ALIGN="center">
<BR><A HREF="fgroup_edit.jsp?id=">����� ������</A><BR></TD>
</TR>
</TABLE>
</FORM>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">������ ����������� � ���������������� �����;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">������ �� ����������� � ���������������� �����;</TD>
</TR>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
