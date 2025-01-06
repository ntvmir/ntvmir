<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<% String pageId = "admin.index"; %>
<%@ include file="/admin/inc/page_init.jsp"%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Административная часть"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>

<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
