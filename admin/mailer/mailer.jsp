<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = MailerTask.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
CMSApplication APP = CMSApplication.getApplication();

Vector error = new Vector();

String message = "";
String action = request.getParameter("action");
if("action_stopMail".equals(action))
	message = "���������� ����������";
else if("action_startMail".equals(action))
	message = "���������� �������";
else if("action_editTextField".equals(action))
	message = "��������� ��������� ���������";
else if("action_set_times".equals(action))
	message = "��������� ��������� ���������. ���������� �����������.";



int sleepTime = 0;
try{ sleepTime = Integer.parseInt(APP.getStoredProperty(MailerTask.MAIL_INTERVAL_PROP)); }catch(Exception e){}
sleepTime /= (60*60*1000);
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="�������������� ���������� ��������"/>
<jsp:param name="header" value="�������������� ���������� ��������"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript" SRC="/admin/inc/functions.js">
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function checkFormEditTime( form ){
	if ( !(1 <= form.sleepTime.value && form.sleepTime.value <= 24) ) {
    	alert( '������������ �������� ������� ��������.' );
		form.sleepTime.focus();
		return false;
	}

    for(var l = 1; l < 10; l++)
    {
        var mmm = document.getElementById('dlv_time_' + l);
        if(mmm == null)
            break;
        if(! isShortTime(mmm.value))
        {
            alert('������� ����� � ������� HH:MM');
            mmm.focus();
            return false;
        }
	}
    
    return true;
}
</SCRIPT>



<TABLE WIDTH="700" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<FORM NAME="EditTime" METHOD="post"  ACTION="xt_mailer.jsp" ONSUBMIT="if ( !checkFormEditTime( document.EditTime ) ) return false;">
<TR ALIGN="center">
<TD CLASS="c2" HEIGHT="20" COLSPAN=2>
<DIV STYLE="padding-left:6px;padding-right:6px;">�������������� ��������� ���������� ��������</DIV>
</TD>
</TR>
<%	if (MailerTask.isMailRuning()) { %>
<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN=2>
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><FONT COLOR="Red">��������� ��������� ���������� ������������ ��������.</FONT></DIV>
</TD>
</TR>
<%	} %>
<%
    Enumeration enum = Delivery.getDeliveries(langCode);
    int l = 0;
    while(enum.hasMoreElements())
    {
        l++;
        Delivery dlv = (Delivery)enum.nextElement();
        if("message".equals(dlv.getCode()))
            continue;
        String sDay = "Mon";
        if(dlv.getStartTime() != null && dlv.getStartTime().length() > "Mon-".length())
            sDay = dlv.getStartTime().substring(0, 3);
        String sTime = dlv.getStartTime();
        if(dlv.getFrequency() == Delivery.WEEKLY && dlv.getStartTime() != null && dlv.getStartTime().length() > "Mon-".length())
            sTime = dlv.getStartTime().substring(4);
%>
    
    
<TR>
<INPUT TYPE="hidden" NAME="delivery_id" VALUE="<%=dlv.getId()%>">
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;"><%=dlv.getName()%>: <%=dlv.getFrequency() == Delivery.DAILY ? "�����" : "����� � ����"%> ��������</DIV>
</TD>
<TD CLASS="c3" valign="top">
<NOBR>
<INPUT TYPE="text" NAME="dlv_time" ID="dlv_time_<%=l%>" SIZE=5 VALUE="<%=sTime%>">
<%      if(dlv.getFrequency() == Delivery.WEEKLY)
        {
%>
<SELECT NAME="dlv_day">
<OPTION VALUE="Mon" <%= "Mon".equals(sDay) ? " SELECTED" : ""%> >�����������
<OPTION VALUE="Tue" <%= "Tue".equals(sDay) ? " SELECTED" : ""%> >�������
<OPTION VALUE="Wed" <%= "Wed".equals(sDay) ? " SELECTED" : ""%> >�����
<OPTION VALUE="Thu" <%= "Thu".equals(sDay) ? " SELECTED" : ""%> >�������
<OPTION VALUE="Fri" <%= "Fri".equals(sDay) ? " SELECTED" : ""%> >�������
<OPTION VALUE="Sat" <%= "Sat".equals(sDay) ? " SELECTED" : ""%> >�������
<OPTION VALUE="Sun" <%= "Sun".equals(sDay) ? " SELECTED" : ""%> >�����������
</SELECT>
<%      }
        else
        {
%>
<INPUT TYPE="hidden" NAME="dlv_day" VALUE="">
<%      } %>
</NOBR>
</TD>
</TR>
<%  } %>

<TR>
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">����� �������� ������� �������� [����] (�� ������ 24)</DIV>
</TD>
<TD CLASS="c3">
<INPUT TYPE=EDIT NAME="sleepTime" SIZE=5 VALUE="<%=sleepTime%>">
</TD>
</TR>

<TR ALIGN="center">
<TD CLASS="c3" COLSPAN="2">
<INPUT TYPE="submit" NAME="action_set_times" VALUE="��������">
</TD>
</TR>
</FORM>
</TABLE>





<BR><BR>







<TABLE WIDTH="700" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<FORM METHOD="post" ACTION="xt_mailer.jsp">
<TR ALIGN="center">
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;">���������� ���������</DIV>
</TD>
</TR>
</TABLE>

<TABLE WIDTH="700" BORDER="0" CELLPADDING="0" CELLSPACING="1">

