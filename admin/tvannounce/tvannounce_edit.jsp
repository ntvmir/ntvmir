<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page import="tengry.ntvmir.tvschedule.TimeZone"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Tvannounce.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
    int MAX_NAMES_LENGTH = 160;
	String id = request .getParameter("id");
	boolean create = id == null || id.length() == 0;
	Tvannounce tvannounce = new Tvannounce(DBObject.LOAD_FULL);
	if(!create)
	{
		tvannounce.load(id);
	}

    ShowPlace sp = ShowPlace.getDefaultShowPlace(langCode);
    TimeZone tz = (sp != null ? sp.getTimeZone() : TimeZone.getGmtTimeZone());
    String showPlaceName = tz.getName() + (sp != null ? " " + sp.getName() : "");
    int gmtShift = tz.getGmtShift();


	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	String header = create ? "�������� ������ ������������" : "�������������� ������ ������������";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="����� ������������"/>
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

function selectImage(imgId, w, h)
{
    window.open("/admin/inc/image_selector.jsp?file=" + document.main_form.img.value + "&name=" + imgId + "&width=" + w + "&height=" + h,
                'ImageSelectorWin',
                'scrollbars=yes,width=658,height=477,location=no,toolbar=no,directories=no,status=no,menubar=no,resizable=no,screenX=180,screenY=166'); //,top=266,left=180');
}
function selectImageDone(imgId, file)
{
    document.images[imgId].src = file;
//    document.getElementById[imgId].src = file;
    document.main_form.img.value = file;
}

function submitForm()
{
	var frm = document.main_form;
	wysiwygPrepareParams('main_form');
	
	if(frm.name.value.length == 0)
	{
		alert("�� ������ ���������");
		frm.name.focus();
		return;
	}
	if(!isDate(frm.start_date.value))
	{
		alert("�� ��������� ������ ����");
		frm.start_date.focus();
		return;
	}
	if(!isShortTime(frm.start_time.value))
	{
		alert("�� ��������� ������ �����");
		frm.start_time.focus();
		return;
	}
/*
	if(frm.finish_date.value.length > 0 && !isDate(frm.finish_date.value))
	{
		alert("�� ��������� ������ ����");
		frm.finish_date.focus();
		return;
	}
*/
	if(frm.img.value.length == 0)
	{
		alert("�� ������ ������� ������");
		frm.img.focus();
		return;
	}
	if(frm.brief.value.length == 0)
	{
		alert("�� ������� ������� �������� ������");
		frm.brief.focus();
		return;
	}
		
	if(frm.ckb2.checked && frm.content.value.length == 0)
	{
		alert("�� ������ ����� � ������������ ������");
		textareaFocus('content');
		return;
	}
    var namesLength = frm.name.value.length + frm.brief.value.length;
    if(namesLength > <%=MAX_NAMES_LENGTH%>)
    {
        if(!confirm('��������!\n\n����� ���������� �������� � ��������� � ������� �������� ������ ��������� �� ' + 
                   (namesLength - <%=MAX_NAMES_LENGTH%> ) +
                   '. �������� ������������ ����������� ������ �� ������� ��������.\n\n' +
                   '����������?'))
        {
            return;
        }
    }
    
	if(confirm('��������� ���������?'))
	{
		frm.submit();
	}
}
</SCRIPT>


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_tvannounce_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id != null ? id : ""%>">

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>���������</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="name" VALUE="<%=CMSApplication.toHTML(tvannounce.getName())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>���� � ����� ������ ������������</B> (� ����� <%=showPlaceName%>)<BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="start_date" VALUE="<%=tvannounce.getStartDate() != null ? sdf.format(tvannounce.getTvDate(langCode)) : sdf.format(new Date())%>" SIZE="11" MAXLENGTH="10">
<INPUT TYPE="text" NAME="start_time" VALUE="<%=tvannounce.getTime(gmtShift)%>" SIZE="6" MAXLENGTH="5">
�������� 31.12.2002 15:20<BR>
</TD>
</TR>
<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<%--  
            <TR>
            <TD CLASS="c2" HEIGHT="16">&nbsp;<B>���� ��������� ������</B><BR></TD>
            </TR>

            <TR>
            <TD ALIGN="left" CLASS="edit">
            <IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
            <INPUT TYPE="text" NAME="finish_date" VALUE="<%=tvannounce.getFinishDate() != null ? sdf.format(tvannounce.getFinishDate()) : ""%>" SIZE="25" MAXLENGTH="10">
            �������� 31.12.2002<BR>
            </TD>
            </TR>
            <!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
--%>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>�������� ��� ������</B><BR></TD>
</TR>


<%
    String announceImg = "/admin/img/blank.gif";
    if(tvannounce.getImg() != null && tvannounce.getImg().length() > 0)
        announceImg = tvannounce.getImg();
%>
<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="hidden" NAME="img" VALUE="<%=tvannounce.getImg()%>">
&nbsp;<A HREF="javascript: selectImage('announceImg', 77, 58);"><IMG SRC="<%=announceImg%>" NAME="announceImg" WIDTH=77 HEIGHT=58 BORDER=1></A><BR>
</TD>
</TR>
<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>





<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>������� ��������</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="brief" VALUE="<%=CMSApplication.toHTML(tvannounce.getBrief())%>" STYLE="width: 700" SIZE="59" MAXLENGTH="1000"><BR>
</TD>
</TR>
<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>





<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>������ ��������</B></TD>
</TR>

<TR>
<TD ALIGN="center" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "content";
	wysiwygWidth = 700;
	wysiwygHeight = 150;
	wysiwygValue = tvannounce.getText();
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>
</TD>
</TR>

<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>���������</B></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="Checkbox" NAME="important" VALUE="1" <%=tvannounce.isImportant() ? "CHECKED" :""%> ID="ckb1"><LABEL FOR="ckb1">���������� ����� �� ������� �������� �����</LABEL><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>

<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>����������</B></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%=tvannounce.isVisible() ? "CHECKED" :""%> ID="ckb2"><LABEL FOR="ckb2">����������� ����� �� �����</LABEL><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>



<TR>
<TD ALIGN=left>
<BR>
<INPUT TYPE="Button" VALUE="��������" ONCLICK="preview('R');">
</TD>
</TR>

<TR>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="��������� ���������" ONCLICK="submitForm();">
</TD>
</TR>
</FORM>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
