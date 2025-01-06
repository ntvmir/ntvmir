<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Vote.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request .getParameter("id");
	Vote vote = new Vote();
	vote.load(id);

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	String message = "";
%>

<%!
	private void printTree(JspWriter out, WebTreeNode node, String voteId, int level, String num) throws IOException, DBException
	{
	    String style = "c1";
	    if(voteId.equals(node.getVoteId()))
	        style = "c3";
	      
        out.println("<TR>");
        out.print("<TD CLASS=\"" + style + "\">");
        out.print( "<!-- распорка --><IMG SRC=\"/admin/img/blank.gif\" WIDTH=" );
		out.print( (level) * 14 );
		out.print( " HEIGHT=1 ALT=\"\" BORDER=\"0\" ALIGN=\"absmiddle\">" );
        out.print( "<INPUT TYPE=\"CHECKBOX\" NAME=\"node_id\" onClick=\"checkbox_click('" + num + "')\" VALUE=\"" );
		out.print( node.getId() );
		out.print( "\" ID=\"node" + num + "\" STYLE=\"width:15;height:15;\" BORDER=\"0\">" );
		out.println("&nbsp;" + node.getName());
        out.println("</TD>");
        out.println("</TR>");
	    
	    Enumeration enum = node.getChilds();
	    int i = 1;
	    while(enum.hasMoreElements())
	    	printTree(out, (WebTreeNode)enum.nextElement(), voteId, level+1, num + "_" + i++);
	}
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Размещение голосования"/>
<jsp:param name="header" value="Размещение голосования"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function checkbox_click(num)
{
	subCheckbox(num, eval( 'document.main_form.node' + num + '.checked' ));
}

function subCheckbox(num, ch)
{
	var i = 1;
	eval('document.main_form.node' + num + '.checked=' + ch);
	
	while(true)
	{
	    if( eval( 'document.main_form.node' + num + '_' + i) == null)
	        break;
	    subCheckbox(num + '_' + i, ch);
	    i++;
	}
}


</SCRIPT>

&nbsp;<A HREF="votes.jsp">назад к списку голосований</A><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>



<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<%  if( Admin.isP( pageAccessCode )){ %>
<FORM NAME="main_form" ACTION="xt_attach_vote.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id%>">
<INPUT TYPE="hidden" NAME="mode" VALUE="set">
<%  } %>
<TR>
<TD ALIGN="right" HEIGHT="16"><A HREF="vote_edit.jsp?id=<%=id%>">редактирование</A>&nbsp;<BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Голосование</B><BR></TD>
</TR>

<TR>
<TD CLASS="edit">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
&nbsp;(<%=sdf.format(vote.getCreateDate())%>)&nbsp;<B><%=CMSApplication.toHTML(vote.getQuestion())%></B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
</TD>
</TR>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>
</TABLE>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="1" WIDTH="700">
<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Размещение</B></TD>
</TR>

<% printTree(out, CMSApplication.getApplication().getWebRoot(langCode), id, 1, ""); %>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
</TABLE>
<%  if( Admin.isP( pageAccessCode )){ %>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">
<TR>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="Разместить на страницах" ONCLICK="document.main_form.mode.value='set'; document.main_form.submit();">
</TD>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="Снять со страниц" ONCLICK="document.main_form.mode.value='del'; document.main_form.submit();">
</TD>
</TR>
</FORM>
</TABLE>

<BR><BR>
&nbsp;<B STYLE="color=red;">Внимание!</B> Размещение голосования на странице автоматически снимает с нее голосование, размещенное ранее.
<%  } %>
<BR><BR>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">страницы на которых размещено голосование;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">страницы на которых не размещено голосование;</TD>
</TR>
</TABLE>
<BR><BR>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>


