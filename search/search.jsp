<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ include file="/inc/init_global.jsp"%>

<%!
public String replaceChars(String s, String chars, char c)
{
	StringBuffer res = new StringBuffer("");
	for(int i = 0; i < s.length(); i++)
	{
		if(chars.indexOf(s.charAt(i)) >= 0)
			res.append(c);
		else
			res.append(s.charAt(i));
	}
	return res.toString();
}
%>


<%  response.setHeader("Pragma","no-cache"); %>
<%

String query = request.getParameter("f_query");
if(query == null)
	query = "";
else
    query = query.trim();
	
String mode = request.getParameter("f_mode");
if( ! ("and".equals(mode) || "or".equals(mode) || "full".equals(mode)))
	mode = "and";
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign="top" class="XsmallFont">
</td>
<!--заголовок страницы--><td align="right"><img src="<%=des%>/search/ttl.gif" height="47" alt="Поиск" border="0"></td>
</tr>
</table>
<%
if(query.length() > 0)
{
%>

<%---- заголовочек РЕЗУЛЬТАТЫ ПОИСКА-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/search/ttl-srch-rslt.gif" height="19" alt="Результаты поиска" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек РЕЗУЛЬТАТЫ ПОИСКА-----%>
<%
	int pageSize = 10;
	int pageNumber = 1;
	try{ pageNumber = Integer.parseInt(request.getParameter("f_page_number")); }catch(Exception e){}

	String hndlQuery = request.getParameter("query_num");
	String pageNum = request.getParameter("f_page_number");
	
	String cgiUrl = "/cgi-bin/yandsearch";
	if(hndlQuery != null && hndlQuery.length() > 0)
		cgiUrl = "/cgi-bin/yandpage";
	
	String yQuery = replaceChars(query, "\t\n@#$%^\"'&*_=[]{};?\\<>~!", ' ');
//	out.println("<BR>phrase: " + yQuery + "</BR>");
	
	if("full".equals(mode))
	{
		yQuery = "\"" + yQuery.trim() + "\"";
	}
	else
	{
		boolean afterDst = false;
		StringTokenizer st = new StringTokenizer(yQuery);
		String modeSign = "and".equals(mode) ? " && " : " | ";
		boolean atStart = true;
		yQuery = "";
		while(st.hasMoreTokens())
		{
			String token = st.nextToken();
			if(atStart)
				atStart = false;
			else
			{
				if(token.startsWith("/"))
				{
					afterDst = true;
					token = " " + token.replace(':', ' ') + " ";
				}
				else
				{
					if(!afterDst)
						yQuery += modeSign;
					afterDst = false;
				}
			}
			yQuery += ("and".equals(mode) && !afterDst ?  "+" : "") + token;
		}
	}

//	out.println("<BR>phrase: " + yQuery + "</BR>");
try
{
	
	URL url = new URL(new URL(request.getRequestURL().toString()),
		cgiUrl + "?des=" + des + 
		(hndlQuery != null && hndlQuery.length() > 0? "&HndlQuery=" + hndlQuery : "") +
		(pageNum != null && pageNum.length() > 0? "&PageNum=" + pageNum : "") +
		"&id=" + pageId +
		"&f_mode=" + mode +
		"&where=0&text=" + CMSApplication.URLEncode(yQuery) +
		"&query=" + CMSApplication.URLEncode(query));
	
//	out.println("<textarea rows=5 cols=80>\n" + url + "\n</textarea>");
	
	BufferedReader ios = new BufferedReader(new InputStreamReader(url.openStream(), "Cp1251"));

	String ss = null;
	while((ss = ios.readLine()) != null)
	{
		out.println(ss);
	}
}catch(Exception e){}
%>

<br>

<% } %>


<%---- заголовочек НОВЫЙ ПОИСК-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/search/ttl-new-srch.gif" height="19" alt="Новый поиск" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек НОВЫЙ ПОИСК-----%>

<%---- НОВЫЙ ПОИСК -----%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" STYLE="margin-top:8px;">
<tr><form action=""><td><div style="width:12;"><SPACER TYPE="block" HEIGHT="1" WIDTH="12"></div></td>
<td class="defFont">Я ищу:&nbsp;</td>
<td colspan="8"><INPUT TYPE="Text" NAME="f_query" SIZE="23" STYLE="width:100%;" VALUE=""></td>
<td><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
<TD><input type="Image" src="<%=des%>/search/btn-srch.gif" height="18" alt="Найти!" border="0"></TD>
</tr>
<TR>
<td height="28"></td>
<td></td>
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="and" STYLE="background:#FFFFFF;" CHECKED id="b1"></TD><TD CLASS="smallFont" WIDTH="15"> <LABEL for="b1">и</LABEL>&nbsp;&nbsp;&nbsp;</TD>
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="or" STYLE="background:#FFFFFF;" id="b2"></TD><TD CLASS="smallFont" WIDTH="25"> <LABEL for="b2">или</LABEL>&nbsp;&nbsp;&nbsp;</TD>
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="full" STYLE="background:#FFFFFF;" id="b3"></TD><TD CLASS="smallFont"> <LABEL for="b3">фраза целиком</LABEL>&nbsp;&nbsp;&nbsp;</TD>
<td></td>
<td></td>
</form></TR>
</TABLE>
<%----// НОВЫЙ ПОИСК-----%>