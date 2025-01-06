<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%
//    out.println("ip: " + request.getRemoteAddr());
//    out.println("url = " + request.getHeader("REDIRECT_URL"));
    String urla = request.getHeader("REDIRECT_URL");
    if(urla == null)
        urla = "";
    WebTreeNode node = null;
    StringTokenizer st = new StringTokenizer(urla, "/");
    while(st.hasMoreTokens())
    {
        String name = st.nextToken();
        if(node == null && "pages".equals(name))
            continue;
        if(node == null)
            node = CMSApplication.getApplication().getWebRoot(name);
        else
            node = node.getChild(name);
        if(node == null)
            break;
    }
    String queryString = request.getHeader("REDIRECT_QUERY_STRING");

    if(queryString == null)
        queryString = "";
    if(queryString.length() > 0 && '&' != queryString.charAt(0))
        queryString = "&" + queryString;

    String redirect = "page.jsp?id=" + (node != null ? node.getId() : "" ) + queryString;
//    response.sendRedirect(redirect);
//    pageContext.forward(redirect);
%>
<jsp:forward page="<%=redirect%>"/>
