<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.forum.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%@include file="/inc/pagebar.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>



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


<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
    String login = request.getParameter("login");
    User theUser = User.getUser(login);
    if(theUser == null)
        theUser = new User();
%>
<%---- заголовочек  Подробные регистрационные данные-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/forum/ttl-usr-detls.gif" height="19" alt="Информация о пользователе" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек  Подробные регистрационные данные-----%>


<table width="100%" border="0" cellpadding="5" cellspacing="0" style="margin:8px 0px 0px 0px;">


<tr valign="top"><td><div style="width:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td>
	<td class="defFont" width="100%" colspan="2"><b class="bluTtl"><%=theUser.isVisible()? CMSApplication.toHTML(theUser.getName()) : ""%></b></td>
</tr>

<!-- divider --><tr><td height="10" colspan="3" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>


<tr valign="top" class="c66">
	<td></td>
	<td class="defFont"><b class="c66">Дата регистрации:</b></td>
	<td class="defFont"><%=theUser.getCreateDate() != null ? sdf.format(theUser.getCreateDate()) : ""%></td>
</tr>

<tr valign="top" class="c66">
	<td></td>
	<td class="defFont"><b class="c66">E-mail:</b></td>
	<td class="defFont"><a href=""><%=theUser.isVisible()? CMSApplication.toHTML(theUser.getEmail()) : ""%></a></td>
</tr>

<tr valign="top" class="c66">
	<td></td>
	<td class="defFont"><b class="c66">Имя пользователя:</b></td>
	<td class="defFont"><%=CMSApplication.toHTML(theUser.getLogin())%></td>
</tr>

<tr valign="top" class="c66">
	<td></td>
	<td class="defFont"><b class="c66">Страна:</b></td>
	<td class="defFont"><%=theUser.isVisible()? CMSApplication.toHTML(theUser.getCountry()) : ""%></td>
</tr>

<tr valign="top" class="c66">
	<td></td>
	<td class="defFont"><b class="c66">Город:</b></td>
	<td class="defFont"><%=theUser.isVisible()? CMSApplication.toHTML(theUser.getCity()) : ""%></td>
</tr>

 <tr valign="top" class="c66">
	<td></td>
	<td class="defFont"><b>Номер ICQ:</b></td>
	<td class="defFont"><%=theUser.isVisible()? CMSApplication.toHTML(theUser.getIcq()) : ""%></td>
</tr>

<tr valign="top" class="c66">
	<td></td>
	<td class="defFont"><b>Страница Интернет:</b></td>
	<td class="defFont">
<%
	if(theUser.isVisible())
	{
	    String url = CMSApplication.toHTML(theUser.getUrl());
	    if(!url.startsWith("http://"))
	        url = "http://" + url;
%><a href="<%=url%>"><%=url%></a>
<%  } %></td>
</tr>

<tr valign="top" class="c66">
	<td></td>
	<td class="defFont" colspan="2"><b>Дополнительная информация:</b>
	<div style="margin-top:4px;"><%=theUser.isVisible()? CMSApplication.toHTML(theUser.getDescription()) : ""%></div>	
	</td>
</tr>

</table>

