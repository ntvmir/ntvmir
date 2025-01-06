<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = "admin";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	
	String id = request.getParameter( "id" );
	if("".equals(id))
		id = null;
	
	int err;
	try{ err = Integer.parseInt( request.getParameter( "err" )); }catch( Exception e ){ err = -1; }

	Admin admin = new Admin();
	if( id != null )
		admin.load( id );

	WebTreeNode root = CMSApplication.getApplication().getWebRoot(langCode);
%>


<%!
	// Рекурсивный обход дерева
	// используется стиль c2 - для узлов первого уровня
	//	стиль с1 - для узлов всех последующих уровней

	private void printTree( HttpSession ses, JspWriter out, Enumeration childs, Admin admin, int level, String pre )
	throws Exception
	{
		ArrayList expandedNodes = (ArrayList) ses.getValue( "admin.tree.expanded.nodes" );
		if( expandedNodes == null )
		{
			expandedNodes = new ArrayList();
			ses.putValue( "admin.tree.expanded.nodes", expandedNodes );
		}
		
		StringBuffer inputIds = new StringBuffer( "" ); //"pageCheckboxIds = new Array();\n" );
		
		
		int l = 0;
		while( childs.hasMoreElements() )
		{
			l++;
			String curPre = pre + "_" + l;
/*			inputIds.append( "pageCheckboxIds[ " + (l-1) + " ] = new Array();\n" );
			inputIds.append( "pageCheckboxIds[ " + (l-1) + " ][0] = 'page_r" + curPre + "';\n" );
			inputIds.append( "pageCheckboxIds[ " + (l-1) + " ][1] = 'page_w" + curPre + "';\n" );
			inputIds.append( "pageCheckboxIds[ " + (l-1) + " ][2] = 'page_c" + curPre + "';\n" );
			inputIds.append( "pageCheckboxIds[ " + (l-1) + " ][3] = 'page_p" + curPre + "';\n" );
*/

			inputIds.append( "pageCheckboxIds[ L ] = new Array();\n" );
			inputIds.append( "pageCheckboxIds[ L ][0] = 'page_r" + curPre + "';\n" );
			inputIds.append( "pageCheckboxIds[ L ][1] = 'page_w" + curPre + "';\n" );
			inputIds.append( "pageCheckboxIds[ L ][2] = 'page_c" + curPre + "';\n" );
			inputIds.append( "pageCheckboxIds[ L ][3] = 'page_p" + curPre + "';\n" );
			inputIds.append( "L = L + 1;\n" );
			
			
			WebTreeNode wp = (WebTreeNode) childs.nextElement();
			String id = wp.getId();
			boolean isVisible = wp.isVisible();

			String friendlyType = wp.getPageType().getTypeName();
			String style = (level == 1 ? " CLASS=\"c3\" " : " CLASS=\"" + (isVisible? "c1" : "c3") + "\" " );
			
			out.println( "<TR>" );
			out.println( "<TD>" );
			
			out.println( "<TABLE  CELLPADDING=\"0\" CELLSPACING=\"0\" BORDER=\"0\" WIDTH=\"100%\">" );
			out.println( "<TR>" );
			
			// уровень отступа в пикселях
			int indent = (level-1) * 24;	
			out.println( "<TD" + style + ">" );
			out.print( "<!-- распорка --><IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"" + indent + "\" HEIGHT=1 ALT=\"\" BORDER=\"0\"><BR></TD>" );
			
			out.println( "<TD" + style + ">" );
			
			// значок - распахнуто/спахнуто, отсутсвует если нет потомков
			if( !wp.hasChilds() )
			{
				out.print( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"\" BORDER=\"0\">" );
			}
			else if( expandedNodes != null && expandedNodes.contains( id ) )
			{
				out.print( "<A HREF=\"xt_perm_tree.jsp?mode=collaps&node=" + id + "&id=" + admin.getId() + "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico3.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"Свернуть\" BORDER=\"0\">" );
				out.println( "</A><BR>" );
			}
			else
			{
				out.print( "<A HREF=\"xt_perm_tree.jsp?mode=expand&node=" + id + "&id=" + admin.getId() + "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico4.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"Распахнуть\" BORDER=\"0\">" );
				out.println( "</A><BR>" );
			}
			
			out.println( "</TD>" );
			out.println( "<TD WIDTH=100%" + style + ">" );
			out.println( "<DIV STYLE=\"padding-left:6px;padding-right:6px;\">" );
			out.print( "<B>" + wp.getName() + "&nbsp;(" + wp.getCode() + ")</B>&nbsp;&nbsp;&nbsp;" );
            out.println( friendlyType );
			out.println( "</DIV>" );
			out.println( "</TD>" );
			out.println( "</TR>" );
			out.println( "</TABLE>" );
			
			out.println( "</TD>" );
			
			


			//----------------===============  права доступа ===============-------------

			int c = admin.getAccessCode(id);
			
			
			out.println( "<INPUT TYPE=\"hidden\" NAME=\"page_id\" VALUE=\"" + id + "\">" );
			if(Admin.isR(c)) out.println( "<INPUT TYPE=\"hidden\" NAME=\"page_orig_r\" VALUE=\"" + id + "\">" );
			if(Admin.isW(c)) out.println( "<INPUT TYPE=\"hidden\" NAME=\"page_orig_w\" VALUE=\"" + id + "\">" );
			if(Admin.isC(c)) out.println( "<INPUT TYPE=\"hidden\" NAME=\"page_orig_c\" VALUE=\"" + id + "\">" );
			if(Admin.isP(c)) out.println( "<INPUT TYPE=\"hidden\" NAME=\"page_orig_p\" VALUE=\"" + id + "\">" );
			
			out.println( "<TD WIDTH=\"1%\"" + style + ">");
			out.println( "    <INPUT TYPE=\"checkbox\" ID=\"page_r" + curPre + "\" NAME=\"page_r\" VALUE=\"" + id + "\"" + (Admin.isR(c)? " CHECKED":"") + " onClick=\"boxChanged( 'page_r', '" + curPre +"' )\">");
			out.println( "</TD>");
			out.println( "<TD WIDTH=\"1%\"" + style + ">");
			out.println( "    <INPUT TYPE=\"checkbox\" ID=\"page_w" + curPre + "\" NAME=\"page_w\" VALUE=\"" + id + "\"" + (Admin.isW(c)? " CHECKED":"") + " onClick=\"boxChanged( 'page_w', '" + curPre +"' )\">");
			out.println( "</TD>");
			out.println( "<TD WIDTH=\"1%\"" + style + ">");
			out.println( "    <INPUT TYPE=\"checkbox\" ID=\"page_c" + curPre + "\" NAME=\"page_c\" VALUE=\"" + id + "\"" + (Admin.isC(c)? " CHECKED":"") + " onClick=\"boxChanged( 'page_c', '" + curPre +"' )\">");
			out.println( "</TD>");
			out.println( "<TD WIDTH=\"1%\"" + style + ">");
			out.println( "    <INPUT TYPE=\"checkbox\" ID=\"page_p" + curPre + "\" NAME=\"page_p\" VALUE=\"" + id + "\"" + (Admin.isP(c)? " CHECKED":"") + " onClick=\"boxChanged( 'page_p', '" + curPre +"' )\">");
			out.println( "</TD>");
			
			out.println( "<TD BGCOLOR=\"white\">&nbsp;<A HREF=\"javascript: setRow( 'page_', '" + curPre + "', true );\"><IMG SRC=\"/admin/img/3arr.gif\" WIDTH=19 HEIGHT=5 ALT=\"Установить/Очистить\" BORDER=\"0\"></A></TD>" );

			out.println( "</TR>" );
	
			// печатаем всех потомков данного узла если он распахнут
			if( expandedNodes != null && expandedNodes.contains( id ) )
			{
				printTree( ses, out, wp.getChilds(), admin, level+1, curPre );
			}
			else
				out.println( "<INPUT TYPE=\"hidden\" NAME=\"page_collapsed\" VALUE=\"" + id + "\">" );
		}
		out.println( "<INPUT TYPE=\"hidden\" NAME=\"node_n" + pre + "\" VALUE=\"" + l + "\">" );
		out.println( "<SCRIPT LANGUAGE=\"javascript\">" );
		out.println( inputIds.toString());
		out.println( "</SCRIPT>" );
	}
