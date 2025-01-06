<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.faq.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String themeId = request.getParameter("theme_id");
    String redirect = nodePath(pageId) + "?";
    String themePage = request.getParameter("theme_page");
    
    if("1".equals(themePage))
        redirect += "&theme_id=" + themeId;

    FaqQuestion faq   = new FaqQuestion();
    FaqCategory fqc   = new FaqCategory();
    try
    {
        fqc.load(themeId);
        if(!fqc.isVisible())
            throw new CMSException("Can't add question to unpubl theme.");
        faq.setFaqCategoryId(themeId);
        faq.setEmail(request.getParameter("email"));
        faq.setUserName(request.getParameter("name"));
        faq.setQuestion(request.getParameter("text"));
        faq.save();
        redirect += "&sent=1";
    }
    catch(Exception e)
    {
        redirect += "?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING;
    }
    response.sendRedirect(redirect);
%>