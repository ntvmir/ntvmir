<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Vote.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
    String [] nodes = request.getParameterValues("node_id");
    if(nodes == null)
        nodes = new String[0];
    String mode = request.getParameter("mode");
    String id = request.getParameter("id");
    

    
    if( nodes.length > 0 && ! Admin.isP( pageAccessCode ))
	{
		response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	String redirect = null;
	
if("set".equals(mode))
{
    Vote vote = new Vote();
    vote.load(id);
    try
    {
        for(int i = 0; i < nodes.length; i++)
        {
            WebTreeNode node = CMSApplication.getApplication().lookup(nodes[i]);
            if(id.equals(node.getVoteId()))
                continue;
            node.setVoteId(id);
            node.save();
        }
        redirect	= "votes.jsp?action_done=publ";
        if(nodes.length > 0)
            try{Journal.newRecord( currentAdmin, vote, pageId, Journal.ACTION_PUBLIC, "" ).save();}catch(Exception e){}
    }catch(Exception e)
	{
		response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if("del".equals(mode))
{
    Vote vote = new Vote();
    vote.load(id);
    try
    {
        for(int i = 0; i < nodes.length; i++)
        {
            WebTreeNode node = CMSApplication.getApplication().lookup(nodes[i]);
            if(! id.equals(node.getVoteId()))
                continue;
            node.setVoteId(null);
            node.save();
        }
        redirect	= "votes.jsp?action_done=unpubl";
        if(nodes.length > 0)
            try{Journal.newRecord( currentAdmin, vote, pageId, Journal.ACTION_UNPUBL, "" ).save();}catch(Exception e){}
    }catch(Exception e)
	{
		response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

if( redirect == null ) 
	redirect = "votes.jsp";
response.sendRedirect( redirect );
%>
