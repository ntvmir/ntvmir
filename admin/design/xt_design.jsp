<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Design.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
String id = request.getParameter("id");
String action = request.getParameter("action");

int CAN_T_MODIFY = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_SAVE = CMSApplication.PAGE_ERROR_WHILE_SAVING;

String href = "/admin/design/design.jsp";

if("set".equals(action))
{
	if( ! Admin.isP( pageAccessCode ))
	{
		response.sendRedirect( "design.jsp?err=" + CAN_T_MODIFY );
		return;
	}
	try
	{
		Design.selectDesign(id);
		Design des = new Design();
		des.load(id);
		try{Journal.newRecord( currentAdmin, des, pageId, Journal.ACTION_PUBLIC, "установка дизайна" ).save(); }catch(Exception e){}
	}
	catch(Exception e)
	{
		response.sendRedirect( "design.jsp?err=" + CAN_T_SAVE );
		return;
	}
}




else if("del".equals(action))
{
	if( ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "design.jsp?err=" + CAN_T_MODIFY );
		return;
	}
	Design des = new Design();
	des.load(id);
	if(des.isSelected())
	{
		response.sendRedirect( "design.jsp?err=" + CAN_T_SAVE );
		return;
	}
	Journal rec = Journal.newRecord( currentAdmin, des, pageId, Journal.ACTION_DELETE, "" );
	try
	{
		des.remove();
		rec.save();
	}
	catch(Exception e)
	{
		response.sendRedirect( "design.jsp?err=" + CAN_T_SAVE );
		return;
	}
}
else if("save".equals(action))
{
	if(id == null)
		id = "";
	Design des = new Design();
	if( (id.length() == 0 && ! Admin.isC(pageAccessCode)) ||
		(id.length() > 0 && ! Admin.isW(pageAccessCode)))
	{
		response.sendRedirect( "design.jsp?err=" + CAN_T_MODIFY );
		return;
	}
	if(id.length() > 0)
		des.load(id);
	if(des.isSelected() && ! Admin.isP(pageAccessCode))
	{
		response.sendRedirect( "design.jsp?err=" + CAN_T_MODIFY );
		return;
	}
	des.setName(request.getParameter("f_name"));
	des.setPath(request.getParameter("f_path"));
	des.setDescription(request.getParameter("f_descr"));
	int act;
	if(id.length() == 0)
	{
		act = Journal.ACTION_CREATE;
		des.setSelected(false);
	}
	else
		act = Journal.ACTION_MODIFY;
	try
	{
		des.save();
		try{Journal.newRecord( currentAdmin, des, pageId, act, "" ).save(); }catch(Exception e){}
	
	}
	catch(Exception e)
	{
		response.sendRedirect( "design.jsp?err=" + CAN_T_SAVE );
		return;
	}
}

response.sendRedirect( href );
%>