<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Vote.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter( "id" );
    
    String [] delVi = request.getParameterValues("del_vi");

	String mode = null;
	if(id == null || id.length() == 0)
		mode = "add";
	else
		mode = "edit";
	if(delVi != null && delVi.length > 0)
	    mode = "delvi";
	    
	String question = request.getParameter("question");
	int type = 1;
	try{
	    type = Integer.parseInt(request.getParameter("vote_type"));
    }catch(Exception e){}

	String redirect = null;

if("add".equals(mode))
{
	Vote vote = new Vote();
	try
	{
	    if(!Admin.isC(pageAccessCode))
	    {
	        response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		    return;
	    }
	    String langId = CMSApplication.getApplication().getWebRoot(langCode).getId();
		vote.setLangRootId(langId);
		vote.setQuestion( question );
		vote.setSelectorType( type );
		vote.save();

		String [] newitem = request.getParameterValues("newitem");
		if(newitem == null)
		    newitem = new String[0];
		for(int i = 0; i < newitem.length; i++)
		{
		    VoteItem vi = new VoteItem();
		    vi.setVoteId(vote.getId());
		    vi.setItem(newitem[i]);
		    vi.save();
		}

		try{ Journal.newRecord( currentAdmin, vote, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}

		redirect	= "votes.jsp?action_done=add";
	}catch(Exception e)
	{
	    if(vote.getId() != null)
	        VoteItem.remove(vote.getId());
		vote.remove();
		response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if( mode != null && mode.equals( "edit" ))
{
	Vote vote = new Vote();
	try
	{
	    if(!Admin.isW(pageAccessCode))
	    {
	        response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		    return;
	    }

		vote.load(id);
		vote.setQuestion( question);
		vote.setSelectorType( type);

		vote.save();
		
		
		String [] voteitem = request.getParameterValues("voteitem");
		if(voteitem == null)
		    voteitem = new String[0];

		Enumeration enum = VoteItem.getVoteItems(id);

		for(int i = 0; enum.hasMoreElements() && i < voteitem.length; i++)
		{
		    VoteItem vi = (VoteItem)enum.nextElement();
		    if(!voteitem[i].equals(vi.getItem()))
		    {
		        vi.setItem(voteitem[i]);
		        vi.save();
		    }
		}

		String [] newitem = request.getParameterValues("newitem");
		if(newitem == null)
		    newitem = new String[0];
		for(int i = 0; i < newitem.length; i++)
		{
		    if(newitem[i] == null || newitem[i].trim().length() == 0)
		        continue;
		    VoteItem vi = new VoteItem();
		    vi.setVoteId(id);
		    vi.setItem(newitem[i]);
		    vi.save();
		}
		
		try{ Journal.newRecord( currentAdmin, vote, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		redirect	=  "votes.jsp?action_done=save";
	}catch(Exception e)
	{
		response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if("delvi".equals(mode))
{
  	if(!Admin.isW(pageAccessCode))
	{
	    response.sendRedirect( "votes.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
	    return;
	}

    Vote vote = new Vote();
    for(int i = 0; i < delVi.length; i++)
    {
        VoteItem vi = new VoteItem();
        vi.load(delVi[i]);
        if(i == 0)
            vote.load(vi.getVoteId());
        vi.remove();
    }
    
	try{ Journal.newRecord( currentAdmin, vote, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
	redirect = "vote_edit.jsp?action_done=save&id=" + vote.getId();
}

if( redirect == null ) 
	redirect = "votes.jsp";
response.sendRedirect( redirect );

%>
