<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = Term.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
int CAN_T_DEL1 = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_DEL2 = CMSApplication.PAGE_ERROR_WHILE_REMOVING;

String href = "requests.jsp?";

String []del = request.getParameterValues( "del" );
if( del	== null ) 
	del = new String[0];


if( del.length > 0 )
{
	if( ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( href + "&err=" + CAN_T_DEL1 );
		return;
	}
	try
	{
		for( int i = 0; i < del.length; i++ )
		{
			TermRequest term = new TermRequest();
			term.load(del[i]);
			Journal rec = Journal.newRecord( currentAdmin, term, pageId, Journal.ACTION_DELETE, "" );
			term.remove();
			try{ rec.save(); }catch( Exception ee ){}
		}
	}
	catch( Exception e )
	{
		href += "&err=" + CAN_T_DEL2;
	}
	response.sendRedirect(href + "&action_done=del");
	return;
}
response.sendRedirect( href );
%>