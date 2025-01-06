<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = Term.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	Enumeration enum = TermRequest.getTermRequests();
%>
<%
	String message = "";
	if("save".equals(request.getParameter("action_done")))
		message = "Термин сохранен.";
	else if("del".equals(request.getParameter("action_done")))
		message = "Выбранные запросы были удалены.";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Словарь"/>
<jsp:param name="header" value="Запросы на добавление терминов"/>
<jsp:param name="width" value="700"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="700">
<TR>
	<TD HEIGHT="16" COLSPAN="6" ALIGN="right">
		<A HREF="terms.jsp">термины словаря</A>
	</TD>
</TR>
<TR>
	<TD CLASS="c2" HEIGHT="16" COLSPAN="6" ALIGN="center">
		<B>Запросы</B>
	</TD>
</TR>


<TR>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">&nbsp;Дата&nbsp;</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="40%">&nbsp;Термин&nbsp;</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="60%">&nbsp;Кто прислал&nbsp;</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">&nbsp;Язык&nbsp;</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">&nbsp;Статус&nbsp;</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">&nbsp;Удалить&nbsp;</TD>
</TR>


<FORM ACTION="xt_requests.jsp" METHOD="POST" NAME="FORM">
<%
	while(enum.hasMoreElements()){
		TermRequest t = (TermRequest)enum.nextElement();
%>
<TR BGCOLOR="#F0F7FF">
	<TD ALIGN="center">
		&nbsp;<%= sdf.format(t.getRequestDate())%>
	</TD>
	<TD>
		&nbsp;<A HREF="request.jsp?id=<%=t.getId()%>"><%=CMSApplication.toHTML( t.getTerm())%></A>
	</TD>
	<TD>
		&nbsp;<%=CMSApplication.toHTML( t.getName())%>
		(<A HREF="mailto:<%=t.getEmail()%>"><%=CMSApplication.toHTML( t.getEmail())%></A>)
	</TD>
	<TD ALIGN="center">
		&nbsp;<%=(t.getLang()==CMSApplication.LANG_RUS ? "rus" : "eng")%>&nbsp;
	</TD>
	<TD ALIGN="center">
		&nbsp;<%
			switch(t.getStatus()){
				case TermRequest.STATUS_NEW:	out.print( "новый" ); break;
				case TermRequest.STATUS_VIEWED: break;
				case TermRequest.STATUS_DONE:	out.print( "исполнен" ); break;
			}
		%>&nbsp;
	</TD>
	<TD ALIGN="center">
		<INPUT TYPE="checkbox" NAME=del VALUE="<%=t.getId()%>">
	</TD>
</TR>
<%
	}
%>
<!-- белая полоска --><TR><TD COLSPAN="3"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>
<TR>
	<TD COLSPAN="6" ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Submit" VALUE="Сохранить изменения" ONCLICK="return confirm('Сохранить изменения?');">
	</TD>
</TR>
</TABLE>
<BR>
</FORM>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>

