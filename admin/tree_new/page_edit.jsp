<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="tengry.northgas.*" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Vector" %>



<% String pageId = request.getParameter( "pageId" ); %>
<%@ include file="/admin/inc/authorize.jsp"%>




<%--
	Страница редактирования контента статических страниц сайта.
--%>
<%
    response.setHeader("Pragma","no-cache");


	boolean fromPreview = "1".equals( request.getParameter( "from_preview" ));
	
	
	// StaticContent content = new StaticContent();
	
	Vector content	= null;
	String nameRus = null;
	String nameEng = null;
	
	String nodeId 	= request.getParameter( "pageId" );
	String mode		= request.getParameter( "mode" );
	boolean isVisible;
	
	if( mode == null )
	{
		mode = "edit";
	}
	
	
	
	if( ! fromPreview )
	{
	
		WebPage wp = (WebPage) WebApp.getApp().getWebRoot().lookup( nodeId );
		if( wp == null )
			response.sendRedirect( "tree.jsp" );
	
		if( mode.equals( "edit" ) )
		{
			nameRus = wp.getNameRus();
			nameEng = wp.getNameEng();
			// загружаем контент
			try
			{
				content = StaticContent.load( nodeId, -1 );
				//content.load( nodeId.trim(), -1 );
			}
			catch( WebException we )
			{
				out.println( we.getOriginal().getMessage() );
				//response.sendRedirect( "tree.jsp" );
			}
		}
		if( content == null || content.size() == 0 )
		{
			content = new Vector();
			content.addElement( new StaticContent());
		}
		isVisible = wp.isVisible();
	}
	else   // from preview.
	{
		content = new Vector();
		int num = 1;
		try{ num = Integer.parseInt( request.getParameter( "frame_num" )); }catch( Exception e ){}
		for( int i = 0; i < num; i++ )
		{
			StaticContent cont = new StaticContent();
			cont.setContentRus( request.getParameter( "contentrus_" + i ));
			cont.setContentEng( request.getParameter( "contenteng_" + i ));
			int fn = i;
			try{ fn = Integer.parseInt( request.getParameter( "fnum_" + i )); }catch( Exception e ){}
			cont.setFrameNum( fn );
			content.add( cont );
		}
		nameRus = request.getParameter( "namerus" );
		nameEng = request.getParameter( "nameeng" );
		isVisible = "1".equals( request.getParameter( "visible" ));

	}
	
	if( nameRus == null ) nameRus = "";
	if( nameEng == null ) nameEng = "";
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>

<TITLE>Редактирование страницы</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">

<SCRIPT LANGUAGE="JavaScript">
function form_check( frm )
{
	if( frm.namerus.value.length==0 && frm.nameeng.value.length==0 )
	{
		frm.namerus.focus();
		alert('Не заполнен заголовок');
		return false;
	}
}

function goUrl( url )
{

	if( confirm( "ВНИМАНИЕ! Несохраненные изменения будут утеряны" )){
		document.location.href = url;
		return true;
//		document..href=url;
	}
	return false;
}

</SCRIPT>

</HEAD>

<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>

Редактирование
<BR>
<BR>

<FORM NAME="FRM_PAGE" ACTION="xt_tree.jsp" METHOD="post" ONSUBMIT="return form_check(this);">

<INPUT TYPE="Hidden" NAME="mode" VALUE="<%=mode%>">
<INPUT TYPE="Hidden" NAME="node" VALUE="<%=nodeId%>">


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
<TR>
<TD COLSPAN="3" ALIGN="CENTER">
<B>Статическая страница</B><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Заголовок</B><BR>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR></TD>
<TD CLASS="c2" WIDTH="50%">&nbsp;<B>Title</B></TD>
</TD>
</TR>

<TR>
<TD ALIGN="center">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="namerus" VALUE="<%= WebUtil.toHTML( nameRus ) %>" STYLE="width:100%" SIZE="59"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR></TD>
<TD ALIGN="center">
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
<INPUT TYPE="text" NAME="nameeng" VALUE="<%= WebUtil.toHTML( nameEng ) %>" STYLE="width:100%" SIZE="59"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Содержание</B>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR></TD>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Content</B>
</TD>
</TR>

