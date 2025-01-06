<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Release.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>
<%
	int pageNumber = 1;
	int pageSize = 15;
	try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}
	String header = "������ �����������";
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	int num = Vote.getVotesNum(langCode);
	Enumeration enum = Vote.getVotes(pageNumber, pageSize, langCode);

	String message = "";
	String actionDone = request.getParameter("action_done");
	if("del".equals(actionDone))
		message = "��������� ����������� ���� �������.";
	else if("add".equals(actionDone))
		message = "����������� ���������.";
	else if("save".equals(actionDone))
		message = "����������� ���������.";
    else if("publ".equals(actionDone))
        message = "����������� ���������.";
    else if("unpubl".equals(actionDone))
        message = "����������� �����.";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="�����������"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	if(confirm("�� ������������� ������ ������� �����������?"))
		document.main_form.submit();
}
</SCRIPT>
<%
	if(num > 0)
		printNavigator(pageNumber, pageSize, num, "votes.jsp?", "700", out);
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM ACTION="xt_votes.jsp" METHOD="post" NAME="main_form">
<INPUT TYPE="hidden" NAME="mode" VALUE="del">
<TR>
<TD COLSPAN="3" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>�����������</B><%if(Admin.isC(pageAccessCode)){%>
<A HREF="vote_edit.jsp?id=">�������� �����������</A>
<% }%>
</TD>
<TD WIDTH="1" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px">�������������</DIV></TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		Vote vote = (Vote)enum.nextElement();
		String style = "c3";
		String name = vote.getQuestion();
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="del" VALUE="<%=vote.getId()%>">
</TD>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
  <A HREF="result.jsp?id=<%=vote.getId()%>" TITLE="�����"><%=sdf.format(vote.getCreateDate())%></A></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px"><%
    if(Admin.isW(pageAccessCode)){%><A HREF="vote_edit.jsp?id=<%=vote.getId()%>"><%=name%></A><% } else
    {  %><%=name%><% } %></DIV>
</TD>
<TD HEIGHT="20" ALIGN="right" CLASS="<%=style%>"><%=vote.getQuantity()%>&nbsp;</TD>
</TR>
<%	
		l++;
	} 
%>
<TR>
<TD COLSPAN="3" HEIGHT="20"><A HREF="javascript: submitForm();">�������</A><BR></TD>
</FORM>
</TABLE>

<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
