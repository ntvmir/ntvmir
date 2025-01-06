<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.ntvmir.*"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%

    String redirect = "index1.jsp?";


    String langCode = CMSApplication.getApplication().getPrimaryLangCode();
    ShowPlace showPlace = null;

    String spId = CMSApplication.getCookie(request, "tvschedule.showplace");
    if(spId != null && spId.length() > 0)
    {
        try{
            showPlace = ShowPlace.getShowPlace(langCode, spId);
        }catch(Exception e)
        {
            showPlace = null;
        }
    }
    
    if(showPlace == null)
    {
        showPlace = ShowPlace.getDefaultShowPlace(langCode);
    }
    
    if(showPlace != null)
        redirect += "&showplace_id=" + showPlace.getId();

%>
<jsp:forward page="<%=redirect%>"/>
<%
//    response.sendRedirect(redirect);
%>