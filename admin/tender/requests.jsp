<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = TenderRequest.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%!
	String buildPath(WebTreeNode node)
	{
		if(node == null) return "";
		if(node.getParent() == null)
			return node.getNameRus();
		return buildPath(node.getParent()) + "/" + node.getNameRus();
	}
%>
<%
	Enumeration enum = CMSApplication.getApplication().getNodesByTypeCode(TenderRequest.SERVICE_CODE);
	
	DBStatement st = new DBStatement(
		" SELECT m_web_page_id, count(*) AS num " +
		" FROM ent_tender_request " +
		" GROUP BY m_web_page_id");
	RS rs = st.executeQuery();
	Hashtable nums = new Hashtable();
	while(rs.next())
	{
		String id = rs.getString("m_web_page_id");
		nums.put(id, new Integer(rs.getInt("num")));
	}
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Тендерные заявки"/>
<jsp:param name="header" value="Тендерные заявки"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD HEIGHT="20" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
Тендер
</B></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>всего заявок</NOBR></B></DIV>
</TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		WebTreeNode node = (WebTreeNode)enum.nextElement();
		Integer nn = (Integer)nums.get(node.getId());
		int num = (nn == null ? 0 : nn.intValue());
		
		String style = node.isVisible() ? "c1" : "c3";
		String sPrivate = isPagePrivate(node.getId()) ? "<B STYLE=\"color: red;\">*</B>" : "";
%>
<TR>
<TD HEIGHT="20" CLASS="<%=style%>">
<DIV STYLE="padding-left:6px;padding-right:6px">
<%		if(currentAdmin.isR(node.getId())) { %>
<%=sPrivate%><A HREF="request_list.jsp?page_id=<%=node.getId()%>"><%=buildPath(node)%></A>
<%		}else{ %>
<%=sPrivate + buildPath(node)%>
<%		} %>
</DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=num%></DIV></TD>
</TR>
<%	
		l++;
	} 
%>
</TABLE>
<BR><BR>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD ROWSPAN="3" WIDTH="10"><IMG SRC="/admin/img/blank.gif" WIDTH="10" HEIGHT="1"><BR></TD>
<TD WIDTH="15" ALIGN="center"><B STYLE="color: red;">*</B></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">заполнение заявки доступно только для зарегистрированных пользователей;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">заполнение заявок открыто в пользовательской части;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">заполнение заявок заблокировано в пользовательской части;</TD>
</TR>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
