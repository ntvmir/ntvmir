<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Message.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	
	String id = request.getParameter( "id" );
	if("".equals(id))
		id = null;
	if( id != null && ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "messages.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	Message m = new Message();
	try
	{
	    if( id != null )
	    	m.load(id);
	}
	catch( Exception e )
	{
		out.println( e);
	}
    Date date = m.getSendDate();
    boolean shortDate = false;
    if ( id == null  )
    {
    	// ����� ���������, ������� ����, �������� �����
    	shortDate = true; 
    }
    else if ( date == null )
    {
    	// ��� ������� � �������, ������� ����, �������� �����
    	shortDate = true; 
    }
    /*else if ( date.getHours() == 0 && date.getMinutes() == 0 && date.getSeconds() == 0 )
    {
    	// ���� ����������� �� ���, �������� �����
	    //out.println("date.getHours() : " + date.getHours() + " date.getMinutes() : " + date.getMinutes() + " date.getSeconds() : " + date.getSeconds());
    	shortDate = true; //out.println(date.getTime() % 24*60*60*1000);}
    }*/
	SimpleDateFormat sdfDate = new SimpleDateFormat( "dd.MM.yyyy" );
	SimpleDateFormat sdfDateAndTime = new SimpleDateFormat( "dd.MM.yyyy HH:mm" );
    SimpleDateFormat sdf = shortDate ? sdfDate : sdfDateAndTime;
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="��������� ��� ��������"/>
<jsp:param name="header" value="��������� ��� ��������"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	

<SCRIPT LANGUAGE="JavaScript">
<%@ include file="/admin/inc/functions.js"%>

function checkForm( form ){
	if( ! isDateAndShortTimeOrSpace( form.send_date.value )){
		alert( '�������� ������ ����.' );
		form.send_date.focus();
		return false;
	}
	if( form.subject.value == '')
	{
		alert( '���� "���� ���������" ������ ���� ���������.' );
		form.subject.focus();
		return false;
	}
	if( form.content.value == '')
	{
		alert( '���� "����������" ������ ���� ���������.' );
		form.content.focus();
		return false;
	}
	return true;
}
</SCRIPT>

<A HREF="messages.jsp">�����</A>
<FORM NAME="form" ACTION="xt_message.jsp" METHOD="post" ONSUBMIT="if ( !checkForm( document.form ) ) return false;">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=m.getId() != null ? m.getId() : ""%>">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
<TR>
	<TD CLASS="c2" HEIGHT="16">&nbsp;<B>���� ��������</B></TD>
</TR>

<TR>
	<TD CLASS="c3" ALIGN="left">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<INPUT TYPE="text" NAME="send_date"" VALUE="<%=sdf.format( m.getSendDate() != null ? m.getSendDate() : new Date())%>" SIZE="59">
        �������� 31.01.2000 23:55
        <BR>
		���� ����� �� �����������, �� ��� ������� ���� ������� ������� �����, 
        � ��� ����������� ��� ������� 00:00
	</TD>
</TR>
<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
	<TD CLASS="c2" HEIGHT="16">&nbsp;<B>���� ��������� </B></TD>
</TR>

<TR>
	<TD CLASS="c3" ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<INPUT TYPE="text" NAME="subject" VALUE="<%=CMSApplication.toHTML( m.getSubject())%>" STYLE="width:100%" SIZE="59"><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
	</TD>
</TR>

<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>����������</B></TD>
</TR>
<TR>
	<TD CLASS="c3" ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<TEXTAREA NAME="content" ROWS=15 STYLE="width:100%" COLS="58" WRAP="PHYSICAL"><%=CMSApplication.toHTML( m.getContent())%></TEXTAREA><BR>
	</TD>
</TR>

<!-- ����� ������� --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
	<TD ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%= m.isVisible() ? "CHECKED" : ""%> ID="cbk"><LABEL FOR="cbk">��������� ���������</LABEL>
	</TD>
</TR>	
<TR>
<TD ALIGN="center">
	<INPUT TYPE="Submit" VALUE="��������� ���������" ONCLICK="return confirm('��������� ���������?');">
</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
