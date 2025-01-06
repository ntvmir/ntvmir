<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page import="tengry.ntvmir.tvschedule.TimeZone"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Tvschedule.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
    // ����������� ��������. ����������� ���������� ���-�� �������� � ������� �������������
    // ��� ����������� ��������� �� �������� ��� ������ ��������� �� ������.
    //int MAX_NAMES_LENGTH = 100;
    int MAX_NAMES_LENGTH = 1000;
    
    
	String sDate = request.getParameter("date");
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	Date date1 = sdf.parse(sDate);

    Calendar ccc = Calendar.getInstance();
    ccc.setTime(date1);
    String attr = "&year=" + ccc.get(Calendar.YEAR) + "&month=" + (ccc.get(Calendar.MONTH));


    ShowPlace sp = ShowPlace.getDefaultShowPlace(langCode);
    TimeZone tz = (sp != null ? sp.getTimeZone() : TimeZone.getGmtTimeZone());
    String showPlaceName = tz.getName() + (sp != null ? " " + sp.getName() : "");
    int gmtShift = tz.getGmtShift();
%>
<%!
    public String weekDay(Date d)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        switch(c.get(Calendar.DAY_OF_WEEK))
        {
            case Calendar.MONDAY:   return "�����������";            case Calendar.TUESDAY:  return "�������";            case Calendar.WEDNESDAY: return "�����";
            case Calendar.THURSDAY: return "�������";            case Calendar.FRIDAY:   return "�������";            case Calendar.SATURDAY: return "�������";
            case Calendar.SUNDAY:   return "�����������";
        }
        return "unknown";
    }
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="�������������� �������������"/>
<jsp:param name="header" value="�������������� �������������"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">


function submitForm(s)
{
    var namesLength = 0;
    
    document.main_form.mode.value=s;
    if('del' == s)
    {
        if(confirm('������� ������?'))
	    {
	    	document.main_form.submit();
	    }
        return;
    }
    
    for(var i = 0; true; i++)
    {
        var time = document.getElementById('item_time' + i);
        if(time == null)
            break;
        if(!isShortTime(time.value))
        {
            alert("������� ����� � ������� hh:mm");
            time.focus();
            return;
        }
        var name = document.getElementById('item_name' + i);
        if(name == null)
            break;
        
        if(trim(name.value).length == 0)
        {
            alert("������� ����� ���������");
            name.focus();
            return;
        }
        namesLength += trim(name.value).length;
    }
    
    for(var i = 0; true; i++)
    {
        var time = document.getElementById('new_time' + i);
        var name = document.getElementById('new_name' + i);
        var descr = document.getElementById('new_descr' + i);
        if(time == null || name == null)
            break;
        if(trim(time.value).length == 0 && trim(name.value).length == 0 && trim(descr.value).length == 0)
            continue;
        if(!isShortTime(time.value))
        {
            alert("������� ����� � ������� hh:mm");
            time.focus();
            return;
        }

        if(trim(name.value).length == 0)
        {
            alert("������� ����� ���������");
            name.focus();
            return;
        }
        namesLength += trim(name.value).length;
    }
    if(namesLength > <%=MAX_NAMES_LENGTH%>)
    {
        if(!confirm('��������!\n\n����� ���������� �������� � ������� ��������� ��������� �� ' + 
                   (namesLength - <%=MAX_NAMES_LENGTH%> ) +
                   '. �������� ������������ ��������� �� �������� ��� ������ ��������� �� ������.\n\n' +
                   '����������?'))
        {
            return;
        }
    }    
	if(confirm('��������� ���������?'))
	{
		document.main_form.submit();
	}
}

function checkAll()
{
    var ch = document.getElementById("del_all").checked;
    for(var i = 0; true; i++)
    {
        if(document.getElementById("del_id" + i) != null)
            document.getElementById("del_id" + i).checked = ch;
        else
            break;
    }
}
</SCRIPT>

