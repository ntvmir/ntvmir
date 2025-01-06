<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page import="tengry.ntvmir.tvschedule.TimeZone"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Tvannounce.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>

<%
	int pageNumber = 1;
	int pageSize = 15;
	try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}
	String header = "Анонсы телепередач";
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");

	Date date1 = null;
	Date date2 = null;
	
	String sDate1 = request.getParameter("date1");
	String sDate2 = request.getParameter("date2");
	
	if(sDate1 == null) sDate1 = "";
	if(sDate2 == null) sDate2 = "";
	
	try{ date1 = sdf.parse(sDate1); }catch(Exception e){}
	try{ date2 = sdf.parse(sDate2); }catch(Exception e){}
	
	int loadPub = Tvannounce.LOAD_PUB_TRUE;
	try{ loadPub = Integer.parseInt(request.getParameter("load_pub")); }catch(Exception e){}
	
	int num = Tvannounce.getTvannouncesNum(langCode, date1, date2, loadPub);
	Enumeration enum = Tvannounce.getTvannounces(langCode, date1, date2, loadPub, pageNumber, pageSize).elements();

	String message = "";
	String actionDone = request.getParameter("action_done");
	if("del".equals(actionDone))
		message = "Выбранные анонсы были удалены.";
	if("publ".equals(actionDone))
		message = "Выбранные анонсы были опубликованы.";
	if("unpub".equals(actionDone))
		message = "Выбранные анонсы были сняты с публикации.";
	else if("add".equals(actionDone))
		message = "Анонс добавлен.";
	else if("save".equals(actionDone))
		message = "Анонс сохранен.";


    ShowPlace sp = ShowPlace.getDefaultShowPlace(langCode);
    TimeZone tz = (sp != null ? sp.getTimeZone() : TimeZone.getGmtTimeZone());
    String showPlaceName = tz.getName() + (sp != null ? " " + sp.getName() : "");
    int gmtShift = tz.getGmtShift();

%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Анонсы телепередач"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">
function submitForm(s)
{
    document.main_form.mode.value=s;
    var ccc;
    if('del' == s)
        ccc = 'Удалить анонсы?';
    else if('publ' == s)
        ccc = 'Опубликовать выбранные анонсы?';
    else 
        ccc = 'Снять с публикации выбранные анонсы?';
        
	if(confirm(ccc))
		document.main_form.submit();
}


function checkAll()
{
    var ch = document.getElementById("tva_all").checked;
    for(var i = 0; true; i++)
    {
        if(document.getElementById("tva_id" + i) != null)
            document.getElementById("tva_id" + i).checked = ch;
        else
            break;
    }
}

function submitFilterForm()
{
	var frm = document.filter_form;

	if(frm.date1.value.length > 0 && !isDate(frm.date1.value))
	{
		alert("Не корректно задана дата");
		frm.date1.focus();
		return;
	}
	if(frm.date2.value.length > 0 && !isDate(frm.date2.value))
	{
		alert("Не корректно задана дата");
		frm.date2.focus();
		return;
	}
	frm.submit();
}
</SCRIPT>

<TABLE WIDTH="400" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<FORM ACTION="tvannounces.jsp" METHOD="get" name="filter_form">
<TR>
<TD CLASS="c2" HEIGHT="16" COLSPAN="2" ALIGN="center">
	<B>Выбрать анонсы</B>
</TD>
</TR>
<TR>
<TD CLASS="edit" HEIGHT="20" WIDTH="1%">
	<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><NOBR>С датой показа</NOBR></DIV>
</TD>
<TD CLASS="edit" WIDTH="100%">
	<DIV STYLE="padding-left:6px;padding-right:6px;"> от <INPUT TYPE="text" NAME="date1" VALUE="<%=date1 != null ? sdf.format( date1 ) : ""%>"> (в формате "ДД.ММ.ГГГГ")<BR>
	до <INPUT TYPE="text" NAME="date2" VALUE="<%=date2 != null ? sdf.format( date2 ) : ""%>"> (в формате "ДД.ММ.ГГГГ")</DIV>
