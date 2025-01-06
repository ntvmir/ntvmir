<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = ISIDemon.SERVICE_CODE;
%>
<%@ page import="tengry.northgas.isi.*"%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	if(!Admin.isW(pageAccessCode))
	{
		response.sendRedirect("isi_news.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}
	
	long period = -1;
	try{ period = Long.parseLong(request .getParameter("period")); }catch(Exception e){}
	
	String nodeId = request.getParameter("news_page_id");
	
	if(period <= 0)
	{
		response.sendRedirect("isi_news.jsp?error=" + 1);
		return;
	}
	if(nodeId == null || nodeId.length() == 0)
	{
		response.sendRedirect("isi_news.jsp?error=" + 2);
		return;
	}

	CMSApplication.getApplication().setStoredProperty(ISIDemon.ISI_DEMON_PERIOD_PROP, "" + period * 1000 * 60 * 60);
	CMSApplication.getApplication().setStoredProperty(ISIDemon.ISI_NEWS_PAGE_ID_PROP, nodeId);

	ISIDemon.restartDemon();
	try{Journal.newRecord( currentAdmin, null, pageId, Journal.ACTION_MODIFY, "изменение параметров и перезапуск импорта новостей" ).save();}catch(Exception e){}
	response.sendRedirect("isi_news.jsp?action_done=set");
%>