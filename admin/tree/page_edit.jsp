<%--
Parameters:
	"page_id"
		values:	correct page id
		descr:	the parent node id
	"mode"
		values:	"add", "edit"
		descr:	what to do
--%>
<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<% String pageId = request.getParameter( "page_id" ); %>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%
	CMSApplication app = CMSApplication.getApplication();
	String nodeId 	= request.getParameter( "page_id" );
	String mode		= request.getParameter( "mode" );

	Vector content	= null;
	String name = null;
	String code = null;
	
	boolean visible = false;
	boolean isPrivate = false;
	String error = "";
	boolean codeEditable = true;
	
	if( mode == null )
		mode = "edit";
	
	PageType pageType = app.getPageTypeByCode("static");
	String header;
	if("add".equals(mode))
		header = "Добавление страницы";
	else
		header = "Редактирование страницы";
	header += ": " + pageType.getTypeName();
	String title = "Дерево сайта";
	
	
	WebTreeNode wp = (WebTreeNode) app.lookup( nodeId );
	if( wp == null )
		response.sendRedirect( "tree.jsp" );
		
	
	    
	if(mode.equals( "edit" ))
	{
		name = wp.getName();
		code = wp.getCode();
		visible = wp.isVisible();
		if(wp.getParent() == null || wp.getParent().getParent() == null)
	        codeEditable = false;
		isPrivate = isPagePrivate(wp.getId());
		// загружаем контент
		try
		{
			content = StaticPage.getStaticPages(nodeId);
		}
		catch( DBException we )
		{
			out.println(we.getOriginal());
			//response.sendRedirect( "tree.jsp" );
		}
	}
	if( content == null || content.size() == 0 )
	{
		content = new Vector();
		content.addElement(new StaticPage());
	}

	if( name == null ) name = "";
	if( code == null ) code = "";
%>
<%
String message = request.getParameter("action_done");
if("1".equals(message))
	error = "Кадр добавлен";
else if("2".equals(message))
	error = "Кадр удален";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Дерево сайта"/>
<jsp:param name="width" value="<%=900%>"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="message" value="<%=error%>"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<%@ include file="/admin/inc/editor/editor_init.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
function submitForm()
{
	wysiwygPrepareParams('frm_page');
	if(document.frm_page.name.value == '')
	{
		alert("Не указан заголовок.");
		document.frm_page.name.focus();
		return;
	}
	if(document.frm_page.code.value == '')
	{
		alert("Не указан код.");
		document.frm_page.code.focus();
		return;
	}
	if(confirm('Сохранить изменения?'))
	{
		document.frm_page.submit();
	}
}

function preview()
{
	window.open('','preview','');
	wysiwygPrepareParams('frm_page');
	document.forms.frm_page.target = 'preview';
	document.forms.frm_page.action = 'preview.jsp';
	document.forms.frm_page.submit();
	document.forms.frm_page.action = 'xt_tree.jsp';
	document.forms.frm_page.target='_self';
}
</SCRIPT>

<FORM NAME="frm_page" ACTION="xt_tree.jsp" METHOD="post" ONSUBMIT="return form_check(this);">
<INPUT TYPE="Hidden" NAME="mode" VALUE="<%=mode%>">
<INPUT TYPE="Hidden" NAME="node" VALUE="<%=nodeId%>">
<INPUT TYPE="Hidden" NAME="page_type" VALUE="<%=pageType.getCode()%>">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700" ALIGN="center">
<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Заголовок</B><BR></TD>
</TR>

<TR>
<TD ALIGN="center">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="name" VALUE="<%= CMSApplication.toHTML(name) %>" STYLE="width:100%" SIZE="59"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="100%">&nbsp;<B>Код</B><BR></TD>
</TR>

<TR>
<TD ALIGN="left">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%  if(codeEditable){ %>
<INPUT TYPE="text" NAME="code" VALUE="<%= CMSApplication.toHTML(code) %>" STYLE="width:100%" SIZE="59"><BR>
<%  } else { %>
<INPUT TYPE="hidden" NAME="code" VALUE="<%= CMSApplication.toHTML(code) %>">
<%= CMSApplication.toHTML(code) %><BR>
<%  } %>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Содержание</B></TD>
</TR>

<INPUT TYPE="Hidden" NAME="frame_num" VALUE="<%= content != null ? content.size() : -1 %>">
<INPUT TYPE="Hidden" NAME="frame_id" VALUE="">

<%
for( int i = 0; i < content.size(); i ++ )
{
	StaticPage text = (StaticPage)content.elementAt(i);
%>
<!------ Код кадра <%=i%>   ------->

<%
	if( content.size() > 1 ){
%>

<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>
<TR CLASS="edit">
<TD ALIGN="left" VALIGN="bottom" HEIGHT="16">&nbsp;<B>Кадр <%=(i+1)%></B></TD>
</TR>

<%
	}
%>
<INPUT TYPE="hidden" NAME="fnum_<%=i%>" VALUE="<%=text.getOrderNumber()%>">
<TR CLASS="edit">
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<%
	wysiwygName = "content_" + i;
	wysiwygWidth = 700;
	wysiwygHeight = 300;
	wysiwygValue = text.getContent();
%>
<%@ include file="/admin/inc/editor/textarea.jsp"%>
	</TD>
</TR>
<%
	if( content.size() > 1 ){
%>

<TR CLASS="edit">
<TD HEIGHT="30" ALIGN="center"><INPUT TYPE="Button" VALUE="Удалить кадр" ONCLICK="if( confirm( 'ВНИМАНИЕ! Несохраненные изменения будут утеряны' )){ frm_page.mode.value='del_frame'; frm_page.frame_id.value='<%=text.getId()%>'; frm_page.submit(); }"></TD>
</TR>

<%
	}
%>
<!---\\  Код кадра <%=i%>    ------->
<%
}
if( "edit".equals( mode ))
{
%>
<!-- белая полоска --><TR><TD><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TR>
<TD align="left" HEIGHT="30" VALIGN="bottom">
<INPUT TYPE="Button" VALUE="Добавить кадр" ONCLICK="if( confirm( 'ВНИМАНИЕ! Несохраненные изменения будут утеряны' )){ frm_page.mode.value='add_frame'; frm_page.submit(); }">
</TD>
</TR>
<%
}
%>


<TR>
<TD ALIGN=left>
<BR>
<INPUT TYPE="Button" VALUE="Просмотр страницы" ONCLICK="preview();">
</TD>
</TR>

<TR>
<TD ALIGN="left">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR><TD ALIGN="left">
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1"<%=visible ? " CHECKED" : ""%> ID="ckb_vis"><LABEL FOR="ckb_vis">видимая</LABEL><BR>
<INPUT TYPE="Checkbox" NAME="private" VALUE="1"<%=isPrivate ? " CHECKED" : ""%> ID="ckb_priv"><LABEL FOR="ckb_priv">доступ только для зарегистрированных пользователей</LABEL>
</TD></TR>
</TABLE>
</TD>
</TR>

<TR>
<TD ALIGN="center" HEIGHT="30">
<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="button" VALUE="Сохранить изменения" ONCLICK="submitForm();">
</TD>
</TR>
</TABLE>
<BR>
</FORM>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
