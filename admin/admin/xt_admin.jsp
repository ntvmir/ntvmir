<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = "admin";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
int CAN_T_MODIFY = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_CREATE = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_SAVE	= CMSApplication.PAGE_ERROR_WHILE_SAVING;


String id = request.getParameter( "id" );
if("".equals(id))
	id = null;
String href = "admins.jsp";
String action = request.getParameter( "action" );

if( "save_admin".equals( action ))
{
	Admin admin = new Admin();
	if( id != null){
		if(!Admin.isW( pageAccessCode ))
		{
			response.sendRedirect( "admin.jsp?id=" + (id==null ? "":id) + "&err=" + CAN_T_MODIFY );
			return;
		}
		admin.load( id );
	}
	else
	{
		if(!Admin.isC( pageAccessCode ))
		{
			response.sendRedirect( "admin.jsp?id=" + (id==null ? "":id) + "err=" + CAN_T_CREATE );
			return;
		}
	}
	boolean newUser = false;
	if( admin.getId() == null ) newUser = true;

	String login = request.getParameter( "login" );
	String password = request.getParameter( "password" );
	String name = request.getParameter( "name" );
	String email = request.getParameter( "email" );
	String phone = request.getParameter( "phone" );
		
	if(newUser)
		admin.setLogin(login);
	if( password != null && password.trim().length() > 0 )
		admin.setPassword( password.trim());
	admin.setName(name);
	admin.setEmail(email);
	admin.setPhone(phone);
	
	try
	{
		admin.save();
		if( newUser )
		{
			try{
				Journal.newRecord( currentAdmin, admin, pageId, Journal.ACTION_CREATE, "" ).save(); 
			} catch( Exception e ){}
			href = "admin.jsp?id=" + admin.getId();
		}
		else
		{
			try{
				Journal.newRecord( currentAdmin, admin, pageId, Journal.ACTION_MODIFY, "" ).save(); 
			} catch( Exception e ){}
			href = "admins.jsp";
		}
	}
	catch(DBException e){
		href = "admin.jsp?err=" + CAN_T_SAVE + "&id=" + (id==null ? "":id);
		if(e.getOriginal() != null && e.getOriginal().getMessage() != null && e.getOriginal().getMessage().indexOf("ADM_LOGIN_AK") >= 0)
			href += "&ununique=1";
		href += "&login=" + login +
				"&name=" + name +
				"&email=" + email +
				"&phone=" + phone;
	}
}

response.sendRedirect( href );
%>