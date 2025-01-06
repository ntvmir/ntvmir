<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
try
{
%>
<%@ include file="/inc/page_init.jsp"%>
<%--
метод response.addCookie() срабатывает только до первого flush'а out-потока, т.е. если
перед установкой куки было записано в out > 8К текста, то кука не установится => установкук кук
придется производить в начале страницы.
--%>
<%@ include file="/inc/set_cookies.jsp"%>
<%
    String sectionImgDir = sectionCode;
	if("about".equals(sectionImgDir))
	    sectionImgDir = "company";
	else if("tvschedule".equals(sectionImgDir))
	    sectionImgDir = "tvprogram";
	else if("auth".equals(sectionImgDir))
	    sectionImgDir = "authorization";
	else if("map".equals(sectionImgDir))
	    sectionImgDir = "sitemap";
    
	PageType pageType;
	
	if(previewInfo == null)
		pageType = node.getPageType();
	else
		pageType = (PageType)previewInfo.get("pagetype");

	String allParams = "?id=" + (node != null ? node.getId() : "");
	for(int i = 0; i < parameters.length; i++)
		if(!parameters[i].startsWith("page_id="))
			allParams += "&" + CMSApplication.URLEncode(parameters[i]);
    
    // для того, что б инклюдящиеся страницы могли устанавливать куки
    session.setAttribute("page.response", response);

    String title = "";
    if(node != null)
    {
        WebTreeNode tmpNode = node;
        while(tmpNode.getParent() != null)
        {
            title = " :: " + tmpNode.getName() + title;
            tmpNode = tmpNode.getParent();
        }
    }
    String siteUrl = CMSApplication.getApplication().getProperty("www.address", "/");
    String europeUrl = CMSApplication.getApplication().getProperty("www.europe", "/");
    String americaUrl = CMSApplication.getApplication().getProperty("www.america", "/");

%>


<html>
<head>

<title><%=CMSApplication.getSiteName()%><%=title%></title>
<NOINDEX>
<link rel="STYLESHEET" type="text/css" href="/inc/css.css">
</head>

<SCRIPT LANGUAGE="JavaScript">(document.layers)?document.write('<style>.SELnn{font-size:11px;}</style>'):document.write('<style>body {background:#1DAF38 url(<%=des%>/bg-grn-ln.gif) repeat-y;} SELECT{font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;font-size: 65%;}</style>');</SCRIPT>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" bgcolor="#80AFE0" background="<%=des%>/bg-grn-ln.gif">
<table width="100%" cellpadding="0" cellspacing="0" border="0" height="100%">
<tr>
	<td colspan="6" height="7" bgcolor="#FF1515"><img src="<%=des%>/t-red.jpg" width="770" height="7" alt="" border="0"></td>
</tr>

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
	<td colspan="6"><a href="/"><img src="<%=des%>/logo-mir.gif" width="96" height="23" border="0"></a><%
	  if(!sectionCode.equals("about")){ 
      %><a href="/pages/<%=langCode%>/about"><img src="<%=des%>/n-abt.gif" alt="О компании" width="92" height="23" border="0"></a><%
	  }else{ 
	  %><img src="<%=des%>/company/n-abt.gif" alt="О компании" width="98" height="23" border="0"><%
	  } 
	 
	  if(!sectionCode.equals("about") && !sectionCode.equals("tvschedule")){ 
	  %><img src="<%=des%>/n-sprtr.gif" width="6" height="23" border="0"><%
	  }
	
	  if(!sectionCode.equals("tvschedule")){ 
	  %><a href="/pages/<%=langCode%>/tvschedule"><img src="<%=des%>/n-tvprg.gif" alt="Телепрограмма" width="112" height="23" border="0"></a><%
	  } else {
	  %><img src="<%=des%>/tvprogram/n-tvprg.gif" alt="Телепрограмма" width="124" height="23" border="0"><%
	  }
	
	  if(!sectionCode.equals("tvschedule") && !sectionCode.equals("support")){ 
	  %><img src="<%=des%>/n-sprtr.gif" width="6" height="23" border="0"><%
	  }
	  
	  if(!sectionCode.equals("support")){ 
	  %><a href="/pages/<%=langCode%>/support"><img src="<%=des%>/n-sprt.gif" alt="Служба поддержки" width="138" height="23" border="0"></a><%
	  } else { 
	  %><img src="<%=des%>/support/n-sprt.gif" alt="Служба поддержки" width="150" height="23" border="0"><%
	  }
	  
	  if(!sectionCode.equals("support") && !sectionCode.equals("forum")){
	  %><img src="<%=des%>/n-sprtr.gif" width="6" height="23" border="0"><%
	  }
	  
	  if(!sectionCode.equals("forum")){ 
	  %><a href="/pages/<%=langCode%>/forum"><img src="<%=des%>/n-frm.gif" alt="Форум" width="60" height="23" alt="" border="0"></a><%
	  } else {
	  %><img src="<%=des%>/forum/n-frm.gif" alt="Форум" width="72" height="23" alt="" border="0"><%
	  } %><img src="<%=des%>/n-r.gif" width="250" height="23" border="0"></td>
</tr>

<%----// ROW nava -----%>


<%---- ROW  белая полоска с закругленным уголком -----%>
<tr>
	<td width="21%" bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	<td bgcolor="#ffffff" rowspan="3"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	<td width="38%" bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	<td width="23%" bgcolor="#ffffff" align="right"><img src="<%=des%>/<%=sectionImgDir%>/top-ttl.gif" height="9" alt="" border="0"></td>
	<td align="right"><img src="<%=des%>/tp-r.gif" width="10" height="9" border="0"></td>
	<td width="18%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%----// ROW белая полоска с закругленным уголком -----%>


<%---- ROW топ новость и анонсы -----%>
<tr valign="top">
<td bgcolor="#80AFE0" width="21%">

<%---- НАВА СЛЕВА -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#E5E5E5">
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
<%  if(!"search".equals(sectionCode))
    {
%>
<tr bgcolor="#ffffff">
<form action="/pages/<%=langCode%>/search">
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr><td height="12"></td></tr>
<tr valign="bottom">
<td><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td width="100%"><NOBR><a href="/pages/<%=langCode%>/search"><img src="<%=des%>/srch.gif" width="67" height="9" border="0"></a><img src="<%=des%>/dvder.gif" width="9" height="9" border="0"><a href="/pages/<%=langCode%>/map"><img src="<%=des%>/sitemap.gif" width="51" height="9" border="0"></a><br></NOBR></td>
	<td></td>
<td><div style="width:5;"><SPACER TYPE="block" HEIGHT="1" WIDTH="5"></div></td>	
</tr>
<tr><td height="6"></td></tr>
<tr>
<td><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td width="100%"><input type="text" name="f_query" style="width:100%;font-size:10px;font-family:Tahoma;" size="15"></td>
	<td><input type="Image" src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5"></td>
<td><div style="width:5;"><SPACER TYPE="block" HEIGHT="1" WIDTH="5"></div></td>	
</tr>
<tr><td height="9"></td></tr>
</table>
</td>
</form>
</tr>
<%
    }
    else
    {
%>
<tr bgcolor="#ffffff">
<td>
<table border="0" cellpadding="0" cellspacing="0">
<tr><td height="11"></td></tr>
<tr valign="bottom">
<td><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td width="67"><NOBR><img src="<%=des%>/srch.gif" alt="Поиск по сайту" width="67" height="9" border="0"><img src="<%=des%>/dvder.gif" width="9" height="9" border="0"><a href=""><img src="<%=des%>/sitemap.gif" alt="Карта сайта" width="51" height="9" border="0"></a><br></NOBR></td>
	<td></td>
<td><div style="width:5;"><SPACER TYPE="block" HEIGHT="1" WIDTH="5"></div></td>	
</tr>
<tr><td height="8"></td></tr>
</table>
</td>
</tr>
<%  } %>
<tr>
<td align="right"><img src="<%=des%>/2lev/lft-n-tr.gif" width="10" height="10" border="0"></td>
</tr>

<tr valign="top">
<td class="smallFont">
<%
    if(adminPreview)
    {
%>
<div class="Lnav"><a href="javascript:window.close();"><b>Закрыть окно.</b></a></div>
<div><img src="<%=des%>/2lev/lft-ln.gif" width="169" height="1" alt="" border="0" vspace="6"></div>
<%
    }
try
{
    if(sectionCode.equals("forum") || sectionCode.equals("map"))
    {
%>
<%@ include file="/user/left_up.jsp"%>
<%  }
    else if(sectionCode.equals("tvschedule"))
    {
%>
<%@ include file="/tvschedule/left_up.jsp"%>
<%  }
    else if(sectionCode.equals("search"))
    {
%>
<%@ include file="/search/left_up.jsp"%>
<%
    }
    else if(sectionCode.equals("auth") && user != null)
    {
%>
<%@ include file="/user/left_up.jsp"%>
<%
    }
    else
    {
%>
<%@ include file="/left_up.jsp"%>
<%  }
}catch(Exception e){}
%>
</td>
</tr>
</table>

<%----//НАВА СЛЕВА -----%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td bgcolor="#E5E5E5" align="right"><img src="<%=des%>/2lev/lft-n-br.gif" width="10" height="10" border="0"></td>
	</tr>
	<tr>
	<td height="10" bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
	</tr>	
</table>



<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#80AFE0">
<%@ include file="/vote/vote.jsp"%>
<tr valign="top">
<td bgcolor="#80AFE0" class="smallFont"><%
    if(!votePrinted)
    {
%><img src="<%=des%>/2lev/lft-b-tr.gif" width="10" height="10" border="0" align="right" hspace="0"><% 
    }
try{
    if("forum".equals(sectionCode))
    {
%>
<%@ include file="/forum/left_down.jsp"%>
<%  }
    else
    {
%>
<%@ include file="/left_down.jsp"%>
<%  }
}catch(Exception e){}
 %>
</td>
</tr>
</table>

</td>
<td width="61%" colspan="2" bgcolor="#ffffff" height="100%">
<%---- ФОРУМ -----%>


<%
    //out.println("<!--" + pageType.getUrlUser() + allParams + "-->");
	pageContext.include(pageType.getUrlUser() + allParams);
%>

</td>
<td bgcolor="#ffffff"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
<td width="18%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td>
</tr>
<%----//ROW топ новость и анонсы -----%>





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
<td height="5" colspan="6"><SPACER TYPE="block" HEIGHT="5" WIDTH="1"></td>
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
	<%-- распорка левой колонки --%><div style="width:184;"><SPACER TYPE="block" HEIGHT="1" WIDTH="184"></div>
	</td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89"><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89" width="38%" align="center">
	<%---- НИЖНЯЯ НАВИГАЦИЯ -----%>	
	<div style="color:#ffffff;font-size:10px;font-family: Tahoma, Verdana, Arial, sans-serif;"><a href="/" style="color:#ffffff;">Главная</a> | <a href="/pages/<%=langCode%>/about" style="color:#ffffff;">О компании</a> | <a href="/pages/<%=langCode%>/tvschedule" style="color:#ffffff;">Телепрограмма</a> | <a href="/pages/<%=langCode%>/support" style="color:#ffffff;">Служба поддержки</a> | <a href="/pages/<%=langCode%>/forum" style="color:#ffffff;">Форум</a></div>
	<%----//НИЖНЯЯ НАВИГАЦИЯ  -----%>	
	<%-- распорка центральной колонки --%><div style="width:372;"><SPACER TYPE="block" HEIGHT="1" WIDTH="372"></div>
	</td>

	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89" width="23%" valign="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" background="" style="margin-top:8px;">
		<tr>
		<td bgcolor="#477FBB"><img src="<%=des%>/btm-2-l.gif" width="7" height="42" border="0"></td>
		<td bgcolor="#477FBB" width="100%" align="center"><img src="<%=des%>/btm-2-txt.gif" width="180" height="42" border="0"></td>
		<td bgcolor="#477FBB"><img src="<%=des%>/btm-1-r.gif" width="7" height="42" border="0"></td>
		</tr>
		</table>
	<%--распорка правой колонки --%><div style="width:195;"><SPACER TYPE="block" HEIGHT="1" WIDTH="195"></div>
	</td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89"><div style="width:10;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td background="<%=des%>/bg-bot.gif" bgcolor="#0D3A89" width="18%"><div style="width:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td>
</tr>
<%----// ROW footer -----%>
</table>
</NOINDEX>
</body>
</html>
<%
}catch(Exception e)
{
    e.printStackTrace(System.err);
}
%>