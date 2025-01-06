<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = FaqCategory.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String mode = request.getParameter( "mode" );
    String id = request.getParameter( "id" );
    String loadType = request.getParameter( "load_type" );
    
    String [] ids = request.getParameterValues("faq_id");
    if(ids == null)
        ids = new String[0];

    String attr = "";
	String redirect = "questions.jsp?id=" + id + "&load_type=" + (loadType != null ? loadType : "");
if("del".equals(mode))
{
	if( ids.length > 0 && !Admin.isC(pageAccessCode))
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	try
	{
        for(int i = 0; i < ids.length; i++)
        {
        	FaqQuestion faq = new FaqQuestion();
            faq.load(ids[i]);
            if( faq.isVisible() && !Admin.isP(pageAccessCode))
	        {
	        	response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
	        	return;
	        }
            Journal rec = Journal.newRecord( currentAdmin, faq, pageId, Journal.ACTION_DELETE, "" );
            
            faq.remove();
		    
		    try{ rec.save(); }catch( Exception e ){}
    		redirect += "&action_done=del";
        }
	}catch(Exception e)
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if("publ".equals(mode) || "unpub".equals(mode))
{
	if( ids.length > 0 && !Admin.isP(pageAccessCode))
	{
		response.sendRedirect( redirect + attr + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	boolean publ = "publ".equals(mode);
	try
	{
        for(int i = 0; i < ids.length; i++)
        {
        	FaqQuestion faq = new FaqQuestion();
            faq.load(ids[i]);
            if(publ == faq.isVisible() || (publ && faq.getAnswerDate() == null))
	            continue;
            Journal rec = Journal.newRecord( currentAdmin, faq, pageId, publ ? Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "" );
            
            faq.setVisible(publ);
		    faq.save();
		    try{ rec.save(); }catch( Exception e ){}
		    
    		redirect += "&action_done=" + mode;
        }
	}catch(Exception e)
	{
    	response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
response.sendRedirect( redirect );
%>
