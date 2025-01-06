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
    
    String [] ids = request.getParameterValues("fqc_id");
    if(ids == null)
        ids = new String[0];

    String attr = "";
	String redirect = "faq.jsp?";
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
        	FaqCategory fqc = new FaqCategory();
            fqc.load(ids[i]);
            if( fqc.isVisible() && !Admin.isP(pageAccessCode))
	        {
	        	response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
	        	return;
	        }
            Journal rec = Journal.newRecord( currentAdmin, fqc, pageId, Journal.ACTION_DELETE, "" );
            
            fqc.remove();
		    
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
        	FaqCategory fqc = new FaqCategory();
            fqc.load(ids[i]);
            if(publ == fqc.isVisible())
	            continue;
            Journal rec = Journal.newRecord( currentAdmin, fqc, pageId, publ ? Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "" );
            
            fqc.setVisible(publ);
		    fqc.save();
		    try{ rec.save(); }catch( Exception e ){}
		    
    		redirect += "&action_done=" + mode;
        }
	}catch(Exception e)
	{
    	response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

else if("set_num".equals(mode))
{
	int n = -1;
	try{ n = Integer.parseInt(request .getParameter("faq_num")); }catch(Exception e){}
	if(n > 0)
		FaqQuestion.setFaqQuestionAmount(n);
	redirect = "faq.jsp?action_done=amount_set";
}

if( redirect == null ) 
	redirect = "/admin/faq/faq.jsp?";
response.sendRedirect( redirect );
%>
