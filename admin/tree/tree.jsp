<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = "tree";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%
	WebTreeNode root = CMSApplication.getApplication().getWebRoot(langCode);
	String error = request.getParameter("error");
	if("1".equals(error))
		error = "—траница имеет подчиненные страницы. ”даление запрещено.";
	else if("2".equals(error))
		error = "”даление типизированных страниц запрещено.";
	else
		error = "";
%>

<%!
	private void printTree(HttpSession ses, JspWriter out, Enumeration childs, int level) throws IOException, DBException
	{
		ArrayList expandedNodes = (ArrayList) ses.getValue( "tree.expanded.nodes" );
		if( expandedNodes == null )
		{
			expandedNodes = new ArrayList();
			ses.putValue( "tree.expanded.nodes", expandedNodes );
		}
		while( childs.hasMoreElements() )
		{
			WebTreeNode wp = (WebTreeNode) childs.nextElement();
			String id = wp.getId();
			boolean isVisible = wp.isVisible();
			String friendlyType = wp.getPageType().getTypeName();
			String typeCode = wp.getPageType().getCode();

			out.println( "<TR>" );
			out.println( "<TD>" );
			//out.println( level == 1 ? "<TD CLASS=\"c2\">" : "<TD CLASS=\""+(isVisible? "c1" : "c3")+"\">" );

			// значок добавлени€
//			if(!typeCode.equals("link"))
//			{
				out.print( "<A HREF=\"page_add.jsp?page_id=" );
				out.print( id );
				out.print( "\"><IMG SRC=\"/admin/img/ico1.gif\" WIDTH=\"28\" HEIGHT=\"20\" ALT=\"ƒобавление страницы\" BORDER=\"0\">" );
				out.println( "</A><BR>" );
//			}
//			else 
//				out.println( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"28\" HEIGHT=\"20\"><BR>" );
			out.println( "</TD>" );

			// значок присоединени€
			out.println( "<TD>" );
			//out.println( level == 1 ? "<TD CLASS=\"c2\">" : "<TD CLASS=\""+(isVisible? "c1" : "c3")+"\">" );
//			if(!typeCode.equals("link"))
//			{
				out.print( "<INPUT TYPE=\"IMAGE\" NAME=\"attach\" onClick=\"button_attach_click(this, '" );
				out.print( id );
				out.println( "')\" SRC=\"/admin/img/ico2.gif\" WIDTH=\"28\" HEIGHT=\"20\" ALT=\"ѕрисоединение страницы\" BORDER=\"0\"><BR>" ); 
//			}
//			else 
//				out.println( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"28\" HEIGHT=\"20\">" );
			out.println( "</TD>" );
			
    		out.println( level == 1 ? "<TD CLASS=\"c2\" WIDTH=\"100%\">" : "<TD CLASS=\""+(!isVisible? "c1" : "c3")+"\" WIDTH=\"100%\">" );
			
			out.print( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=2 HEIGHT=1 ALT=\"\" BORDER=\"0\" ALIGN=\"absmiddle\">" );
			
			// checkbox
			if( level == 1 )
			{
				out.print( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=15 HEIGHT=15 ALIGN=\"absmiddle\">" );
			}
			else
			{
				out.print( "<INPUT TYPE=\"CHECKBOX\" NAME=\"CHECK-" );
				out.print( id );
				out.print( "\" onClick=\"checkbox_click( this )\" VALUE=\"" );
				out.print( level );
				out.print( "\" STYLE=\"width:15;height:15;\" BORDER=\"0\">" );
			}

			
			// значок - распахнуто/спахнуто, отсутсвует если нет потомков
			if( !wp.hasChilds() )
			{
				out.print( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"\" BORDER=\"0\" ALIGN=\"absmiddle\">" );
			}
			else if( expandedNodes != null && expandedNodes.contains( id ) )
			{
				out.print( "<A HREF=\"xt_tree.jsp?mode=collaps&node=" );
				out.print( id );
				out.print( "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico3.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"—вернуть\" BORDER=\"0\" ALIGN=\"absmiddle\">" );
				out.print( "</A>" );
			}
			else
			{
				out.print( "<A HREF=\"xt_tree.jsp?mode=expand&node=" );
				out.print( id );
				out.print( "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico4.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"–аспахнуть\" BORDER=\"0\" ALIGN=\"absmiddle\">" );
				out.print( "</A>" );
			}


            if(level > 2)
            {
                out.print( "<!-- распорка --><IMG SRC=\"/admin/img/blank.gif\" WIDTH=" );
			    out.print( (level-2) * 24 );
			    out.print( " HEIGHT=1 ALT=\"\" BORDER=\"0\" ALIGN=\"absmiddle\">" );
            }
    		if( level > 1 )
			{
				// значок передвижени€ ветки вниз, отсутствует дл€ первого уровн€
				out.print( "<A HREF=\"xt_tree.jsp?mode=down&node=" );
				out.print( id );
				out.print( "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico5.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"переместить вниз на текущем уровне\" BORDER=\"0\" ALIGN=\"absmiddle\">" );
				out.print( "</A>" );
			}
			if( level > 1 )
			{
				// значок перемещени€ ветки вверх, отсутствует дл€ первого уровн€
				out.print( "<A HREF=\"xt_tree.jsp?mode=up&node=" );
				out.print( id );
				out.print( "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico6.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"переместить вверх на текущем уровне\" BORDER=\"0\" ALIGN=\"absmiddle\">" );
				out.print( "</A>" );
			}

			if(isPagePrivate(wp.getId()))
				out.print("<B STYLE=\"color: red\">*</B>");
			out.print( "<A HREF=\"" + ("static".equals(typeCode) ? "page_edit.jsp" : "custom_page_edit.jsp" ));
			out.print( "?page_id=" + id + "&mode=edit\" CLASS=\"tr\">" );
			out.print( wp.getName() + " (" + wp.getCode() + ")" );
			out.print( "</A><BR>" );
			out.println( "</TD>" );

            out.print( level == 1 ? "<TD CLASS=\"c2\" NOWRAP WIDTH=\"1\">" : "<TD CLASS=\""+(!isVisible? "c1" : "c3")+"\" NOWRAP WIDTH=\"1\">" );
			out.print("<DIV STYLE=\"padding-left:6px;padding-right:6px;\"><NOBR>");
			out.print( friendlyType );
			out.print("</NOBR></DIV>");
			out.println( "</TD>" );

			String href = "preview.jsp?preview=1&node=" + id;
			
			out.println( "<TD><A HREF=\"javascript:preview('"+href+"&lang=R');\"><IMG SRC=\"/admin/img/ico10.gif\" WIDTH=25 HEIGHT=20 ALT=\"посмотреть страницу\" BORDER=\"0\"></A><BR></TD>" );
			out.println( "</TR>\n" );
	
			// печатаем всех потомков данного узла если он распахнут
			if( expandedNodes != null && expandedNodes.contains( id ) )
			{
				printTree( ses, out, wp.getChilds(), level+1);
			}
		}
	}
