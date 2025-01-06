<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String  sDate   = request.getParameter("date");
    Date    date    = null;
    Date    nextDate    = null;
    Date    prevDate    = null;
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");

try{

    try{
        date = sdf.parse(sDate);
    } catch(Exception e) {
        date = sdf.parse(sdf.format(new Date()));
    }
    
    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    cal.add(Calendar.DATE, -1);
    prevDate = cal.getTime();
    cal.add(Calendar.DATE, +2);
    nextDate = cal.getTime();

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

    Enumeration spEnum = ShowPlace.getShowPlaces(langCode);
    Enumeration enum = Tvschedule.getItems(langCode, date, 1, true).elements();
    Enumeration tvaEnum = Tvannounce.getTvannounces(langCode, date, 2, 6).elements();
%>
<%!
    private static final String [] MONTHS = new String[] {
        "Января", "Февраля", "Марта", "Апреля", "Мая", "Июня",
        "Июля", "Авгуса", "Сентября", "Октября", "Ноября", "Декабря"
    };
    private static final String [] DAYS = new String[] {
        "--", "Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"
    };
    public String toString(Date date, int offset)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        if(offset != 0)
            cal.add(Calendar.DATE, offset);
        return  "" + cal.get(Calendar.DATE) + " " + MONTHS[cal.get(Calendar.MONTH)] + 
                    ", <b>" + DAYS[cal.get(Calendar.DAY_OF_WEEK)] + "</b>";
    }
%>




<%@ include file="/inc/path_init.jsp"%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign="top" class="XsmallFont">
<%
    if(pagePath.size() > 1)
    {
%>
<div style="margin-top:8px">
<%  
        for(int i = 0; i < pagePath.size(); i++)
        {
            WebTreeNode treeNode = (WebTreeNode)pagePath.elementAt(i);
            if(i+1 == pagePath.size())
                out.println(CMSApplication.toHTML(treeNode.getName()));
            else
            {
%>  
<a href="<%=nodePath(treeNode)%>"><%=CMSApplication.toHTML(treeNode.getName())%></a> /
<%
            }
        }
%>
</div>
<%  } %>
</td>
<!--заголовок страницы--><td align="right"><img src="<%=des%>/<%=sectionImg%>/ttl.gif" height="47" alt="<%=sectionName%>" border="0"></td>
</tr>
</table>


<%---- заголовочек Программа на неделю-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/tvprogram/ttl-weekly.gif" width="131" height="19" alt="Программа на неделю" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек Программа на неделю-----%>

<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:8px;">
<tr><form action="">
<td>
<a href="/pages/<%=langCode%>/auth"><img src="<%=des%>/tvprogram/btn-subs.gif" width="143" height="9" alt="Подписаться на программу" border="0" hspace="7"></a><br>
<a href="/tvschedule/schedule_prn.jsp?date=<%=sdf.format(date)%>&days=7" target="_blank"><img src="<%=des%>/tvprogram/btn-prnt-week.gif" width="169" height="12" alt="Версия для печати на всю неделю" border="0" hspace="7" vspace="7"></a><br>
</td>
<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
<td width="100%" align="right" valign="top">
	<table border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
	<tr><form action="/page.jsp" method="get">
	<input type="hidden" name="date" value="<%=sdf.format(date)%>">
	<input type="hidden" name="id" value="<%=pageId%>">
	<td class="defFont"><SPAN class="bluTtl">Выберите часовой пояс:</SPAN>&nbsp;</td>
	<td class="SELnn">
	<NOBR><select name="show_place_id" style="width:205;font-size:10px;font-family:Tahoma;" width="200">
<%  while(spEnum.hasMoreElements())
    {
        ShowPlace sp = (ShowPlace)spEnum.nextElement();
%>
	<option value="<%=sp.getId()%>"<%=sp.getId().equals(showPlaceId) ? " SELECTED" : ""%>><%=sp.getTimeZone().getName()%> <%=CMSApplication.toHTML(sp.getName())%></option>
<%	} %>
	</select><input type="Image" src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="3" vspace="0" align="absmiddle"><br>
	</NOBR>
	</td>
	</form></tr>
	</table>
