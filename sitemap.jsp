<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.forum.*"%>
<%@ include file="/inc/init_global.jsp"%>

<%  response.setHeader("Pragma","no-cache"); %>
<%!
	public void printTree(WebTreeNode node, int level, int idx, JspWriter out) throws IOException
	{
		if(!node.isVisible())
			return;
		if(node.getPageType().getCode().equals("auth") && node.getParent().getCode().equals("root"))
			return;

		if(level > 1)
		    out.println("<div style=\"margin: " +
		        (idx == 0 && level == 2 ? "-5" : "6" )+ 
		        "px 0px 0px " + (16*(level-1)) + "px;\" class=\"smallFont\">" + 
		        (level > 2 ? "-&nbsp;" : "") + "<a href=\"" + nodePath(node) +"\">" + CMSApplication.toHTML(node.getName()) +"</a></div>");


		Enumeration enum = node.getChilds();
		int i = 0;
		while(enum.hasMoreElements())
		{
			WebTreeNode child = (WebTreeNode)enum.nextElement();
			printTree(child, level+1, i++, out);
		}
	}
%>


<%!
    private static final String [] TVS_MONTHS = new String[] {
        "Января", "Февраля", "Марта", "Апреля", "Мая", "Июня",
        "Июля", "Авгуса", "Сентября", "Октября", "Ноября", "Декабря"
    };
    private static final String [] TVS_DAYS = new String[] {
        "--", "Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"
    };
    public String TVS_toString(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return  "" + cal.get(Calendar.DATE) + " " + TVS_MONTHS[cal.get(Calendar.MONTH)] + 
                    ", <b>" + TVS_DAYS[cal.get(Calendar.DAY_OF_WEEK)] + "</b>";
    }
