<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Vote.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
    String [] del = request.getParameterValues("del");
    if( del.length > 0 && ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	String redirect = null;


	try
	{
		for(int i = 0; i < del.length; i++)
		{
		    if(CMSApplication.getApplication().getNodesByVoteId(del[i]).size() > 0)
		        throw new Exception("Vote '" + del[i] + "' attached to some pages.");
		    VoteItem.remove(del[i]);
		    Vote vote = new Vote();
            vote.load(del[i]);
            Journal rec = Journal.newRecord( currentAdmin, vote, pageId, Journal.ACTION_DELETE, "" );
            vote.remove();
            try{ rec.save(); }catch(Exception e){}
		}
		redirect	= "votes.jsp?action_done=del";
	}catch(Exception e)
	{
		response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
		return;
	}

if( redirect == null ) 
	redirect = "votes.jsp";
response.sendRedirect( redirect );
%>
