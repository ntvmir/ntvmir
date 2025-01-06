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
	String sDate = request.getParameter("date");
	int num = 1;
	try{ num = Integer.parseInt(request.getParameter("num")); }catch(Exception e){}
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	Date date = sdf.parse(sDate);

    Calendar ccc = Calendar.getInstance();
    ccc.setTime(date);
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
            case Calendar.MONDAY:   return "Понедельник";            case Calendar.TUESDAY:  return "Вторник";            case Calendar.WEDNESDAY: return "Среда";
            case Calendar.THURSDAY: return "Четверг";            case Calendar.FRIDAY:   return "Пятница";            case Calendar.SATURDAY: return "Суббота";
            case Calendar.SUNDAY:   return "Воскресенье";
        }
        return "unknown";
    }
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Публикация телепрограммы"/>
<jsp:param name="header" value="Публикация телепрограммы"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">

function submitForm(s)
{
    document.main_form.mode.value=s;
    if('publ' == s)
    {
    	if(confirm('Опубликовать выбранные пункты?'))
    		document.main_form.submit();
	}
	else
	{
    	if(confirm('Снять с публикации выбранные пункты?'))
    		document.main_form.submit();
    }

}

function checkAll(p)
{
    var ch = document.getElementById("pub_all" + p).checked;
    for(var i = 0; true; i++)
    {
        if(document.getElementById("pub_id" + p + "_" + i) != null)
            document.getElementById("pub_id" + p + "_" + i).checked = ch;
        else
            break;
    }
}
</SCRIPT>

&nbsp;<A HREF="tvschedule.jsp?<%=attr%>">назад к календарю</A><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<FORM NAME="main_form" ACTION="xt_tvschedule_edit.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="mode" VALUE="publ">
<INPUT TYPE="hidden" NAME="date" VALUE="<%=sDate%>">
<INPUT TYPE="hidden" NAME="num" VALUE="<%=num%>">
<%
    if(num == 1)
    {
%>
<TR>
<TD ALIGN="right" HEIGHT="16" COLSPAN="2"><A HREF="tvschedule_edit.jsp?date=<%=sDate%>&num=1">редактирование</A>&nbsp;<BR>
</TD>
</TR>
<%  } %>

<%
    Date prevDate = null;
    boolean left = false;
    int p = -1;
    Enumeration enum = Tvschedule.getItems(langCode, date, num).elements();
    for(int i = 0; enum.hasMoreElements(); i++)
    {
        Tvschedule item = (Tvschedule)enum.nextElement();
        String style = (item.isVisible() ? "c3" : "c1");
        Date dd = item.getTvDate(langCode);
        if(!dd.equals(prevDate))
        {
            if(prevDate != null)
            {
%>
    </TABLE>
</TD>
<%              if(!left){%>
</TR>
<%              }
            }
            prevDate = dd;
            left = !left;
            i = 0;
            p++;
            if(left){ %>
<TR>
<%          } %>
<TD WIDTH="350" VALIGN="top">
    <TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="350">
    <TR>
    <TD CLASS="c2" WIDTH="1">&nbsp;<INPUT TYPE="checkbox" ID="pub_all<%=p%>" onClick="checkAll(<%=p%>);">&nbsp;</TD>
    <TD CLASS="c2" WIDTH="100%">&nbsp;<B><%=weekDay(dd)%> (<%=sdf.format(dd)%>)</B></TD>
<%
        }
%>
    <TR>
    <TD ALIGN="left" CLASS="<%=style%>" WIDTH="1">&nbsp;<INPUT TYPE="checkbox" NAME="pub_id" ID="pub_id<%=p%>_<%=i%>" VALUE="<%=item.getId()%>">&nbsp;</TD>
    <TD ALIGN="left" CLASS="<%=style%>" WIDTH="100%">&nbsp;<B><%=item.getTime(gmtShift)%></B>
    <%=CMSApplication.toHTML(item.getName())%><BR>&nbsp;<EM><%=CMSApplication.toHTML(item.getDescription())%></EM><BR></TD>
    </TR>
<%
    }
if(prevDate != null) {%>
    </TABLE>
</TD>
<%    if(left){ %>
<TD WIDTH="350">&nbsp;</TD>
<%    } %>
</TR>
<% } %>
</TABLE>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="Опубликовать выбранные" ONCLICK="submitForm('publ');">
</TD>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="Снять с публикации" ONCLICK="submitForm('unpub');">
</TD>
</TR>
</FORM>
</TABLE>


<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>


