<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Release.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
String node = request.getParameter( "page_id" );
String mode = request.getParameter( "mode" );
String href = "releases.jsp";

if( mode != null && mode.equals( "del" ) )
{
	int nodeAccessCode = currentAdmin.getAccessCode(node);
	if(!currentAdmin.isC(node))
	{
		response.sendRedirect("release_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
	}
	try
	{
		String [] releaseCol = request .getParameterValues("releases");
		if ( releaseCol != null )
		{
			for (int i=0; i < releaseCol.length ;i++)
			{
				Release release	= new Release(DBObject.LOAD_LIST);
				release.load(releaseCol[i]);
				if((release.isVisible()) && ! Admin.isP( nodeAccessCode ))
				{
					response.sendRedirect( "release_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
//					clearFrontEntries();
					return;
				}
				
				Journal rec = Journal.newRecord( currentAdmin, release, pageId, Journal.ACTION_DELETE, "" );
				release.remove();
				try{ rec.save(); }catch( Exception e ){}
			}
//			clearFrontEntries();
		}
		href	=  "release_list.jsp?action_done=del&page_id=" + node;
	}catch(Exception e)
	{
		response.sendRedirect( "release_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
		return;
	}
}



else if("set_num".equals(mode))
{
	int n = -1;
	try{ n = Integer.parseInt(request .getParameter("press_num")); }catch(Exception e){}
	if(n > 0)
		Release.setPagePressAmount(n);
	href = "releases.jsp";
}

response.sendRedirect( href );
%>

