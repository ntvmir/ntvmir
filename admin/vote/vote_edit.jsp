<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Vote.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request .getParameter("id");
	boolean create = id == null || id.length() == 0;
	Vote vote = new Vote();
	if(!create)
	{
		vote.load(id);
	}
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	String header = create ? "Создание голосования" : "Редактирование голосования";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Голосование"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">

function submitForm()
{
	var frm = document.main_form;

	if(frm.question.value.length == 0)
	{
		alert("Не указан вопрос");
		frm.question.focus();
		return;
	}
		
	if(confirm('Сохранить изменения?'))
	{
		frm.submit();
	}
}
</SCRIPT>

&nbsp;<A HREF="votes.jsp">назад к списку голосований</A><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_vote_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id != null ? id : ""%>">
<%  if(!create)
    {
%>
<TR>
<TD ALIGN="right" HEIGHT="16"><A HREF="attach_vote.jsp?id=<%=id%>">размещение</A>&nbsp;<BR>
</TD>
</TR>
<%  } %>
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
    &nbsp;<B><%=sdf.format(create ? new Date() : vote.getCreateDate())%></B><BR>
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
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="question" VALUE="<%=CMSApplication.toHTML(vote.getQuestion())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>


<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Тип голосования</B></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="radio" NAME="vote_type" VALUE="<%=Vote.SELECTOR_RADIO%>" <%=vote.getSelectorType() ==  Vote.SELECTOR_RADIO ? "CHECKED" :""%> ID="rdb1"><LABEL FOR="rdb1">с возможностью голосовать только по одному пункту (radio)</LABEL><BR>
<INPUT TYPE="radio" NAME="vote_type" VALUE="<%=Vote.SELECTOR_CHECKBOX%>" <%=vote.getSelectorType() ==  Vote.SELECTOR_CHECKBOX ? "CHECKED" :""%> ID="rdb2"><LABEL FOR="rdb2">с возможностью голосовать по нескольким пунктам (checkbox)</LABEL><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

</TABLE>



<SCRIPT LANGUAGE="Javascript">
function ListForm(oPlaceholder)
{
	this.oPlaceholder = oPlaceholder;
	this.oPlaceholder.ListForm = this;
	this.idx=0;
}

ListForm.prototype.append = function()
{
	this.oPlaceholder.innerHTML += '<INPUT STYLE="width: 550;" TYPE="Text" ID="newitem' + this.idx + '" NAME="newitem" SIZE="20" ONKEYUP="ListForm_Append(this)"><BR>';

	var newInp = document.getElementById('newitem');
	setTimeout("ListForm_SetFocus('newitem" + this.idx + "')", 50);
	this.idx++;
		
}

function ListForm_SetFocus(sId)
{
	document.getElementById(sId).focus();
}

function ListForm_Append(oSenderElt)
{
	if (event.keyCode == 13)
	{
		var oListForm = null;
		var oElt = oSenderElt;
		while(oElt != null)
		{
			if (!(oElt.ListForm == null || oElt.ListForm == 'undefined'))
			{
				oListForm = oElt.ListForm;
				break;
			}
				
			oElt = oElt.parentElement;
		}
		
		if (oListForm)
		{
			oListForm.append();
		}
	}
}
</SCRIPT>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="1" WIDTH="700">
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="560">&nbsp;<B>Пункты голосования</B>&nbsp;</TD>
<TD CLASS="c2" HEIGHT="16" WIDTH="100">&nbsp;<B>Голосов</B>&nbsp;</TD>
<TD CLASS="c2" HEIGHT="16" WIDTH="40">&nbsp;</TD>
</TR>

<%
    if(!create)
    {
        Enumeration enum = VoteItem.getVoteItems(id);
        while(enum.hasMoreElements())
        {
            VoteItem voteItem = (VoteItem)enum.nextElement();
%>
<TR>
<TD CLASS="edit"><INPUT TYPE="text" STYLE="width: 550;" NAME="voteitem" VALUE="<%=voteItem.getItem()%>"></TD>
<TD CLASS="edit" ALIGN="right"><%=voteItem.getQuantity()%>&nbsp;&nbsp;</TD>
<TD CLASS="edit" ALIGN="center"><A HREF="xt_vote_edit.jsp?del_vi=<%=voteItem.getId()%>">&times;</A></TD>
</TR>
<%
        }
    }
%>
<TR>
<TD class="edit" COLSPAN="3">
<DIV ID="item_list"></DIV>

<SCRIPT>
var listForm = new ListForm(document.getElementById("item_list"));
listForm.append();
</SCRIPT>
</TD>
</TR>
</TABLE>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="Сохранить изменения" ONCLICK="submitForm();">
</TD>
</TR>
</FORM>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>


