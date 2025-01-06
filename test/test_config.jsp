<%@ page language="Java" %>


<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="com.caucho.sql.DBPool" %>


<%
		String err = null;
		Exception exp = null;
		
  		String propsPath = null;
		Properties m_props = new Properties();
		DBPool m_dbpool = null;
		
		try
		{
			java.io.InputStream is = null;
			try
			{
				is = Thread.currentThread().getContextClassLoader().getResourceAsStream("cms.properties");
			    m_props.load( is );
			} finally {
				if (is != null) {
					try { is.close(); } catch (Exception e){}
				}
			}
		}
		catch( Exception e )
		{
  			err = "Error reading <B>cms.properties</B> file";
  			exp = e;
		}
 
		
 
		if( m_dbpool != null )
		{
			try
			{
				m_dbpool.close();
			}
			catch( Exception e ){}
		}
		
%>
	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//RU">
<HTML>
<HEAD>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
<META HTTP-EQUIV=Content-language CONTENT=RU>
<META NAME=description CONTENT="">
<META NAME=keywords CONTENT="">
<META NAME=autor CONTENT="">
<TITLE>Config files Test</TITLE>
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
<SPAN STYLE="color:red"><B>
Config files test passed. Config files are OK.
</B></SPAN>
<BR><IMG SRC="/img/eng/blank.gif" WIDTH=1 HEIGHT=35><BR>

<%	if( err != null )
		out.println( err );
	else
	{
%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="300">
<TR><TD COLSPAN="2" ALIGN="center"><B>cms.properties file</B></TD></TR>
<TR><TD COLSPAN="2" ALIGN="center"><IMG SCR="/img/eng/blank.gif" WIDTH="1" HEIGHT="5"><BR><HR WIDTH="100%"><BR><IMG SCR="/img/eng/blank.gif" WIDTH="1" HEIGHT="5"><BR></TD></TD>

<%		String [] props = {
			"upload.dir",
			"www.address",
			"driver.name",
			"connection.string",
			"connection.user",
			"connection.password",
			"isi.dir.upload",
			"isi.dir.image",
			"isi.fields",
			"mail.feedback",
			"mail.sender",
			"mail.smtp.host"
		};
		for( int i = 0; i < props.length; i++ )
		{
			String s = m_props.getProperty( props[i] );
			if( s == null || s.trim().length() == 0 ) 
				s = null;
%>
<TR><TD><%=props[i]%></TD><TD ALIGN="center"><%= s != null ? "Ok" : "Undefined"%></TD></TR>
<%		
		}
%>
</TABLE>
<%
	}
%>




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