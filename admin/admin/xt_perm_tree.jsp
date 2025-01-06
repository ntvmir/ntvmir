<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = "admin";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
// определим все полученные параметры
String mode = request.getParameter( "mode" );
String node	 = request.getParameter( "node" );
String redirect = "permissions.jsp?id=" + (request.getParameter("id") == null ? "" : request.getParameter("id"));
String error = "";

WebTreeNode webroot = CMSApplication.getApplication().getWebRoot(langCode);
WebTreeNode webpage = CMSApplication.getApplication().lookup(node);

if( mode != null && mode.equals( "expand" ) )
{
//
//	Распахивание узла
//
	if(Admin.isR( pageAccessCode ))
	{
		ArrayList exp = (ArrayList) session.getValue( "admin.tree.expanded.nodes" );
		if( exp == null )
		{
			exp = new ArrayList();
		}
		exp.add( node );
	
		session.putValue( "admin.tree.expanded.nodes", exp );
	}
}
else if(mode != null && mode.equals( "collaps" ) )
{
//
//	Схлопывание узла
//
	if(Admin.isR( pageAccessCode ))
	{
		ArrayList exp = (ArrayList) session.getValue( "admin.tree.expanded.nodes" );
		if( exp == null )
		{
			exp = new ArrayList();
		}
		else
		{
			exp.remove( exp.indexOf( node ) );
		}
		session.putValue( "admin.tree.expanded.nodes", exp );
	}
}



else if( mode != null && mode.equals( "expand_all" ) )
{
//
//	Расхлапывание всего дерева
//
	if(Admin.isR( pageAccessCode ))
	{
		ArrayList exp = new ArrayList();
		Enumeration enum = CMSApplication.getApplication().getAllNodeIds();
		while(enum.hasMoreElements())
		{
			exp.add((String)enum.nextElement());
		}
		session.putValue( "admin.tree.expanded.nodes", exp );
	}
}



else if( mode != null && mode.equals( "collaps_all" ) )
{
//
//	Схлапывание всего дерева
//
	if( Admin.isR( pageAccessCode ))
	{
		session.putValue( "admin.tree.expanded.nodes", new ArrayList());
	}
}

response.sendRedirect( redirect );
%>

