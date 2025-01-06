<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = TenderRequest.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
String node = request.getParameter( "page_id" );
String mode = request.getParameter( "mode" );
String href = null;

if( mode != null && mode.equals( "del" ) )
{
	int nodeAccessCode = currentAdmin.getAccessCode(node);
	if(!currentAdmin.isC(node))
	{
		response.sendRedirect("request_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}
	try
	{
		String [] requestsCol = request .getParameterValues("requests");
		if ( requestsCol != null )
		{
			for (int i=0; i < requestsCol.length ;i++)
			{
				TenderRequest tenderRequest	= new TenderRequest();
				tenderRequest.load(requestsCol[i]);
				Journal rec = Journal.newRecord( currentAdmin, tenderRequest, pageId, Journal.ACTION_DELETE, "" );
				tenderRequest.remove();
				try{ rec.save(); }catch( Exception e ){}
			}
		}
		href =  "request_list.jsp?page_id=" + node + "&action_done=1";
	}catch(Exception e)
	{
		response.sendRedirect( "request_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
		return;
	}
}
response.sendRedirect( href );
%>

