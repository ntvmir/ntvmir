<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.user.*"%>
<%@ page import="tengry.cms.press.*"%>
<%@ page import="tengry.cms.dict.*"%>
<%@ page import="tengry.cms.tender.*"%>
<%@ page import="tengry.cms.vote.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  
	response.setHeader("Pragma","no-cache");
	
	WebTreeNode node            = null;
	String sectionCode = "";	
	
	if(previewInfo == null)
	{
		if(pageId != null)
			node = CMSApplication.getApplication().lookup(pageId);
		if(node == null || (! node.isVisible() && ! adminPreview))
		{
%>
<jsp:forward page="/404.html"/>
<%
//			response.sendRedirect("/404.html");
			return;
		}
		if(node.getParent() == null)
		{		
			response.sendRedirect("/index.jsp");
			return;
		}
		
		// When page not found or page is soft link.
		if(node.getLinkId() != null && node.getLinkId().length() > 0)
		{
			WebTreeNode rootWebNode = CMSApplication.getApplication().getWebRoot(langCode);
			if(node.getLinkId().equals(rootWebNode.getId()))
			{
				response.sendRedirect("/index.jsp");
			}
			else
			{
				response.sendRedirect(nodePath(node.getLinkId()));
		    }
		    return;
		}
		
		sectionCode = node.getSectionCode();
	
		// Where page is private
		if(isPagePrivate(node.getId()) && ! adminPreview)
		{
			boolean isOk = false;
			if(user != null)
			{
/*
				Enumeration enum = user.getGroups();
				while(enum.hasMoreElements())
				{
					Group g = (Group)enum.nextElement();
					if(g.isR(node.getId()))
					{
						isOk = true;
						break;
					}
				}
*/
                isOk = true;
			}
			// when user has no permission to view page redirect him to authorization
			if( ! isOk && ! node.getPageType().getCode().equals("auth"))
			{
			    response.sendRedirect("/pages/" + langCode + "/auth?back_page_id=" + node.getId());
			    return;
/********************************************
				Enumeration enum = CMSApplication.getApplication().getNodesByTypeCode(langCode, "auth");
				if(enum.hasMoreElements())
				{
					WebTreeNode authNode = (WebTreeNode)enum.nextElement();
					response.sendRedirect("/page.jsp?id=" + authNode.getId() + "&back_page_id=" + node.getId());
					return;
				}
		    
		        response.sendRedirect("/pages/" + langCode + "/auth?back_page_id=" + node.getId());
				else
				{

<jsp:forward page="/404.html"/>
//					response.sendRedirect("/404.html");
					return;
				}
*******************************************/
			}
		}
	}
	else
	{
		sectionCode = (String)previewInfo.get("section");
	}

	
	String [] parameters = null;
	{
		Vector params = new Vector();
		Enumeration paramNames = request.getParameterNames();
		while(paramNames.hasMoreElements())
		{
			String paramName = (String)paramNames.nextElement();
			String [] vals = request .getParameterValues(paramName);
			for(int i = 0; i < vals.length; i++)
				params.add(paramName + "=" + vals[i]);
		}
		parameters = new String[params.size()];
		for(int i = 0; i < parameters.length; i++)
			parameters[i] = (String)params.elementAt(i);
	}
%>
<%!
	public boolean isPagePrivate(String id) throws DBException
	{
		Group g1 = CMSApplication.getApplication().getGroupByName("default");
		Group g2 = CMSApplication.getApplication().getGroupByName("private");
		if(g1 != null && g2 != null)
		{
			return !Group.isR(g1.getAccessCode(id)) && 
					Group.isR(g2.getAccessCode(id));
		}
		else return false;
	}
%>