<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="oracle.sql.BLOB"%>

<%@ page import="tengry.northgas.*"%>



<% String pageId = "comp.tree"; %>
<%@ include file="/admin/inc/authorize.jsp"%>





<%
// определим все полученные параметры
String xml = request.getParameter( "content" );
if( xml == null )
{
	xml = "";
}

Connection conn = null;
PreparedStatement pst = null;
ResultSet rs = null;

try
{
	conn = WebApp.getConnection();
	conn.setAutoCommit( false );
	
	pst = conn.prepareStatement( "UPDATE file_storage SET content=empty_blob() WHERE name=?" );
	pst.setString( 1, "xmltree" );
	
	pst.executeUpdate();

	try { if (pst != null) pst.close(); } catch (Exception e){} finally { pst = null; }
	
	pst = conn.prepareStatement( "SELECT content FROM file_storage WHERE name=? FOR UPDATE" );
	pst.setString( 1, "xmltree" );
	
	rs = pst.executeQuery();
	
	if( rs.next() )
	{
		BLOB blob = (BLOB) rs.getObject( "content" );
		if( blob != null )
		{
			OutputStreamWriter os = new OutputStreamWriter( blob.getBinaryOutputStream(), "Cp1251" );
			xml = xml.trim();
			os.write( xml.toCharArray(), 0, xml.length() );
			os.close();
		}
	}
	
	conn.commit();
	
	WebApp.getApp().loadTree();
	
}
catch( SQLException e )
{
	out.println( "Exception: " + e );
}
catch( WebException we1 )
{
	out.println( "Exception: " + we1 + we1.getOriginal().getMessage() );
}
catch( Exception e1 )
{
	out.println( "Exception: " + e1 );
}
finally
{
	try
	{
		conn.setAutoCommit( true );
		try { if (rs != null) rs.close(); } catch (Exception e){} finally { rs = null; }
		try { if (pst != null) pst.close(); } catch (Exception e){} finally { pst = null; }
		if( conn != null )	conn.close();
	}
	catch( Exception e )
	{}
}

response.sendRedirect( "tree_edit.jsp" );
%>

