<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Tvannounce.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String mode = request.getParameter( "mode" );
    String date1 = request.getParameter("date1");
    String date2 = request.getParameter("date2");
    String pageNum = request.getParameter("page_number");
    String loadType = request.getParameter("load_type");
    
    String attr = "";
    if(date1 != null) attr += "&date1=" + date1;
    if(date2 != null) attr += "&date2=" + date2;
    if(pageNum != null) attr += "&page_number=" + pageNum;
    if(loadType != null) attr += "&load_type=" + loadType;
    
    String [] ids = request.getParameterValues("tva_id");
    if(ids == null)
        ids = new String[0];

	String redirect = "tvannounces.jsp?" + attr;
if("del".equals(mode))
{
	if( ids.length > 0 && !Admin.isC(pageAccessCode))
	{
		response.sendRedirect( redirect + attr + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	try
	{
	    boolean impDeleted = false;
        for(int i = 0; i < ids.length; i++)
        {
        	Tvannounce tvannounce = new Tvannounce();
            tvannounce.load(ids[i]);
            if( tvannounce.isVisible() && !Admin.isP(pageAccessCode))
	        {
	        	response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
	        	return;
	        }
	        if(tvannounce.isImportant())
	            impDeleted = true;
            Journal rec = Journal.newRecord( currentAdmin, tvannounce, pageId, Journal.ACTION_DELETE, "" );
            
            tvannounce.remove();
		    
		    try{ rec.save(); }catch( Exception e ){}
    		redirect += "&action_done=del";
        }
        if(impDeleted)
            tengry.ntvmir.HomePage.getInstance(langCode).dropAnnounces();
            
	}catch(Exception e)
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
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
    boolean impChanged = false;
	boolean publ = "publ".equals(mode);
	try
	{
        for(int i = 0; i < ids.length; i++)
        {
        	Tvannounce tvannounce = new Tvannounce();
            tvannounce.load(ids[i]);
            if(publ == tvannounce.isVisible())
	            continue;
	        if(tvannounce.isImportant())
	            impChanged = true;
            Journal rec = Journal.newRecord( currentAdmin, tvannounce, pageId, publ ? Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "" );
            
            tvannounce.setVisible(publ);
		    tvannounce.save();
		    try{ rec.save(); }catch( Exception e ){}
		    
    		redirect += "&action_done=" + mode;
        }
        if(impChanged)
            tengry.ntvmir.HomePage.getInstance(langCode).dropAnnounces();
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
