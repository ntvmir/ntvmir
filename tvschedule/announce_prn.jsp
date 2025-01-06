<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String  id   = request.getParameter("id");
try{

    Tvannounce announce = new Tvannounce();
    try
    {
        announce.load(id);
    }
    catch(Exception e){}

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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>НТВ МИР :: Подробное описание телепередачи :: Версия для печати</title>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251"><link rel="STYLESHEET" type="text/css" href="/inc/css.css">
<style>
.h1{font-size:200%;font-weight:normal;}
</style>
</head>
<body bgcolor="#ffffff" text="#000000">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td align="center"><img src="<%=des%>/logo-prnt.gif" width="53" height="55" alt="" border="0"><br></td>
<td valign="bottom" class="defFont">
<div class="h1"><%=CMSApplication.toHTML(announce.getName())%></div>
</td>
</tr>
<tr>
<td colspan="2">
<hr noshade width="100%" size="1" color="#b2b2b2">
</td>
</tr>
<tr valign="top">
<td align="center">
<b style="color:#666666;"><%=toDateString(announce.getStartDate())%>, <%=toDayString(announce.getStartDate())%></b>
<br>
<br>
<b> <%=announce.getTime(gmtShift)%>  </b>
<br>
<br>
<img src="<%=announce.getImg()%>" width="77" height="58" alt="" border="0">
</td>
<td width="60%" class="defFont">
<%=announce.getText()%>
</td>
</tr>
</table>
</body>
</html>
<%  }catch(Exception e){} %>