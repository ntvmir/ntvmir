<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String announceId = request.getParameter("announce_id");
    Tvannounce announce = null;
    
try{

	if(previewInfo == null)
	{
	    announce = new Tvannounce();
        announce.load(announceId);
    }
	else
	{
		announce = (Tvannounce)previewInfo.get("article");
	}
	
    
    ShowPlace showPlace = null;
    int gmtShift = 0;
    
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
    
    if(showPlace == null)
    {
        showPlace = ShowPlace.getDefaultShowPlace(langCode);
    }
    
    if(showPlace != null)
        gmtShift = showPlace.getTimeZone().getGmtShift();
%>

<%!
    private static final String [] MONTHS = new String[] {
        "Января", "Февраля", "Марта", "Апреля", "Мая", "Июня",
        "Июля", "Авгуса", "Сентября", "Октября", "Ноября", "Декабря"
    };
    private static final String [] DAYS = new String[] {
        "--", "Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"
    };
    public String toString(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
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



<!---- заголовочек Программа на неделю----->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/tvprogram/ttl-weekly.gif" width="131" height="19" alt="Программа на неделю" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<!----//заголовочек Программа на неделю----->


<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:8px;">
<tr>
<td height="20" bgcolor="#DDF3E1" class="defFont"><div style="width:205;">
&nbsp;<img src="<%=des%>/tvprogram/ico-cal.gif" width="16" height="12" alt="" border="0" align="absbottom" hspace="3"><SPAN class="grnTtl"><%=toString(announce.getTvDate(langCode))%></SPAN>
</div></td>
<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
<td bgcolor="#DDF3E1" class="defFont" width="100%"><a href="/tvschedule/announce_prn.jsp?id=<%=announce.getId()%>" target="_blank"><img src="<%=des%>/tvprogram/btn-prnt.gif" width="101" height="10" alt="Версия для печати" border="0" align="right" hspace="5" vspace="2"></a></td>
</tr>

<tr valign="top">
<td align="center">

<table border="0" width="184" cellpadding="0" cellspacing="0" style="margin-top:8px">
<!---- 1 ----->
<tr>
<td valign="top" width="184" height="87" background="<%=des%>/tvprogram/bg-m-pic.gif"><div style="padding-left:53px;"><img src="<%=announce.getImg()%>" width="77" height="58" alt="" border="0"></div></td>
</tr>
<tr>
<td align="center" class="smallFont">
<a class="nonUa">
<div style="margin:5px 0px 0px 6px;line-height:130%;">
<!---- время ----->
<table border="0" cellpadding="2" cellspacing="0" style="margin-top:4px">
<tr valign="top">
	<td style="background:#FFFFFF url(<%=des%>/hm-bg.gif) no-repeat;font-family: Verdana;" class="smallFont" align="center" height="18"><div style="width:36;height:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="36"></div>
	<a href="" class="nonUa"><b class="bluTtl"><%=announce.getTime(gmtShift)%></b></a>
	</td>
	<td><div style="width:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td>
</tr>
</table>
<!----//время ----->
</NOINDEX><b class="bluTtl"><%=CMSApplication.toHTML(announce.getName())%></b><br><NOINDEX>
</div>
</a>
</td>
</tr>
<!----//1 ----->
</table>

</td>
<td></td>
<td>
</NOINDEX>
<div style="margin:8px 0px 0px 7px;" class="defFont">
<%=announce.getText()%>
</div>
<NOINDEX>
</td>
</tr>

<tr><td height="11" colspan="3"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>		
<!-- divider --><tr><td height="11" colspan="3" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>		
<tr><td></td><td></td><td><a href="/pages/<%=langCode%>/tvschedule"><img src="<%=des%>/tvprogram/btn-prog-lst.gif" width="119" height="18" alt="" border="0" hspace="8"></a></td></tr>
</table>
<%  }catch(Exception e){} %>