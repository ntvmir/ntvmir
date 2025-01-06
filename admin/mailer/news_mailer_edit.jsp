<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = NewsFields.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String news_page_id = request.getParameter("news_page_id");
	NewsFields news_obj = new NewsFields();
	boolean news_res = false;
	try
	{
		news_res = news_obj.load_news_fields(news_page_id);
	}
	catch(Exception e)
	{
		//out.println (e);
		response.sendRedirect( "news_mailer.jsp?err_msg=1");	
		//return;
	}
	String message = "";
	String actionDone = request.getParameter("action_done");
	if("save".equals(actionDone))
		message = "��������� ���������";
	else if("load".equals(actionDone))
		message = "��������� ���������";
%>
<HTML>
<HEAD>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="��������� �������� ��������"/>
<jsp:param name="header" value="��������� �������� ��������"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
<!--
function show_msg()
{
	alert('�������� �� ������� !!!  ��������� �������� �� ���������!!');
}

function form_submit()
{
	if (confirm('�������� ��������� �������� ��������?'))
	{
	var frm = document.f1;
	// check the user data
	if( frm.subjectRusNews.value.length == 0 )
	{
		frm.subjectRusNews.focus();
		alert('�� ��������� ���� ����');
		return false;
	}
	if( frm.subjectEngNews.value.length == 0 )
	{
		frm.subjectEngNews.focus();
		alert('�� ��������� ���� Subject');
		return false;
	}
	if( frm.headerRusNews.value.length == 0 )
	{
		frm.headerRusNews.focus();
		alert('�� ��������� ���� ������');
		return false;
	}
	if( frm.headerEngNews.value.length == 0 )
	{
		frm.headerEngNews.focus();
		alert('�� ��������� ���� Header');
		return false;
	}
	if( frm.footerRusNews.value.length == 0 )
	{
		frm.footerRusNews.focus();
		alert('�� ��������� ���� �������');
		return false;
	}
	if( frm.footerEngNews.value.length == 0 )
	{
		frm.footerEngNews.focus();
		alert('�� ��������� ���� Footer');
		return false;
	}
	return true;
	}
	else
	{
		return false;
	}
}

//-->
</SCRIPT>


<TABLE WIDTH="700" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<FORM METHOD="post" ACTION="xt_news_mailer_edit.jsp" name="f1">
<input type="Hidden" name="news_page_id" value="<%=news_page_id%>">
<input type="Hidden" name="action" value="edit_values">
<TR ALIGN="center">
<TD CLASS="titnew" HEIGHT="20" COLSPAN=2>
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="titnew">��� �������� ��������:</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20" SIZE="310">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">���� (�������� ��������):</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20" SIZE="310">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Subject (�������� ��������):</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20">
<INPUT TYPE=EDIT NAME="subjectRusNews" STYLE="width: 300px;" SIZE=25 VALUE="<%=(news_res==true ? CMSApplication.toHTML(news_obj.getNews_Subject_Rus()) : "")%>">
</TD>
<TD CLASS="c1" HEIGHT="20">
<INPUT TYPE=EDIT NAME="subjectEngNews" STYLE="width: 300px;" SIZE=25 VALUE="<%=(news_res==true ? CMSApplication.toHTML(news_obj.getNews_Subject_Eng()) : "")%>">
</TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">������ (�������� ��������):</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Header (�������� ��������):</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20">
<TEXTAREA  NAME="headerRusNews" ROWS=5 STYLE="width:300" COLS="43" WRAP="PHYSICAL"><%=(news_res==true ? CMSApplication.toHTML(news_obj.getNews_Header_Rus()) : "")%></TEXTAREA>
</TD>
<TD CLASS="c1" HEIGHT="20">
<TEXTAREA  NAME="headerEngNews" ROWS=5 STYLE="width:300" COLS="43" WRAP="PHYSICAL"><%=(news_res==true ? CMSApplication.toHTML(news_obj.getNews_Header_Eng()) : "")%></TEXTAREA>
</TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">������� (�������� ��������):</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Footer (�������� ��������):</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20">
<TEXTAREA   NAME="footerRusNews" ROWS=5 STYLE="width:300" COLS="43" WRAP="PHYSICAL"><%=(news_res==true ? CMSApplication.toHTML(news_obj.getNews_Footer_Rus()) : "")%></TEXTAREA>
</TD>
<TD CLASS="c1" HEIGHT="20">
<TEXTAREA   NAME="footerEngNews" ROWS=5 STYLE="width:300" COLS="43" WRAP="PHYSICAL"><%=(news_res==true ? CMSApplication.toHTML(news_obj.getNews_Footer_Eng()) : "")%></TEXTAREA>
</TD>
</TR>

<TR ALIGN="center">
<TD CLASS="titnew" HEIGHT="20" COLSPAN=2>
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="titnew">�������������� ��������� :</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
��������� �������� ������ (SMTP) 
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
<%=CMSApplication.toHTML( CMSApplication.getApplication().getProperty( "mail.smtp.host" ) )%>
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
�������� ����� ����������� �����
</DIV>
</TD>
<TD CLASS="c1" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
<%=CMSApplication.toHTML( CMSApplication.getApplication().getProperty( "mail.sender" ) )%>
</DIV>
</TD>
</TR>

<TR>
<TD COLSPAN="2">
<BR>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="1" ALIGN="center">
<TR>
<TD>
<!--<input type="Submit" value="��������" ONCLICK="return confirm('�������� ��������� �������� ��������?');">-->
<input type="Submit" value="��������" ONCLICK="return form_submit();">

</form>
</TD>
<TD>&nbsp;&nbsp;&nbsp;</TD>
<TD>
<form name="f2" action="xt_news_mailer_edit.jsp">
<input type="Hidden" name="news_page_id" value="<%=news_page_id%>">
<input type="Hidden" name="action" value="load_defaults">
<input type="Submit" style="width: 230px;" value="���������� ��������� �� ���������" ONCLICK="return confirm('�������� �� ��������� �������� �������� �� ���������?');">
</form>
</TD></TR>
</TABLE>
</TD></TR>
</TABLE>

<BR><BR>
</BODY>
</HTML>
