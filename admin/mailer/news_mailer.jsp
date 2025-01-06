<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = NewsFields.SERVICE_CODE;
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
	String message = "";
	if ("1".equals(request.getParameter("err_msg")))
	{
		message = "ошибка изменения данных!";
	};
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Параметры рассылки новостей"/>
<jsp:param name="header" value="Параметры рассылки новостей"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>	
<%
	Enumeration enum = CMSApplication.getApplication().getNodesByTypeCode(News.SERVICE_CODE);
	
	DBStatement st = new DBStatement(
		" SELECT m_web_page_id, m_visible_rus, m_visible_eng, count(*) AS num " +
		" FROM ent_news " +
		" GROUP BY m_web_page_id, m_visible_rus, m_visible_eng");
	RS rs = st.executeQuery();
	Hashtable nums = new Hashtable();
	while(rs.next())
	{
		String id = rs.getString("m_web_page_id");
		int [] nn = (int[])nums.get(id);
		if(nn == null)
		{
			nn = new int[] {0, 0, 0, 0};
			nums.put(id, nn);
		}
		int num = rs.getInt("num");
		if(rs.getBoolean("m_visible_rus"))
			nn[0] += num;
		if(rs.getBoolean("m_visible_eng"))
			nn[1] += num;
		if(!rs.getBoolean("m_visible_rus") && !rs.getBoolean("m_visible_eng"))
			nn[2] += num;
		nn[3] += num;
	}
%>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD HEIGHT="20" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
новостная лента
</B></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>рус.</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>англ.</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>не опубл.</NOBR></B></DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px"><B>
<NOBR>всего</NOBR></B></DIV>
</TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		WebTreeNode node = (WebTreeNode)enum.nextElement();
		int [] nn = (int[])nums.get(node.getId());
		if(nn == null)
			nn = new int[] {0,0,0,0};
		String style = node.isVisible() ? "c1" : "c3";
		String sPrivate = isPagePrivate(node.getId()) ? "<B STYLE=\"color: red;\">*</B>" : "";
%>
<TR>
<TD HEIGHT="20" CLASS="<%=style%>">
<DIV STYLE="padding-left:6px;padding-right:6px">
<%		if(currentAdmin.isR(node.getId())) { %>
<%=sPrivate%><A HREF="news_mailer_edit.jsp?news_page_id=<%=node.getId()%>"><%=buildPath(node)%></A>
<%		}else{ %>
<%=sPrivate + buildPath(node)%>
<%		} %>
</DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=nn[0]%></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=nn[1]%></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=nn[2]%></DIV></TD>
<TD HEIGHT="20" WIDTH="1%" ALIGN="right" CLASS="<%=style%>"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=nn[3]%></DIV></TD>
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
<TD ALIGN="left">просмотр ленты доступен только для зарегистрированных пользователей;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">лента опубликована в пользовательской части;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">лента не опубликована в пользовательской части;</TD>
</TR>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
