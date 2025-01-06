<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.press.*"%>
<%@ include file="/inc/page_init.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%

String [] pressIds = request .getParameterValues("press_id");
if(pressIds != null && pressIds.length == 0)
	pressIds = null;
%>




<%@ include file="/inc/path_init.jsp"%>


<%
try{

String pressName = "";
// show selected presses
if(pressIds != null || previewInfo != null)
{
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	Enumeration enum;
	if(previewInfo == null)
	{
		Vector v = new Vector();
		enum = Press.getPress(pressIds, new Release());
		while(enum.hasMoreElements())
		    v.add(enum.nextElement());
		enum = v.elements();
		if(v.size() > 0)
		    pressName = ((Press)v.firstElement()).getCaption();
    }
	else
	{
		Vector v = new Vector();
		v.add(previewInfo.get("article"));
		enum = v.elements();
		if(v.size() > 0)
		    pressName = ((Press)v.firstElement()).getCaption();
	}
%>



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
%>  
<a href="/page.jsp?id=<%=treeNode.getId()%>"><%=CMSApplication.toHTML(treeNode.getName())%></a> /
<%
        }
%>
<%=CMSApplication.toHTML(pressName)%>
</div>
<%  } %>
</td>
<!--заголовок страницы--><td align="right"><img src="<%=des%>/<%=sectionImg%>/ttl.gif" height="47" alt="<%=sectionName%>" border="0"></td>
</tr>
</table>


<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
<tr>
	<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/company/ttl-press.gif" height="19" alt="Пресса об НТВ МИР" border="0"></td>
	<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
</tr>
</table>



<table width="100%" border="0" cellpadding="3" cellspacing="0" style="margin-top:8px;">
<%
	while(enum.hasMoreElements())
	{
		Release news = (Release)enum.nextElement();
%>
<!---- 1 ----->
<tr>
<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
<td colspan="3">
<b class="bluTtl"><%= CMSApplication.toHTML(news.getCaption())%></b>
</td>
</tr>

<tr valign="top">
<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
<td class="defFont"><span class="grnTtl"><%=sdf.format(news.getRecordDate())%></span></td>
<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
<td width="100%" class="defFont">
<div style="margin-top:8px;">
<%=news.getContent()%>
</div>
</td>
</tr>
<!----//1 ----->

<!-- divider --><tr><td height="11" colspan="4" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%
	}
%>
<!---- 5 ----->
<tr valign="top">
	<td></td>
	<td></td>
	<td></td>
	<td width="100%"><a href="/page.jsp?id=<%=pageId%>"><img src="<%=des%>/press/btn-prs-lst.gif" height="18" alt="Вернуться к списку релизов" border="0"></a><br></td>
</tr>
<!----//5 ----->
</table>
<%
}


////////////////////////////////////////////////////////////////////////////////////////////////////////




// show press list
else
{
	
	int month = -1;
	int year = -1;
	try{
		month = Integer.parseInt(request.getParameter("month"));
		year = Integer.parseInt(request.getParameter("year"));
	}catch(Exception e){}
	Calendar cal = Calendar.getInstance();
	Date startDate = null;
	Date finishDate = null;
	boolean inArc = false;
	
	boolean showAll = "all".equals(request.getParameter("year"));
	
	if(month >= 0 && year >= 0)
	{
		inArc = true;
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		startDate = cal.getTime();
		cal.add(Calendar.MONTH, 1);
		finishDate = cal.getTime();
		cal.setTime(startDate);
	}
	else
	{
		showAll = true;
	}
	
	if(startDate == null && finishDate == null)
	{
		cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, 1);
		startDate = cal.getTime();
		month = cal.get(Calendar.MONTH);
		year = cal.get(Calendar.YEAR);
		cal.add(Calendar.MONTH, 1);
		finishDate = cal.getTime();
	}
	cal = Calendar.getInstance();
	
	
	
	int pageNumber = 1;
	try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}
	
	int pageSize = Release.getPagePressAmount();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	
	if(showAll)
	{
		startDate = null;
		finishDate = null;
	}
	
	int num = Press.getPressNum(startDate, finishDate, new Release(DBObject.LOAD_EXTENDED_LIST), pageId, true);
	Enumeration enum;
	if(num > 0 || inArc)
	{
		enum = Press.getPress(startDate, finishDate, pageNumber, pageSize, new Release(DBObject.LOAD_EXTENDED_LIST), pageId, true);
	}
	else
	{
		enum = Press.getPress(3, new Release(DBObject.LOAD_EXTENDED_LIST), pageId, true);
		num = 3;
	}
