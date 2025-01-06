<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Release.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String node = request.getParameter( "page_id" );
	String id = request.getParameter( "id" );

	int pageAccess = currentAdmin.getAccessCode( node );
	String mode = null;
	if(id == null || id.length() == 0)
		mode = "add";
	else
		mode = "edit";
	
	boolean visible = "1".equals(request .getParameter("visible"));
	String caption = request.getParameter("caption");
	String brief = request.getParameter("brief");
	String content = request.getParameter("content");
	String recordDate = request.getParameter("recorddate");
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy"); 

	String redirect = null;
if(mode != null && mode.equals("add"))
{
	Release release = new Release();
	try
	{
		if( !Admin.isC(pageAccessCode) || (visible && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "releases.jsp?&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		boolean modified = true;
		boolean changePubl = false;
		
		
		release.setWebPageId(node);
		release.setRecordDate( sdf.parse( recordDate ) );

		release.setCaption( caption );
		release.setBrief( brief );
		release.setContent( content );
		release.setVisible( visible );

		release.save();

		try{ Journal.newRecord( currentAdmin, release, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		if(visible)
			try{ Journal.newRecord( currentAdmin, release, pageId, Journal.ACTION_PUBLIC, "публикация на сайте").save(); 
			}catch( Exception e ){}

		// invalidate cached values
//		clearFrontEntries();
		
		redirect	= "release_list.jsp?action_done=add&page_id=" + node;
	}catch(Exception e)
	{
		release.remove();
		response.sendRedirect( "release_list.jsp?page_id=" + node + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if( mode != null && mode.equals( "edit" ) )
{
	Release release = new Release();
	try
	{
		release.load(id);
		
		boolean modif = true;
		boolean publ = visible;
		boolean chPubl = (release.isVisible() != visible);
		
		if(	release.getWebPageId().equals(node) &&
			sdf.format(release.getRecordDate()).equals(recordDate) &&
			release.getCaption().equals(caption) &&
			release.getBrief().equals(brief) &&
			release.getContent().equals(content)) modif= false;

		if( (( modif) && !Admin.isW(pageAccessCode)) ||
			( chPubl && ! Admin.isP( pageAccessCode )) ||
			( modif && publ && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "releases.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		
		release.setRecordDate( sdf.parse( recordDate ) );
		release.setWebPageId( node );

		release.setCaption( caption);
		release.setBrief( brief);
		release.setContent( content );
		
		release.setVisible( visible );

		release.save();
		
		if( modif )
			try{ Journal.newRecord( currentAdmin, release, node, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( (publ) && chPubl )
			try{ Journal.newRecord( currentAdmin, release, node, Journal.ACTION_PUBLIC, "публикация на сайте" ).save();
			}catch( Exception e ){}
		if( !publ && chPubl )
				try{ Journal.newRecord( currentAdmin, release, node, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}

		// invalidate cached values
//		clearFrontEntries();
		
		redirect	=  "release_list.jsp?action_done=save&page_id=" + node;
	}catch(Exception e)
	{
		response.sendRedirect( "release_list.jsp?page_id=" + node + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

if( redirect == null ) 
	redirect = "/admin/release/release_list.jsp?page_id=" + node;
response.sendRedirect( redirect );

%>