</td>
</tr>
<tr>
<td height="20" bgcolor="#DDF3E1" class="defFont">
&nbsp;<img src="<%=des%>/tvprogram/ico-fngr.gif" width="11" height="11" alt="" border="0" hspace="5"><b class="grnTtl">В этот день</b>
</td>
<td></td>
<td bgcolor="#DDF3E1" class="defFont"><a href="/tvschedule/schedule_prn.jsp?date=<%=sdf.format(date)%>&days=1" target="_blank"><img src="<%=des%>/tvprogram/btn-prnt.gif" width="101" height="10" alt="Версия для печати" border="0" align="right" hspace="5" vspace="2"></a>
&nbsp;<img src="<%=des%>/tvprogram/ico-cal.gif" width="16" height="12" alt="" border="0" align="absbottom" hspace="3"><SPAN class="grnTtl"><%=toString(date, 0)%></SPAN>
</td>
</tr>

<tr valign="top">
<td>

<table border="0" width="100%" cellpadding="0" cellspacing="0" style="margin-top:8px">
<%
    String sCurDate = sdf.format(date);
    while(tvaEnum.hasMoreElements())
    {
        Tvannounce tva = (Tvannounce)tvaEnum.nextElement();
        String sTvaDate = sdf.format(tva.getTvDate(langCode));
        if(!sCurDate.equals(sTvaDate))
        {
%>
<tr>
<td height="20" bgcolor="#DDF3E1" class="defFont">
&nbsp;<img src="<%=des%>/tvprogram/ico-fngr.gif" width="11" height="11" alt="" border="0" hspace="5"><b class="grnTtl">На следующий день</b>
</td>
</tr>
<tr><td height="8"></td></tr>
<%
        }
        sCurDate = sTvaDate;
%>
<%---- 1 -----%>
<tr>
<td valign="top" width="184" height="87" background="<%=des%>/tvprogram/bg-m-pic.gif"><div style="padding-left:53px;"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=tva.getId()%>"><img src="<%=tva.getImg()%>" width="77" height="58" alt="" border="0"></a></div></td>
</tr>
<tr>
<td align="center" class="smallFont">
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=tva.getId()%>" class="nonUa">
<div style="margin:5px;line-height:130%;">
<SPAN class="grn"><%=tva.getTime(gmtShift)%></SPAN><br>
<b class="bluTtl"><%=CMSApplication.toHTML(tva.getName())%></b><br>
<%=CMSApplication.toHTML(tva.getBrief())%><img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
</td>
</tr>
<%----//1 -----%>
<tr><td height="12"></td></tr>
<%  } %>
</table>

</td>
<td></td>
<td>

<%---- сегодня в эфире -----%>
<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin-top:8px">
<%
    while(enum.hasMoreElements())
    {
        Tvschedule item = (Tvschedule)enum.nextElement();
%>
<tr valign="top">
	<td style="background:#FFFFFF url(<%=des%>/hm-bg.gif) no-repeat;font-family: Verdana;" class="smallFont" align="center" height="18"><!--распорка--><div style="width:36;height:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="36"></div>
	<a class="nonUa"><b class="bluTtl"><%=item.getTime(gmtShift)%></b></a>
	</td>
	<td><div style="width:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td>
	<td width="100%" class="defFont"><a class="nonUa"><b class="bluTtl"><%=CMSApplication.toHTML(item.getName())%></b></a> <%=CMSApplication.toHTML(item.getDescription())%></td>
</tr>
<tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  } %>
</table>
<%----//сегодня в эфире -----%>

<%---- навигация -----%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:8px;">
<tr>
	<td class="smallFont"><a href="/pages/<%=langCode%>/tvschedule?date=<%=sdf.format(prevDate)%>" class="nonUa"><img src="<%=des%>/2lev/arr-grn-prew.gif" width="9" height="5" alt="" border="0" hspace="4"><SPAN class="grnTtl"><%=toString(date, -1)%></SPAN></a></td>
	<td align="right" class="smallFont"><a href="/pages/<%=langCode%>/tvschedule?date=<%=sdf.format(nextDate)%>" class="nonUa"><SPAN class="grnTtl"><%=toString(date, +1)%></SPAN><img src="<%=des%>/2lev/arr-grn-forw.gif" width="9" height="5" alt="" border="0" hspace="4"></a></td>
</tr>
</table>
<%----//навигация -----%>

</td>
</tr>
</table>
<%----//ТВ ПРОГРАММА   -----%>
<%  }catch(Exception e){} %>