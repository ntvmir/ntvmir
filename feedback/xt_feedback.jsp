<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.mailer.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%
	response.setHeader("Pragma","no-cache");

	String nodeId = request.getParameter("id");
	String back = nodePath(nodeId) + "?";

	
	String toEmail = CMSApplication.getApplication().getProperty("mail.feedback");
	if(toEmail == null || toEmail.length() == 0)
	{
		CMSApplication.debug("[NTVMIR] Feedback email address property (\"mail.feedback\") doesn't present");
		response.sendRedirect(back + "&err=1");
		return;
	}
	
	
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String mailto = request.getParameter("mailto");
	String theme = request.getParameter("theme");
	String text = request.getParameter("text");
	
	
	Mailer letter = new Mailer();
	letter.setRecipient(toEmail);
	letter.setSender( email );
	letter.setSubject(mailto + ": " + theme);
	letter.setBody(
	"<B>Имя:</B> " + CMSApplication.toHTML(name) + "<BR>\n" + 
	"<B>E-mail:</B> " + CMSApplication.toHTML(email) + "<BR>\n" + 
	"<B>Тема:</B> " + CMSApplication.toHTML(theme) + "<BR><BR><HR>\n" + 
	text);

	try
	{
		letter.send();
		back += "&sent=1";
	}
	catch(Exception e)
	{
		back += "&err=1";
	}
	response.sendRedirect(back);
%>
