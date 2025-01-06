<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String  sDate   = request.getParameter("date");
    int     days    = 1;
    Date    date    = null;
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
    try{ days = Integer.parseInt(request.getParameter("days")); }catch(Exception e){}
    
try{
    
    try{
        date = sdf.parse(sDate);
    } catch(Exception e) {
        date = sdf.parse(sdf.format(new Date()));
    }

    Calendar cal = Calendar.getInstance();
    if(days > 1)
    {
        cal.setTime(date);
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        date = cal.getTime();
    }
    
    Date lastDate = null;
    if(days > 1)
    {
        cal.setTime(date);
        cal.add(Calendar.DATE, days - 1);
        lastDate = cal.getTime();
    }
    else
        lastDate = new Date();


    String showPlaceId = request.getParameter("show_place_id");
    ShowPlace showPlace = null;
    int gmtShift = 0;
    
    if(showPlaceId != null && showPlaceId.length() > 0)
    {
        try
        {
            showPlace = ShowPlace.getShowPlace(langCode, showPlaceId);
        }
        catch(Exception e)
        {
            showPlace = null;
        }
    }

    if(showPlace == null)
    {
        String spId = CMSApplication.getCookie(request, "tvschedule.showplace");
        if(spId != null && spId.length() > 0)
        {
            try{
                showPlace = ShowPlace.getShowPlace(langCode, spId);
            }catch(Exception e)
            {
                showPlace = null;
            }
        }
    }
    
    if(showPlace == null)
    {
        showPlace = ShowPlace.getDefaultShowPlace(langCode);
    }
    
    if(showPlace == null)
        showPlaceId = "";
    else
    {
        showPlaceId = showPlace.getId();
        gmtShift = showPlace.getTimeZone().getGmtShift();
    }
    
    String spName = "";
    if(showPlace != null)
        spName = CMSApplication.toHTML(showPlace.getName()) + " " + showPlace.getTimeZone().getName();

    boolean publOnly = ! adminPreview;
    Enumeration enum = Tvschedule.getItems(langCode, date, days, publOnly).elements();
%>
<%!
    private static final String [] MONTHS = new String[] {
        "Января", "Февраля", "Марта", "Апреля", "Мая", "Июня",
        "Июля", "Авгуса", "Сентября", "Октября", "Ноября", "Декабря"
    };
    private static final String [] DAYS = new String[] {
        "--", "Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"
    };
    public String toDateString(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return  "" + cal.get(Calendar.DATE) + " " + MONTHS[cal.get(Calendar.MONTH)];
    }
    public String toDayString(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return  DAYS[cal.get(Calendar.DAY_OF_WEEK)];
    }
%>

<%  if(days > 1)
    {
%>
<html>
<head>
<title><%=CMSApplication.getSiteName()%> :: Телепрограмма :: Версия для печати</title>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251"><link rel="STYLESHEET" type="text/css" href="/inc/css.css">
<style>
.h1{font-size:11px;font-weight:bold;}
TD {font-family:arial;font-size:9px;}
TD B{font-family:tahoma;}
</style>
</head>
<body bgcolor="#ffffff" text="#000000" style="margin:-10px;" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td colspan="7">
<table border="0" cellpadding="0" cellspacing="0">
<tr valign="top">
    <td width="20%" class="defFont">
        <img src="<%=des%>/logo-prnt.gif" width="53" height="55" alt="" border="0">
        <br><br>
        <B style="color:#B2B2B2;">Программа телепередач</B><br> <SMALL>c <%=toDateString(date)%> по <%=toDateString(lastDate)%></SMALL>
        <br><br>
        Часовой пояс:
        <b style="color:#666666;"><%=spName%></b>
    </td>



<%
    Date prevDate = null;
    int col = 0;
    while(enum.hasMoreElements())
    {
        Tvschedule item = (Tvschedule)enum.nextElement();
        if(!item.getTvDate(langCode).equals(prevDate))
        {
            col ++;
            //  закрываем ячейку
            if(prevDate != null)
            {
%>
        </td></tr>
        <%--tr valign=top><td colspan="2">
        <hr noshade color="#B2B2B2" size="1">
        <div class="h1">
        <SPAN style="color:#B2B2B2;"><%=toDateString(prevDate)%></SPAN>
        <br>
        <%=toDayString(prevDate)%> 
        </div>
        </td>
        </tr--%>
        </table>
    </td>
<%          }
            // если не последняя колонка
            if(col % 4 != 0)
            {
%>
    <td><div style="width:20px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="20"></div></td>
<%          }
            // началась след. строка
            if(col % 4 == 0 && prevDate != null)
            {
%>
    </tr>

    <tr><td colspan="7"><p style="page-break-before: always;"></p></td></tr>

    <tr valign="top">
<%
            }
            prevDate = item.getTvDate(langCode);
%>
    <td width="20%" class="defFont">
        <table border="0" cellpadding="2" cellspacing="0">
        <tr valign=top><td colspan="2">
        <div class="h1">
        <SPAN style="color:#B2B2B2;"><%=toDateString(prevDate)%></SPAN>
        <br>
        <%=toDayString(prevDate)%>  
        </div>
        <hr noshade color="#B2B2B2" size="1">
        </td></tr>
<%
        }
        
%>
        <tr valign=top><td><b><%=item.getTime(gmtShift)%>.</b></td><td><%=CMSApplication.toHTML(item.getName())%></td></tr>

<%
    }
%>
<%  if(prevDate != null)
    {
%>
        </td></tr>
        <%--tr valign=top><td colspan="2">
        <hr noshade color="#B2B2B2" size="1">
        <div class="h1">
        <SPAN style="color:#B2B2B2;"><%=toDateString(prevDate)%></SPAN>
        <br>
        <%=toDayString(prevDate)%> 
        </div>
        </td></tr--%>
        </table>
    </td>
    </tr>
<%  } %>
</table>
</td>
</tr>
</table>
</body>
</html>


<%












}
else
{











%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=CMSApplication.getSiteName()%> :: Телепрограмма :: Версия для печати</title>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251"><link rel="STYLESHEET" type="text/css" href="/inc/css.css">
<style>
.h1{font-size:200%;font-weight:normal;}
</style>
</head>
<body bgcolor="#ffffff" text="#000000">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td><img src="<%=des%>/logo-prnt.gif" width="53" height="55" alt="" border="0"><br></td>
<td valign="bottom" class="defFont">

<div class="h1">
<%=toDateString(date)%>, <%=toDayString(date)%>
</div>
</td>
</tr>
<tr>
<td colspan="2">
<hr noshade width="100%" size="1" color="#b2b2b2">
</td>
</tr>
<tr valign="top">
<td>
<div class="defFont">Часовой пояс:</div>
<b style="color:#666666;"><%=spName%></b>
</td>
<td width="60%" class="defFont">

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:17px;">
<%
    while(enum.hasMoreElements())
    {
        Tvschedule item = (Tvschedule)enum.nextElement();
        String descr = CMSApplication.toHTML(item.getDescription());
        if(descr.length() > 0)
            descr = " <br>" + descr;
%>
	<tr valign="top"><td class=defFont width="1%"><b><%=item.getTime(gmtShift)%></b></td><td><div style="width:15px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="15"></div></td><td class=defFont  width="100%"><b><%=CMSApplication.toHTML(item.getName())%></b><%=descr%></td></tr>
<tr><td colspan="3" height="7"></td></tr><tr><td bgcolor="#b2b2b2" height="1" colspan="3"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr><tr><td colspan="3" height="7"></td></tr>		
<%  } %>
</table>

</td>
</tr>
</table>


</body>
</html>
<% } %>
<%  }catch(Exception e){} %>