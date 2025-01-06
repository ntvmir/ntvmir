<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = "admin";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
int CANT_DEL1 = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CANT_DEL2 = CMSApplication.PAGE_ERROR_WHILE_REMOVING;

if( ! Admin.isC(pageAccessCode))
{
	response.sendRedirect( "admins.jsp?err=" + CANT_DEL1 );
	return;
}

String [] del = request.getParameterValues( "del" );
try
{
	if( del != null )
	{
		for( int i = 0; i < del.length; i++ )
		{
			Admin admin = new Admin();
			admin.load(del[i]);
			if(!Admin.ROOT_NAME.equals(admin.getLogin()))
			{
				Journal rec = Journal.newRecord( currentAdmin, admin, pageId, Journal.ACTION_DELETE, "" );
				
				admin.remove();
				try{ rec.save(); }catch( Exception e ){}
			}
		}
	}
}
catch( Exception e )
{
	response.sendRedirect( "admins.jsp?err=" + CANT_DEL2 );
	return;
}
response.sendRedirect( "admins.jsp" );
%>