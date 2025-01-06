<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ include file="/inc/page_init.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String sectionImgDir = sectionCode;

    if("tvschedule".equals(sectionCode))
        sectionImgDir = "tvprogram";
    
	PageType pageType;
	
	if(previewInfo == null)
		pageType = node.getPageType();
	else
		pageType = (PageType)previewInfo.get("pagetype");

	String allParams = "?id=" + (node != null ? node.getId() : "");
	for(int i = 0; i < parameters.length; i++)
		if(!parameters[i].startsWith("page_id="))
			allParams += "&" + CMSApplication.URLEncode(parameters[i]);
    
//    out.println( "value: " + CMSApplication.getCookie(request, "forum.last_view." + request.getParameter("forum_id")) + "<br>");
    out.println( "value: " + CMSApplication.getCookie(request, "kuka") + "<br>");
    
    // для того, что б инклюдящиеся страницы могли устанавливать куки
    session.setAttribute("page.response", response);
    int num = 1;
    try{num = Integer.parseInt(request.getParameter("num")); }catch(Exception e){}
    
    for(int i = 0; i < num; i++)
    {
%>
123456789
<%  } %><%
    out.flush();
    java.text.SimpleDateFormat forumSdf = new java.text.SimpleDateFormat("dd.MM.yyyy-HH.mm.ss");
    String sDate =  forumSdf.format(new Date());
    CMSApplication.setCookie(response, "kuka", sDate);
//	pageContext.include("kuka_tst.jsp" + allParams);
%>
1233333333333333333333
312222222222222222
