<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="oracle.sql.BLOB"%>

<%@ page import="tengry.northgas.*"%>



<% String pageId = "comp.tree"; %>
<%@ include file="/admin/inc/authorize.jsp"%>





<%--
	Страница "ручного" редактирования XML файла.
--%>
<%
	response.setHeader( "Pragma", "no-cache" );
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Редактирование</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">

</HEAD>

<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>

Редактирование
<BR>
<BR>

<FORM ACTION="xt_tree_edit.jsp" METHOD="post">

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD ALIGN="CENTER">
<B>XML файл контент</B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>
</TR>

<TR>

<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Содержание</B>
</TD>

</TR>

<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6 ALT="" BORDER="0"><BR>
<TEXTAREA NAME="content" ROWS=30 STYLE="width:600" COLS="43" WRAP="PHYSICAL">
<%
Connection conn = null;
PreparedStatement pst = null;
ResultSet rs = null;
try
{
	conn = WebApp.getConnection();
	pst = conn.prepareStatement( "SELECT DBMS_LOB.GETLENGTH(content) length, content FROM file_storage WHERE name=?" );
	pst.setString( 1, "xmltree" );
	
	rs = pst.executeQuery();

	BLOB blob = null;
	byte buf[] = null;
	int length = -1;

	if( rs.next() )
	{
		length = rs.getInt( "length" );
		blob = (BLOB) rs.getObject( "content" );
		
		buf = blob.getBytes( 1, length );
		
		out.println( WebUtil.toHTML( new String( buf, 0, buf.length, "Cp1251" )) );
	}

}
catch( Exception e )
{
	out.println( "Exception: " + e );
}
finally
{
	try
	{
		try { if (rs != null) rs.close(); } catch (Exception e){} finally { rs = null; }
		try { if (pst != null) pst.close(); } catch (Exception e){} finally { pst = null; }
		if( conn != null )	conn.close();
	}
	catch( Exception e ){}
}

%>
</TEXTAREA><BR>
		   		
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20 ALT="" BORDER="0"><BR>
</TD>

</TR>

<TR>
<TD ALIGN=CENTER><BR><BR>
<INPUT TYPE="Submit" VALUE="Изменить">
</TD>
</TR>

</TABLE>

</FORM>

</BODY>
</HTML>
