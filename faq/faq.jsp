<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.faq.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%@ include file="/inc/path_init.jsp"%>
<%
    String message = null;
    if("1".equals(request.getParameter("sent")))
        message = "Вопрос поступил на рассмотрение администратору";

    String themeId = request.getParameter("theme_id");
    try
    {
    if(themeId == null || themeId.length() == 0)
    {
        Vector categories = FaqCategory.getFaqCategoryList(pageId);
        Enumeration enum = categories.elements();
%>
<script language="Javascript">
function submitMainForm()
{
    var frm = document.main_form;
    if(frm.theme_id.value == '')
    {
        alert('Укажите тему вопроса.');
        frm.theme_id.focus();
        return;
    }
    if(frm.text.value == '')
    {
        alert('Не введен текст вопроса.');
        frm.text.focus();
        return;
    }
    frm.submit();
}
</script>

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





<%---- заголовочек Выберите интересующую Вас тему:-----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
<tr>
	<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/support/ttl-faq.gif" height="19" alt="Вопросы и ответы" border="0"></td>
	<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
</tr>
</table>
<%----//заголовочек Выберите интересующую Вас тему:-----%>

<%  if(message != null)
    {
%>
<div align="center" class="smallFont" style="color: red; margin-top: 10pt; margin-bottom; 10pt;"><%=message%></div>
<%  } %>



<%---- ТЕМЫ -----%>
<table width="100%" border="0" cellpadding="3" cellspacing="0" style="margin-top:8px;">
<%
    boolean firstLoop = true;
    while(enum.hasMoreElements())
    {
        FaqCategory fqc = (FaqCategory)enum.nextElement();
        if(firstLoop)
        {
            firstLoop = false;
        } else {
%>
<!-- divider --><tr><td height="11" colspan="3" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%      } %>
<%---- 1 -----%>
<tr valign="top">
	<td><div style="width:3;"><SPACER TYPE="block" HEIGHT="1" WIDTH="3"></div></td>
	<td><a href="<%=nodePath(pageId)%>?theme_id=<%=fqc.getId()%>"><img src="<%=des%>/support/ico-faq.gif" width="13" height="15" border="0" hspace="4"></a></td>
	<td width="100%" class="defFont">
	<a href="<%=nodePath(pageId)%>?theme_id=<%=fqc.getId()%>" class="nonUa"><b class="bluTtl"><%=CMSApplication.toHTML(fqc.getName())%></b></a>
	</td>
</tr>
<%----//1 -----%>
<%  } %>
</table>
<%----//ТЕМЫ -----%>


<%---- заголовочек Звадать вопрос-----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896" style="margin-top:8px;">
<tr>
	<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/support/ttl-ask.gif" height="19" alt="Задать вопрос" border="0"></td>
	<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
</tr>
</table>
<%----//заголовочек Звадать вопрос-----%>


<%---- пояснения -----%>
<table border="0" cellpadding="0" cellspacing="8" style="margin-top:104px;" width="180" align="right">
<tr>
<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
<td class="smallFont">
		поля отмеченные 
		<SPAN class="str">*</SPAN>
		являются обязательными для заполнения
</td>
</tr>		
</table>
<%----//пояснения -----%>


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="4" style="margin-top:4px;">
    <form action="/faq/xt_faq.jsp" method="post" name="main_form">
    <input type="hidden" name="id" value="<%=pageId%>">
<TR><td><div style="width:8;"><SPACER TYPE="block" HEIGHT="1" WIDTH="8"></div></td>
<TD class="defFont">Тема</TD><TD>
<DIV class="SELnn">
<SELECT name="theme_id" style="width:220;" width="220">
<option selected value="">Выберите из списка</option>
<%
    enum = categories.elements();
    while(enum.hasMoreElements())
    {
        FaqCategory fqc = (FaqCategory)enum.nextElement();
%>
<option value="<%=fqc.getId()%>"><%=CMSApplication.toHTML(fqc.getName())%></option>
<%  } %>
</SELECT></DIV>
</TD>
</TR>
<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<TR><td></td>
<TD class="defFont"><div style="width:125;"><SPACER TYPE="block" HEIGHT="1" WIDTH="125"></div>Имя</TD><TD width="240"><INPUT TYPE="text" STYLE="width:220;" NAME="name" SIZE="28" maxlength="100"></TD>
</TR>
<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>	
<TR><td></td>
<TD class="defFont">E-mail</TD><TD><INPUT TYPE="text" NAME="email" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
</TR>
<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<TR><td></td>
<TD  COLSPAN="2" class="defFont"><div STYLE="margin:3px 0px 0px 0px;">Текст вопроса<SPAN CLASS="str">*</SPAN></div><div class="SELnn"><TEXTAREA maxlength="1000" COLS="47" ROWS="5" NAME="text" STYLE="width:352;margin:3px 0px 0px 0px;" WRAP="ON"></TEXTAREA></div></TD>
</TR>	
<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<tr><td></td>
<td colspan="2"><a href="javascript: document.main_form.reset();"><img src="<%=des%>/faq/btn-cancle.gif" height="18" alt="Отменить" border="0" hspace="10"></a><a href="javascript: submitMainForm();"><img src="<%=des%>/feedback/btn-send.gif" height="18" alt="Отправить" border="0"></a></td>
</form></tr>	
</TABLE>
<%  }



    else
    
    
    
    
    {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
        FaqCategory theme = new FaqCategory();
        theme.load(themeId);
        if(!theme.isVisible())
            throw new CMSException("Theme is not published");
        int pageSize = FaqQuestion.getFaqQuestionAmount();
        int pageNumber = 1;
        try
        {
            pageNumber = Integer.parseInt(request.getParameter("page_number"));
        }
        catch(Exception e){}
        int num = FaqQuestion.getFaqQuestionsNum(themeId, FaqQuestion.LOAD_PUBLISHED);
        Enumeration enum = FaqQuestion.getFaqQuestions(themeId, FaqQuestion.LOAD_PUBLISHED, pageNumber, pageSize).elements();
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
<a href="<%=nodePath(treeNode)%>"><%=CMSApplication.toHTML(treeNode.getName())%></a> /
<%
        }
%>
<%=CMSApplication.toHTML(theme.getName())%>
</div>
<%  } %>
</td>
<!--заголовок страницы--><td align="right"><img src="<%=des%>/<%=sectionImg%>/ttl.gif" height="47" alt="<%=sectionName%>" border="0"></td>
</tr>
</table>





