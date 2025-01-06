<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.dict.*"%>
<%!
public static final char E = CMSApplication.LANG_ENG;
public static final char R = CMSApplication.LANG_RUS;
%>
<%
	response.setHeader("Pragma","no-cache");
	char lang = R;
	if(("" + E).equals(request .getParameter("lang")))
		lang = E;
	String nodeId = request.getParameter("id");
	String letter = request.getParameter("letter");
	String f_term = request.getParameter("f_term");
	String f_descr = request.getParameter("f_descr");
	String f_name = request.getParameter("f_name");
	String f_email = request.getParameter("f_email");
	
	String back = "/page.jsp?id=" + nodeId + "&lang=" + lang + "&letter=" + (letter != null ? letter : "");
	TermRequest tr = new TermRequest();
	tr.setTerm(f_term);
	tr.setDescr(f_descr);
	tr.setName(f_name);
	tr.setEmail(f_email);
	tr.setLang(lang);
	try
	{
		tr.save();
		back += "&ok=1";
	}
	catch(Exception e)
	{
		back += "&ok=0";
	}
	response.sendRedirect(back);
%>