<INPUT TYPE="Hidden" NAME="frame_num" VALUE="<%= content != null ? content.size() : -1 %>">
<INPUT TYPE="Hidden" NAME="num" VALUE="-1">

<%
for( int i = 0; i < content.size(); i ++ )
{
	StaticContent text = (StaticContent) content.elementAt(i);
%>
<!------ Код кадра <%=i%>   ------->

<%
	if( content.size() > 1 ){
%>

<!-- белая полоска --><TR><TD COLSPAN="3"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>
<TR BGCOLOR="#F0F7FF">
<TD ALIGN="left" COLSPAN="3" VALIGN="bottom" HEIGHT="16">&nbsp;<B>Кадр <%=(i+1)%></B></TD>
</TR>

<%
	}
%>
<INPUT TYPE="hidden" NAME="fnum_<%=i%>" VALUE="<%=text.getFrameNum()%>">
<TR BGCOLOR="#F0F7FF">
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<TEXTAREA NAME="contentrus_<%=i%>" ROWS=15 STYLE="width:100%" COLS="58" WRAP="PHYSICAL"><%=WebUtil.toHTML( text.getContentRus())%></TEXTAREA><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=10><BR>
	</TD>
	<TD>
		<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
	</TD>
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<TEXTAREA NAME="contenteng_<%=i%>" ROWS=15 STYLE="width:100%" COLS="58" WRAP="PHYSICAL"><%=WebUtil.toHTML( text.getContentEng())%></TEXTAREA><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=10><BR>
	</TD>
</TR>
<%
	if( content.size() > 1 ){
%>

<TR BGCOLOR="#F0F7FF">
<TD HEIGHT="30" ALIGN="center" VALIGN="top" COLSPAN="3"><INPUT TYPE="Button" VALUE="Удалить кадр" ONCLICK="if( confirm( 'ВНИМАНИЕ! Несохраненные изменения будут утеряны' )){ FRM_PAGE.mode.value='del_frame'; FRM_PAGE.num.value=<%=text.getFrameNum()%>; FRM_PAGE.submit(); }"></TD>
</TR>
<!--
<TR>
	<TD COLSPAN="3" align=center>Кадр <%=(i+1)%> (<a href="xt_tree.jsp?mode=del_frame&node=<%=nodeId%>&num=<%=text.getFrameNum()%>" onClick="return confirm( 'ВНИМАНИЕ! Несохраненные изменения будут утеряны.' )">удалить</a>)</TD>
</TR>
-->
<%
	}
%>
<!---\\  Код кадра <%=i%>    ------->
<%
}
if( "edit".equals( mode ))
{
%>
<TR>
<!-- белая полоска --><TR><TD COLSPAN="3"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=15><BR></TD></TR>
<TD COLSPAN="3" align=center HEIGHT="30" VALIGN="bottom">
<INPUT TYPE="Button" VALUE="Добавить кадр" ONCLICK="if( confirm( 'ВНИМАНИЕ! Несохраненные изменения будут утеряны' )){ FRM_PAGE.mode.value='add_frame'; FRM_PAGE.submit(); }">
</TD>
</TR>
<%
}
%>


<TR>
<TD ALIGN=left>
<BR>
<INPUT TYPE="Button" VALUE="Просмотр русской версии" ONCLICK="document.FRM_PAGE.action='previewpage.jsp'; document.FRM_PAGE.submit();">
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR></TD>
<TD ALIGN=right>
<BR>
<INPUT TYPE="Button" VALUE="Просмотр английской версии" ONCLICK="document.FRM_PAGE.action='previewpage.jsp?lang=E'; document.FRM_PAGE.submit();">
</TD>
</TR>

<TR>
<TD COLSPAN="3" ALIGN="center" HEIGHT="30">
<INPUT TYPE="Checkbox" NAME="visible" VALUE="1" <%= isVisible ? "CHECKED" : ""%>>видимая
<BR><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
<INPUT TYPE="Submit" VALUE="Сохранить изменения" ONCLICK="return confirm('Сохранить изменения?');">
</TD>
</TR>
</TABLE>
<BR>
</FORM>

</BODY>
</HTML>