<%---- заголовочек ТЕМА:-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/support/ttl-faq.gif" height="19" alt="Вопросы и ответы" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек ТЕМА:-----%>

<%  if(message != null)
    {
%>
<div align="center" class="smallFont" style="color: red; margin-top: 10pt; margin-bottom; 10pt;"><%=message%></div>
<%  } %>


<div style="margin:8px 0px 0px 16px;font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;"></NOINDEX><b class="bluTtl"><%=CMSApplication.toHTML(theme.getName())%></b><NOINDEX></div>
<div style="margin:4px 0px 0px 16px;" class="smallFont">
<span class="c66"></NOINDEX><%=CMSApplication.toHTML(theme.getDescription())%><NOINDEX></span>
<br>
<a href="#ask"><img src="<%=des%>/faq/btn-ask.gif" height="18" alt="Задать вопрос" border="0" vspace="5"></a><br>
</div>

<%---- ТЕМЫ -----%>
</NOINDEX>
<table width="100%" border="0" cellpadding="3" cellspacing="0">
<!-- divider --><tr><td height="11" colspan="4" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  while(enum.hasMoreElements())
    {
        FaqQuestion faq = (FaqQuestion)enum.nextElement();
%>
<%---- 1 -----%>
<tr valign="top">
	<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
	<td class="defFont"><span class="grnTtl"><%=sdf.format(faq.getAnswerDate())%></span></td>
	<td><div style="width:7;"><SPACER TYPE="block" HEIGHT="1" WIDTH="7"></div></td>
	<td width="100%">
	<div class="defFont"><b class="bluTtl"><%=CMSApplication.toHTML(faq.getQuestion())%></b></div>
	<div style="margin-top:8px;" class="smallFont"><span class="c66"><%=faq.getAnswer()%></span></div>
	</td>
</tr>
<%----//1 -----%>

<!-- divider --><tr><td height="11" colspan="4" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  } %>
</table>
<NOINDEX>
<%----//ТЕМЫ -----%>

