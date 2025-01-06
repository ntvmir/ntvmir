<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.tender.*"%>
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
	String back = "/page.jsp?id=" + nodeId + "&lang=" + lang;

	TenderRequest tr = new TenderRequest();
	tr.setWebPageId(nodeId);
	tr.setCountryId(request.getParameter("f_country"));
	tr.setCompany(request.getParameter("f_company"));
	tr.setEmail(request.getParameter("f_email"));
	tr.setFirstName(request.getParameter("f_name"));
	tr.setLastName(request.getParameter("f_name"));
	tr.setPosition(request.getParameter("f_position"));
	tr.setCity(request.getParameter("f_city"));
	tr.setAddress(request.getParameter("f_address"));
	tr.setPhone(request.getParameter("f_phone"));
	tr.setFax(request.getParameter("f_fax"));
	tr.setUrl(request.getParameter("f_url"));
	tr.setAmount(request.getParameter("f_amount"));
	tr.setPrice(request.getParameter("f_price"));
	tr.setDescription(request.getParameter("f_descr"));

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
