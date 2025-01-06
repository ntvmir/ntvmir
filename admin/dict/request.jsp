<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = Term.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter( "id" );
	if("".equals(id))
		id = null;

	TermRequest t = new TermRequest();
	if( id != null )
		t.load( id );
	t.setStatus( TermRequest.STATUS_VIEWED );
	t.save();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Словарь"/>
<jsp:param name="header" value="Запрос на добавление термина"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>

<A HREF="requests.jsp">назад</A>
<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="655">
<TR CLASS="c2">
	<TD HEIGHT="16">&nbsp;Термин:</TD>
	<TD>&nbsp;<B><%=CMSApplication.toHTML( t.getTerm())%></B></TD>
</TR>

<TR BGCOLOR="#F0F7FF">
	<TD HEIGHT="16">&nbsp;Комментарий:</TD>
	<TD>&nbsp;<%=CMSApplication.toHTML( t.getDescr() )%></TD>
</TR>

<TR BGCOLOR="#F0F7FF">
	<TD HEIGHT="16">&nbsp;Дата:</TD>
	<TD>&nbsp;<%=sdf.format( t.getRequestDate())%></TD>
</TR>

<TR BGCOLOR="#F0F7FF">
	<TD HEIGHT="16">&nbsp;Часть сайта:</TD>
	<TD>&nbsp;<%=t.getLang()==CMSApplication.LANG_RUS? "русская":"английская"%></TD>
</TR>

<TR BGCOLOR="#F0F7FF">
	<TD HEIGHT="16">&nbsp;Прислал:</TD>
	<TD>&nbsp;<%=CMSApplication.toHTML( t.getName() )%></TD>
</TR>

<TR BGCOLOR="#F0F7FF">
	<TD HEIGHT="16">&nbsp;E-mail:</TD>
	<TD>&nbsp;<A HREF="mailto:<%=t.getEmail()%>"><%=CMSApplication.toHTML( t.getEmail() )%></A></TD>
</TR>

<!-- белая полоска --><TR><TD COLSPAN="3"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR>
	<TD CLASS="c2" COLSPAN="2" HEIGHT="16" ALIGN="center"><A HREF="term.jsp?request=<%=t.getId()%>">Добавить термин</A></TD>
</TR>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