%>
<%
String message = request.getParameter("action_done");
if("1".equals(message))
	error = "—траница добавлена";
else if("2".equals(message))
	error = "—траница сохранена";
else if("3".equals(message))
	error = "—траницы, не имеющие подстраниц, были удалены";
else if("4".equals(message))
	error = "”зел дерева перемещен";
else if("5".equals(message))
	error = "”зел дерева перемещен";
else if("6".equals(message))
{
	if("0".equals(request.getParameter("count")))
		error = "ќшибка при присоединении узлов.";
	else
		error = "”злы дерева присоединены";
}
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="ƒерево сайта"/>
<jsp:param name="header" value="ƒерево страниц"/>
<jsp:param name="width" value="700"/>
<jsp:param name="message" value="<%=error%>"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript">
<!--
var checkedLevel = -1;
var checkedItems = 0;
function button_click(obj)
{
	obj.form.mode.value = obj.name;
}
function button_attach_click(obj, id)
{
	obj.form.mode.value = "attach";
	obj.form.node.value = id;
}
function checkbox_click( obj )
{
	var checkingLevel = obj.value;
	checkedItems = obj.checked ? checkedItems + 1 : checkedItems - 1;
	
	if( checkedItems == 0 )
	{
		checkedLevel = -1;
		return;
	}
	
	if( checkedLevel == -1 )
	{
		checkedLevel = checkingLevel;
		return;
	}
	
	if( checkedLevel != checkingLevel )
	{
		alert( "Ёлементы наход€щиес€ на разных уровн€х не могут быть выбраны." );
		obj.checked = "";
		checkedItems--;
		return false;
	}
}

