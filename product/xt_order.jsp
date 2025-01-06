<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.product.*"%>
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

	Order order	= new Order();

	order.setName(request.getParameter("f_name"));
	order.setPosition( request.getParameter("f_position"));
	order.setCompany( request.getParameter("f_company"));
	order.setCompanyType( "P".equals(request.getParameter("f_company_type")) ? Order.COMPANY_PRODUCER : Order.COMPANY_TRADER );
	order.setCountryId( request.getParameter("f_country_id") );
	order.setCity( request.getParameter("f_city") );
	order.setAddress( request.getParameter("f_address") );
	order.setPhone( request.getParameter("f_phone") );
	order.setFax( request.getParameter("f_fax") );
	order.setEmail( request.getParameter("f_email") );
	order.setUrl(request.getParameter("f_url"));
	order.setFrequency( "many".equals(request.getParameter("f_frequency")) ? Order.FREQUENCY_MANY : Order.FREQUENCY_ONE );
	order.setExperience("yes".equals(request.getParameter("f_experience")));
	order.setConditions(request.getParameter("f_conditions"));
	try
	{
		order.save();
	}
	catch(Exception e)
	{
		response.sendRedirect(back + "&ok=0");
		return;
	}

	int ll = 0;
	try{ ll = Integer.parseInt(request.getParameter("f_prod_num")); }catch(Exception e){}
	for(int i = 0; i < ll; i++)
	{
		String prodId = request.getParameter("f_prod_id_" + (i+1));
		int vol = -1;
		try{ vol = Integer.parseInt(request.getParameter("f_volume_" + (i+1))); }catch(Exception e){}
		if(vol > 0)
			order.setProduct(prodId, vol);
	}

	response.sendRedirect(back + "&ok=1");
%>
