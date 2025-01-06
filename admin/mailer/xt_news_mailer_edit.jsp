<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = NewsFields.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
String page_id 	= 	request.getParameter( "news_page_id" );
String action 	=	request.getParameter( "action" );
String subjectRusNews = request.getParameter( "subjectRusNews" );
String subjectEngNews = request.getParameter( "subjectEngNews" );
String headerRusNews = request.getParameter( "headerRusNews" );
String headerEngNews = request.getParameter( "headerEngNews" );
String footerRusNews = request.getParameter( "footerRusNews" );
String footerEngNews = request.getParameter( "footerEngNews" );

int CAN_T_MODIFY = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_SAVE = CMSApplication.PAGE_ERROR_WHILE_SAVING;

if( ! Admin.isW( pageAccessCode ))
{
	response.sendRedirect( "news_mailer.jsp?err=" + CAN_T_MODIFY );
	return;
}

NewsFields news_obj = new NewsFields();
if (action.equals("edit_values"))
{
	news_obj.setNews_Subject_Rus(subjectRusNews);
	news_obj.setNews_Subject_Eng(subjectEngNews);
	news_obj.setNews_Header_Rus(headerRusNews);
	news_obj.setNews_Header_Eng(headerEngNews);
	news_obj.setNews_Footer_Rus(footerRusNews);
	news_obj.setNews_Footer_Eng(footerEngNews);
	try
	{
		news_obj.save_news_fields(page_id);
	}
	catch(Exception e)
	{
		response.sendRedirect("news_mailer.jsp?err_msg=1");
	}
	response.sendRedirect("news_mailer_edit.jsp?action_done=save&news_page_id="+CMSApplication.toHTML(page_id));
	return;
}
else if (action.equals("load_defaults")==true)
{
	CMSApplication APP = CMSApplication.getApplication();

	news_obj.setNews_Subject_Rus(APP.getStoredProperty(MailerTask.MAIL_NEWS_SUBJECT_RUS_PROP));
	news_obj.setNews_Subject_Eng(APP.getStoredProperty(MailerTask.MAIL_NEWS_SUBJECT_ENG_PROP));
	news_obj.setNews_Header_Rus(APP.getStoredProperty(MailerTask.MAIL_NEWS_HEADER_RUS_PROP));
	news_obj.setNews_Header_Eng(APP.getStoredProperty(MailerTask.MAIL_NEWS_HEADER_ENG_PROP));
	news_obj.setNews_Footer_Rus(APP.getStoredProperty(MailerTask.MAIL_NEWS_FOOTER_RUS_PROP));
	news_obj.setNews_Footer_Eng(APP.getStoredProperty(MailerTask.MAIL_NEWS_FOOTER_ENG_PROP));
	try
	{
		news_obj.save_news_fields(page_id);
	}
	catch(Exception e)
	{
		response.sendRedirect("news_mailer.jsp?err_msg=1");
	}
	response.sendRedirect("news_mailer_edit.jsp?action_done=load&news_page_id="+page_id);
	return;
}
response.sendRedirect( "news_mailer.jsp");
return;

%>