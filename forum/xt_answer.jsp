<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.forum.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String forumId = request.getParameter("forum_id");
    String themeId = request.getParameter("theme_id");
    String itemId = request.getParameter("item_id");

    Forum       forum   = new Forum();
    ForumGroup  group   = new ForumGroup();
    ForumItem   theme   = null;

try{
    forum.load(forumId);
    group.load(forum.getForumGroupId());
    boolean isModerator = (user != null && !user.isDisabled() && forum != null && forum.isModerator(user.getId()));

    if(themeId != null && themeId.length() > 0)
    {
        theme = new ForumItem();
        theme.load(themeId);
    }
    
    if(user != null  && !user.isDisabled() && forum != null && group != null &&
        forum.isVisible() && group.isVisible() && (isModerator || theme == null || theme.getPublicDate() != null || theme.getThemeId() != null))
    {
        String name = request.getParameter("header");
        String text = request.getParameter("message");
        
        ForumItem   message = new ForumItem();
        if(itemId != null && itemId.length() > 0)
        {
            message.load(itemId);
        }
        else
        {
            message.setForumId(forum.getId());
            if(theme != null)
                message.setThemeId(theme.getId());
            message.setUserId(user.getId());
        }
        message.setHeader(name);
        message.setText(text);
        if(forum.getStatus() == Forum.NON_MODERATED)
            message.setPublic(true);
        message.save();
    }
}catch(Exception e){}
    if(theme != null)
        response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId() + "&theme_id=" + themeId);
    else
        response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId());
%>