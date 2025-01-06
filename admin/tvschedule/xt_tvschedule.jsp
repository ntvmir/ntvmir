<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page import="tengry.ntvmir.tvschedule.TimeZone"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Tvschedule.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
String mode = request.getParameter( "mode" );
String href = "tvschedule.jsp?";
String year = request.getParameter( "year" );
String month = request.getParameter( "month" );
String attr = "&year=" + year + "&month=" + month;

if(!Admin.isP(pageAccessCode) || !Admin.isW(pageAccessCode))
{
	response.sendRedirect("tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS + attr);
	return;
}

if( "midnight".equals( mode ) )
{
	try
	{
        ShowPlace sp = ShowPlace.getDefaultShowPlace(langCode);
        TimeZone tz = (sp != null ? sp.getTimeZone() : TimeZone.getGmtTimeZone());
        int gmtShift = tz.getGmtShift();
        String midnight = request.getParameter("midnight");
        int hh = Integer.parseInt(midnight.substring(0, 2));
        int mm = Integer.parseInt(midnight.substring(3, 5));
        Tvschedule.setMidnight(langCode, hh, mm, gmtShift);
        
		try{ Journal.newRecord( currentAdmin, new Tvschedule(), pageId, Journal.ACTION_MODIFY, "Изменение окончания TV суток" ).save(); }catch( Exception e ){}
		href	=  "tvschedule.jsp?action_done=mid";
	}catch(Exception e)
	{
	    //e.printStackTrace(new PrintWriter(out));
		response.sendRedirect( "tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if("def_showplace".equals(mode))
{
	try
	{
        String id = request.getParameter("showplace_id");
        ShowPlace sp = ShowPlace.getShowPlace(langCode, id);
        ShowPlace.setDefaultShowPlace(langCode, id);
        
		try{ Journal.newRecord( currentAdmin, sp, pageId, Journal.ACTION_MODIFY, "Выбрано по умолчанию" ).save(); }catch( Exception e ){}
		href = "tvschedule.jsp?action_done=sp_set";
	}catch(Exception e)
	{
		response.sendRedirect( "tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if("new_showplace".equals(mode))
{
    if(!Admin.isC(pageAccessCode))
    {
    	response.sendRedirect("tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
    }
	try
	{
        String tzId = request.getParameter("tz_id");
        String name = request.getParameter("name");

        ShowPlace sp = new ShowPlace();
        sp.setLangRootId(CMSApplication.getApplication().getWebRoot(langCode).getId());
        sp.setTimeZoneId(tzId);
        sp.setName(name);
        sp.save();

		try{ Journal.newRecord( currentAdmin, sp, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		href = "tvschedule.jsp?action_done=sp_new";
	}catch(Exception e)
	{
		response.sendRedirect( "tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

else if("del_showplace".equals(mode))
{
    if(!Admin.isC(pageAccessCode))
    {
    	response.sendRedirect("tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
    }
	try
	{
        String id = request.getParameter("showplace_id");
        ShowPlace sp = ShowPlace.getShowPlace(langCode, id);
        
        Journal rec = Journal.newRecord( currentAdmin, sp, pageId, Journal.ACTION_DELETE, "" );
        
        sp.remove();
        
        try{ rec.save(); }catch( Exception e ){}
		href = "tvschedule.jsp?action_done=sp_del";
	}catch(Exception e)
	{
		response.sendRedirect( "tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

response.sendRedirect( href + attr);
%>
