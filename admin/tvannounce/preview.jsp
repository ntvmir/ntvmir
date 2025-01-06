<%@ page language="Java" %>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	// set the Service name for authorization
	String pageId = Tvannounce.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	response.setHeader("Pragma", "no-cache");
	SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");

	String node = request.getParameter( "page_id" );


	boolean visible = "1".equals(request .getParameter("visible"));
	boolean important = "1".equals(request .getParameter("important"));
	String img = request.getParameter("img");
	String name = request.getParameter("name");
	String brief = request.getParameter("brief");
	String text = request.getParameter("content");
	String startDate = request.getParameter("start_date");
	String finishDate = request.getParameter("finish_date");
	if(finishDate != null && finishDate.length() == 0)
	    finishDate = null;
	    	
	Tvannounce tvannounce = new Tvannounce();
	
	tvannounce.setLangRootId(CMSApplication.getApplication().getWebRoot(langCode).getId());
		
	if(startDate != null && startDate.length() > 0)
	    tvannounce.setStartDate(sdf.parse(startDate));
	if(finishDate != null && finishDate.length() > 0)
	    tvannounce.setFinishDate(sdf.parse(finishDate));

	tvannounce.setName( name );
	tvannounce.setImg( img );
	tvannounce.setBrief( brief );
	tvannounce.setText( text );
	tvannounce.setVisible( visible );
	tvannounce.setImportant( important );


	session.removeAttribute("admin.previewinfo");
	
	String nodeId = request.getParameter( "node" );
	
	// prepare preview information for /page.jsp
	// previewInfo is hash of:
	// "path" -> the vector of Strings to show page path.
	// "childs" -> the vector of Strings to show page childs.
	// "nodename" -> String. the page name
	// "frames" -> vector of Strings. static page frame contents.

	Hashtable previewInfo = new Hashtable();
	
	Vector path = new Vector();	
	Vector childs = new Vector();

	String sectionCode = "tvannounce";
	String nodeName = "Анонс телепередачи";
	
	previewInfo.put("childs", childs);
	previewInfo.put("path", path);
	previewInfo.put("nodename", nodeName);
	previewInfo.put("article", tvannounce);
	previewInfo.put("section", sectionCode);
	previewInfo.put("pagetype", CMSApplication.getApplication().getPageTypeByCode("tvannounce"));
		
	session.setAttribute("admin.previewinfo", previewInfo);
	
	response.sendRedirect("/page.jsp?preview=1" );
%>