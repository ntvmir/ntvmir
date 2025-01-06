<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.db.*"%>
<%@ page import="tengry.cms.user.*"%>
<%@ page import="tengry.cms.tender.*"%>
<%@ page import="tengry.cms.press.*"%>
<%@ page import="tengry.cms.product.*"%>
<%@ page import="tengry.cms.dict.*"%>
<%@ page import="tengry.cms.vote.*"%>
<%@ page import="tengry.cms.faq.*"%>
<%@ page import="tengry.cms.forum.*"%>
<%@ page import="tengry.cms.mailer.*"%>
<%@ include file="/admin/inc/authorize.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String langCode = request.getParameter("lang_code");
    if(langCode == null || langCode.trim().length() == 0)
        langCode = CMSApplication.getApplication().getPrimaryLangCode();
%>