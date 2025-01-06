<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.util.Hashtable" %>
<%@ page import="tengry.cms.core.*" %>
<%@ page import="tengry.cms.press.*" %>
<%@ page import="tengry.cms.dict.*" %>
<%@ page import="tengry.cms.user.*" %>
<%@ page import="tengry.cms.vote.*" %>
<%@ page import="tengry.cms.forum.*" %>
<%@ page import="tengry.cms.faq.*" %>
<%@ page import="tengry.ntvmir.tvschedule.*" %>
<%@ page import="tengry.ntvmir.*" %>
<%@ page import="tengry.cms.CMSApplication"%>
<%
    response.setHeader( "Pragma", "no-cache" );
    String title = request .getParameter("title");
    String header = request.getParameter("header");
    String message = request.getParameter("message");
    String width = request.getParameter("width");
    
    if(title == null)
		title = "Административная зона";
	
	if("".equals(header))
		header = null;
	
	if("".equals(message))
		message = null;
	
	if(width == null || "".equals(width))
		width = "100%";
	
	Admin admin = (Admin)session.getValue("admin.user");
	java.util.Enumeration services = CMSApplication.getApplication().getServices();
	Hashtable serviceHash = new Hashtable();
	while(services.hasMoreElements())
	{
	    Service srv = (Service)services.nextElement();
	    serviceHash.put(srv.getCode(), srv);
	}
%>
<%!
    public void printService(JspWriter out, Service srv, Admin admin) throws Exception
    {
        if(srv == null)
            return;
        if(admin != null && admin.isR(srv.getId()))
    		out.print("<A HREF=\"" + srv.getUrl() + "\">" + srv.getName() + "</A>");
    	else
    		out.print("<B STYLE=\"color: #888888;\">" + srv.getName() + "</B>");
    	out.println("<BR>");
    }
%>

<jsp:include page="/admin/inc/page_header.jsp" flush="true">
<jsp:param name="title" value="<%=title%>"/>
</jsp:include>

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD>
    <TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
    <TR>
    <TD VALIGN="bottom">
    <%printService(out, (Service)serviceHash.get(WebTreeNode.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(HomePage.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(Vote.SERVICE_CODE), admin);%>
    </TD>
    <TD WIDTH="20"><IMG SRC="/admin/img/blank.gif" WIDTH="20" HEIGHT="1"><BR></TD>

    <TD VALIGN="bottom">
    <%printService(out, (Service)serviceHash.get(Forum.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(News.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(Article.SERVICE_CODE), admin);%>
    <%//printService(out, (Service)serviceHash.get(Release.SERVICE_CODE), admin);%>
    </TD>
    <TD WIDTH="20"><IMG SRC="/admin/img/blank.gif" WIDTH="20" HEIGHT="1"><BR></TD>

<%--
    <TD VALIGN="bottom">
    <%printService(out, (Service)serviceHash.get(Forum.SERVICE_CODE), admin);%>
    <%//printService(out, (Service)serviceHash.get(Design.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(FileObject.SERVICE_CODE), admin);%>
--%>
    </TD>
    <TD WIDTH="20"><IMG SRC="/admin/img/blank.gif" WIDTH="20" HEIGHT="1"><BR></TD>

    <TD VALIGN="bottom">
    <%printService(out, (Service)serviceHash.get(Tvschedule.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(Tvannounce.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(FaqCategory.SERVICE_CODE), admin);%>
    </TD>
    <TD WIDTH="20"><IMG SRC="/admin/img/blank.gif" WIDTH="20" HEIGHT="1"><BR></TD>

    <TD VALIGN="bottom">
    <%printService(out, (Service)serviceHash.get(User.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get("message"), admin);%>
    <%printService(out, (Service)serviceHash.get("mailer"), admin);%>
    </TD>
    <TD WIDTH="20"><IMG SRC="/admin/img/blank.gif" WIDTH="20" HEIGHT="1"><BR></TD>

    <TD VALIGN="bottom">
    <%printService(out, (Service)serviceHash.get(FileObject.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(Admin.SERVICE_CODE), admin);%>
    <%printService(out, (Service)serviceHash.get(Journal.SERVICE_CODE), admin);%>
    </TD>
    </TR>
    </TABLE>
</TD>
</TR>
<!--TR>
<TD CLASS="c2" COLSPAN="11"></TD>
</TR-->
</TABLE>

<%@ include file="/admin/inc/error.jsp"%>
<TABLE WIDTH="<%=width%>" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<!-- ADMIN PAGE HEADER -->
<%	
	if(header != null)
	{
%>
<TR>
<TD ALIGN="center">
<DIV CLASS="page_header"><%=header%></DIV>
</TD>
</TR>
<%	}
	if(message != null)
	{
%>
<TR>
<TD ALIGN="center">
<SPAN CLASS="page_error"><%=message%></SPAN><BR><IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="10">
</TD>
</TR>
<%
	}
%>
<TR>
<TD>
