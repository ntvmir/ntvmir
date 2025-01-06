<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Design.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter("id");
	String titl = (id == null ? "Варианты дизайна" : "Дизайн");
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Варианты дизайна"/>
<jsp:param name="header" value="<%=titl%>"/>
<jsp:param name="message" value=""/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<%
	if(id == null)
	{
		Enumeration enum = Design.getDesigns();
		Vector vv = new Vector();
		while(enum.hasMoreElements())
			vv.add(enum.nextElement());
%>
<SCRIPT LANGUAGE="javascript">
	function viewPicture( str, w, h ){
		ww = w + 35;
		hh = h + 100;
		dw = 7;
		dh = 7;
			
		win = window.open( "", "some_window_with_unique_name", 
			  "width=" + ww + ",height=" + hh + "," +
			  "status=no,toolbar=no,menubar=no,resizable=yes");
		win.resizeTo( ww, hh );
		win.document.open();
		win.document.write(
			"<HTML>\n"+
			"<HEAD>\n"+
			"	<TITLE></TITLE>\n"+
			"	<META NAME=\"version\" CONTENT=\"HTML 4.0\">\n"+
			"	<META HTTP-EQUIV=\"content-type\" CONTENT=\"text/html; charset=windows-1251\">\n"+
			"	<META HTTP-EQUIV=\"content-language\" CONTENT=\"ru-RU\">\n"+
			"</HEAD>\n"+
			'<BODY TOPMARGIN="0" LEFTMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" BGCOLOR="#FFFFFF" TEXT="#000000">\n'+
			"<BR>\n"+
			'<DIV ALIGN=center><A HREF="javascript:window.close()" TITLE="закрыть"><IMG SRC="' + str + '" border=0 width=' + w + ' height=' + h + '></A></DIV>\n' +
			'<BR>\n' +
			"</BODY>\n"+
			"</HTML>\n" );
		win.focus();
	}
</SCRIPT>
<FORM ACTION="xt_design.jsp" METHOD="get" NAME="FORM">
<INPUT TYPE="hidden" NAME="action" VALUE="set">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
<TR>
<TD COLSPAN="5" ALIGN="right">
<A HREF="design.jsp?id=">добавить дизайн</A>
</TD>
</TR>
<%
	for(int i = 0; i < vv.size(); i++)
	{
		Design des = (Design)vv.elementAt(i);
%>
<!-- белая полоска --><TR><TD COLSPAN="5"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>

<TR BGCOLOR="#F0F7FF">
	<TD ALIGN="center" WIDTH="1%">
		<INPUT TYPE="radio" NAME="id" VALUE="<%=des.getId()%>"<%= des.isSelected() ? " CHECKED" : ""%>>
	</TD>
	<TD ALIGN="center" WIDTH="1%">
		<IMG SRC="/admin/img/blank.gif" WIDTH=10 HEIGHT=1><A HREF="javascript:viewPicture('<%=des.getPath()%>/design.jpg', 341, 341 )"><IMG SRC="<%=des.getPath()%>/design_small.jpg" ALT="Увеличить" WIDTH=100 HEIGHT=100 BORDER="0"></A><IMG SRC="/admin/img/blank.gif" WIDTH=10 HEIGHT=1>
	</TD>
	<TD WIDTH="1%"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=1><BR>
	</TD>
	<TD>
		<A HREF="design.jsp?id=<%=des.getId()%>" WIDTH="100%"><%=CMSApplication.toHTML( des.getName())%></A><BR>
		<%=CMSApplication.toHTML(des.getDescription())%>
	</TD>
	<TD WIDTH="1%">
	<% if(vv.size() > 0 && !des.isSelected()){ %><A HREF="xt_design.jsp?action=del&id=<%=des.getId()%>">удалить</A><% } %>
	</TD>
</TR>
<%
	} 
%>
<TR>
	<TD COLSPAN="4" ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Submit" VALUE="Установить" ONCLICK="return confirm('Установить?');">
	</TD>
</TR>

</TABLE>
<BR>
</FORM>
<%
	}
	else
	{
		Design des = new Design();
		if(id.length() > 0)
			des.load(id);
%>
<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	var frm = document.main_form;
	if(frm.f_name.value == '')
	{
		alert("Не заполнено поле Название");
		frm.f_name.focus();
		return;
	}
	if(frm.f_path.value == '')
	{
		alert("Не заполнено поле Путь");
		frm.f_path.focus();
		return;
	}
	if(confirm("Сохранить изменения?"))
		frm.submit();
}
</SCRIPT>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="1" WIDTH="100%">
<TR>
<TD COLSPAN="2" ALIGN="right">
<A HREF="design.jsp">назад</A>
</TD>
</TR>
<TR>
<FORM ACTION="xt_design.jsp" NAME="main_form" METHOD="get" NAME="FORM">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id%>">
<INPUT TYPE="hidden" NAME="action" VALUE="save">
<TD CLASS="c2" WIDTH=30%>
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
Название:
</DIV>
</TD>
<TD CLASS="c1">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
<INPUT NAME="f_name" STYLE="width: 350;" VALUE="<%=CMSApplication.toHTML(des.getName())%>">
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
Путь:
</DIV>
</TD>
<TD CLASS="c1">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
<INPUT NAME="f_path" STYLE="width: 350;" VALUE="<%=CMSApplication.toHTML(des.getPath())%>">
</DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
Описание:
</DIV>
</TD>
<TD CLASS="c1">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
<TEXTAREA NAME="f_descr" STYLE="width: 350;"><%=CMSApplication.toHTML(des.getDescription())%></TEXTAREA>
</DIV>
</TD>
</TR>

<TR>
<TD COLSPAN="2" ALIGN="center">
<INPUT TYPE="button" VALUE="Сохранить" onClick="submitForm();">
</TD>
</FORM>
</TABLE>
<%
	}
%>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
