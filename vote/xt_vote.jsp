<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.vote.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String voteId = request.getParameter("vote_id");
    String redirect = "/page.jsp?id=" + pageId;
    String userIP = request.getRemoteAddr();
    
    try
    {
        Vote vote = new Vote();
        vote.load(voteId);
        String [] items = request.getParameterValues("vote_item_id");
        vote.vote(userIP, items);
    }
    catch(Exception e){}
    response.sendRedirect(redirect);
%>