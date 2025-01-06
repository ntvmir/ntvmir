<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.user.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
    String login = request.getParameter("login");
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


<%---- заголовочек  Список пользователей-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/forum/ttl-usr-list.gif" height="19" alt="Список пользователей" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек  Список пользователей-----%>

<%---- скроллер -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:8px 0px 0px 0px;">
<td valign="bottom" align="right" class="smallFont"><SPAN class="c66"><%printPagebar(pageNumber, pageSize, num, href, out);%></SPAN></td>
</tr>
</table>
<%----//скроллер -----%>

<table width="100%" border="0" cellpadding="3" cellspacing="0" style="margin:8px 0px 0px 0px;">

<%---- заголовок раздела -----%>
<tr bgcolor="#DDF3E1">
	<td><div style="width:16;"><SPACER TYPE="block" HEIGHT="1" WIDTH="16"></div></td>
	<td class="defFont"><NOBR><a href="<%=href%>&order=<%=ord==1 ? -1 : 1%>" class="nonUa"><% 
if(ord == 1){
%><b class="grnTtl">Login</b></a><img src="<%=des%>/forum/arr-sort-up.gif" width="5" height="5" alt="" border="0" hspace="6" align="baseline" vspace="1"><%
}else if(ord == -1){
%><b class="grnTtl">Login</b></a><img src="<%=des%>/forum/arr-sort-down.gif" width="5" height="5" alt="" border="0" hspace="6" align="baseline" vspace="1"><%
}else {
%>Login</a><%
}
%><SMALL style="color:#7FB299;">&nbsp;&nbsp;&nbsp;/&nbsp;<a href="<%=href%>&order=<%=ord==2 ? -2 : 2%>" class="nonUa" style="color:#7FB299;"><%
if(ord == 2){
%><b class="grnTtl">Дата регистрации</b></a><img src="<%=des%>/forum/arr-sort-up.gif" width="5" height="5" alt="" border="0" hspace="6" align="baseline" vspace="1"><%
}else if(ord == -2){
%><b class="grnTtl">Дата регистрации</b></a><img src="<%=des%>/forum/arr-sort-down.gif" width="5" height="5" alt="" border="0" hspace="6" align="baseline" vspace="1"><%
}else {
%>Дата регистрации</a><%
}
%><%
%> | <a href="<%=href%>&order=<%=ord==3 ? -3 : 3%>" class="nonUa" style="color:#7FB299;"><%
if(ord == 3){
%><b class="grnTtl">Кол-во сообщений</b></a><img src="<%=des%>/forum/arr-sort-up.gif" width="5" height="5" alt="" border="0" hspace="6" align="baseline" vspace="1"><%
}else if(ord == -3){
%><b class="grnTtl">Кол-во сообщений</b></a><img src="<%=des%>/forum/arr-sort-down.gif" width="5" height="5" alt="" border="0" hspace="6" align="baseline" vspace="1"><%
}else {
%>Кол-во сообщений</a><%
}
%> /</SMALL></NOBR></td>
	<td class="defFont"><b style="color:#7FB299;">Место жительства</b><!--<img src="<%=des%>/forum/arr-sort-dwn-bl.gif" width="5" height="5" alt="" border="0" hspace="6" align="baseline" vspace="1">--></td>
</tr>
<%----//заголовок раздела -----%>

<!--отступ--><tr><td height="7" colspan="3"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%
    int l = 0;
    while(enum.hasMoreElements())
    {
        User uuu = (User)enum.nextElement();
        l++;
        String location = "";
        if(uuu.isVisible())
        {
            location = CMSApplication.toHTML(uuu.getCountry());
            if(location.length() > 0 && uuu.getCity().length() > 0)
                location += ", <BR>";
            location += uuu.getCity();
        }
        
        if(l > 1)
        {
%>        
<%---- 1 -----%>
<!-- отступ сверху--><tr <%=l%2==1?"bgcolor=\"#F1F1F1\"":""%> class="lnz"><td height="5" colspan="3"><div style="height:1px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td></tr>
<%      } %>
<tr valign="top" <%=l%2==1?"bgcolor=\"#F1F1F1\"":""%>>
	<td class="smallFont" align="right"><%=l%>.</td>
	<td class="smallFont"><a href=""><b><%=uuu.getLogin()%></b></a></td>
	<td class="smallFont" rowspan="3"><%=location%></td>
</tr>
<tr valign="top" <%=l%2==1?"bgcolor=\"#F1F1F1\"":""%>>
	<td class="smallFont">&nbsp;</td>
	<td class="smallFont"><SPAN class="c66">Дата регистрации: <b><%=sdf.format(uuu.getCreateDate())%></b></SPAN></td>
</tr>
<tr valign="top" <%=l%2==1?"bgcolor=\"#F1F1F1\"":""%>>
	<td class="smallFont">&nbsp;</td>
	<td class="smallFont"><SPAN class="c66">
	<img src="<%=des%>/ans-all.gif" width="18" height="8" border="0" align="baseline">Сообщений: <b><%=uuu.getMessageAmount()%></b>
<%  if(uuu.isVisible()){%>
|<img src="<%=des%>/forum/ico-eml.gif" align="Отправить e-mail" width="10" height="10" hspace="5" border="0"><a href="mailto:<%=uuu.getEmail()%>"><%=uuu.getEmail()%></a>
<%  } %><br>	
	</SPAN></td>
</tr>
<!-- отступ снизу --><tr <%=l%2==1?"bgcolor=\"#F1F1F1\"":""%>><td height="5" colspan="3"><div style="height:1px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td></tr>
<%----//1 -----%>
<%  } %>
<!-- отступ сверху--><tr class="lnz"><td height="5" colspan="3"><div style="height:1px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td></tr>
</table>


<%---- скроллер -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:8px 0px 0px 0px;">
<tr>
<td align="right" class="smallFont"><SPAN class="c66"><%printPagebar(pageNumber, pageSize, num, href, out);%></SPAN></td>
</tr>
</table>
<%----//скроллер -----%>
