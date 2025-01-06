<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Forum.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter("id");
	String mode = request.getParameter( "mode" );
    String [] ids = request.getParameterValues("user_id");

    if(ids == null)
        ids = new String[0];

	String redirect = "forum.jsp?";
if(mode != null)
{
	if(ids.length > 0 && !Admin.isW(pageAccessCode))
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	try
	{
	    
        Forum forum = new Forum();
        forum.load(id);
        
        for(int i = 0; i < ids.length; i++)
        {
            User user = new User(DBObject.LOAD_LIST);
            user.load(ids[i]);
            if("user".equals(mode))
            {
                forum.addModerator(user);
                try{ Journal.newRecord( currentAdmin, forum, pageId, Journal.ACTION_MODIFY, "назначен модератор " + user.getLogin()); }catch( Exception e ){}
                
            }
            else
            {
                forum.delModerator(user);
                try{ Journal.newRecord( currentAdmin, forum, pageId, Journal.ACTION_MODIFY, "отсртанен модератор " + user.getLogin()); }catch( Exception e ){}
            }
        }
        if("user".equals(mode))
            redirect += "&action_done=moder_add";
        else
            redirect += "&action_done=moder_del";
	}catch(Exception e)
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
response.sendRedirect( redirect );
%>
