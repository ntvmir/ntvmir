<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Forum.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter("id");
	String groupId = request.getParameter("group_id");
	boolean create = id == null || id.length() == 0;
	
	Forum forum = new Forum();
	if(!create)
	{
		forum.load(id);
	}

   	ForumGroup group = new ForumGroup();
    group.load( create ? groupId : forum.getForumGroupId());

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	String header = create ? "Создание подраздела" : "Редактирование подраздела";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Подраздел форума"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">

function submitForm()
{
	var frm = document.main_form;
	
	if(frm.name.value.length == 0)
	{
		alert("Не указано название");
		frm.name.focus();
		return;
	}

	if(confirm('Сохранить изменения?'))
	{
		frm.submit();
	}
}
</SCRIPT>


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_forum_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id != null ? id : ""%>">
<INPUT TYPE="hidden" NAME="group_id" VALUE="<%=group.getId()%>">

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Раздел</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<B><%=group.getName()%></B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Название подраздела</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="name" VALUE="<%=CMSApplication.toHTML(forum.getName())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Краткое описание</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="descr" VALUE="<%=CMSApplication.toHTML(forum.getDescription())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Тип форума</B></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<INPUT TYPE="radio" NAME="status" VALUE="<%=Forum.NON_MODERATED%>" <%=forum.getStatus() ==  Forum.NON_MODERATED? "CHECKED" :""%> ID="ckb0"><LABEL FOR="ckb0">обычный;<BR>
&nbsp;<INPUT TYPE="radio" NAME="status" VALUE="<%=Forum.MODERATED%>" <%=forum.getStatus() ==  Forum.MODERATED? "CHECKED" :""%> ID="ckb1"><LABEL FOR="ckb1">премодерируемый;<BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Публикация</B></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%=forum.isVisible() ? "CHECKED" :""%> ID="ckb2"><LABEL FOR="ckb2">публиковать раздел</LABEL><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
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
