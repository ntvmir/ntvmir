<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%@ page import="java.util.*" %>

<%@ include file="components.jsp"%>

<%!
	boolean  isR( int code )
	{
		return (code & tengry.northgas.Admin.ACCESS_READ) > 0;
	}
%>

<%
tengry.northgas.Admin admin = (tengry.northgas.Admin)session.getValue( "admin.user" );
if( admin != null )
{
%>

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="0">
<TR>
<TD CLASS="c2" ALIGN="center">
<SPAN CLASS="tit">
Норильский никель - административная часть
</SPAN>
</TD>
<TD CLASS="c2" WIDTH="1%">
&nbsp;администратор:&nbsp;<B><%=admin.getLogin()%></B>&nbsp;
</TD>
</TR>
</TABLE>

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<%

	java.util.Enumeration enum = getComponentIds();

	Vector v = new Vector();
	int l = 0;
	StringBuffer sb = new StringBuffer( "" );
	
	while( enum.hasMoreElements())
	{
		l++;
		String cid = (String) enum.nextElement();
		if( "SEPARATOR".equals( cid ))
		{
			v.add( sb.toString());
			sb = new StringBuffer( "" );
		}
		else
		{
			if( isR( admin.getAccessCode( cid )))
				sb.append( "<A HREF=\"" + ( getComponentURL( cid )) + "\">" +  getComponentName( cid ) + "</A><BR>\n" );
			else
				sb.append( "<B STYLE=\"color: #888888;\">" + getComponentName( cid ) + "</B><BR>\n" );
		}
	}
	
	if( sb.length() > 0 ) 
		v.add( sb.toString());
	
	String WIDTH = " WIDTH=\"" + (100/v.size()) + "%\" ";
	enum = v.elements();
	out.println( "<TR>\n" );
	while( enum.hasMoreElements())
	{
		out.println( "<TD " + WIDTH + " VALIGN=\"top\">" );
		out.println( (String)enum.nextElement());
		out.println( "</TD>" );
	}
	out.println( "</TR>\n" );
%>
<TR>
<TD COLSPAN="<%=v.size()%>" ALIGN="right">
<A HREF="/admin/xt_logout.jsp">Выход</A>
</TD>
</TR>
</TABLE>
<%
}
%>

<BR>
<BR>