&nbsp;<A HREF="tvschedule.jsp?<%=attr%>">����� � ���������</A><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="1" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_tvschedule_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="mode" VALUE="save">
<INPUT TYPE="hidden" NAME="date" VALUE="<%=sDate%>">
<TR>
<TD COLSPAN="2" ALIGN="right" HEIGHT="16"><A HREF="tvschedule_publ.jsp?date=<%=sDate%>&num=1">����������</A>&nbsp;<BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="1%"><INPUT TYPE="checkbox" ID="del_all" onClick="checkAll();"></TD>
<TD CLASS="c2">&nbsp;<B>������������� �� <%=weekDay(date1)%> (<%=sDate%>)</B><BR></TD>
</TR>

<%
    Enumeration enum = Tvschedule.getItems(langCode, date1, 1).elements();
    int i = -1;
    while(enum.hasMoreElements())
    {
        i++;
        Tvschedule item = (Tvschedule)enum.nextElement();
%>
<TR>
<INPUT TYPE="hidden" NAME="item_id" VALUE="<%=item.getId()%>">
<TD ALIGN="left" CLASS="edit"><INPUT TYPE="checkbox" NAME="del_id" ID="del_id<%=i%>" VALUE="<%=item.getId()%>"></TD>
<TD ALIGN="left" CLASS="edit"><NOBR>&nbsp;<INPUT TYPE="text" NAME="item_time" ID="item_time<%=i%>" VALUE="<%=item.getTime(gmtShift)%>" STYLE="width: 40" SIZE="5" MAXLENGTH="5">
<INPUT TYPE="text" NAME="item_name" ID="item_name<%=i%>" VALUE="<%=CMSApplication.toHTML(item.getName())%>"  STYLE="width: 100%" MAXLENGTH="200"></NOBR><BR>
<NOBR>&nbsp;<IMG SRC="/admin/img/blank.gif" WIDTH=44 HEIGHT=1><INPUT TYPE="text" NAME="item_descr" VALUE="<%=CMSApplication.toHTML(item.getDescription())%>"  STYLE="width: 100%" MAXLENGTH="500"></NOBR></TD>
</TD>
</TR>
<TR><TD COLSPAN="2"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=4></TD></TR>
<%
    }
%>

<SCRIPT LANGUAGE="Javascript">
function ListForm(oPlaceholder)
{
	this.oPlaceholder = oPlaceholder;
	this.oPlaceholder.ListForm = this;
	this.idx=0;
}

ListForm.prototype.append = function()
{
	this.oPlaceholder.innerHTML += //'<INPUT STYLE="width: 550;" TYPE="Text" ID="newitem' + this.idx + '" NAME="newitem" SIZE="20" ONKEYUP="ListForm_Append(this)"><BR>';

'<NOBR>&nbsp;<INPUT TYPE="text" NAME="new_time" VALUE="" STYLE="width: 40" SIZE="5" MAXLENGTH="5" ID="new_time' + this.idx + '" ONKEYUP="ListForm_Append(this)">\n' + 
'<INPUT TYPE="text" NAME="new_name" VALUE=""  STYLE="width: 100%" MAXLENGTH="200" ID="new_name' + this.idx + '" ONKEYUP="ListForm_Append(this)"></NOBR><BR>\n' + 
'<NOBR>&nbsp;<IMG SRC="/admin/img/blank.gif" WIDTH=44 HEIGHT=1><INPUT TYPE="text" NAME="new_descr" VALUE=""  STYLE="width: 100%" MAXLENGTH="500" ID="new_descr' + this.idx + '" ONKEYUP="ListForm_Append(this)"></NOBR><BR>\n';

	var newInp = document.getElementById('new_time'+ this.idx);
	setTimeout("ListForm_SetFocus('new_time" + this.idx + "')", 50);
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

<TR>
<TD CLASS="edit"><BR></TD>
<TD CLASS="edit">
<DIV ID="item_list"></DIV>
<SCRIPT>
var listForm = new ListForm(document.getElementById("item_list"));
listForm.append();
</SCRIPT>
</TD>
</TR>
</TABLE>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="������� ���������" ONCLICK="submitForm('del');">
</TD>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="��������� ���������" ONCLICK="submitForm('save');">
</TD>
</TR>
</FORM>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>