</TD>
</TR>
<TR>
<TD CLASS="edit" HEIGHT="20" WIDTH="1%">
	<DIV STYLE="padding-left:6px;padding-right:6px;">Показывать</DIV>
</TD>
<TD CLASS="edit" WIDTH="100%">
	<DIV STYLE="padding-left:6px;padding-right:6px;">
	<NOBR><INPUT TYPE="radio" NAME="load_pub" VALUE="<%=Tvannounce.LOAD_PUB_BOTH%>"<%=loadPub == Tvannounce.LOAD_PUB_BOTH ? " CHECKED" : ""%> ID="ppp1"><LABEL FOR="ppp1">  все анонсы</LABEL></NOBR><BR>
	<NOBR><INPUT TYPE="radio" NAME="load_pub" VALUE="<%=Tvannounce.LOAD_PUB_TRUE%>"<%=loadPub == Tvannounce.LOAD_PUB_TRUE ? " CHECKED" : ""%> ID="ppp2"><LABEL FOR="ppp2">  только опубликованные</LABEL></NOBR><BR>
	<NOBR><INPUT TYPE="radio" NAME="load_pub" VALUE="<%=Tvannounce.LOAD_PUB_FALSE%>"<%=loadPub == Tvannounce.LOAD_PUB_FALSE ? " CHECKED" : ""%> ID="ppp3"><LABEL FOR="ppp3"> только неопубликованные</LABEL></NOBR><BR>
	</DIV>
</TD>
</TR>


<TR><TD COLSPAN="2"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=1><BR></TD></TR>
<TR ALIGN="center">
	<TD COLSPAN="2">
		<INPUT TYPE="button" VALUE="Показать" onClick="submitFilterForm();">
	</TD>
</TR>
</FORM>
</TABLE>
<BR>


<%
	if(num > 0)
		printNavigator(pageNumber, pageSize, num, "tvannounces.jsp?date1=" + sDate1 + "&date2=" + sDate2 + "&load_pub=" + loadPub, "700", out);
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM ACTION="xt_tvannounces.jsp" METHOD="post" NAME="main_form">
<INPUT TYPE="hidden" NAME="mode" VALUE="del">
<INPUT TYPE="hidden" NAME="date1" VALUE="<%=sDate1%>">
<INPUT TYPE="hidden" NAME="date2" VALUE="<%=sDate2%>">
<INPUT TYPE="hidden" NAME="load_pub" VALUE="<%=loadPub%>">
<INPUT TYPE="hidden" NAME="page_number" VALUE="<%=pageNumber%>">
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c2" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="tva_all" ID="tva_all" onClick="checkAll();">
</TD>

<TD COLSPAN="2" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Анонсы телепередач</B>
<A HREF="tvannounce_edit.jsp?id=">добавить анонс</A>
</TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		Tvannounce tvannounce = (Tvannounce)enum.nextElement();
		String style = "c3";
		if(!tvannounce.isVisible())
			style = "c1";
		String name = tvannounce.getName();
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="tva_id" VALUE="<%=tvannounce.getId()%>" ID="tva_id<%=l%>">
</TD>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px"><NOBR>
<A HREF="tvannounce_edit.jsp?id=<%=tvannounce.getId()%>"><%=sdf.format(tvannounce.getTvDate(langCode))%></A>&nbsp;&nbsp;<A HREF="tvannounce_edit.jsp?id=<%=tvannounce.getId()%>"><%=tvannounce.getTime(gmtShift)%></A></NOBR></DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">&nbsp;<%=CMSApplication.toHTML(name)%><BR>
&nbsp;<EM><%=CMSApplication.toHTML(tvannounce.getBrief())%></EM><BR></TD>
</TR>
<%	
		l++;
	} 
%>
<TR>
<TD COLSPAN="3" HEIGHT="20" ALIGN="center">
<A HREF="javascript: submitForm('del');">удалить</A>&nbsp;&nbsp;
<A HREF="javascript: submitForm('publ');">опубликовать анонсы</A>&nbsp;&nbsp;
<A HREF="javascript: submitForm('unpub');">снять с публикации</A><BR></TD>
</FORM>
</TABLE>
<BR><BR><BR>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