%>

<%


	if( admin.getId() != null )
	{
	String header = "Права доступа администратора " + admin.getLogin();
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Права доступа администратора"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="message" value=""/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>

<STYLE>
a.textline { 
	font-size: 10px;
	font-family : Verdana;
	font-weight : normal;
	color : #3C3C3C;
	text-decoration: none;
	font-weight: bold;
}
a.textline:hover { 
	font-size: 10px;
	font-family : Verdana;
	font-weight : normal;
	color : #3C3C3C;
	text-decoration: none;
	font-weight: bold;
}
</STYLE>

<SCRIPT LANGUAGE="JavaScript">
function checkForm( form, id ){
	if( form.login.value == '' )
	{
		alert( 'Поле "login" должно быть заполнено.' );
		form.login.focus();
		return false;
	}
	if( id < 0 && form.password.value == '' )
	{
		alert( 'При регистрации нового пользователя необходимо установить пароль.' );
		form.password.focus();
		return false;
	}
	return true;
}

function changeChecking( pre, id, ch )
{
	if( eval( 'document.form.' + pre + id + '!= null' ))
		eval( 'document.form.' + pre + id + '.checked=' + ch );
	var nField = eval( 'document.form.node_n' + id );
	if( nField != null )
	{
		var n = nField.value;
		for( var i = 1; i <= n; i++ )
			changeChecking( pre, '' + id + '_' + i, ch );
	}
		
}

function boxChanged( pre, id )
{
	var b = eval( 'document.form.' + pre + id );
	changeChecking( pre, id, b.checked );
}

function setAll( arr, ind )
{
	if( arr.lehgth == 0 ) return;
	
	var b = false;
	var p;
	for( p = 0; p < arr.length; p++ )
		if( eval( 'document.form.' + arr[p][ind] + ' != null' ))
			break;
	b = eval( '! document.form.' + arr[p][ind] + '.checked' );
	
	for( var i = 0; i < arr.length; i++ )
	{
		var bb = eval( 'document.form.' + arr[ i ][ ind ] + ' != null' );
		if( bb )
			eval( 'document.form.' + arr[ i ][ ind ] + '.checked=' + b );
	}
}

function setRow( pre, post, depth )
{
	var b = eval( '! document.form.' + pre + 'r' + post + '.checked' );
	if( eval( 'document.form.' + pre + 'r' + post + '!= null' ))
		eval( 'document.form.' + pre + 'r' + post + '.checked=' + b );
	if( eval( 'document.form.' + pre + 'w' + post + '!= null' ))
		eval( 'document.form.' + pre + 'w' + post + '.checked=' + b );
	if( eval( 'document.form.' + pre + 'c' + post + '!= null' ))
		eval( 'document.form.' + pre + 'c' + post + '.checked=' + b );
	if( eval( 'document.form.' + pre + 'p' + post + '!= null' ))
		eval( 'document.form.' + pre + 'p' + post + '.checked=' + b );
	if( depth )
	{
		boxChanged( pre + 'r', post );
		boxChanged( pre + 'w', post );
		boxChanged( pre + 'c', post );
		boxChanged( pre + 'p', post );
	}
}

</SCRIPT>

<FORM NAME="form" ACTION="xt_permissions.jsp" METHOD="POST">
<INPUT TYPE="hidden" NAME="id" VALUE="<%= admin.getId()%>">
<TABLE CELLPADDING="0" CELLSPACING="1" BORDER="0" WIDTH="700">
<TR>
	<TD COLSPAN="2" ALIGN="left">
		<A HREF="admin.jsp?id=<%= admin.getId()%>">назад</A><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
	</TD>
</TR>
<TR CLASS="c2">
	<TD HEIGHT="16" ALIGN="center">
		<B>Функциональные компоненты</B>
	</TD>
	<TD ALIGN="center"><A HREF="javascript: setAll( compCheckboxIds, 0 );" TITLE="Установить/Очистить"><B>R</B></A></TD>
	<TD ALIGN="center"><A HREF="javascript: setAll( compCheckboxIds, 1 );" TITLE="Установить/Очистить"><B>W</B></A></TD>
	<TD ALIGN="center"><A HREF="javascript: setAll( compCheckboxIds, 2 );" TITLE="Установить/Очистить"><B>C</B></A></TD>
	<TD ALIGN="center"><A HREF="javascript: setAll( compCheckboxIds, 3 );" TITLE="Установить/Очистить"><B>P</B></A></TD>
	<TD BGCOLOR="white">&nbsp;</TD>
</TR>
<%
	StringBuffer inputIds = new StringBuffer( "compCheckboxIds = new Array();\n" );

			
			
	Enumeration enum = CMSApplication.getApplication().getServices();
	int l = 0;
	while( enum.hasMoreElements())
	{
		Service service  = (Service)enum.nextElement();




		if(service.getCode().equals("release") || service.getCode().equals("design"))
		    continue;


		String jsId = service.getId();
		inputIds.append( "compCheckboxIds[ " + l + " ] = new Array();\n" );
		inputIds.append( "compCheckboxIds[ " + l + " ][0] = 'comp_r_" + l + "';\n" );
		inputIds.append( "compCheckboxIds[ " + l + " ][1] = 'comp_w_" + l + "';\n" );
		inputIds.append( "compCheckboxIds[ " + l + " ][2] = 'comp_c_" + l + "';\n" );
		inputIds.append( "compCheckboxIds[ " + l + " ][3] = 'comp_p_" + l + "';\n" );
		
		
		int c = admin.getAccessCode( service.getId() );
		
		int ccc = service.getAccessMask();
%>
	<INPUT TYPE="hidden" NAME="page_id" VALUE="<%=service.getId()%>">
<%	if(Admin.isR(c)){ %>
	<INPUT TYPE="hidden" NAME="page_orig_r" VALUE="<%=service.getId()%>">
<%	} %>
<%	if(Admin.isW(c)){ %>
	<INPUT TYPE="hidden" NAME="page_orig_w" VALUE="<%=service.getId()%>">
<%	} %>
<%	if(Admin.isC(c)){ %>
	<INPUT TYPE="hidden" NAME="page_orig_c" VALUE="<%=service.getId()%>">
<%	} %>
<%	if(Admin.isP(c)){ %>
	<INPUT TYPE="hidden" NAME="page_orig_p" VALUE="<%=service.getId()%>">
<%	} %>
<TR>
	<TD CLASS="edit"><DIV STYLE="padding-left:26px;padding-right:6px;">
		<B><%=service.getName()%></B><BR>
		<%=service.getAccessDescription()%>
	</TD>
	<TD ALIGN="center" VALIGN="center" CLASS="edit">
<%	if( Admin.isR(ccc)){ %>
		<INPUT TYPE="checkbox" ID="comp_r_<%=l%>" NAME="page_r" VALUE="<%=service.getId()%>"<%=Admin.isR(c) ? " CHECKED":""%>>
<%	}else{ %>
		&times;
<%	} %>
	</TD>
	<TD ALIGN="center" VALIGN="center" CLASS="edit">
<%	if(Admin.isW(ccc)){ %>
		<INPUT TYPE="checkbox" ID="comp_w_<%=l%>" NAME="page_w" VALUE="<%=service.getId()%>"<%=Admin.isW(c) ? " CHECKED":""%>>
<%	}else{ %>
		&times;
<%	} %>
	</TD>
	<TD ALIGN="center" VALIGN="center" CLASS="edit">
<%	if(Admin.isC(ccc)){ %>
		<INPUT TYPE="checkbox" ID="comp_c_<%=l%>" NAME="page_c" VALUE="<%=service.getId()%>"<%=Admin.isC(c) ? " CHECKED":""%>>
<%	}else{ %>
		&times;
<%	} %>
	</TD>
	<TD ALIGN="center" VALIGN="center" CLASS="edit">
<%	if(Admin.isP(ccc)){ %>
		<INPUT TYPE="checkbox" ID="comp_p_<%=l%>" NAME="page_p" VALUE="<%=service.getId()%>"<%=Admin.isP(c) ? " CHECKED":""%>>
<%	}else{ %>
		&times;
<%	} %>
	</TD>
	<TD BGCOLOR="white">&nbsp;<A HREF="javascript: setRow( 'comp_', '_<%=l%>', false );"><IMG SRC="/admin/img/3arr.gif" WIDTH=19 HEIGHT=5 ALT="Установить/Очистить" BORDER="0"></A></TD>
</TR>
<%      l++; %>
<%	} %>
<SCRIPT LANGUAGE="javascript">
<%= inputIds.toString() %>
</SCRIPT>
<!-- белая полоска --><TR><TD COLSPAN="6"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>
<TR CLASS="c2">
	<TD HEIGHT="16" ALIGN="center">
		<B>Разделы сайта</B>
	</TD>
	<TD ALIGN="center"><A HREF="javascript: setAll( pageCheckboxIds, 0 );" TITLE="Установить/Очистить"><B>R</B></A></TD>
	<TD ALIGN="center"><A HREF="javascript: setAll( pageCheckboxIds, 1 );" TITLE="Установить/Очистить"><B>W</B></A></TD>
	<TD ALIGN="center"><A HREF="javascript: setAll( pageCheckboxIds, 2 );" TITLE="Установить/Очистить"><B>C</B></A></TD>
	<TD ALIGN="center"><A HREF="javascript: setAll( pageCheckboxIds, 3 );" TITLE="Установить/Очистить"><B>P</B></A></TD>
	<TD BGCOLOR="white">&nbsp;</TD>
</TR>
<SCRIPT LANGUAGE="javascript">
pageCheckboxIds = new Array();
L = 0;
</SCRIPT>
<% printTree( session, out, root.getChilds(), admin, 1, "" ); %>

<TR>
	<TD COLSPAN="5" ALIGN="center" HEIGHT="30">
		<INPUT TYPE="submit" VALUE="Установить права" ONCLICK="return confirm('Установить права?');" id=submit1 name=submit1>
	</TD>
	<TD BGCOLOR="white">&nbsp;</TD>
</TR>

<TR>
	<TD COLSPAN="5" ALIGN="center" HEIGHT="30">
		<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="15"><BR>
		<HR WIDTH="100%">
		<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="15"><BR>
	</TD>
	<TD BGCOLOR="white">&nbsp;</TD>
</TR>

<TR>
	<TD COLSPAN="5">
	<CENTER><B>Условные обозначения</B></CENTER><BR>
	Права доступа к разделам сайта состоят из четырех компонент:<BR>
	<TABLE>
	<TR><TD>&nbsp;</TD><TD ALIGN="center"><B>R</B></TD><TD> &#151;</TD><TD>возможность просмотра содержания раздела</TD></TR>
	<TR><TD>&nbsp;</TD><TD ALIGN="center"><B>W</B></TD><TD> &#151;</TD><TD>возможность изменения содержания раздела<TD></TR>
	<TR><TD>&nbsp;</TD><TD ALIGN="center"><B>C</B></TD><TD> &#151;</TD><TD>возможность создания и удаления подстраниц данного раздела<TD></TR>
	<TR><TD>&nbsp;</TD><TD ALIGN="center"><B>P</B></TD><TD> &#151;</TD><TD>возможность опубликования раздела в пользовательской части<TD></TR>
	</TABLE>
	
	<p>При работе с разделами установлены следующие правила:
	<ol>
	<li> для перестановки подразделов необходимо обладать правом редактирования раздела, которому они принадлежат;
	<li> для присоединения подразделов необходимо обладать правом редактирования, как старого, так и нового родительских разделов;
	<li> при создании нового подраздела администратор автоматически получает на него те же права, что и у родительского раздела;
	</ol>
	
	<p>При работе с разделами и функциональными компонентами установлено правило:
	<ol>
	<li> для редактирования опубликованного раздела (компоненты) необходимо обладать правами редактирования и публикации одновременно;
	</ol>
	

	</TD>
	<TD BGCOLOR="white">&nbsp;</TD>
</TR>
<TR>
	<TD COLSPAN="5" ALIGN="center" HEIGHT="30">
		<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="15"><BR>
		<HR WIDTH="100%">
		<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="15"><BR>
	</TD>
	<TD BGCOLOR="white">&nbsp;</TD>
</TR>

</TABLE>
</FORM>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>


<%
	}
	else
		response.sendRedirect( "/admin/admin/admins.jsp" );
%>