function preview(href)
{
	window.open(href,'preview','');
}

-->
</SCRIPT>

<TABLE WIDTH="700">
<FORM ACTION="xt_tree.jsp" METHOD="POST">
<INPUT TYPE="HIDDEN" name="mode" value="NO">
<INPUT TYPE="HIDDEN" name="node" value="">
<TR>
<TD COLSPAN="5">
<INPUT TYPE="IMAGE" NAME="expand_all" onClick="button_click(this)" SRC="/admin/img/open.gif" WIDTH="52" HEIGHT="14" ALT="раскрыть" BORDER="0"><INPUT TYPE="IMAGE" NAME="collaps_all" onClick="button_click(this)" SRC="/admin/img/close.gif" WIDTH="51" HEIGHT="14" ALT="свернуть" BORDER="0"><INPUT TYPE="IMAGE" NAME="delete" onClick="button_click(this)" SRC="/admin/img/del.gif" WIDTH="44" HEIGHT="14" ALT="удалить" BORDER="0"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="3" ALT="" BORDER="0"><BR>
</TD>
</TR>
<TR>
    <TD WIDTH="28">
    	<IMG SRC="/admin/img/blank.gif" WIDTH="28" HEIGHT="20"><BR>
    </TD>
    <TD WIDTH="28">
    	<IMG SRC="/admin/img/blank.gif" WIDTH="28" HEIGHT="20"><BR>
    </TD>

    <TD CLASS="c2" WIDTH="100%" COLSPAN="2">
    	<DIV CLASS="tr" STYLE="padding-left:6px;padding-right:6px;">
    		<B>√лавна€ страница</B>
    	</DIV>
    </TD>
    <TD WIDTH="25"><IMG SRC="/admin/img/blank.gif" WIDTH="25" HEIGHT="20"><BR></TD>
</TR>
<%
printTree(session, out, root.getChilds(), 1);
%>
<TR>
<TD COLSPAN="5">
<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="3" ALT="" BORDER="0"><BR>
<INPUT TYPE="IMAGE" NAME="expand_all" onClick="button_click(this)" SRC="/admin/img/open.gif" WIDTH="52" HEIGHT="14" ALT="раскрыть" BORDER="0"><INPUT TYPE="IMAGE" NAME="collaps_all" onClick="button_click(this)" SRC="/admin/img/close.gif" WIDTH="51" HEIGHT="14" ALT="свернуть" BORDER="0"><INPUT TYPE="IMAGE" NAME="delete" onClick="button_click(this)" SRC="/admin/img/del.gif" WIDTH="44" HEIGHT="14" ALT="удалить" BORDER="0"><BR>
</TD>
</TR>
</FORM>
</TABLE>
<BR><BR>
<BR><BR>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR>
<TD ROWSPAN="3" WIDTH="10"><IMG SRC="/admin/img/blank.gif" WIDTH="10" HEIGHT="1"><BR></TD>
<TD WIDTH="15" ALIGN="center"><B STYLE="color: red;">*</B></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">страница (и все ее подстраницы) доступны только дл€ зарегистрированных пользователей;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">страница опубликована в пользовательской части;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">страница не опубликована в пользовательской части;</TD>
</TR>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
