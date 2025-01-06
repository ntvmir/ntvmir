<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.vote.*"%>
<%@ page import="tengry.cms.forum.ForumItem"%>
<%@ page import="tengry.cms.forum.Forum"%>
<%@ page import="tengry.ntvmir.*"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%! 
    public void printBanner(HomePage hp, int idx, String des, JspWriter out, boolean showSpacer) throws Exception
    {
        out.println("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
        if(showSpacer)
        {
            out.println("<tr bgcolor=\"#ffffff\">");
            out.println("<td height=\"10\"><SPACER TYPE=\"block\" HEIGHT=\"1\" WIDTH=\"1\"></td>");
            out.println("</tr>");
        }
        out.println("<tr>");
        out.print("<td background=\"" + hp.getBannerImg(idx) + "\" bgcolor=\"#0E213F\"><a href=\"" + hp.getBannerUrl(idx) + "\">");
        out.print("<img src=\"" + des + "/blank.gif\" width=\"160\" height=\"142\" border=\"0\" align=\"left\" hspace=\"0\">");
        out.println("<img src=\"" + des + "/bnr-rc.gif\" width=\"8\" height=\"142\" border=\"0\" align=\"right\" hspace=\"0\"></a></td>");
        out.println("</tr>");
        out.println("</table>");
    }
%>
<%
try
{
    String langCode = CMSApplication.getApplication().getPrimaryLangCode();
    
	String des = CMSApplication.getApplication().getCurrentDesignPath() + "/" + langCode;	
	HomePage hp = HomePage.getInstance(langCode);
	int gmtShift = 0;
	
	WebPage node = CMSApplication.getApplication().getWebRoot(langCode);
	String pageId = null;
	
	if(node != null)
	    pageId = node.getId();
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yy");
	
	boolean light = ("1".equals(request.getParameter("light")));
	
	tengry.cms.press.News news = hp.getTopNews();
	Tvannounce announce1 = hp.getAnnounce(1);
	Tvannounce announce2 = hp.getAnnounce(2);
	Tvannounce announce3 = hp.getAnnounce(3);
	Tvannounce announce4 = hp.getAnnounce(4);

    String europeUrl = CMSApplication.getApplication().getProperty("www.europe", "/");
    String americaUrl = CMSApplication.getApplication().getProperty("www.america", "/");
    String siteUrl = CMSApplication.getApplication().getProperty("www.address", "/");
	
	Enumeration scheduleItems = hp.getTvschedule();
	Enumeration showPlaces = hp.getShowPlaces();

    ShowPlace showPlace = null;
    String showPlaceId = request.getParameter("showplace_id");
    if(showPlaceId != null)
    {
        try
        {
            showPlace = ShowPlace.getShowPlace(langCode, showPlaceId);
        }catch(Exception e){}
    }
    if(showPlace == null)
        showPlace = ShowPlace.getDefaultShowPlace(langCode);

    if(showPlace != null)
        gmtShift = showPlace.getTimeZone().getGmtShift();
    
	if(!light)
	{
%>
<%!
public String nodePath(WebTreeNode node)
{
    if(node == null)
        return "/pages";
    return nodePath(node.getParent()) + "/" + node.getCode();
}

public String nodePath(String nodeId)
{
    return nodePath(CMSApplication.getApplication().lookup(nodeId));
}
%>
<html>
<head>
<title><%=CMSApplication.getSiteName()%></title>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
</head>
<style>
.defFont {
font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;
font-size: 70%;
}
.smallFont {
font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;
font-size: 65%;
}
.XsmallFont {
font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;
font-size: 60%;
}
.bluTtl{color:#032866;}
.nonUa{text-decoration:none;color:#000000;}
.w{color:#FFFFFF;}
.grn{color:#006513}
</style>

<SCRIPT LANGUAGE="JavaScript">(document.layers)?document.write('<style></style>'):document.write('<style>body {background:#1DAF38 url(<%=des%>/bg-grn-ln.gif) repeat-y;}</style>');</SCRIPT>

<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" bgcolor="#80AFE0" background="<%=des%>/bg-grn-ln.gif">
<table width="100%" cellpadding="0" cellspacing="0" border="0" height="100%">


<%-- RED -----%>
<tr>
	<td colspan="7" height="7" bgcolor="#FF1515"><img src="<%=des%>/t-red.jpg" width="770" height="7" alt="" border="0"></td>
</tr>
<%----//RED -----%>

<%----  ROW header -----%>
<tr>
	<td colspan="7" height="53" bgcolor="#D1E8FA" valign="top">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr>
		<td><img src="<%=des%>/logo-ntv.gif" width="88" height="52" alt="" border="0"></td>
		<td bgcolor="#4991D3"><img src="<%=des%>/t-1.gif" width="158" height="52" alt="" border="0"></td>
		<td bgcolor="#0F3E8C"><img src="<%=des%>/t-2.gif" width="271" height="52" alt="" border="0"></td>
		<td bgcolor="#2E516F"><img src="<%=des%>/t-3.gif" width="90" height="52" alt="" border="0"></td>
		<td width="100%"><img src="<%=des%>/t-4.jpg" width="165" height="52" alt="" border="0"></td>
		</tr>
		<tr>
		<td height="1" bgcolor="#ffffff" colspan="5"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
		</tr>
		</table>
	</td>
</tr>
<%----// ROW  header -----%>


<%---- ROW  nava -----%>
<tr>
	<td colspan="7"><a href="/"><img src="<%=des%>/<%=siteUrl.equals(americaUrl) ? "logo-mir-america.gif" : "logo-mir.gif"%>" width="96" height="23" border="0"></a><a href="/pages/<%=langCode%>/about"><img src="<%=des%>/n-abt.gif" width="92" height="23" border="0"></a><img src="<%=des%>/n-sprtr.gif" width="6" height="23" border="0"><a href="/pages/<%=langCode%>/tvschedule"><img src="<%=des%>/n-tvprg.gif" width="112" height="23" border="0"></a><img src="<%=des%>/n-sprtr.gif" width="6" height="23" border="0"><a href="/pages/<%=langCode%>/support"><img src="<%=des%>/n-sprt.gif" width="138" height="23" border="0"></a><img src="<%=des%>/n-sprtr.gif" width="6" height="23" border="0"><a href="/pages/<%=langCode%>/forum"><img src="<%=des%>/n-frm.gif" width="60" height="23" border="0"></a><img src="<%=des%>/n-r.gif" width="250" height="23" border="0"></td>
</tr>
<%----// ROW nava -----%>


<%---- ROW  белая полоска с закругленным уголком -----%>
<tr>
	<td width="21%" bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	<td bgcolor="#ffffff" rowspan="6"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	<td width="38%" bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	<td bgcolor="#ffffff" rowspan="6"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	<td width="23%" bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	<td align="right"><img src="<%=des%>/tp-r.gif" width="10" height="9" border="0"></td>
	<td width="18%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%----// ROW белая полоска с закругленным уголком -----%>


<%---- ROW топ новость и анонсы -----%>
<tr valign="top">
<td bgcolor="#<%= news != null ? "80AFE0" : "ffffff"%>" width="21%">

<%---- топ новость -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#80AFE0">

<tr bgcolor="#ffffff">
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/lng-bg.gif">
<tr align="right">
<%
    if(siteUrl.equals(americaUrl))
    {
%>
    <td width="100%"><a href="<%=europeUrl%>"><img src="<%=des%>/lng-eur-rus.gif" width="62" height="19" alt="Europe" border="0"></a><a href="<%=americaUrl%>"><img src="<%=des%>/lng-usa-cur-rus.gif" width="37" height="19" alt="USA" border="0" hspace="8"></a></td>
<%
    }
    else
    {
%>
	<td width="100%"><a href="<%=americaUrl%>"><img src="<%=des%>/lng-usa-rus.gif" width="37" height="19" alt="USA" border="0"></a><a href="<%=europeUrl%>"><img src="<%=des%>/lng-eur-cur-rus.gif" width="62" height="19" alt="Europe" border="0" hspace="8"></a></td>
<%  } %>
	<td><img src="<%=des%>/lng-r.gif" width="8" height="19" alt="" border="0"></td>
</tr>
</table>
</td>
</tr>

<tr bgcolor="#ffffff">
<form action="/pages/<%=langCode%>/search">
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr><td height="10"></td></tr>
<tr valign="bottom">
<td><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td width="100%"><NOBR><a href="/pages/<%=langCode%>/search"><img src="<%=des%>/srch.gif" width="67" height="9" border="0"></a><img src="<%=des%>/dvder.gif" width="9" height="9" border="0"><a href="/pages/<%=langCode%>/map"><img src="<%=des%>/sitemap.gif" width="51" height="9" border="0"></a><br></NOBR></td>
	<td></td>
<td><div style="width:5;"><SPACER TYPE="block" HEIGHT="1" WIDTH="5"></div></td>	
</tr>
<tr><td height="3"></td></tr>
<tr>
<td><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td width="100%"><input name="f_query" type="text" style="width:100%;font-size:10px;font-family:Tahoma;" size="15"></td>
	<td><input type="Image" src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5"></td>
<td><div style="width:5;"><SPACER TYPE="block" HEIGHT="1" WIDTH="5"></div></td>	
</tr>
<tr><td height="10"></td></tr>
</table>

</td>
</form>
</tr>
<tr valign="top">
<%  if(news != null){ %>
<td height="180" style="background-image:url(<%=des%>/lft-tn-bg.gif);background-repeat:repeat-x;" class="defFont"><img src="<%=des%>/lft-tn-tr.gif" width="10" height="10" border="0" align="right" hspace="0">
<img src="<%=des%>/ttl-top-news.gif" width="74" height="7" border="0" hspace="10" vspace="11"><br>
<div style="margin:0px 30px 10px 10px;line-height:130%">
<SPAN class="w"><%=sdf.format(news.getRecordDate())%></SPAN><br>
<b class="bluTtl"><%=CMSApplication.toHTML(news.getCaption())%></b><br>
<a href="<%=nodePath(news.getWebPageId())%>?press_id=<%=news.getId()%>" class="nonUa"><%=CMSApplication.removeTags(news.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"></a><br>
</div>
</td>
<%  } else { %>
<td>
<%  
        if(hp != null && hp.isBannerShow(1))
            printBanner(hp, 1, des, out, false);
        else if(hp != null && hp.isBannerShow(2))
            printBanner(hp, 2, des, out, false);
%>
</td>
<%  } %>
</tr>
</table>
<%----//топ новость -----%>

</td>
<td width="61%" colspan="3" bgcolor="#ffffff" height="1">

<%---- АНОНСЫ -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">
<tr>
<td height="9" colspan="5">
<%---- заголовочек -----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/blu-ttl-anons.gif" width="46" height="19" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек -----%>
</td>
</tr>

<!--отступ--><tr><td height="9" colspan="5"></td></tr>

<tr valign="top">
<td background="<%=des%>/a-bg.gif"><%  if(announce1 != null){ %><div style="margin:0px 8px 0px 3px"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce1.getId()%>"><img src="<%=announce1.getImg()%>" width="77" height="58" border="0" hspace="3"></a><br></div><%}%></td>
<td width="50%" rowspan="2" class="defFont">
<%  if(announce1 != null){ %>
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce1.getId()%>" class="nonUa">
<SPAN class="grn"><%=sdf.format(announce1.getTvDate(langCode))%></SPAN>
<div style="margin-top:5px;line-height:130%;">
<b class="bluTtl"><%=CMSApplication.toHTML(announce1.getName())%></b><br>
<%=CMSApplication.toHTML(announce1.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
<%  } %>
</td>
<td rowspan="2"><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
<td background="<%=des%>/a-bg.gif"><%  if(announce2 != null){ %><div style="margin:0px 8px 0px 3px"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce2.getId()%>"><img src="<%=announce2.getImg()%>" width="77" height="58" border="0" hspace="3"></a><br></div><%}%></td>
<td width="50%" rowspan="2" class="defFont">
<%  if(announce2 != null){ %>
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce2.getId()%>" class="nonUa">
<SPAN class="grn"><%=sdf.format(announce2.getTvDate(langCode))%></SPAN>
<div style="margin-top:5px;line-height:130%;">
<b class="bluTtl"><%=CMSApplication.toHTML(announce2.getName())%></b><br>
<%=CMSApplication.toHTML(announce2.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
<%  } %>
</td>
</tr>
<tr valign="top">
<td background="<%=des%>/a-bg.gif" valign="bottom"><%  if(announce1 != null){ %><DIV style="position:relative;top:1;left:0;"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce1.getId()%>"><img src="<%=des%>/x.gif" width="66" height="28" border="0"></a></DIV><% } %></td>
<td background="<%=des%>/a-bg.gif" valign="bottom"><%  if(announce2 != null){ %><DIV style="position:relative;top:1;left:0;"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce2.getId()%>"><img src="<%=des%>/x.gif" width="66" height="28" border="0"></a></DIV><% } %></td>
</tr>
<tr>
<td background="<%=des%>/a-bg-h.gif" height="1" colspan="2"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
<td height="1"></td>
<td background="<%=des%>/a-bg-h.gif" bgcolor="#DFE6F0" height="1" colspan="2"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>	

<!--отступ--><tr><td height="3" colspan="5"></td></tr>

<tr valign="top">
<td background="<%=des%>/a-bg.gif"><%  if(announce3 != null){ %><div style="margin:4px 8px 0px 3px"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce3.getId()%>"><img src="<%=announce3.getImg()%>" width="77" height="58" border="0" hspace="3"></a><br></div><%}%></td>
<td width="50%" rowspan="2" class="defFont">
<%  if(announce3 != null){ %>
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce3.getId()%>" class="nonUa">
<SPAN class="grn"><%=sdf.format(announce3.getTvDate(langCode))%></SPAN>
<div style="margin-top:5px;line-height:130%;">
<b class="bluTtl"><%=CMSApplication.toHTML(announce3.getName())%></b><br>
<%=CMSApplication.toHTML(announce3.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
<%  } %>
</td>
<td rowspan="2"><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
<td background="<%=des%>/a-bg.gif"><%  if(announce4 != null){ %><div style="margin:4px 8px 0px 3px"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce4.getId()%>"><img src="<%=announce4.getImg()%>" width="77" height="58" border="0" hspace="3"></a><br></div><%}%></td>
<td width="50%" rowspan="2" class="defFont">
<%  if(announce4 != null){ %>
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce4.getId()%>" class="nonUa">
<SPAN class="grn"><%=sdf.format(announce4.getTvDate(langCode))%></SPAN>
<div style="margin-top:5px;line-height:130%;">
<b class="bluTtl"><%=CMSApplication.toHTML(announce4.getName())%></b><br>
<%=CMSApplication.toHTML(announce4.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
<%  } %>
</td>
</tr>
<tr valign="top">
<td background="<%=des%>/a-bg.gif" valign="bottom"><%  if(announce3 != null){ %><DIV style="position:relative;top:1;left:0;"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce3.getId()%>"><img src="<%=des%>/x.gif" width="66" height="28" border="0"></a></DIV><% } %></td>
<td background="<%=des%>/a-bg.gif" valign="bottom"><%  if(announce4 != null){ %><DIV style="position:relative;top:1;left:0;"><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce4.getId()%>"><img src="<%=des%>/x.gif" width="66" height="28" border="0"></a></DIV><% } %></td>
</tr>
<tr>
<td background="<%=des%>/a-bg-h.gif" height="1" colspan="2"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
<td height="1"></td>
<td background="<%=des%>/a-bg-h.gif" height="1" colspan="2"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>	

</table>
<%----//АНОНСЫ  -----%>


</td>
<td bgcolor="#ffffff" rowspan="4"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
<td width="18%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%----//ROW топ новость и анонсы -----%>



<%----  ROW отступ между блоками-----%>
<tr>
<td width="21%" align="right" bgcolor="#ffffff"><% if(news != null){ %><div style="position:relative;top:-10;left:0;"><img src="<%=des%>/lft-tn-br.gif" width="10" height="10" border="0"></div><% } %></td>
<td width="38%" bgcolor="#FFFFFF"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
<td width="23%" bgcolor="#FFFFFF"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
<td width="18%"></td>
</tr>
<%----// ROW отступ между блоками-----%>



<%---- ROW main -----%>
<tr valign="top">
<td width="21%" bgcolor="#80AFE0" rowspan="2" height="100%">
<%---- БАННЕР -----%>
<%  
    if(news != null){
        boolean showSpacer = false;
        if(hp != null && hp.isBannerShow(1))
        {
            printBanner(hp, 1, des, out, false);
            showSpacer = true;
        }
        if(hp != null && hp.isBannerShow(2))
            printBanner(hp, 2, des, out, showSpacer);
    }
    else
    {
        if(hp != null && hp.isBannerShow(1) && hp.isBannerShow(2))
            printBanner(hp, 2, des, out, false);
    }
%>
<%----//БАННЕР -----%>
<%---- ОПРОС -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#80AFE0">
<tr bgcolor="#ffffff">
<td height="10"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%@ include file="/vote/vote.jsp"%>
</table>
<%----//ОПРОС -----%>

</td>
<td width="38%" bgcolor="#ffffff">
<%---- ЦЕНТРАЛ -----%>

<%---- заголовочек сейчас в эфире-----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/grn-ttl-bg.gif" bgcolor="#1DAE38">
<tr>
	<td nowrap><img src="<%=des%>/grn-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/grn-ttl-efir.gif" width="94" height="19" border="0"></td>
	<td align="right"><img src="<%=des%>/grn-ttl-rght.gif" width="16" height="19" border="0"></td>
</tr>
</table>
<%----//заголовочек сейчас в эфире-----%>

<%---- сейчас в эфире -----%>
<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin:9px 0px 0px 0px;">
<%
    boolean firstLoop = true;
    while(scheduleItems.hasMoreElements())
    {
        Tvschedule item = (Tvschedule)scheduleItems.nextElement();
        if(firstLoop)
            firstLoop = false;
        else
        {
%>
<tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%      } %>
<tr valign="top">
	<td style="background:#FFFFFF url(<%=des%>/hm-bg.gif) no-repeat;font-family: Verdana;" class="smallFont" align="center" height="18"><!--распорка--><div style="width:36;height:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="36"></div>
	<a href="/pages/<%=langCode%>/tvschedule" class="nonUa"><b class="bluTtl"><%=item.getTime(gmtShift)%></b></a>
	</td>
	<td><div style="width:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td>
	<td width="100%" class="defFont"><a href="/pages/<%=langCode%>/tvschedule" class="nonUa"><b class="bluTtl"><%=CMSApplication.toHTML(item.getName())%></b></a> <%=CMSApplication.toHTML(item.getDescription())%></td>
</tr>
<%  } %>
</table>
<%----//сейчас в эфире -----%>

<%----//ЦЕНТРАЛ -----%>
</td>
<td width="23%" bgcolor="#ffffff">

<%---- программа на неделю -----%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#72D184">
<tr valign="top">
<form action="/pages/<%=langCode%>/tvschedule">
<td height="126" background="<%=des%>/prog-bg.gif" class="defFont">
<img src="<%=des%>/grn-crn-tl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-tr.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0">
<img src="<%=des%>/ttl-prog.gif" width="130" height="9" border="0" vspace="11"><br>
<div style="margin:0px 10px 10px 10px;" class="grn">
Выберите часовой пояс для просмотра прграммы:
</div>
<div style="margin:10px 0px 10px 10px;width:100%;font-size:10px;font-family:Tahoma;">
<NOBR>
<select name="show_place_id" style="width:157;font-size:10px;font-family:Tahoma;" width="160">
<%
    while(showPlaces.hasMoreElements())
    {
        ShowPlace sp = (ShowPlace)showPlaces.nextElement();
%>
<option VALUE="<%=sp.getId()%>"<%=showPlace != null && showPlace.getId().equals(sp.getId()) ? " SELECTED" : ""%>><%=sp.getTimeZone().getName()%> <%=CMSApplication.toHTML(sp.getName())%></option>
<%  } %>
</select><input type="Image" src="<%=des%>/btn-arr-grn.gif" width="18" height="18" border="0" hspace="3" vspace="0" align="absmiddle"><br>
</NOBR>
</div>
</td>
</form>
</tr>
<tr><td><a href="/pages/<%=langCode%>/auth"><img src="<%=des%>/btn-subs.gif" width="145" height="18" border="0" hspace="10"></a></td></tr>
<tr>
<td><img src="<%=des%>/grn-crn-bl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-br.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"></td>
</tr>
</table>
<%----//программа на неделю -----%>

</td>
<td width="18%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%----//ROW main -----%>





<%---- ROW main2 -----%>
<tr valign="top">
<td width="38%" bgcolor="#ffffff">
<%---- ЦЕНТРАЛ 2-----%>

<%---- заголовочек ДАВАЙТЕ ОБСУДИМ-----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/grn-ttl-bg.gif" bgcolor="#1DAE38" style="margin:14px 0px 0px 0px;">
<tr>
	<td nowrap><img src="<%=des%>/grn-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/grn-ttl-dsct.gif" width="104" height="19" border="0"></td>
	<td align="right"><img src="<%=des%>/grn-ttl-rght.gif" width="16" height="19" border="0"></td>
</tr>
</table>
<%----//заголовочек ДАВАЙТЕ ОБСУДИМ-----%>

<%---- ДАВАЙТЕ ОБСУДИМ -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:9px 0px 0px 0px;">
<%
    java.text.SimpleDateFormat forumSdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm");
    firstLoop = true;
    Enumeration themes = hp.getForumThemes();
    while(themes.hasMoreElements())
    {
        ForumItem theme = (ForumItem)themes.nextElement();
        if(firstLoop)
            firstLoop = false;
        else
        {
%>
<tr><td height="11" colspan="3" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%      } %>
<tr valign="top">
	<td rowspan="2"><a href="/pages/<%=langCode%>/forum?forum_id=<%=theme.getForumId()%>&theme_id=<%=theme.getId()%>"><img src="<%=des%>/ico-frm.gif" width="13" height="15" border="0" hspace="7"></a></td>
	<td width="100%" class="defFont" colspan="2"><a href="/pages/<%=langCode%>/forum?forum_id=<%=theme.getForumId()%>&theme_id=<%=theme.getId()%>" class="nonUa"><b class="bluTtl"><%=CMSApplication.toHTML(theme.getHeader())%></b></a></td>
</tr>
<tr valign="top">
	<td class="smallFont">
	<img src="<%=des%>/ans-all.gif" width="18" height="8" border="0" align="baseline">Сообщений: <%=theme.getAnswerAmount()%>
	</td>
	<td class="smallFont" nowrap>
	<img src="<%=des%>/ans-lst.gif" width="8" height="7" border="0" hspace="7" align="baseline">Посл. сообщ.: <%=theme.getLastMessageDate() ==  null ? "" : forumSdf.format(theme.getLastMessageDate())%>
	</td>
</tr>
<%  } %>
</table>
<%----//ДАВАЙТЕ ОБСУДИМ -----%>
<br>
<%----//ЦЕНТРАЛ 2-----%>
</td>
<td width="23%" bgcolor="#ffffff">

<%---- давайте обсудим -----%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#72D184" style="margin-top:14px;">
<tr valign="top">
<form action="/pages/<%=langCode%>/forum">
<td height="126" background="<%=des%>/frm-bg.gif" class="defFont">
<img src="<%=des%>/grn-crn-tl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-tr.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0">
<img src="<%=des%>/ttl-thms.gif" width="131" height="9" border="0" vspace="11"><br>
<div style="margin:0px 10px 10px 10px;" class="grn">
Выберите тему для обсуждения в форуме:
</div>
<div style="margin:10px 0px 10px 10px;width:100%;font-size:10px;font-family:Tahoma;">
<NOBR>
<select name="forum_id" style="width:157;font-size:10px;font-family:Tahoma;" width="160">
<%
    Enumeration forumEnum = hp.getForums();
    while(forumEnum.hasMoreElements())
    {
        Forum forum = (Forum)forumEnum.nextElement();
%>
<option value="<%=forum.getId()%>"><%=CMSApplication.toHTML(forum.getName())%></option>
<%  } %>
</select><input type="Image" src="<%=des%>/btn-arr-grn.gif" width="18" height="18" border="0" hspace="3" vspace="0" align="absmiddle"><br>
</NOBR>
</div>
</td>
</form>
</tr>
<tr><td><a href="/pages/<%=langCode%>/auth"><img src="<%=des%>/btn-regforum.gif" width="108" height="18" border="0" hspace="10"></a></td></tr>
<tr>
<td><img src="<%=des%>/grn-crn-bl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-br.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"></td>
</tr>
</table>
<%----//давайте обсудим -----%>

</td>
<td width="18%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%----//ROW main 2-----%>

<%---- ROW белая полоска с закругленным уголком -----%>
<tr>
<td width="21%" align="right" bgcolor="#ffffff"><div style="position:relative;top:-10;left:0;"><img src="<%=des%>/lft-tn-br.gif" width="10" height="10" border="0"></div></td>
<td width="38%" bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
<td width="23%" bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
<td align="right"><img src="<%=des%>/bt-r.gif" width="10" height="10" border="0"></td>
<td width="18%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%----//ROW белая полоска с закругленным уголком -----%>


<%----  ROW зеленая полоска снизу-----%>
<tr>
<td height="5" colspan="7"><SPACER TYPE="block" HEIGHT="5" WIDTH="1"></td>
</tr>
<%----// ROW зеленая полоска снизу-----%>



<%----  ROW footer -----%>
<tr>
	<td height="60" background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89" width="21%" valign="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" background="" style="margin-top:8px;" bgcolor="#477FBB">
		<tr>
		<td><div style="width:13;"><SPACER TYPE="block" HEIGHT="1" WIDTH="13"></div></td>
		<td width="100%"><img src="<%=des%>/btm-1-txt.gif" width="140" height="42" border="0"></td>
		<td><img src="<%=des%>/btm-1-r.gif" width="7" height="42" border="0"></td>
		</tr>
		</table>
	<!-- распорка левой колонки --><div style="width:184;"><SPACER TYPE="block" HEIGHT="1" WIDTH="184"></div>
	</td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89"><div style="width:8;"><SPACER TYPE="block" HEIGHT="1" WIDTH="8"></div></td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89" width="38%" align="center">
	<%---- НИЖНЯЯ НАВИГАЦИЯ -----%>	
	<div style="color:#ffffff;font-size:10px;font-family: Tahoma, Verdana, Arial, sans-serif;">Главная | <a href="/pages/<%=langCode%>/about" style="color:#ffffff;">О компании</a> | <a href="/pages/<%=langCode%>/tvschedule" style="color:#ffffff;">Телепрограмма</a> | <a href="/pages/<%=langCode%>/support" style="color:#ffffff;">Служба поддержки</a> | <a href="/pages/<%=langCode%>/forum" style="color:#ffffff;">Форум</a></div>
	<%----//НИЖНЯЯ НАВИГАЦИЯ  -----%>	
	<!-- распорка центральной колонки --><div style="width:372;"><SPACER TYPE="block" HEIGHT="1" WIDTH="372"></div>
	</td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89"><div style="width:8;"><SPACER TYPE="block" HEIGHT="1" WIDTH="8"></div></td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89" width="23%" valign="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" background="" style="margin-top:8px;" bgcolor="#477FBB">
		<tr>
		<td><img src="<%=des%>/btm-2-l.gif" width="7" height="42" border="0"></td>
		<td width="100%" align="center"><img src="<%=des%>/btm-2-txt.gif" width="180" height="42" border="0"></td>
		<td><img src="<%=des%>/btm-1-r.gif" width="7" height="42" border="0"></td>
		</tr>
		</table>
	<!--распорка правой колонки --><div style="width:195;"><SPACER TYPE="block" HEIGHT="1" WIDTH="195"></div>
	</td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89"><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89" width="18%"><div style="width:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td>
</tr>
<%----// ROW footer -----%>
</table>
</body>
</html>
<%




    }
    else
    {





%>
<html>
<head>
<title><%=CMSApplication.getSiteName()%></title>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
</head>
<style>
.defFont {
font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;
font-size: 70%;
}
.smallFont {
font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;
font-size: 65%;
}

.bluTtl{color:#032866;}
.nonUa{text-decoration:none;color:#000000;}
.w{color:#FFFFFF;}
.grn{color:#006513}

.bgTN1{background:#80AFE0 url(<%=des%>/l-bg-tn1.png) repeat-x 0 48;width:100%;}
.bgTN{background:url(<%=des%>/l-bg-tn.png) no-repeat right top}
.bgVt1{background:#80AFE0 url(<%=des%>/l-bg-tn1.png) repeat-x 0 10;width:100%;}
.bgVt{background:url(<%=des%>/l-vt-bg.png) no-repeat right top}

.bgPrg1{background:#72D184 url(<%=des%>/l-prg-bg1.gif) repeat-x;width:100%;}
.bgPrg{background:url(<%=des%>/l-prg-bg.png) no-repeat left top;height:126;}
.bgDsc{background: url(<%=des%>/l-dsc-bg.png) no-repeat left top;height:126;}
.bgBot TD{background:#0D3A89 url(<%=des%>/l-bg-bot.gif) repeat-x}
.bgClrBot TD{background:#477FBB}
.aBg TD{background:#004896 url(<%=des%>/l-blu-ttl-bg.gif) repeat-x}
.LBLn TD{border-left:#DFE6F0 solid 1;border-bottom:#DFE6F0 solid 1;}
.LLn{border-left:#DFE6F0 solid 1;}
#aBotTV{position:relative;top:1;left:-1;}
.BLn{border-bottom:#DFE6F0 solid 1;padding:0 0 5 0;width:50%}
.BLn div{margin-top:5;line-height:130%;}
.hm{background:#FFFFFF url(<%=des%>/hm-bg.gif) no-repeat;font-family: Verdana;padding:3 6 1 6;font-size:9px;height:18;text-align:center;}
</style>


<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" bgcolor="#1DAF38" background="<%=des%>/bg-grn-ln.gif" style="background:#1DAF38 url(<%=des%>/bg-grn-ln.gif) repeat-y;">
<table width=100% cellpadding="0" cellspacing="0" border="0" height="100%">

<%-- RED -----%>
<tr>
	<td colspan="7" height="7" bgcolor="#FF1515"><img src="<%=des%>/t-red.jpg" width="770" height="7" alt="" border="0"></td>
</tr>
<%----//RED -----%>

<%----  ROW header -----%>
<tr>
	<td colspan="7" height="53" bgcolor="#D1E8FA" valign="top">
		<table cellpadding="0" cellspacing="0" border="0" width="1">
		<tr>
		<td><img src="<%=des%>/logo-ntv.gif" width="88" height="52" alt="" border="0"></td>
		<td bgcolor="#4991D3"><img src="<%=des%>/t-1.gif" width="158" height="52" alt="" border="0"></td>
		<td bgcolor="#0F3E8C"><img src="<%=des%>/t-2.gif" width="271" height="52" alt="" border="0"></td>
		<td bgcolor="#2E516F"><img src="<%=des%>/t-3.gif" width="90" height="52" alt="" border="0"></td>
		<td><img src="<%=des%>/t-4.jpg" width="165" height="52" alt="" border="0"></td>
		</tr>
		</table>
	</td>
</tr>
<%----// ROW  header -----%>


<%---- ROW  nava -----%>
<tr>
	<td colspan=7><a href="/"><img src="<%=des%>/<%=siteUrl.equals(americaUrl) ? "logo-mir-america.gif" : "logo-mir.gif"%>" width="96" height="23" border="0"></a><a href="/pages/<%=langCode%>/about"><img src="<%=des%>/n-abt.gif" width="92" height="23" border="0"></a><img src="<%=des%>/n-sprtr.gif" width="6" height="23"><a href="/pages/<%=langCode%>/tvschedule"><img src="<%=des%>/n-tvprg.gif" width="112" height="23" border="0"></a><img src="<%=des%>/n-sprtr.gif" width="6" height="23" border="0"><a href="/pages/<%=langCode%>/support"><img src="<%=des%>/n-sprt.gif" width="138" height="23" border="0"></a><img src="<%=des%>/n-sprtr.gif" width="6" height="23" border="0"><a href="/pages/<%=langCode%>/forum"><img src="<%=des%>/n-frm.gif" width="60" height="23" border="0"></a><img src="<%=des%>/n-r.gif" width="250" height="23"></td>
</tr>
<%----// ROW nava -----%>


<%---- ROW  белая полоска с закругленным уголком -----%>
<tr>
	<td width=21% bgcolor=#ffffff><SPACER WIDTH=1></td>
	<td bgcolor=#ffffff rowspan=6><SPACER WIDTH=1></td>
	<td width=38% bgcolor=#ffffff><SPACER WIDTH=1></td>
	<td bgcolor=#ffffff rowspan=6><SPACER WIDTH=1></td>
	<td width=23% bgcolor=#ffffff><SPACER WIDTH=1></td>
	<td align=right><img src="<%=des%>/tp-r.gif" width="10" height="9"></td>
	<td width=18%><SPACER WIDTH=1></td>
</tr>
<%----// ROW белая полоска с закругленным уголком -----%>


<%---- ROW топ новость и анонсы -----%>
<tr valign=top>
<td bgcolor="#<%=news != null ? "80AFE0" : "ffffff"%>" width=21%>

<%---- топ новость -----%>
<table border=0 cellpadding=0 cellspacing=0 class="bgTN1">

<tr bgcolor="#ffffff">
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/lng-bg.gif">
<tr align="right">
<%
    if(siteUrl.equals(americaUrl))
    {
%>
    <td width="100%"><a href="<%=europeUrl%>"><img src="<%=des%>/lng-eur-rus.gif" width="62" height="19" alt="Europe" border="0"></a><a href="<%=americaUrl%>"><img src="<%=des%>/lng-usa-cur-rus.gif" width="37" height="19" alt="USA" border="0" hspace="8"></a></td>
<%
    }
    else
    {
%>
	<td width="100%"><a href="<%=americaUrl%>"><img src="<%=des%>/lng-usa-rus.gif" width="37" height="19" alt="USA" border="0"></a><a href="<%=europeUrl%>"><img src="<%=des%>/lng-eur-cur-rus.gif" width="62" height="19" alt="Europe" border="0" hspace="8"></a></td>
<%  } %>
	<td><img src="<%=des%>/lng-r.gif" width="8" height="19" alt="" border="0"></td>
</tr>
</table>
</td>
</tr>

<tr bgcolor=#ffffff>
<form action="/pages/<%=langCode%>/search">
<td style="padding:7 5 9 10;">
	<table width=100% border=0 cellpadding=0 cellspacing=0>
	<tr valign=bottom>
		<td width=100%><NOBR><a href="/pages/<%=langCode%>/search"><img src="<%=des%>/srch.gif" width="67" height="9" border="0"></a><img src="<%=des%>/dvder.gif" width="9" height="9"><a href="/pages/<%=langCode%>/map"><img src="<%=des%>/sitemap.gif" width="51" height="9" border="0"></a><br></NOBR></td>
		<td></td>
	</tr>
	<tr>
		<td width=100%><input type="text" name="f_query" style="width:100%;font-size:10;font-family:Tahoma;margin:4 0 0 0" size="15"></td>
		<td><input type="Image" src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" style="margin:4 0 0 0"></td>
	</tr>
	</table>
</td>
</form>
</tr>
<tr valign=top>
<% if(news != null){ %>
<td class="bgTN"><img src="<%=des%>/ttl-top-news.gif" width="74" height="7" border="0" hspace="10" vspace="11"><br>
<div style="margin:0 30 10 10;line-height:130%" class=defFont>
<SPAN class="w"><%=sdf.format(news.getRecordDate())%></SPAN><br>
<b class="bluTtl"><%=CMSApplication.toHTML(news.getCaption())%></b><br>
<a href="<%=nodePath(news.getWebPageId())%>?press_id=<%=news.getId()%>" class="nonUa"><%=CMSApplication.removeTags(news.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"></a><br>
</div>
</td>
<%  } else { %>
<td>
<%  
        if(hp != null && hp.isBannerShow(1))
            printBanner(hp, 1, des, out, false);
        else if(hp != null && hp.isBannerShow(2))
            printBanner(hp, 2, des, out, false);
%>
</td>
<%  } %>
</tr>
</table>
<%----//топ новость -----%>

</td>
<td width="61%" colspan="3" bgcolor=#ffffff height="1">

<%---- АНОНСЫ -----%>
<table width=100% border=0 cellpadding=0 cellspacing=0 height="100%">
<tr class="aBg">
<td nowrap colspan="2"><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19"><img src="<%=des%>/blu-ttl-anons.gif" width="46" height="19"></td>
<td colspan="3" align=right><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19"></td>
</tr>
<tr><td height="9" colspan="5"></td></tr>
<tr valign=top class=defFont>
<td class="LLn"><%  if(announce1 != null){ %><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce1.getId()%>"><img src="<%=announce1.getImg()%>" width="77" height="58" border="0" hspace=3 style="margin:0 8 0 3"></a><% } %></td>
<td class="BLn" rowspan=2>
<%  if(announce1 != null){ %>
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce1.getId()%>" class="nonUa">
<SPAN class="grn"><%=sdf.format(announce1.getTvDate(langCode))%></SPAN>
<div>
<b class="bluTtl"><%=CMSApplication.toHTML(announce1.getName())%></b><br>
<%=CMSApplication.toHTML(announce1.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
<%  } %>
</td>
<td rowspan=2><div style="width:7;"><SPACER WIDTH="7"></div></td>
<td class="LLn"><%  if(announce2 != null){ %><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce2.getId()%>"><img src="<%=announce2.getImg()%>" width="77" height="58" border="0" hspace=3 style="margin:0 8 0 3"></a><% } %></td>
<td class="BLn" rowspan=2>
<%  if(announce2 != null){ %>
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce2.getId()%>" class="nonUa">
<SPAN class="grn"><%=sdf.format(announce2.getTvDate(langCode))%></SPAN>
<div>
<b class="bluTtl"><%=CMSApplication.toHTML(announce2.getName())%></b><br>
<%=CMSApplication.toHTML(announce2.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
<%  } %>
</td>
</tr>
<tr valign=top class="LBLn">
<td valign=bottom><% if(announce1 != null){ %><DIV id=aBotTV><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce1.getId()%>"><img src="<%=des%>/x.gif" width="66" height="28" border="0"></a></DIV><% } %></td>
<td valign=bottom><% if(announce2 != null){ %><DIV id=aBotTV><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce2.getId()%>"><img src="<%=des%>/x.gif" width="66" height="28" border="0"></a></DIV><% } %></td>
</tr>
<tr><td height="3" colspan="5"></td></tr>
<tr valign=top class=defFont>
<td class="LLn"><%  if(announce3 != null){ %><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce3.getId()%>"><img src="<%=announce3.getImg()%>" width="77" height="58" border="0" hspace=3 style="margin:5 8 0 3"></a><% } %></td>
<td class="BLn" rowspan=2>
<%  if(announce3 != null){ %>
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce3.getId()%>" class="nonUa">
<SPAN class="grn"><%=sdf.format(announce3.getTvDate(langCode))%></SPAN>
<div>
<b class="bluTtl"><%=CMSApplication.toHTML(announce3.getName())%></b><br>
<%=CMSApplication.toHTML(announce3.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
<%  } %>
</td>
<td rowspan=2><div style="width:7;"><SPACER WIDTH="7"></div></td>
<td class="LLn"><%  if(announce4 != null){ %><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce4.getId()%>"><img src="<%=announce4.getImg()%>" width="77" height="58" border="0" hspace=3 style="margin:5 8 0 3"></a><% } %></td>
<td class="BLn" rowspan=2>
<%  if(announce4 != null){ %>
<a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce4.getId()%>" class="nonUa">
<SPAN class="grn"><%=sdf.format(announce4.getTvDate(langCode))%></SPAN>
<div>
<b class="bluTtl"><%=CMSApplication.toHTML(announce4.getName())%></b><br>
<%=CMSApplication.toHTML(announce4.getBrief())%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"><br>
</div>
</a>
<%  } %>
</td>
</tr>
<tr valign=top class="LBLn">
<td valign=bottom><% if(announce3 != null){ %><DIV id=aBotTV><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce3.getId()%>"><img src="<%=des%>/x.gif" width="66" height="28" border="0"></a></DIV><% } %></td>
<td valign=bottom><% if(announce4 != null){ %><DIV id=aBotTV><a href="/pages/<%=langCode%>/tvschedule/announce?announce_id=<%=announce4.getId()%>"><img src="<%=des%>/x.gif" width="66" height="28" border="0"></a></DIV><% } %></td>
</tr>
</table>
<%----//АНОНСЫ  -----%>


</td>
<td bgcolor=#ffffff rowspan=4><SPACER WIDTH="1"></td>
<td width=18%><SPACER WIDTH=1></td>
</tr>
<%----//ROW топ новость и анонсы -----%>



<%----  ROW отступ между блоками-----%>
<tr>
<td width=21% align=right bgcolor=#ffffff><%if(news != null){ %><div style="position:relative;top:-10;left:0;"><img src="<%=des%>/lft-tn-br.gif" width="10" height="10"></div><% } %></td>
<td width=38% bgcolor=#ffffff><SPACER WIDTH=1></td>
<td width=23% bgcolor=#ffffff><SPACER WIDTH=1></td>
<td width=18%></td>
</tr>
<%----// ROW отступ между блоками-----%>



<%---- ROW main -----%>
<tr valign=top>
<td width=21% bgcolor=#80AFE0 rowspan=2 height="100%">
<%  if(news != null){ %>
<%---- БАННЕР -----%>
<%
    if(news != null){
        boolean showSpacer = false;
        if(hp != null && hp.isBannerShow(1))
        {
            printBanner(hp, 1, des, out, false);
            showSpacer = true;
        }
        if(hp != null && hp.isBannerShow(2))
            printBanner(hp, 2, des, out, showSpacer);
    }
    else
    {
        if(hp != null && hp.isBannerShow(1) && hp.isBannerShow(2))
            printBanner(hp, 2, des, out, false);
    }
%>
<%----//БАННЕР -----%>
<%  } %>
<%---- ОПРОС -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#80AFE0">
<tr bgcolor="#ffffff">
<td height="10"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%@ include file="/vote/vote.jsp"%>
</table>
<%----//ОПРОС -----%>

</td>
<td width=38% bgcolor=#ffffff>
<%---- ЦЕНТРАЛ -----%>

<%---- заголовочек сейчас в эфире-----%>
<table width=100% border=0 cellpadding=0 cellspacing=0 background="<%=des%>/l-grn-ttl-bg.gif" bgcolor="#1DAE38">
<tr>
	<td nowrap><img src="<%=des%>/grn-ttl-lft.gif" width="16" height="19"><img src="<%=des%>/grn-ttl-efir.gif" width="94" height="19"></td>
	<td align=right><img src="<%=des%>/grn-ttl-rght.gif" width="16" height="19"></td>
</tr>
</table>
<%----//заголовочек сейчас в эфире-----%>

<%---- сейчас в эфире -----%>
<table width=100% border="0" cellpadding="2" cellspacing="0" style="margin:9 0 14 0;">
<%
    boolean firstLoop = true;
    while(scheduleItems.hasMoreElements())
    {
        Tvschedule item = (Tvschedule)scheduleItems.nextElement();
        if(firstLoop)
            firstLoop = false;
        else
        {
%>
<tr><td height=6 colspan=2 background="<%=des%>/greyln.gif"></td></tr>
<%      } %>
<tr valign=top>
	<td class="hm">
	<a href="/pages/<%=langCode%>/tvschedule" class="nonUa"><b class="bluTtl"><%=item.getTime(gmtShift)%></b></a>
	</td>
	<td width=100% class=defFont><a href="/pages/<%=langCode%>/tvschedule" class="nonUa"><b class="bluTtl"><%=CMSApplication.toHTML(item.getName())%></b></a> <%=CMSApplication.toHTML(item.getDescription())%></td>
</tr>
<%  } %>
</table>
<%----//сейчас в эфире -----%>

<%----//ЦЕНТРАЛ -----%>
</td>
<td width=23% bgcolor=#ffffff>

<%---- программа на неделю -----%>
<table border=0 cellpadding=0 cellspacing=0 class="bgPrg1">
<tr valign=top class="grn">
<form action="">
<td class="bgPrg">
<img src="<%=des%>/grn-crn-tr.gif" width="11" height="11" border="0" align=right hspace=0 vspace=0>
<img src="<%=des%>/ttl-prog.gif" width="130" height="9" border="0" vspace="11" hspace="10"><br>
<div style="margin:0 10 10 10;" class=defFont>
Выберите часовой пояс для просмотра прграммы:
</div>
<div style="margin:10 0 10 10;width:100%;font-size:10;font-family:Tahoma;">
<NOBR>
<select name="" style="width:157;font-size:10;font-family:Tahoma;" width="160">
<%
    while(showPlaces.hasMoreElements())
    {
        ShowPlace sp = (ShowPlace)showPlaces.nextElement();
%>
<option VALUE="<%=sp.getId()%>"><%=sp.getTimeZone().getName()%> <%=CMSApplication.toHTML(sp.getName())%></option>
<%  } %>
</select><input type="Image" src="<%=des%>/btn-arr-grn.gif" width="18" height="18" border="0" hspace=3 vspace=0 align=absmiddle><br>
</NOBR>
</div>
</td>
</form>
</tr>
<tr>
<td><a href="/pages/<%=langCode%>/auth"><img src="<%=des%>/btn-subs.gif" width="145" height="18" border="0" hspace="10"></a><br><img src="<%=des%>/grn-crn-bl.gif" width="11" height="11" border="0" align="left" hspace=0 vspace=0><img src="<%=des%>/grn-crn-br.gif" width="11" height="11" border="0" align=right hspace=0 vspace=0></td>
</tr>
</table>
<%----//программа на неделю -----%>

</td>
<td width=18%><SPACER WIDTH=1></td>
</tr>
<%----//ROW main -----%>





<%---- ROW main2 -----%>
<tr valign=top>
<td width=38% bgcolor=#ffffff>
<%---- ЦЕНТРАЛ 2-----%>

<%---- заголовочек ДАВАЙТЕ ОБСУДИМ-----%>
<table width=100% border=0 cellpadding=0 cellspacing=0 background="<%=des%>/grn-ttl-bg.gif" bgcolor="#1DAE38">
<tr>
	<td nowrap><img src="<%=des%>/grn-ttl-lft.gif" width="16" height="19"><img src="<%=des%>/grn-ttl-dsct.gif" width="104" height="19"></td>
	<td align=right><img src="<%=des%>/grn-ttl-rght.gif" width="16" height="19"></td>
</tr>
</table>
<%----//заголовочек ДАВАЙТЕ ОБСУДИМ-----%>

<%---- ДАВАЙТЕ ОБСУДИМ -----%>

<table width=100% border=0 cellpadding=0 cellspacing=0 style="margin:9 0 0 0;">
<%
    java.text.SimpleDateFormat forumSdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm");
    firstLoop = true;
    Enumeration themes = hp.getForumThemes();
    while(themes.hasMoreElements())
    {
        ForumItem theme = (ForumItem)themes.nextElement();
        if(firstLoop)
            firstLoop = false;
        else
        {
%>
<tr><td height="11" colspan="3" background="<%=des%>/greyln2.gif"></td></tr>
<%      } %>
<tr valign=top>
	<td rowspan=2><a href="/pages/<%=langCode%>/forum?forum_id=<%=theme.getForumId()%>&theme_id=<%=theme.getId()%>"><img src="<%=des%>/ico-frm.gif" width="13" height="15" border="0" hspace=7></a></td>
	<td width=100% class=defFont  colspan=2><a href="/pages/<%=langCode%>/forum?forum_id=<%=theme.getForumId()%>&theme_id=<%=theme.getId()%>" class="nonUa"><b class="bluTtl"><%=CMSApplication.toHTML(theme.getHeader())%></b></a></td>
</tr>
<tr valign=top>
	<td class=smallFont>
	<img src="<%=des%>/ans-all.gif" width="18" height="8" align=baseline>Сообщений: <%=theme.getAnswerAmount()%>
	</td>
	<td class=smallFont nowrap>
	<img src="<%=des%>/ans-lst.gif" width="8" height="7" hspace=7 align=baseline>Посл. сообщ.: <%=theme.getLastMessageDate() ==  null ? "" : forumSdf.format(theme.getLastMessageDate())%>
	</td>
</tr>
<%  } %>
</table>
<%----//ДАВАЙТЕ ОБСУДИМ -----%>
<br>
<%----//ЦЕНТРАЛ 2-----%>
</td>
<td width=23% bgcolor=#ffffff>

<%---- давайте обсудим -----%>
<table border=0 cellpadding=0 cellspacing=0 class="bgPrg1">
<tr valign=top class="grn">
<form action="/pages/<%=langCode%>/forum">
<td height="126" class="bgDsc"><img src="<%=des%>/grn-crn-tr.gif" width="11" height="11" border="0" align=right hspace=0 vspace=0>
<img src="<%=des%>/ttl-thms.gif" width="131" height="9" border="0" vspace="11" hspace="10"><br>
<div style="margin:0 10 10 10;" class=defFont>
Выберите тему для обсуждения в форуме:
</div>
<div style="margin:10 0 10 10;width:100%;font-size:10;font-family:Tahoma;">
<NOBR>
<select name="forum_id" style="width:157;font-size:10;font-family:Tahoma;" width="160">
<%
    Enumeration forumEnum = hp.getForums();
    while(forumEnum.hasMoreElements())
    {
        Forum forum = (Forum)forumEnum.nextElement();
%>
<option value="<%=forum.getId()%>"><%=CMSApplication.toHTML(forum.getName())%></option>
<%  } %>
</select><input type="Image" src="<%=des%>/btn-arr-grn.gif" width="18" height="18" border="0" hspace=3 vspace=0 align=absmiddle><br>
</NOBR>
</div>
</td>
</form>
</tr>
<tr>
<td><a href="/pages/<%=langCode%>/auth"><img src="<%=des%>/btn-regforum.gif" width="108" height="18" border="0" hspace="10"></a><br><img src="<%=des%>/grn-crn-bl.gif" width="11" height="11" border="0" align="left" hspace=0 vspace=0><img src="<%=des%>/grn-crn-br.gif" width="11" height="11" border="0" align=right hspace=0 vspace=0></td>
</tr>
</table>
<%----//давайте обсудим -----%>

</td>
<td width=18%><SPACER WIDTH=1></td>
</tr>
<%----//ROW main 2-----%>

<%---- ROW белая полоска с закругленным уголком -----%>
<tr>
<td width=21% align=right bgcolor=#ffffff><div style="position:relative;top:-10;left:0;"><img src="<%=des%>/lft-tn-br.gif" width="10" height="10"></div></td>
<td width=38% bgcolor=#ffffff><SPACER WIDTH=1></td>
<td width=23% bgcolor=#ffffff><SPACER WIDTH=1></td>
<td align=right><img src="<%=des%>/bt-r.gif" width="10" height="10"></td>
<td width=18%><SPACER WIDTH=1></td>
</tr>
<%----//ROW белая полоска с закругленным уголком -----%>


<%----  ROW зеленая полоска снизу-----%>
<tr>
<td height="5" colspan=7><SPACER WIDTH=1></td>
</tr>
<%----// ROW зеленая полоска снизу-----%>



<%----  ROW footer -----%>
<tr class="bgBot">
	<td height="60" width=21% valign=top>
		<table border=0 cellpadding=0 cellspacing=0 width=100% style="margin-top:8;" class="bgClrBot">
		<tr>
		<td width=100% style="padding:0 0 0 13;"><img src="<%=des%>/btm-1-txt.gif" width="140" height="42"></td>
		<td><img src="<%=des%>/btm-1-r.gif" width="7" height="42"></td>
		</tr>
		</table>
	<!-- распорка левой колонки --><div style="width:184;"><SPACER WIDTH="184"></div>
	</td>
	<td><div style="width:8;"><SPACER WIDTH="8"></div></td>
	<td width=38% align=center>
	<%---- НИЖНЯЯ НАВИГАЦИЯ -----%>	
	<div style="color:#ffffff;font-size:10;font-family: Tahoma, Verdana, Arial, sans-serif;">Главная | <a href="/pages/<%=langCode%>/about" style="color:#ffffff;">О компании</a> | <a href="/pages/<%=langCode%>/tvschedule" style="color:#ffffff;">Телепрограмма</a> | <a href="/pages/<%=langCode%>/support" style="color:#ffffff;">Служба поддержки</a> | <a href="/pages/<%=langCode%>/forum" style="color:#ffffff;">Форум</a></div>
	<%----//НИЖНЯЯ НАВИГАЦИЯ  -----%>	
	<!-- распорка центральной колонки --><div style="width:372;"><SPACER WIDTH="372"></div>
	</td>
	<td><div style="width:8;"><SPACER WIDTH="8"></div></td>
	<td width=23% valign=top>
		<table border=0 cellpadding=0 cellspacing=0 width=100% style="margin-top:8;" class="bgClrBot">
		<tr>
		<td><img src="<%=des%>/btm-2-l.gif" width="7" height="42"></td>
		<td width=100% align=center><img src="<%=des%>/btm-2-txt.gif" width="180" height="42"></td>
		<td><img src="<%=des%>/btm-1-r.gif" width="7" height="42"></td>
		</tr>
		</table>
	<!--распорка правой колонки --><div style="width:195;"><SPACER WIDTH="195"></div>
	</td>
	<td><div style="width:10;"><SPACER WIDTH="10"></div></td>
	<td width=18%><div style="width:1;"><SPACER WIDTH=1></div></td>
</tr>
<%----// ROW footer -----%>
</table>
</body>
</html>
<%  } %>
<%
}catch(Exception e)
{
    e.printStackTrace(System.err);
}
%>