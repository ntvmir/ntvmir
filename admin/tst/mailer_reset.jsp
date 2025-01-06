<%@ page language="Java" %>
<%@page import="java.io.*"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.zip.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tengry.cms.*"%>
<%@page import="tengry.cms.mailer.*"%>

<%@ page contentType="text/html; charset=windows-1251"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat( "dd.MM.yyyy HH:mm" );
	Enumeration enum = Message.getMessages();
	String id = request.getParameter("id");
	String dd = request.getParameter("dd");
	Date date = null;
	try{ date = sdf.parse(dd);}catch(Exception e){}
%>

<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="700">
<%
    enum = Delivery.getDeliveries("rus");
    while(enum.hasMoreElements())
    {
        Delivery dlv = (Delivery)enum.nextElement();
        if(dlv.getId().equals(id) && date != null)
        {
            dlv.setLastSendDate(date);
            dlv.save();
        }
%>
<TR>
<FORM METHOD="POST" NAME="FORM">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=dlv.getId()%>">
    <TD>
        <%=dlv.getName()%>
    </TD>
	<TD>
		<INPUT TYPE="text" NAME="dd" VALUE="<%=sdf.format(dlv.getLastSendDate())%>"><BR>
	</TD>
	<TD ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Submit" VALUE="Установить">
	</TD>
</FORM>
</TR>
<%  } %>
</TABLE>

