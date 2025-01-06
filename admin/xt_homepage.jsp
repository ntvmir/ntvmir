<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="tengry.ntvmir.*"%>
<%
	// set the Service name for authorization
	String pageId = HomePage.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	HomePage hp = HomePage.getInstance(langCode);
	String mode = request .getParameter("mode");
	if(!Admin.isW(pageAccessCode))
	{
		response.sendRedirect("homepage.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
		return;
	}
	if("news".equals(mode))
	{
		String nodeId = request .getParameter("news_page_id");
		String show  = request .getParameter("news_show");
		if(nodeId == null || nodeId.trim().length() == 0)
		{
			response.sendRedirect("homepage.jsp?error=1");
			return;
		}
		hp.setShowNews("1".equals(show));
		hp.setNewsNodeId(nodeId);
		response.sendRedirect("homepage.jsp?action_done=news");
		return;
	}
	if("banner".equals(mode))
	{
	    String [] img = request.getParameterValues("banner_img");
		String [] url = request.getParameterValues("banner_url");
		boolean show1 = "1".equals(request .getParameter("banner_show_1"));
		boolean show2 = "1".equals(request .getParameter("banner_show_2"));
		
        if(img != null && img.length == 2 && url != null && url.length == 2)
        {
            hp.setBanner(1, img[0], url[0], show1);
            hp.setBanner(2, img[1], url[1], show2);
        }
		response.sendRedirect("homepage.jsp?action_done=banner");
		return;
	}
	if("themes".equals(mode))
	{
        String submode = request.getParameter("submode");
        int status = ForumItem.MAIN_PAGE_THEME;
        if("unpubl".equals(submode))
            status = ForumItem.HOT_THEME;
        else if("unhot".equals(submode))
            status = ForumItem.SIMPLE_THEME;
        
        ForumItem theme = new ForumItem(DBObject.LOAD_LIST);

        try
        {
            String [] themeId = request.getParameterValues("theme_id");
            for(int i = 0; themeId != null && i < themeId.length; i++)
            {
                theme.reset();
                theme.load(themeId[i]);
                theme.setStatus(status);
                theme.save();
            }
            hp.dropForumThemes();
        }
        catch(Exception e)
        {
            response.sendRedirect("homepage.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING);
		    return;
        }
		response.sendRedirect("homepage.jsp?action_done=themes");
		return;
	}	
	response.sendRedirect("homepage.jsp");
%>