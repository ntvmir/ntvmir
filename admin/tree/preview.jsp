<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%@ page import="tengry.northgas.*" %>
<%@ page import="tengry.cms.*" %>
<%@ page import="tengry.cms.core.*" %>
<%@ page import="java.util.*" %>
<%
    response.setHeader("Pragma","no-cache");
    
    session.removeAttribute("admin.previewinfo");
    
    if("1".equals(request.getParameter( "preview" )))
    {
		response.sendRedirect("/page.jsp?id=" + (request.getParameter("node")) + 
								"&preview=1" );
    }
    else
    {
		String nodeId = request.getParameter( "node" );
		String mode = request.getParameter( "mode" );
	
		// prepare preview information for /page.jsp
		// previewInfo is hash of:
		// "path" -> the vector of Strings to show page path.
		// "childs" -> the vector of Strings to show page childs.
		// "nodename" -> String. the page name
		// "frames" -> vector of Strings. static page frame contents.

		Hashtable previewInfo = new Hashtable();
	
		Vector path = new Vector();	
		Vector childs = new Vector();
	
		WebTreeNode wp = (WebTreeNode) CMSApplication.getApplication().lookup( nodeId );
		String sectionCode = wp.getSectionCode();
		String nodeName = request.getParameter("name");
	
		path.add(request.getParameter("name"));
		if("edit".equals(mode))
		{
			Enumeration enum = wp.getVisibleChilds().elements();
			while(enum.hasMoreElements())
			{
				WebTreeNode child = (WebTreeNode)enum.nextElement();
				childs.add(child.getName());
			}
			wp = wp.getParent();
			if(wp == null || wp.getParent() == null)
				nodeName = "";
		}
		while(wp != null)
		{
			path.insertElementAt(wp.getName(), 0);
			wp = wp.getParent();
		}
	
		Vector frames = new Vector();
		int fnum = 0;
		try{ fnum = Integer.parseInt(request.getParameter("frame_num")); }catch(Exception e){}
		for(int i = 0; i < fnum; i++)
		{
			frames.add(request.getParameter("content_" + i));
		}
	
		previewInfo.put("childs", childs);
		previewInfo.put("path", path);
		previewInfo.put("nodename", nodeName);
		previewInfo.put("frames", frames);
		previewInfo.put("section", sectionCode);
		previewInfo.put("pagetype", CMSApplication.getApplication().getPageTypeByCode("static"));
		
		session.setAttribute("admin.previewinfo", previewInfo);
		response.sendRedirect("/page.jsp?preview=1" );
		return;
	}
%>