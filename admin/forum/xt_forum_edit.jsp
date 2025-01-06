<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Forum.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter( "id" );

	String mode = null;
	String groupId = request.getParameter( "group_id" );
	if(id == null || id.length() == 0)
		mode = "add";
	else
		mode = "edit";
	
	boolean visible = "1".equals(request .getParameter("visible"));
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	int status = Forum.NON_MODERATED;
	try{ status = Integer.parseInt(request.getParameter("status")); }catch(Exception e){}
	
	String redirect = null;
if(mode != null && mode.equals("add"))
{
	Forum forum = new Forum();
	try
	{
		if( !Admin.isC(pageAccessCode) || (visible && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "forum.jsp?&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		boolean modified = true;
		boolean changePubl = false;
		
		
		forum.setForumGroupId(groupId);

		forum.setName( name );
		forum.setDescription( descr );
		
		forum.setStatus( status );
		forum.setVisible( visible );

		forum.save();

		try{ Journal.newRecord( currentAdmin, forum, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		if(visible)
			try{ Journal.newRecord( currentAdmin, forum, pageId, Journal.ACTION_PUBLIC, "").save(); 
	        }catch( Exception e ){}

		// invalidate cached values
//		clearFrontEntries();
		
		redirect = "forum.jsp?action_done=forum_add";
	}catch(Exception e)
	{
		forum.remove();
		response.sendRedirect( "forum.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if( mode != null && mode.equals( "edit" ) )
{
	Forum forum = new Forum();
	try
	{
		forum.load(id);
		
		boolean modif = true;
		boolean publ = visible;
		boolean chPubl = (forum.isVisible() != visible);
		
		if( forum.getName().equals(name) &&
		    forum.getDescription().equals(descr) &&
		    forum.getStatus() == status) modif= false;

		if( ((modif) && !Admin.isW(pageAccessCode)) ||
			( chPubl && ! Admin.isP( pageAccessCode )) ||
			( modif && publ && !Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "forum.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		
		forum.setName( name );
		forum.setDescription( descr );
		
		forum.setStatus( status );
		forum.setVisible( visible );

		forum.save();
		
		if( modif )
			try{ Journal.newRecord( currentAdmin, forum, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( (publ) && chPubl )
			try{ Journal.newRecord( currentAdmin, forum, pageId, Journal.ACTION_PUBLIC, "" ).save();
			}catch( Exception e ){}
		if( !publ && chPubl )
				try{ Journal.newRecord( currentAdmin, forum, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}

		// invalidate cached values
//		clearFrontEntries();
		
		redirect	=  "forum.jsp?action_done=forum_save";
	}catch(Exception e)
	{
		response.sendRedirect( "forum.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

if( redirect == null ) 
	redirect = "forum.jsp?";
response.sendRedirect( redirect );
%>
