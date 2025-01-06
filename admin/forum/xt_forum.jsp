<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Forum.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String mode = request.getParameter( "mode" );

    String [] fids = request.getParameterValues("forum_id");
    String [] gids = request.getParameterValues("group_id");
    if(fids == null)
        fids = new String[0];
    if(gids == null)
        gids = new String[0];

	String redirect = "forum.jsp?";
if("del".equals(mode))
{
	if((fids.length > 0 || gids.length > 0) && !Admin.isC(pageAccessCode))
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	try
	{
        for(int i = 0; i < fids.length; i++)
        {
        	Forum forum = new Forum();
            forum.load(fids[i]);
            if( forum.isVisible() && !Admin.isP(pageAccessCode))
	        {
	        	response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
	        	return;
	        }
            Journal rec = Journal.newRecord( currentAdmin, forum, pageId, Journal.ACTION_DELETE, "" );
            
            forum.remove();
		    try{ rec.save(); }catch( Exception e ){}
        }
        for(int i = 0; i < gids.length; i++)
        {
        	ForumGroup group = new ForumGroup();
            group.load(gids[i]);
            if( group.isVisible() && !Admin.isP(pageAccessCode))
	        {
	        	response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
	        	return;
	        }
            Journal rec = Journal.newRecord( currentAdmin, group, pageId, Journal.ACTION_DELETE, "" );
            
            group.remove();
		    
		    try{ rec.save(); }catch( Exception e ){}
        }
        redirect += "&action_done=del";
	}catch(Exception e)
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
		return;
	}
}
else if("publ".equals(mode) || "unpub".equals(mode))
{
	if((fids.length > 0 || gids.length > 0) && !Admin.isP(pageAccessCode))
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	boolean publ = "publ".equals(mode);
	try
	{
        for(int i = 0; i < fids.length; i++)
        {
        	Forum forum = new Forum();
            forum.load(fids[i]);
            if(publ == forum.isVisible())
	            continue;
            Journal rec = Journal.newRecord( currentAdmin, forum, pageId, publ ? Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "" );
            
            forum.setVisible(publ);
		    forum.save();
		    try{ rec.save(); }catch( Exception e ){}
        }
        for(int i = 0; i < gids.length; i++)
        {
        	ForumGroup group = new ForumGroup();
            group.load(gids[i]);
            if(publ == group.isVisible())
	            continue;
            Journal rec = Journal.newRecord( currentAdmin, group, pageId, publ ? Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "" );
            
            group.setVisible(publ);
		    group.save();
		    try{ rec.save(); }catch( Exception e ){}
        }
        
        redirect += "&action_done=" + mode;
	}catch(Exception e)
	{
    	response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

if( redirect == null ) 
	redirect = "/admin/tvannounce/tvannounces.jsp?";
response.sendRedirect( redirect );
%>
