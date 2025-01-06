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
	int year;
	int month;
	int monthCount = 3;
    Calendar cal = Calendar.getInstance();
    
    try{ year = Integer.parseInt(request.getParameter("year"));}catch(Exception e){year = cal.get(Calendar.YEAR);}
    try{ month = Integer.parseInt(request.getParameter("month"));}catch(Exception e){month = cal.get(Calendar.MONTH);}
    int tty = year;
    int ttm = month;
    if(--ttm < 0)
    {
        ttm = 11;
        tty--;
    }
    cal.clear();
    cal.set(tty, ttm, 1);
    
//    public static Vector getTvDays(String langCode, Date start, int days) throws DBException

	String header = "Телепрограмма";
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");


	String message = "";
	String actionDone = request.getParameter("action_done");
	if("mid".equals(actionDone))
		message = "Значение установлено.";
	else if("sp_set".equals(actionDone))
		message = "Значение установлено.";
	else if("sp_new".equals(actionDone))
		message = "Место показа добавлено.";
    else if("sp_del".equals(actionDone))
        message = "Место показа удалено.";
    else if("tvsave".equals(actionDone))
        message = "Пункты программы сохранены.";
    else if("tvdel".equals(actionDone))
        message = "Пункты программы удалены.";
    else if("tvpubl".equals(actionDone))
        message = "Пункты программы опубликованы.";
    else if("tvunpub".equals(actionDone))
        message = "Пункты программы сняты с публикации.";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Телепрограмма"/>