%>
<%  try{ %>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign="top" class="XsmallFont">

</td>
<!--заголовок страницы--><td align="right"><img src="<%=des%>/sitemap/ttl.gif" height="47" alt="Карта сайта" border="0"></td>
</tr>
</table>

<!---- заголовочек ----->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/sitemap/ttl-stmp.gif" width="68" height="19" alt="Карта сайта" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<!----//заголовочек ----->
<%  }catch(Exception e){} %>
<!---- ГЛАВНАЯ ----->
<%  try{%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:3px;">
<tr>
	<td width="49%"><a href="/pages/<%=langCode%>/about"><img src="<%=des%>/sitemap/company.gif" width="79" height="26" alt="О компании" border="0"></a></td>
	<td width="2%"><div style="width:7px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="11"></div></td>
	<td width="49%"><a href="/pages/<%=langCode%>/tvschedule"><img src="<%=des%>/sitemap/tvprogram.gif" width="100" height="26" alt="Телепрограмма" border="0"></a></td>
</tr>
<tr>
	<td valign="top" bgcolor="#72D184">
<!---- компания ----->
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#72D184">
<tr valign="top">
<td height="126" style="background:#72D184 url(<%=des%>/cmpny-bg.gif) repeat-x;" class="stmp">
<img src="<%=des%>/grn-crn-tl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-tr.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"><br>
<%
    WebTreeNode tmpNode = CMSApplication.getApplication().getSectionNode(langCode, "about");
    printTree(tmpNode, 1, 0, out);
%>
  <div style="margin:6px 0px 0px 16px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div>	
</td>
</tr>
</table>
<!----//компания ----->
	</td>
	<td></td>
	<td valign="top" bgcolor="#72D184">
<!---- телепрограмма ----->
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#72D184">
<tr valign="top">
<td height="126" class="stmp" style="background:#72D184 url(<%=des%>/prog-bg.gif) repeat-x;">
<img src="<%=des%>/grn-crn-tl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-tr.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"><br>

<%
{
    Date    date    = new Date();
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");

    try{
        date = sdf.parse(sdf.format(date));
    } catch(Exception e) {}
    
    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    int nnn = 1;
    switch(cal.get(Calendar.DAY_OF_WEEK))
    {
        case Calendar.MONDAY:       nnn = 1; break;        case Calendar.TUESDAY:      nnn = 2; break;        case Calendar.WEDNESDAY:    nnn = 3; break;
        case Calendar.THURSDAY:     nnn = 4; break;        case Calendar.FRIDAY:       nnn = 5; break;        case Calendar.SATURDAY:     nnn = 6; break;
        case Calendar.SUNDAY:       nnn = 7; break;
    }
    cal.add(Calendar.DATE, -nnn);
    
    for(int i = 0; i < 7; i++)
    {
        cal.add(Calendar.DATE, 1);
%>
<div style="margin: <%=i == 0 ? -5 : 6%>px 0px 0px 16px;" class="smallFont"><a href="/pages/<%=langCode%>/tvschedule?date=<%=sdf.format(cal.getTime())%>"><%=TVS_toString(cal.getTime())%></a></div>
<%
    }
}
%>

    <div style="margin:6px 0px 0px 16px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div>	
</td>
</tr>
</table>
<!----//телепрограмма ----->	
	</td>
</tr>

<tr>
<td bgcolor="#72D184"><img src="<%=des%>/grn-crn-bl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-br.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"></td>
<td><div style="width:7px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="11"></div></td>
<td bgcolor="#72D184"><img src="<%=des%>/grn-crn-bl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-br.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"></td>
</tr>

<tr>
	<td><img src="<%=des%>/sitemap/support.gif" width="121" height="23" alt="Служба поддержки" border="0"></td>
	<td></td>
	<td><a href="/pages/<%=langCode%>/forum"><img src="<%=des%>/sitemap/forum.gif" width="100" height="23" alt="Форум" border="0"></a></td>
</tr>
<tr>
	<td valign="top" bgcolor="#72D184">
<!---- поддержка ----->
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#72D184">
<tr valign="top">
<td height="126" class="stmp" style="background:#72D184 url(<%=des%>/sprt-bg.gif) repeat-x;">
<img src="<%=des%>/grn-crn-tl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-tr.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"><br>
<%
    tmpNode = CMSApplication.getApplication().getSectionNode(langCode, "support");
    printTree(tmpNode, 1, 0, out);
%>
		<div style="margin:6px 0px 0px 16px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div>
</td>
</tr>
</table>
<!----//поддержка ----->	
	</td>
	<td></td>
	<td valign="top" bgcolor="#72D184">
<!---- форум ----->
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#72D184">
<tr valign="top">
<td height="126" class="stmp" style="background:#72D184 url(<%=des%>/frm-bg.gif) repeat-x;">
<img src="<%=des%>/grn-crn-tl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-tr.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"><br>

		<div style="margin:-5px 0px 0px 16px;" class="smallFont"><a href="/pages/<%=langCode%>/auth">Регистрация в форуме</a></div>
		<div style="margin:6px 0px 0px 16px;" class="smallFont"><a href="/pages/<%=langCode%>/forum/list">Список пользователей</a></div>
<%
    Enumeration enum = Forum.getForumList(langCode).elements();
    while(enum.hasMoreElements())
    {
        Forum frm = (Forum)enum.nextElement();
%>
		<div style="margin:6px 0px 0px 16px;" class="smallFont"><a href="/pages/<%=langCode%>/forum?forum_id=<%=frm.getId()%>"><%=CMSApplication.toHTML(frm.getName())%></a></div>
<%  } %>
		<div style="margin:6px 0px 0px 16px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div>
</td>
</tr>
</table>
<!----//форум ----->	
	</td>
</tr>

<tr>
<td bgcolor="#72D184"><img src="<%=des%>/grn-crn-bl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-br.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"></td>
<td><div style="width:7px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="11"></div></td>
<td bgcolor="#72D184"><img src="<%=des%>/grn-crn-bl.gif" width="11" height="11" border="0" align="left" hspace="0" vspace="0"><img src="<%=des%>/grn-crn-br.gif" width="11" height="11" border="0" align="right" hspace="0" vspace="0"></td>
</tr>
</table>
<%  }catch(Exception e){} %>
