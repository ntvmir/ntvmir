<%
        String message = null;
        if("auth".equals(request.getParameter("err")))
            message = "�������� �����/������";
        else if("1".equals(request.getParameter("reg_ok")))
            message = "����������� ������ �������. �� ��� e-mail ���������� ������ � ������� � �������.";

%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
<TR VALIGN="top">
<TD WIDTH="55%" class="defFont">

<!---- ����������� ������������������ ----->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/authorization/ttl-reg.gif" height="19" alt="������������������ ������������" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<!----//����������� ������������������ ----->
<div style="width:100%;padding:10px 0px 0px 16px;">
<P>
��� ������� � ��������� ���������� ������� ���������������� ����� �����, ���������� �������� �����������:
</P>
<%  if(message != null)
    {
%>
<div align="left" style="color: red; margin-bottom: 10pt;"><%=message%></div>
<%  } %>


<!---- LOGIN FORMZ -----><TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<FORM ACTION="/user/xt_auth.jsp" method="post">
<input type="hidden" name="id" value="<%=pageId%>">
<input type="hidden" name="action" value="login">
<input type="hidden" name="back_page_id" value="<%=backPageId != null ? backPageId : ""%>">
<TD class="defFont" WIDTH="70">�����:</TD><TD><INPUT TYPE="text" name="login" STYLE="width:85;" SIZE="11"></TD>
</TR>
<tr><td height="7"></td></tr>
<TR>
<TD class="defFont">������:</TD><TD><INPUT TYPE="password" name="password" STYLE="width:85;" SIZE="11"><input type="Image"src="<%=des%>/forum/btn-entr.gif" width="43" height="18" border="0" hspace="10" alt="����" align="absbottom"></TD>
</FORM>
</TR>
</TABLE><!----//LOGIN FORMZ----->
<BR>
<BR>
</div>
<!---- ����������� ������ ������? ----->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/authorization/ttl-psw.gif" height="19" alt="������ ������?" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<!----//����������� ������ ������? ----->
<div style="width:100%;padding:10px 0px 0px 16px;">
<P>
�������������� �������� �������������� ������������� ������������������� ������������ �� e-mail � ������� ������ ������ �� ������� e-mail
</P>
<!---- EMAIL FORMZ ----->
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
	<form action="/user/xt_auth.jsp">
	<input type="hidden" name="id" value="<%=pageId%>">
	<input type="hidden" name="action" value="send_pass">
	<td class="defFont">E-mail:</td>
	</tr>
	<tr>
	<tr><td><input type="text" name="email" style="width:155;" size="11"><input type="Image"src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="10" align="absmiddle"></td>
	
	</form>
	</tr>
	</table>
<!----//EMAIL FORMZ----->
</div>
</TD>
<TD><div style="width:15"><SPACER TYPE="block" WIDTH="15"></div></TD>
<TD BGCOLOR="#DDE6F0"><div style="width:1"><SPACER TYPE="block" WIDTH="1"></div></TD>
<TD><div style="width:15"><SPACER TYPE="block" WIDTH="15"></div></TD>
<TD WIDTH="45%" class="defFont">

<!---- ����������� �����----->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/authorization/ttl-new.gif" height="19" alt="����� ������������" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<!----//����������� ����� ----->
<div style="width:100%;padding:10px 0px 0px 16px;">
���� �� �� ���������������� � ������� ��� ������� � ��������� ���������� ������� ���������������� ����� �����, ���������� ��������� <A HREF="/pages/<%=langCode%>/auth?create=1">���������������&nbsp;�����</A> ������ ������������.</P>
</div>
</TD>
</TR>
</TABLE>
<!----// CONTENT ----->