<jsp:param name="header" value="Телепрограмма"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD ALIGN="left"><A HREF="tvschedule.jsp?year=<%=month > 0 ? year : year-1 %>&month=<%=month > 0 ? month-1 : 11%>">&lt;- предыдущие месяцы</A></TD>
<TD ALIGN="right"><A HREF="tvschedule.jsp?year=<%=month < 11 ? year : year+1 %>&month=<%=month < 11 ? month+1 : 0%>">следующие месяцы -&gt;</A></TD>
</TR>
</TABLE>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<%!
    public String monthName(int c)
    {
        switch(c)
        {
            case Calendar.JANUARY: return "Январь";
            case Calendar.FEBRUARY: return "Февраль";
            case Calendar.MARCH: return "Март";
            case Calendar.APRIL: return "Апрель";
            case Calendar.MAY: return "Май";
            case Calendar.JUNE: return "Июнь";
            case Calendar.JULY: return "Июль";
            case Calendar.AUGUST: return "Август";
            case Calendar.SEPTEMBER: return "Сентябрь";
            case Calendar.OCTOBER: return "Октябрь";
            case Calendar.NOVEMBER: return "Ноябрь";
            case Calendar.DECEMBER: return "Декабрь";
        }
        return "unknown";
    }

    public int printMonth(JspWriter out, Vector v, int p) throws IOException
    {
        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
        if(p >= v.size())
            return p;
        Tvschedule.TvDay tvday = (Tvschedule.TvDay)v.elementAt(p);
        Calendar cal = Calendar.getInstance();
        cal.setTime(tvday.day);
        out.println("<TD VALIGN=\"top\">");
        out.println("<TABLE WIDTH=\"200\" BORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"1\">");
        out.println("<TR>");
        out.println("    <TD>&nbsp;</TD><TD COLSPAN=\"8\">&nbsp;<B>" + monthName(cal.get(Calendar.MONTH)) + " " + cal.get(Calendar.YEAR) + "</B></TD>");
        out.println("</TR>");

        out.println("<TR>");
        out.println("    <TD>&nbsp;</TD>");
        out.println("    <TD CLASS=\"c2\" ALIGN=\"center\"><B>Пн.</B>&nbsp;</TD>");
        out.println("    <TD CLASS=\"c2\" ALIGN=\"center\"><B>Вт.</B>&nbsp;</TD>");
        out.println("    <TD CLASS=\"c2\" ALIGN=\"center\"><B>Ср.</B>&nbsp;</TD>");
        out.println("    <TD CLASS=\"c2\" ALIGN=\"center\"><B>Чт.</B>&nbsp;</TD>");
        out.println("    <TD CLASS=\"c2\" ALIGN=\"center\"><B>Пт.</B>&nbsp;</TD>");
        out.println("    <TD CLASS=\"c2\" ALIGN=\"center\"><B>Сб.</B>&nbsp;</TD>");
        out.println("    <TD CLASS=\"c2\" ALIGN=\"center\"><B>Вс.</B>&nbsp;</TD>");
        out.println("    <TD>&nbsp;</TD>");
        out.println("</TR>");
        out.println("<TR>");
        int num = 7;
        String sss = "";
        switch(cal.get(Calendar.DAY_OF_WEEK))
        {
            case Calendar.SUNDAY:                sss += "\t<TD ALIGN=\"right\">&nbsp;</TD>\n"; num--;
            case Calendar.SATURDAY:                sss += "\t<TD ALIGN=\"right\">&nbsp;</TD>\n"; num--;            case Calendar.FRIDAY:
                sss += "\t<TD ALIGN=\"right\">&nbsp;</TD>\n"; num--;
            case Calendar.THURSDAY:                sss += "\t<TD ALIGN=\"right\">&nbsp;</TD>\n"; num--;
            case Calendar.WEDNESDAY:                sss += "\t<TD ALIGN=\"right\">&nbsp;</TD>\n"; num--;
            case Calendar.TUESDAY:                sss += "\t<TD ALIGN=\"right\">&nbsp;</TD>\n"; num--;
        }
        out.println("\t<TD><A HREF=\"tvschedule_publ.jsp?num=" + num + "&date=" + sdf.format(cal.getTime()) + "\"><IMG SRC=\"/admin/img/3arr_r.gif\" BORDER=\"0\"></A>&nbsp;</TD>");
                out.print(sss);        
        boolean firstLoop = true;        while(true)
        {
            if(cal.get(Calendar.DAY_OF_WEEK) == Calendar.MONDAY && !firstLoop)
            {
                out.println("<TR>");
                out.println("\t<TD><A HREF=\"tvschedule_publ.jsp?num=7&date=" + sdf.format(cal.getTime()) + "\"><IMG SRC=\"/admin/img/3arr_r.gif\" BORDER=\"0\"></A>&nbsp;</TD>");
            }                        String style = "";            if(tvday.visible == tvday.amount && tvday.amount > 0)                style = " CLASS=\"c3\"";            else if(tvday.visible < tvday.amount)
                style = " CLASS=\"c1\"";
             
            out.print("\t<TD" + style + " ALIGN=\"right\">");            out.println("<A HREF=\"tvschedule_edit.jsp?date=" + sdf.format(cal.getTime()) + "\">" + cal.get(Calendar.DATE) + "</A>&nbsp;</TD>");
                        if(cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
            {
                Date prevDate = null;                cal.add(Calendar.DATE, -1);
                prevDate = cal.getTime();
                cal.add(Calendar.DATE, 1);
                                out.println("\t<TD><A HREF=\"/tvschedule/schedule_prn.jsp?date=" + sdf.format(prevDate) + "&days=7&preview=1\" TARGET=\"_blank\"\"><IMG SRC=\"/admin/img/file.gif\" ALT=\"Версия для печати\" BORDER=\"0\"></A></TD>");
                out.println("</TR>");            }
                         p++;            if(p >= v.size())               break;            tvday = (Tvschedule.TvDay)v.elementAt(p);            cal.setTime(tvday.day);            if(cal.get(Calendar.DATE) == 1)               break;            firstLoop = false;
        }                if(p >= v.size())
            cal.add(Calendar.DATE, 1);

        switch(cal.get(Calendar.DAY_OF_WEEK))
        {
            case Calendar.TUESDAY:                out.println("\t<TD ALIGN=\"right\">&nbsp;</TD>");            case Calendar.WEDNESDAY:
                out.println("\t<TD ALIGN=\"right\">&nbsp;</TD>");
            case Calendar.THURSDAY:                out.println("\t<TD ALIGN=\"right\">&nbsp;</TD>");
            case Calendar.FRIDAY:                out.println("\t<TD ALIGN=\"right\">&nbsp;</TD>");
            case Calendar.SATURDAY:                out.println("\t<TD ALIGN=\"right\">&nbsp;</TD>");            case Calendar.SUNDAY:                out.println("\t<TD ALIGN=\"right\">&nbsp;</TD>");
                out.println("\t<TD><A HREF=\"/tvschedule/schedule_prn.jsp?date=" + sdf.format(cal.getTime()) + "&days=7&preview=1\"  TARGET=\"_blank\"><IMG SRC=\"/admin/img/file.gif\" ALT=\"Версия для печати\" BORDER=\"0\"></A></TD>");                out.println("</TR>");
        }
        
        out.println("</TABLE>");
        out.println("</TD>");
        return p;
    }
%>

<%
    long mil1 = cal.getTime().getTime();
    Date d1 = cal.getTime();
    cal.add(Calendar.MONTH, monthCount);
    int dayCount = (int)((cal.getTime().getTime()- mil1) / (long)(1000*60*60*24));
    
    Vector tvdays = Tvschedule.getTvDays(langCode, d1, dayCount);
    int p = 0;
    for(int i = 0; i < monthCount; i++)
    {
        p = printMonth(out, tvdays, p);
    }
%>       
</TR>
</TABLE>

<BR>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD ROWSPAN="3" WIDTH="10"><IMG SRC="/admin/img/blank.gif" WIDTH="10" HEIGHT="1"><BR></TD>
<TD WIDTH="15" ALIGN="center"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15" BORDER="1"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">программа за день не заполнена;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">программа за день полностью опубликована;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">программа за день опубликована не полностью;</TD>
</TR>
</TABLE>

<SCRIPT LANGUAGE="JavaScript">
    function submitMidnight()
    {
        if(!isShortTime(document.midnight_form.midnight.value))
        {
            alert("Введите время в формате hh:mm");
            document.midnight_form.midnight.focus();
        }
        else
            if(confirm("Установить значение?"))
                document.midnight_form.submit();
    }
    function submitDefShowplace(s)
    {
        document.def_showplace_form.mode.value = s;
        var ccc;
        if('def_showplace' == s)
            ccc = "Установить место показа?";
        else
            ccc = "Удалить место показа?";
        if(document.def_showplace_form.showplace_id.value.length == 0)
        {
            alert("Выберите место показа");
            document.def_showplace_form.showplace_id.focus();
        }
        else
            if(confirm(ccc))
                document.def_showplace_form.submit();
    }
    
    function submitNewShowplace()
    {

        if(trim(document.new_showplace_form.name.value).length == 0)
        {
            alert("Введите название");
            document.new_showplace_form.name.focus();
        }
        else
            if(confirm("Добавить место показа?"))
                document.new_showplace_form.submit();
    }
    
</SCRIPT>
<%
    ShowPlace sp = ShowPlace.getDefaultShowPlace(langCode);
    TimeZone tz = (sp != null ? sp.getTimeZone() : TimeZone.getGmtTimeZone());
    String showPlaceName = tz.getName() + (sp != null ? " " + sp.getName() : "");
    int gmtShift = tz.getGmtShift();
%>


<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM NAME="new_showplace_form" ACTION="xt_tvschedule.jsp" METHOD="POST">
<INPUT TYPE="hidden" NAME="mode" VALUE="new_showplace">
<INPUT TYPE="hidden" NAME="year" VALUE="<%=year%>">
<INPUT TYPE="hidden" NAME="month" VALUE="<%=month%>">
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Добавить новое место показа</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<SELECT NAME="tz_id">
<%
    Enumeration enum = TimeZone.getTimeZones();
    while(enum.hasMoreElements())
    {
        TimeZone ttzz = (TimeZone)enum.nextElement();
%>
<OPTION VALUE="<%=ttzz.getId()%>"><%=ttzz.getName()%></OPTION>
<%  } %>
</SELECT>
&nbsp;<INPUT TYPE="text" NAME="name" VALUE="" STYLE="width: 200" SIZE="30" MAXLENGTH="200">
&nbsp;&nbsp;&nbsp;<INPUT TYPE="button" VALUE="добавить" onClick="submitNewShowplace();" id=button2 name=button2><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
</FORM>
</TABLE>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM NAME="def_showplace_form" ACTION="xt_tvschedule.jsp" METHOD="POST">
<INPUT TYPE="hidden" NAME="mode" VALUE="def_showplace">
<INPUT TYPE="hidden" NAME="year" VALUE="<%=year%>">
<INPUT TYPE="hidden" NAME="month" VALUE="<%=month%>">
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Место показа, используемое по умолчанию</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<SELECT NAME="showplace_id">
<OPTION VALUE="">Выберите место показа</OPTION>
<%
    enum = ShowPlace.getShowPlaces(langCode);
    while(enum.hasMoreElements())
    {
        ShowPlace sspp = (ShowPlace)enum.nextElement();
%>
<OPTION VALUE="<%=sspp.getId()%>"<%= sspp.equals(sp) ? " SELECTED" : ""%>><%=sspp.getTimeZone().getName()%> <%=sspp.getName()%></OPTION>
<%  } %>
</SELECT>
&nbsp;&nbsp;&nbsp;<INPUT TYPE="button" VALUE="установить" onClick="submitDefShowplace('def_showplace');">&nbsp;&nbsp;<INPUT TYPE="button" VALUE="удалить" onClick="submitDefShowplace('del_showplace');"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
</FORM>
</TABLE>


<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM NAME="midnight_form" ACTION="xt_tvschedule.jsp" METHOD="POST">
<INPUT TYPE="hidden" NAME="mode" VALUE="midnight">
<INPUT TYPE="hidden" NAME="year" VALUE="<%=year%>">
<INPUT TYPE="hidden" NAME="month" VALUE="<%=month%>">
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Время окончания "телевизионных суток"</B> (для <%=showPlaceName%>)<BR></TD>
</TR>

<TR>
<TD ALIGN="left" CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;<INPUT TYPE="text" NAME="midnight" VALUE="<%=Tvschedule.getMidnight(langCode, gmtShift)%>" STYLE="width: 50" SIZE="5" MAXLENGTH="5">
&nbsp;&nbsp;&nbsp;<INPUT TYPE="button" VALUE="установить" onClick="submitMidnight();"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
</FORM>
</TABLE>

<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
