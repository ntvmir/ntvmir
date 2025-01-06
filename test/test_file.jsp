<%@ page language="Java" %>


<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>


<%
		String err = null;
		Exception exp = null;
		
  		String propsPath = null;
		Properties m_props = new Properties();
		
		try
		{
			java.io.InputStream is = null;
			try
			{
				propsPath = System.getProperty("cms.properties");
				is = Thread.currentThread().getContextClassLoader().getResourceAsStream(propsPath);
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
		
		String uploadDir = null;
		
		uploadDir = m_props.getProperty( "upload.dir" );
		
		String uploadErr	= null;
		String uploadOwner	= null;
		String uploadAccess	= null;
		String nobody = "";
		if( err == null )
		{
			if( uploadDir != null && uploadDir.length() > 0 )
			{
				try{
					Process p1 = Runtime.getRuntime().exec( "id -un" );
					BufferedReader in1 = new BufferedReader(new InputStreamReader( p1.getInputStream()));
					nobody = in1.readLine();
					if( nobody == null)
						nobody = "nobody";
					else
						nobody = nobody.trim();
					
					Process p = Runtime.getRuntime().exec( "ls -ld " + uploadDir );
					BufferedReader in = new BufferedReader(new InputStreamReader( p.getInputStream()));
					String s = in.readLine();
					if( s != null && s.length() > ("-rwxr-xr-x    1 " + nobody).length())
					{
						uploadOwner = s.substring(16);
						int ppp = uploadOwner.indexOf(" ");
						if(ppp > 0)
							uploadOwner = uploadOwner.substring(0, ppp);
						uploadAccess = s.substring( 1, 3 );
					}
					else
						uploadErr = "Error access to upload directory";
				}
				catch( Exception e )
				{
					uploadErr = "Error access to upload directory";
				}			
			}
			else uploadDir = null;
			
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
<TITLE>File Test</TITLE>
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
File access test passed.
<%	if( err != null )
		out.println( err );
	else if( !uploadOwner.equals(nobody) || ! uploadAccess.equals( "rw" ))
		out.println( "Something wrong. " );
	else
		out.println( "File access is OK. " );
%>	
</B></SPAN>
<BR><IMG SRC="/img/eng/blank.gif" WIDTH=1 HEIGHT=35><BR>



<%
	if( exp != null )
		out.println( exp );
	else
	{
%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR><TD COLSPAN="2"><IMG SRC="/img/eng/blank.gif" WIDTH="1" HEIGHT="10"><BR></TD></TD>
<TR><TD COLSPAN="2"><B>upload directory</B></TD></TR>
<TR><TD COLSPAN="2"><IMG SRC="/img/eng/blank.gif" WIDTH="1" HEIGHT="5"><BR><HR WIDTH="100%"><BR><IMG SRC="/img/eng/blank.gif" WIDTH="1" HEIGHT="5"><BR></TD></TD>
<%	if( uploadErr != null )
	{
%>
<TR><TD COLSPAN="2"><%=uploadErr%></TD></TR>
<%	}else{ %>
<TR><TD>path:</TD>
<TD>
&nbsp;&nbsp;&nbsp;<%=uploadDir != null ? uploadDir : "upload directory path property doesn't defined"%></TD></TR>
<TR><TD>Owner:</TD><TD>
<%		if( uploadOwner.equals(nobody)){ %>
&nbsp;&nbsp;&nbsp;nobody&nbsp;&nbsp;&nbsp;Ok</TD>
<%		}else{ %>
&nbsp;&nbsp;&nbsp;<%=uploadOwner%>&nbsp;&nbsp;&nbsp;must be - <%=nobody%></TD>
<%		} %>
</TD></TR>
<TR><TD>Permissions:</TD><TD>
<%		if( uploadAccess.equals( "rw" )){ %>
&nbsp;&nbsp;&nbsp;Read and Write&nbsp;&nbsp;&nbsp;Ok
<%		}else{ %>
&nbsp;&nbsp;&nbsp;must have access to Read and Write for owner
<%		} %>
</TD></TR>
<%	} %>

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