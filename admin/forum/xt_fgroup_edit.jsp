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
	if(id == null || id.length() == 0)
		mode = "add";
	else
		mode = "edit";
	
	boolean visible = "1".equals(request .getParameter("visible"));
	String name = request.getParameter("name");
	String redirect = null;
if(mode != null && mode.equals("add"))
{
	ForumGroup group = new ForumGroup();
	try
	{
		if( !Admin.isC(pageAccessCode) || (visible && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "forum.jsp?&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		boolean modified = true;
		boolean changePubl = false;
		
		
		group.setWebPageId(CMSApplication.getApplication().getWebRoot(langCode).getId());

		group.setName( name );
		group.setVisible( visible );

		group.save();

		try{ Journal.newRecord( currentAdmin, group, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		if(visible)
			try{ Journal.newRecord( currentAdmin, group, pageId, Journal.ACTION_PUBLIC, "").save(); 
	        }catch( Exception e ){}

		// invalidate cached values
//		clearFrontEntries();
		
		redirect = "forum.jsp?action_done=group_add";
	}catch(Exception e)
	{
		group.remove();
		response.sendRedirect( "forum.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if( mode != null && mode.equals( "edit" ) )
{
	ForumGroup group = new ForumGroup();
	try
	{
		group.load(id);
		
		boolean modif = true;
		boolean publ = visible;
		boolean chPubl = (group.isVisible() != visible);
		
		if(group.getName().equals(name)) modif= false;

		if( ((modif) && !Admin.isW(pageAccessCode)) ||
			( chPubl && ! Admin.isP( pageAccessCode )) ||
			( modif && publ && !Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "forum.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		
		group.setName( name);
		group.setVisible( visible );

		group.save();
		
		if( modif )
			try{ Journal.newRecord( currentAdmin, group, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( (publ) && chPubl )
			try{ Journal.newRecord( currentAdmin, group, pageId, Journal.ACTION_PUBLIC, "" ).save();
			}catch( Exception e ){}
		if( !publ && chPubl )
				try{ Journal.newRecord( currentAdmin, group, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}

		// invalidate cached values
//		clearFrontEntries();
		
		redirect	=  "forum.jsp?action_done=group_save";
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
