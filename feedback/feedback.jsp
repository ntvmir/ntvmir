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
    String message = null;
    if("1".equals(request.getParameter("sent")))
        message = "���� ��������� ���� ������� ����������.";    
    try{
%>
<script language="Javascript">
function submitMainForm()
{
    var frm = document.main_form;
    
    if(frm.email.value == '')
    {
        alert('�� ������ e-mail.');
        frm.email.focus();
        return;
    }
    if(frm.text.value == '')
    {
        alert('�� ������ ����� ���������.');
        frm.text.focus();
        return;
    }
    frm.submit();
}
</script>



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
<!--��������� ��������--><td align="right"><img src="<%=des%>/<%=sectionImg%>/ttl.gif" height="47" alt="<%=sectionName%>" border="0"></td>
</tr>
</table>



<%---- ����������� ������� ������-----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
<tr>
	<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/feedback/ttl-feedback.gif" height="19" alt="�������� �����" border="0"></td>
	<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
</tr>
</table>
<%----//����������� ������� ������-----%>

<%  if(message != null)
    {
%>
<div align="center" class="smallFont" style="color: red; margin-top: 10pt; margin-bottom: 10pt;"><%=message%></div>
<%  } %>


<%---- ��������� -----%>
<table border="0" cellpadding="0" cellspacing="8" style="margin-top:38px;" width="180" align="right">
<tr>
<td valign="top" align="center" style="color:#D82E12;" class="smallFont"><b>!</b></td>
<td class="smallFont">
		���� ���������� 
		<SPAN class="str">*</SPAN>
		�������� ������������� ��� ����������
</td>
</tr>		
</table>
<%----//��������� -----%>


<table border="0" cellpadding="0" cellspacing="4" style="margin-top:4px;">

<tr>
<form action="/feedback/xt_feedback.jsp" name="main_form" method="post">
<input type="hidden" name="id" value="<%=pageId%>">
<td><div style="width:8;"><spacer type="block" height="1" width="8"></div></td>
<td class="defFont"><div style="width:125;"><spacer type="block" height="1" width="125"></div>���</td><td width="240"><input type="text" name="name" style="width:220;" size="28" maxlength="100"></td>
</tr>

<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<TR><td></td>
<TD class="defFont">E-mail<SPAN CLASS="str">*</SPAN></TD><TD><INPUT TYPE="text" name="email" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
</TR>

<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<TR><td></td>
<TD class="defFont">���� ����������<SPAN CLASS="str">*</SPAN></TD><TD>
<DIV class="SELnn">
<SELECT name="mailto" style="width:220;" width="220">
<OPTION value="��������">��������</option>
<OPTION value="���������� �����">���������� �����</option>
<OPTION value="������������ ���-���">������������ ���-���</option>
</SELECT></DIV>
</TD>
</TR>
<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<TR><td></td>
<TD class="defFont">���� ���������</TD><TD><INPUT TYPE="text" name="theme" STYLE="width:220;" SIZE="28" maxlength="100"></TD>
</TR>

<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<TR><td></td>
<TD  COLSPAN="2" class="defFont"><div STYLE="margin:3px 0px 0px 0px;">����� ���������<SPAN CLASS="str">*</SPAN></div><div class="SELnn"><TEXTAREA maxlength="1000" name="text" COLS="47" ROWS="5" STYLE="width:352;margin:3px 0px 0px 0px;" WRAP="ON"></TEXTAREA></div></TD>
</TR>	
<!-- divider --><tr><td height="6" colspan="3" background="<%=des%>/greyln.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<tr><td></td>
<td colspan="2"><a href="javascript: submitMainForm();"><img src="<%=des%>/feedback/btn-send.gif" height="18" alt="���������" border="0"></a></td>
</form></tr>	
</TABLE>
<%  }catch(Exception e){} %>