<%----  навигация -----%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:3px;">
	<tr>
	<td align="right" width="100%"><a name="ask"></a><%
	if(pageNumber > 1){
	%><a href="<%=nodePath(pageId)%>?theme_id=<%=theme.getId()%>&page_number=<%=pageNumber-1%>"><img src="<%=des%>/btn-arr-blu-prew.gif" width="18" height="18" border="0" hspace="5" alt="Предыдущая"></a><%
	}else{
	%><img src="<%=des%>/btn-arr-blu-prew.gif" width="18" height="18" border="0" hspace="5" alt="Предыдущая"><%
	}
	%><img src="<%=des%>/dvder.gif" width="9" height="9" border="0" vspace="4"><%
	if(pageNumber < (num+1)/pageSize){
	%><a href="/<%=nodePath(pageId)%>?theme_id=<%=theme.getId()%>&page_number=<%=pageNumber+1%>"><img src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" alt="Следующая"></a><%
	} else {
	%><img src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" alt="Следующая"><%
	}%>
	</td>
	<td><div style="width:11;"><SPACER TYPE="block" HEIGHT="1" WIDTH="11"></div></td>
	</tr>
</table>
<%----//навигация -----%>
<br>



<%---- заголовочек Звадать вопрос-----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/support/ttl-ask.gif" height="19" alt="Задать вопрос" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек Звадать вопрос-----%>


<%---- пояснения -----%>
	<table border="0" cellpadding="0" cellspacing="8" style="margin-top:104px;" width="180" align="right">
	<tr>
	<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
	<td class="smallFont">
			поля отмеченные 
			<SPAN class="str">*</SPAN>
			являются обязательными для заполнения
	</td>
	</tr>		
	</table>
<%----//пояснения -----%>

<script language="Javascript">
function submitMainForm()
{
    var frm = document.main_form;
    
    if(frm.text.value == '')
    {
        alert('Не введен текст вопроса.');
        frm.text.focus();
        return;
    }
    frm.submit();
}
</script>

	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="4" style="margin-top:4px;">
	<TR>
	<form action="/faq/xt_faq.jsp" name="main_form">
	<input type="hidden" name="theme_id" value="<%=theme.getId()%>">
	<input type="hidden" name="id" value="<%=pageId%>">
	<input type="hidden" name="theme_page" value="1">
	<td><div style="width:8;"><SPACER TYPE="block" HEIGHT="1" WIDTH="8"></div></td>
	<TD class="defFont">Тема</TD><TD><INPUT TYPE="text" STYLE="width:220;" SIZE="28" maxlength="100" disabled value="<%=CMSApplication.toHTML(theme.getName())%>"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD class="defFont"><div style="width:125;"><SPACER TYPE="block" HEIGHT="1" WIDTH="125"></div>Имя</TD><TD width="240"><INPUT TYPE="text" NAME="name" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>	
	<TR><td></td>
	<TD class="defFont">E-mail</TD><TD><INPUT TYPE="text" name="email" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
	</TR>
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
	<TR><td></td>
	<TD  COLSPAN="2" class="defFont"><div STYLE="margin:3px 0px 0px 0px;">Текст вопроса<SPAN CLASS="str">*</SPAN></div><div class="SELnn"><TEXTAREA maxlength="1000" name="text" COLS="47" ROWS="5" STYLE="width:352;margin:3px 0px 0px 0px;" WRAP="ON"></TEXTAREA></div></TD>
	</TR>	
	<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

	<tr><td></td>
	<td colspan="2"><a href="javascript: document.main_form.reset();"><img src="<%=des%>/faq/btn-cancle.gif" height="18" alt="Отменить" border="0" hspace="10"></a><a href="javascript: submitMainForm();"><img src="<%=des%>/feedback/btn-send.gif" height="18" alt="Отправить" border="0"></a></td>
	</form></tr>	
	</TABLE>
<%  }
    }catch(Exception e){}
%>