<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

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
<%@ page import="tengry.northgas.mailer.*"%>
<%  response.setHeader("Pragma","no-cache"); %>

<%
	String id = request.getParameter( "id" );

	String txt = request.getParameter( "txt" );
	
	Article article = new Article();
	article.load(id);
		
out.println("getWebPageId = " + article.getWebPageId() + "<BR>");
out.println("getCaptionRus = " + article.getCaptionRus() + "<BR>");
out.println("getBriefRus = " + article.getBriefRus() + "<BR>");
out.println("getContentRus = " + article.getContentRus() + "<BR>");
out.println("getAuthorRus = " + article.getAuthorRus() + "<BR>");
out.println("getPublisherRus = " + article.getPublisherRus()  + "<BR>");
out.println("getAnnounceRus = " + article.getAnnounceRus()  + "<BR>");
out.println("getPublisherurlRus = " + article.getPublisherurlRus()  + "<BR>");
out.println("getExtrainfourlRus = " + article.getExtrainfourlRus() + "<BR>");
out.println("getWebpagesurlRus = " + article.getWebpagesurlRus()  + "<BR><BR>");


	article.setContentRus( txt );
	article.save();

out.println("done");
%>
