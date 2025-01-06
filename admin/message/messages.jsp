<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = tengry.northgas.mailer.Message.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat( "dd.MM.yyyy HH:mm" );
	Enumeration enum = Message.getMessages();

	String message = "";
	if("del".equals(request.getParameter("action_done")))
		message = "��������� ��������� ���� �������.";
	else if("save".equals(request.getParameter("action_done")))
		message = "��������� ���������.";
	else if("sender".equals(request.getParameter("action_done")))
		message = "����� ��������.";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="���������"/>
<jsp:param name="header" value="���������"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	

<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="700">
<TR>
	<TD CLASS="c2" HEIGHT="16" COLSPAN="4" ALIGN="center">
		<B>��������� (<A HREF="message.jsp">�������� ���������</A>)</B>
	</TD>
</TR>


<TR>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">&nbsp;����&nbsp;</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">&nbsp;������&nbsp;</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;���� ��������� &nbsp;</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">&nbsp;�������&nbsp;</TD>
</TR>
<FORM ACTION="xt_messages.jsp" METHOD="POST" NAME="FORM">
<%
	while( enum.hasMoreElements()){
		Message m = (Message)enum.nextElement();
%>
<INPUT TYPE="hidden" NAME="id" VALUE="<%=m.getId()%>">
<TR CLASS="c3">
	<TD ALIGN="center"><NOBR>&nbsp;<%= sdf.format( m.getSendDate()) %>&nbsp;</NOBR></TD>
	<TD ALIGN="center">&nbsp;<%=  m.isSent() ? "����������" : "�����"  %>&nbsp;</TD>
	<TD>&nbsp;<A HREF="message.jsp?id=<%=m.getId()%>"><%=m.getSubject()%></A>&nbsp;</TD>
	<TD ALIGN="center"><INPUT TYPE="checkbox" NAME="del" VALUE="<%=m.getId()%>"></TD>
</TR>
<%
	}
%>





<TR>
	<TD COLSPAN="4" ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Submit" VALUE="�������" ONCLICK="return confirm('������� ���������?');">
	</TD>
</TR>
</FORM>
</TABLE>

<BR>

<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="700">
<FORM ACTION="xt_messages.jsp" METHOD="POST" NAME="FORM">
<TR>
	<TD CLASS="c2" HEIGHT="16">&nbsp;<B>����� �����������</B></TD>
</TR>
<%
    Delivery delivery = null;
    enum = Delivery.getDeliveries(langCode);
    while(enum.hasMoreElements())
    {
        Delivery dlv = (Delivery)enum.nextElement();
        if("message".equals(dlv.getCode()))
        {
            delivery = dlv;
            break;
        }
    }
%>
<TR>
	<TD CLASS="c3" ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<INPUT TYPE="text" NAME="sender" VALUE="<%=delivery != null ? CMSApplication.toHTML(delivery.getSender()) : "" %>" STYLE="width:100%" SIZE="59"><BR>
	</TD>
</TR>
<TR>
	<TD COLSPAN="4" ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Submit" VALUE="����������" ONCLICK="return confirm('���������� �����?');">
	</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>

