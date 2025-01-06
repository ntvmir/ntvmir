<%@ page language="Java" %>


<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="com.caucho.sql.DBPool" %>
<%@ page import="tengry.cms.*" %>


<%
	DBPool pool = CMSApplication.getDBPool();
%>
	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//RU">
<HTML>
<HEAD>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
<META HTTP-EQUIV=Content-language CONTENT=RU>
<META NAME=description CONTENT="">
<META NAME=keywords CONTENT="">
<META NAME=autor CONTENT="">
<TITLE>DBPool Test</TITLE>
<LINK REL="STYLESHEET" TYPE="text/css" HREF="/inc/css.css">
<BODY BGCOLOR="#FFFFFF" LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<CENTER>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD WIDTH="1" VALIGN="top">
</TD>
<TD WIDTH="57" VALIGN="top">
<IMG SRC="/img/eng/blank.gif" WIDTH=57 HEIGHT=1><BR>
</TD>
<TD WIDTH="673"><BR>

<IMG SRC="/img/eng/blank.gif" WIDTH=1 HEIGHT=35><BR>

<A HREF="javascript:history.back();" CLASS="tn"><B>Назад</B></A><BR>
<CENTER>
<SPAN STYLE="color:red;"><B>
<%	if( pool == null )
		out.println( "Database pool is null" );
	else {
		out.println( "Database pool is OK." );
	}
%>
</B></SPAN>

<TABLE ALIGN="center">
<%
	if( pool != null ) { %>
<TR><TD>getActiveConnections() </TD><TD>=</TD><TD><%=pool.getActiveConnections()%></TD></TR>
<TR><TD>getConnectionWaitTime() </TD><TD>=</TD><TD><%=pool.getConnectionWaitTime()%></TD></TR>
<TR><TD>getDriverName() </TD><TD>=</TD><TD><%=pool.getDriverName()%></TD></TR>
<TR><TD>getEnableTransaction() </TD><TD>=</TD><TD><%=pool.getEnableTransaction()%></TD></TR>
<TR><TD>getLoginTimeout() </TD><TD>=</TD><TD><%=pool.getLoginTimeout()%></TD></TR>
<TR><TD>getMaxConnections() </TD><TD>=</TD><TD><%=pool.getMaxConnections()%></TD></TR>
<TR><TD>getMaxIdleTime() </TD><TD>=</TD><TD><%=pool.getMaxIdleTime()%></TD></TR>
<TR><TD>getPingOnFree() </TD><TD>=</TD><TD><%=pool.getPingOnFree()%></TD></TR>
<TR><TD>getPingOnReuse() </TD><TD>=</TD><TD><%=pool.getPingOnReuse()%></TD></TR>
<TR><TD>getPingTable() </TD><TD>=</TD><TD><%=pool.getPingTable()%></TD></TR>
<TR><TD>getTotalConnections() </TD><TD>=</TD><TD><%=pool.getTotalConnections()%></TD></TR>
<TR><TD>logWriter() </TD><TD>=</TD><TD><%=pool.getLogWriter()%></TD></TR>
<%	}
%>
</TABLE>


<BR><IMG SRC="/img/eng/blank.gif" WIDTH=1 HEIGHT=35><BR>
</CENTER>
</TD>
<TD WIDTH="57" VALIGN="top">
<IMG SRC="/img/eng/blank.gif" WIDTH=57 HEIGHT=1><BR>
</TD></TR>
</TABLE>
</CENTER>
</BODY>
</HTML>