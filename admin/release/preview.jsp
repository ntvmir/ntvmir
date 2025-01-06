<%@ page language="Java" %>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.press.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	response.setHeader("Pragma", "no-cache");
	SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");

	String node = request.getParameter( "page_id" );

	String caption = request.getParameter("caption");
	String brief = request.getParameter("brief");
	String content = request.getParameter("content");
	String recordDate = request.getParameter("recorddate");
	
	Release release = new Release();
	release.setWebPageId(node);
	release.setRecordDate( sdf.parse( recordDate ) );

	release.setCaption( caption );
	release.setBrief( brief );
	release.setContent( content );
	release.setVisible( true );



	session.removeAttribute("admin.previewinfo");
	
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
	previewInfo.put("article", release);
	previewInfo.put("section", sectionCode);
	previewInfo.put("pagetype", CMSApplication.getApplication().getPageTypeByCode("release"));
		
	session.setAttribute("admin.previewinfo", previewInfo);
	
	response.sendRedirect("/page.jsp?preview=1" );
%>