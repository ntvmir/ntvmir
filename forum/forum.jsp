<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.forum.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%@include file="/inc/pagebar.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%@ include file="/inc/path_init.jsp"%>
<%
    String forumId = request.getParameter("forum_id");
    String themeId = request.getParameter("theme_id");
    String create = request.getParameter("create");
    String edit = request.getParameter("edit");
    if("".equals(forumId))
        forumId = null;
try
{
    if(forumId != null && ("1".equals(create) || "1".equals(edit)))
    {
%>
<%@ include file="/forum/answer.jsp"%>
<%
    }
    else if(forumId == null)
    {
%>
<%@ include file="/forum/main_page.jsp"%>
<%
    }
    else if(themeId == null)
    {
%>
<%@ include file="/forum/forum_page.jsp"%>
<%
    }
    else
    {
%>
<%@ include file="/forum/theme_page.jsp"%>
<%
    }
%>
<%  }catch(Exception e){} %>