%>



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
<a href="/page.jsp?id=<%=treeNode.getId()%>"><%=CMSApplication.toHTML(treeNode.getName())%></a> /
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


<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
<tr>
	<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/company/ttl-press.gif" height="19" alt="Пресса об НТВ МИР" border="0"></td>
	<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
</tr>
</table>




<table border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
<tr>
<form action="/page.jsp" method="get" name="arc_form">
<input type="hidden" name="id" value="<%=pageId%>">
<td width="100%">&nbsp;</td>
<td class="defFont"><a hreF="<%=nodePath(pageId)%>?&year=all">Все</a></td>
<td><img src="<%=des%>/dvder.gif" width="9" height="9" border="0" vspace="4"></td>
<td class="defFont"><SPAN class="bluTtl">Архив:</SPAN>&nbsp;</td>
<td class="SELnn">
<nobr><select name="month" style="width:77;font-size:10px;font-family:Tahoma;" width="80">
<%!
	public static final String [] MONTH_RUS = new String[]{
		"Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", 
		"Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"};
%>
<%
		for(int i = 0; i < MONTH_RUS.length; i++)
		{
%>
	<option value="<%=i%>"<%=month == i ? " SELECTED" : ""%>><%= MONTH_RUS[i]%></OPTION>
<%		} %>
</select>
<select name="year" style="width:47;font-size:10px;font-family:Tahoma;" width="50">
<%
      int last = 2005;
		if(cal.get(Calendar.YEAR) > 2005)
			last = cal.get(Calendar.YEAR) + 2;
		for(int i = 2000; i < last; i++)
		{
%>
	<option value="<%=i%>"<%=year == i ? " SELECTED" : ""%>><%=i%></OPTION>
<%		} %>
</select>
<input type="Image" src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="3" vspace="0" align="absmiddle" id=Image1 name=Image1><br>
</nobr>
</td>
</form>
</tr>
</table>



<table width="100%" border="0" cellpadding="3" cellspacing="0" style="margin-top:8px;">
		
<%
if(num > 0)
{
	while(enum.hasMoreElements())
	{
		Release news = (Release)enum.nextElement();
%>
<!---- 1 ----->
<tr valign="top">
	<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
	<td class="defFont"><span class="grnTtl"><%=sdf.format(news.getRecordDate())%></span></td>
	<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
	<td width="100%">
	<div class="defFont"><a href="<%=nodePath(pageId)%>?&press_id=<%=news.getId()%>" class="nonUa"><b class="bluTtl"><%= CMSApplication.toHTML(news.getCaption())%></b></div>
	<div style="margin-top:8px;" class="defFont"><a href="<%=nodePath(pageId)%>?&press_id=<%=news.getId()%>" class="nonUa"><%= news.getBrief()%>&nbsp;<img src="<%=des%>/ar.gif" width="9" height="7" border="0"></a></div>
	</td>
</tr>
<!----//1 ----->

<!-- divider --><tr><td height="11" colspan="4" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>


<%
	}
}
else
{
%>
Релизов нет.
<%} %>
</table>		
<%	if(num > 0){ %>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:3px;">
	<tr>
	<td align="right" width="100%">
<%		if(pageNumber > 1){ %>
	<a href="<%=nodePath(pageId)%>?&month=<%=month%>&year=<%=year%>&page_number=<%=pageNumber-1%>"><img src="<%=des%>/btn-arr-blu-prew.gif" width="18" height="18" border="0" hspace="5" alt="Предыдущая"></a>
<%  } %>
	<img src="<%=des%>/dvder.gif" width="9" height="9" border="0" vspace="4">
<%		if(pageNumber*pageSize < num){ %>
	<a href="<%=nodePath(pageId)%>?&month=<%=month%>&year=<%=year%>&page_number=<%=pageNumber+1%>"><img src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" alt="Следующая"></a>
<%  } %>
    </td>
	<td><div style="width:11;"><SPACER TYPE="block" HEIGHT="1" WIDTH="11"></div></td>
	</tr>
</table>
<%	} %>
<!---- //CONTENT ----->
<%
}
%>
<%  }catch(Exception e){} %>