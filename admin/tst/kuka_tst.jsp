<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.forum.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%@include file="/inc/pagebar.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String forumId = request.getParameter("forum_id");
    String themeId = request.getParameter("theme_id");
    String create = request.getParameter("create");
    String edit = request.getParameter("edit");
    if("".equals(forumId))
        forumId = null;

    if(forumId != null)
    {
    Forum forum = new Forum();
    ForumGroup group = new ForumGroup();    
    forum.load(forumId);
    if(forum != null)
        group.load(forum.getForumGroupId());

    if(forum != null && group != null && forum.isVisible() && group.isVisible())
    {
        HttpServletResponse parentResponse = (HttpServletResponse) session.getAttribute("page.response");

        if(parentResponse != null)
        {
            java.text.SimpleDateFormat forumSdf = new java.text.SimpleDateFormat("dd.MM.yyyy-HH.mm.ss");
            String sDate =  forumSdf.format(new Date());
            CMSApplication.setCookie(parentResponse, "forum.last_view." + forum.getId(), sDate);
            out.println("forum.last_view." + forum.getId() + " -- "+ sDate);
        }
    }
    }
%>
