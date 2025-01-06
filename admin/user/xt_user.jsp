<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = User.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
int CAN_T_MODIFY = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_CREATE = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_SAVE	= CMSApplication.PAGE_ERROR_WHILE_SAVING;

String mode = request.getParameter("mode");

if("save".equals(mode))
{
	if(!Admin.isW( pageAccessCode ))
	{
		response.sendRedirect( "users.jsp?err=" + CAN_T_MODIFY );
		return;
	}
	
	String id = request.getParameter("id");
	try
	{
		User user = new User();
		user.load(id);
		if(request.getParameter("f_password") != null &&
		   request.getParameter("f_password").length() > 0)
			user.setPassword(request.getParameter("f_password"));
		user.setName(request.getParameter("f_name"));
		user.setCountry(request.getParameter("f_country"));
		user.setCity(request.getParameter("f_city"));
//		user.setAddress(request.getParameter("f_address"));
//		user.setPhone(request.getParameter("f_phone"));
//		user.setFax(request.getParameter("f_fax"));
		user.setEmail(request.getParameter("f_email"));
		user.setUrl(request.getParameter("f_url"));
		user.setIcq(request.getParameter("f_icq"));
		user.setDescription(request.getParameter("f_extra"));
		user.setForumSign(request.getParameter("f_sign"));
		user.setDisabled(!"1".equals(request.getParameter("f_disabled")));
		
		user.save();
		
		user.unsubscribe();
            
        String dlvNewsId = request.getParameter("subscr_news");
        String dlvTvId = request.getParameter("subscr_tv");
        String showPlaceId = request.getParameter("show_place_id");
            
        if("1".equals(request.getParameter("cookie_gmt")))
            CMSApplication.setCookie(response, "tvschedule.showplace", showPlaceId);
            
        try
        {
            if(dlvNewsId != null && dlvNewsId.length() > 0)
                user.subscribe(dlvNewsId);
            if(dlvTvId != null && dlvTvId.length() > 0)
                user.subscribe(dlvTvId, showPlaceId);
        }
        catch(Exception e){}
        
		try{
			Journal.newRecord( currentAdmin, user, pageId, Journal.ACTION_MODIFY, "" ).save(); 
		} catch( Exception e ){}
		response.sendRedirect( "users.jsp?ok=1" );
		return;
	}
	catch(Exception e)
	{
		response.sendRedirect( "users.jsp?err=" + CAN_T_SAVE );
		return;
	}
}
else if("del".equals(mode))
{
	if(!Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "users.jsp?err=" + CAN_T_MODIFY );
		return;
	}
	try
	{
		String [] users = request.getParameterValues("users");
		for(int i = 0; users != null && i < users.length; i++)
		{
			User user = new User();
			user.load(users[i]);
			Journal rec = Journal.newRecord( currentAdmin, user, pageId, Journal.ACTION_DELETE, "" );
			user.remove();
			try{ rec.save(); }catch(Exception e){}
		}
		response.sendRedirect( "users.jsp?ok=2" );
		return;
	}
	catch(Exception e)
	{
		response.sendRedirect( "users.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
		return;
	}

}

response.sendRedirect( "users.jsp" );
%>