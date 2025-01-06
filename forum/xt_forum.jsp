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
    String action = request.getParameter("action");

    Forum       forum   = new Forum();
    ForumItem   item   = null;
    
try
{
    forum.load(forumId);
    if(user != null  && !user.isDisabled() && forum.isModerator(user.getId()))
    {
        if("del".equals(action))
        {
            try
            {
                item = new ForumItem();
                item.load(itemId);
                item.remove();
            }
            catch(Exception e)
            {
                response.sendRedirect("/pages/" + langCode + "/forum?err=del&forum_id=" + forum.getId() + "&theme_id=" + themeId);
                return;
            }
            if(themeId.equals(itemId))
                response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId());
            else
                response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId() + "&theme_id=" + themeId);
            return;
        }
        else if("publ".equals(action))
        {
            try
            {
                item = new ForumItem();
                item.load(itemId);
                item.setPublic(true);
                item.save();
            }
            catch(Exception e)
            {
                response.sendRedirect("/pages/" + langCode + "/forum?err=publ&forum_id=" + forum.getId() + "&theme_id=" + themeId);
                return;
            }
            response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId() + "&theme_id=" + themeId);
            return;
        }
        else if("close".equals(action))
        {
            try
            {
                item = new ForumItem();
                item.load(themeId);
                
                if(item.getStatus() != ForumItem.MAIN_PAGE_THEME)
                {
                    item.setStatus(ForumItem.CLOSED_THEME);
                    item.save();
                }
            }
            catch(Exception e)
            {
                response.sendRedirect("/pages/" + langCode + "/forum?err=close&forum_id=" + forum.getId());
                return;
            }
            response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId());
            return;
        }
        else if("hot".equals(action))
        {
            try
            {
                item = new ForumItem();
                item.load(themeId);
                
                if(item.getStatus() != ForumItem.MAIN_PAGE_THEME && item.getStatus() != ForumItem.CLOSED_THEME)
                {
                    item.setStatus(ForumItem.HOT_THEME);
                    item.save();
                }
            }
            catch(Exception e)
            {
                response.sendRedirect("/pages/" + langCode + "/forum?err=hot&forum_id=" + forum.getId());
                return;
            }
            response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId());
            return;
        }
        else if("simple".equals(action))
        {
            try
            {
                item = new ForumItem();
                item.load(themeId);
                
                if(item.getStatus() != ForumItem.MAIN_PAGE_THEME && item.getStatus() != ForumItem.CLOSED_THEME)
                {
                    item.setStatus(ForumItem.SIMPLE_THEME);
                    item.save();
                }
            }
            catch(Exception e)
            {
                response.sendRedirect("/pages/" + langCode + "/forum?err=hot&forum_id=" + forum.getId());
                return;
            }
            response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId());
            return;
        }
    }
}catch(Exception e){}
    response.sendRedirect("/pages/" + langCode + "/forum?forum_id=" + forum.getId());
%>
