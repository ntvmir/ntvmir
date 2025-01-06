<%@ page language="Java" %>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.press.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	response.setHeader("Pragma", "no-cache");
	SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
	Article article = new Article();
	article.setWebPageId(request.getParameter("page_id"));
	article.setRecordDate(sdf.parse(request.getParameter("recorddate")));
	article.setCaption( request.getParameter("caption"));
	article.setBrief( request.getParameter("brief"));
	article.setContent( request.getParameter("content"));
	article.setVisible( true );
	article.setAuthor(request.getParameter("author"));
	article.setPublisher(request.getParameter("publisher"));
	article.setAnnounce(request.getParameter("short"));
	article.setPublisherurl(request.getParameter("puburl"));
	article.setExtrainfourl(request.getParameter("ref"));
	article.setWebpagesurl(request.getParameter("webpages"));
	
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

	WebTreeNode wp = (WebTreeNode) CMSApplication.getApplication().lookup( request.getParameter("page_id") );
	String sectionCode = wp.getSectionCode();
	String nodeName = (wp.getName());

	path.add(wp.getName());
	Enumeration enum = wp.getVisibleChilds().elements();
	while(enum.hasMoreElements())
	{
		WebTreeNode child = (WebTreeNode)enum.nextElement();
		childs.add(child.getName());
	}

	wp = wp.getParent();
	if(wp == null || wp.getParent() == null)
	{
		nodeName = "";
	}

	while(wp != null)
	{
		path.insertElementAt(wp.getName(), 0);
		wp = wp.getParent();
	}
	
	previewInfo.put("childs", childs);
	previewInfo.put("path", path);
	previewInfo.put("nodename", nodeName);
	previewInfo.put("article", article);
	previewInfo.put("section", sectionCode);
	previewInfo.put("pagetype", CMSApplication.getApplication().getPageTypeByCode("article"));
		
	session.setAttribute("admin.previewinfo", previewInfo);
	
	response.sendRedirect("/page.jsp?preview=1" );
%>