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
 
 
		if( exp == null )
		{
			try 
			{
				String driverName = m_props.getProperty( "driver.name", "oracle.jdbc.driver.OracleDriver" );
				String connString = m_props.getProperty( "connection.string", "" );
				String user	= m_props.getProperty( "connection.user", "" );
				String pwd 	= m_props.getProperty( "connection.password", "" );

				m_dbpool = new DBPool("ora-pool", connString, user, pwd,
					driverName, null //CMSApplication.class.getClassLoader()
					, 50);
			
				m_dbpool.setPingOnFree(true);

			}
			catch ( Exception e )
			{
				err = "Cannot create pool";
				exp = e;
			}
		}


		
		StringBuffer  tables = new StringBuffer("");
		if( exp == null )
		{
			Connection	conn = null;
			Statement	st = null;
			ResultSet	rs = null;
			
			
			try 
			{
				conn = m_dbpool.getConnection();
				st = conn.createStatement();
				rs = st.executeQuery( "select table_name from user_tables where table_name not like '%$%' order by table_name" );
			
				Vector names = new Vector();
				
				while( rs.next())
				{
					names.add( rs.getString( "table_name" ));
				}
				rs.close();
				rs = null;
				
				Enumeration enum = names.elements();
				while( enum.hasMoreElements())
				{
					int n = -1;
					String name = (String) enum.nextElement();
					name = name != null ? name.toLowerCase() : "";
					
					if( ! (name.startsWith("ent_") || name.startsWith("ext_") || name.startsWith("col_")))
						continue;
					rs = st.executeQuery( "select count(*) num from " + name );
					if( rs.next())
						n = rs.getInt( "num" );
					
					rs.close();
					rs = null;
					
					tables.append( "<TR><TD>&nbsp;&nbsp;&nbsp;" + name + "</TD><TD ALIGN=\"right\">" + n + "&nbsp;&nbsp;&nbsp;</TD>\n" );
				}
				
			}
			catch ( Exception e )
			{
				err = "Database access error";
				exp = e;
			}
			finally
			{
				try { if (rs != null) rs.close(); } catch (Exception e){} finally { rs = null; }
				try { if (st != null) st.close(); } catch (Exception e){} finally { st = null; }
				if( conn != null )	try{ conn.close(); conn = null; }catch( Exception e ){}
			
			}
		
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
<TITLE>Database Test</TITLE>
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
<%	if( err != null )
		out.println( err );
	else
		out.println( "Database access test passed. Database is OK. " );
%>
</B></SPAN>

<%	if( exp != null )
		out.println( exp.toString());
	else
	{
		if( tables != null )
		{
%>

<BR><IMG SRC="/img/eng/blank.gif" WIDTH=1 HEIGHT=35><BR>

<TABLE WIDTH="200" CELLPADDING="0" CELLSPACING="0" BORDER="0" ALIGN="center">
<TR><TD>&nbsp;&nbsp;&nbsp;Table name</TD><TD ALIGN="right">count(*)&nbsp;&nbsp;&nbsp;</TD></TR>
<TR><TD COLSPAN="2"><IMG SCR="/img/eng/blank.gif" WIDTH="1" HEIGHT="5"><BR><HR WIDTH="200"><BR><IMG SCR="/img/eng/blank.gif" WIDTH="1" HEIGHT="5"><BR></TD></TD>
<%=tables.toString()%>
</TABLE>
<%
		}
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