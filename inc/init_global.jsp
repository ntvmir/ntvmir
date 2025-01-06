<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.db.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.user.*"%>
<%@ page import="tengry.cms.mailer.*"%>
<%
	String      langCode        = null;
	String      pageId          = null;
	String      des             = null;
    User        user            = null;

    langCode = request.getParameter("lang_code");
    if(langCode == null || langCode.trim().length() == 0)
        langCode = CMSApplication.getApplication().getPrimaryLangCode();

	des = CMSApplication.getApplication().getCurrentDesignPath() + "/" + langCode;

	pageId = request.getParameter("id");
	if("".equals(pageId))
		pageId = null;
		
    user = (User)session.getAttribute("ntvmir.user");
    if(user == null)
    {
        String usrid = CMSApplication.getCookie(request, "user.id");
        if(usrid != null && usrid.length() > 0)
        {
            try
            {
                user = User.quickAuthorize(usrid);
            }catch(Exception e){}
        }
    }

	boolean     adminPreview    = false;
	Hashtable   previewInfo     = null;
	adminPreview = (session.getValue("admin.user") != null && "1".equals(request.getParameter("preview")));
	
	previewInfo = (Hashtable)session.getAttribute("admin.previewinfo");
	if(!adminPreview)
		previewInfo = null;
%>

<%!
public String nodePath(WebTreeNode node)
{
    if(node == null)
        return "/pages";
    return nodePath(node.getParent()) + "/" + node.getCode();
}

public String nodePath(String nodeId)
{
    return nodePath(CMSApplication.getApplication().lookup(nodeId));
}
%>