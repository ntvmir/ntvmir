<%
	Vector pagePath = new Vector();
	String sectionImg = "company";
	String sectionName = "О компании";
	if(pageId != null)
	{
	    WebTreeNode treeNode = CMSApplication.getApplication().lookup(pageId);
	    while(treeNode != null && treeNode.getParent() != null)
	    {
	        pagePath.insertElementAt(treeNode, 0);
	        sectionImg = treeNode.getCode();
	        sectionName = treeNode.getName();
	        treeNode = treeNode.getParent();
	    }
	}
	if(adminPreview && previewInfo != null)
	{
	    sectionImg = (String)previewInfo.get("section");
	    if(sectionImg == null)
	        sectionImg = "about";
	    
	}
	if("about".equals(sectionImg))
	    sectionImg = "company";
	else if("tvschedule".equals(sectionImg))
	    sectionImg = "tvprogram";
	else if("auth".equals(sectionImg))
	    sectionImg = "authorization";
%>