<TR>
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">������: </DIV>
</TD>
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
<%=MailerTask.isMailRuning() ? "�������� ��������������" : "�������� �� ��������"%>
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c3" HEIGHT="20" VALIGN="top">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
���������� ���������
</TD>
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
�����������: <%=APP.getStoredProperty(MailerTask.MAIL_LAST_START_PROP)%><BR>
<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm");
    enum = Delivery.getDeliveries(langCode);
    while(enum.hasMoreElements())
    {
        Delivery dlv = (Delivery)enum.nextElement();
%>
�������� "<%=dlv.getName()%>":  <%=dlv.getLastSendDate() == null ? "�� ��������������" : sdf.format(dlv.getLastSendDate())%><BR>
<%  } %>
</DIV>
</TD>
</TR>
</TABLE>

<TABLE WIDTH="700" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<TR ALIGN="center">
<%  if ( MailerTask.isMailRuning() ) { %>
<TD CLASS="c3">
<INPUT TYPE="submit" NAME="action_stopMail"  VALUE="����������">
</TD>
<%	} else { %>
<TD CLASS="c3" COLSPAN="2">
<INPUT TYPE="submit" NAME="action_startMail" VALUE="���������">
</TD>
<%	} %>
</TR>
</FORM>
</TABLE>


<!-- ��������� ���� -->
<BR>
<BR>

<%
	String readOnlyIsRunning = "";
	if ( MailerTask.isMailRuning() )
    	readOnlyIsRunning = " READONLY ";
%>

<FORM METHOD="post" ACTION="xt_mailer.jsp">
<TABLE WIDTH="700" BORDER="0" CELLPADDING="0" CELLSPACING="1">

<TR ALIGN="center">
<TD CLASS="c2" HEIGHT="20" COLSPAN=2>
<DIV STYLE="padding-left:6px;padding-right:6px;">�������������� ��������� ����� ������������ ��� ������������ �����:</DIV>
</TD>
</TR>

<%	if ( MailerTask.isMailRuning() ) { %>
<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><FONT COLOR="Red">�� ��������� ������ ��������� ��������� ����� �������� ������ ��� ����������� ��������.</FONT></DIV>
</TD>
</TR>
<%	} %>















<%
    enum = Delivery.getDeliveries(langCode);
    while(enum.hasMoreElements())
    {
        Delivery dlv = (Delivery)enum.nextElement();
        if("message".equals(dlv.getCode()))
            continue;
        LetterFields fields = new LetterFields();
        try
        {
            fields.load(dlv.getId());
        }catch(Exception e){}
%>
<TR ALIGN="center">
<TD HEIGHT="5" COLSPAN=2></TD>
</TR>

<TR ALIGN="center">
<INPUT TYPE="hidden" NAME="delivery_id" VALUE="<%=dlv.getId()%>">
<TD CLASS="c2" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;"><B><%=dlv.getName()%></B></DIV>
</TD>
</TR>

<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;">����� �����������</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<INPUT <%=readOnlyIsRunning%> TYPE=text NAME="letter_sender" style="width: 100%;" VALUE="<%=CMSApplication.toHTML(dlv.getSender())%>">
</TD>
</TR>


<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;">����</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<INPUT <%=readOnlyIsRunning%> TYPE=text NAME="letter_subject" style="width: 100%;" VALUE="<%=CMSApplication.toHTML(fields.getSubject())%>">
</TD>
</TR>


<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;">������ ������</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<TEXTAREA <%=readOnlyIsRunning%> NAME="letter_header" ROWS=3 STYLE="width:700" COLS="43" WRAP="PHYSICAL"><%=CMSApplication.toHTML(fields.getHeader())%></TEXTAREA>
</TD>
</TR>

<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;">��������� ������</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<TEXTAREA <%=readOnlyIsRunning%> NAME="letter_footer" ROWS=3 STYLE="width:700" COLS="43" WRAP="PHYSICAL"><%=CMSApplication.toHTML(fields.getFooter())%></TEXTAREA>
</TD>
</TR>

<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;">�����������</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<TEXTAREA <%=readOnlyIsRunning%> NAME="letter_separator" ROWS=3 STYLE="width:700" COLS="43" WRAP="PHYSICAL"><%=CMSApplication.toHTML(fields.getSeparator())%></TEXTAREA>
</TD>
</TR>

<%  } %>













<TR ALIGN="center">
<TD CLASS="c2" HEIGHT="20" COLSPAN=2>
<DIV STYLE="padding-left:6px;padding-right:6px;">�������������� ��������� :</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
��������� �������� ������ (SMTP) 
</DIV>
</TD>
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
<%=CMSApplication.toHTML( CMSApplication.getApplication().getProperty( "mail.smtp.host" ) )%>
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
�������� ����� ����������� �����
</DIV>
</TD>
<TD CLASS="c3" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
<%=CMSApplication.toHTML( CMSApplication.getApplication().getProperty( "mail.sender" ) )%>
</DIV>
</TD>
</TR>












<%	if ( MailerTask.isMailRuning() ) { %>
<TR>
<TD CLASS="c3" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><FONT COLOR="Red">�� ��������� ������ ��������� ��������� ����� �������� ������ ��� ����������� ��������.</FONT></DIV>
</TD>
</TR>
<%	} else { %>
<TR ALIGN="center">
<TD CLASS="c3" COLSPAN=2>
<INPUT TYPE="submit" NAME="action_editTextField" VALUE="��������">
</TD>
</TR>
<%//=(MailerTask.isMailRuning() ? "button" : "submit")%>
<%	} %>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
    