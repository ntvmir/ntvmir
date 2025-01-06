<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>



<%
    response.setHeader("Pragma","no-cache");
%>
<%
	
	// ������� �������� ���� �����
	WebTreeNode root = CMSApplication.getApplication().getWebRoot();
	String error = request.getParameter("error");
	if( error == null )
		error = "";
%>
<%!
	// ����������� ����� ������
	// ������������ ����� c2 - ��� ����� ������� ������
	//	����� �1 - ��� ����� ���� ����������� �������
	private void printTree( HttpSession ses, JspWriter out, Enumeration childs, int level) throws IOException
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

			out.println( "<TR>" );
			out.println( "<TD>" );
			
			
			out.println( "<TABLE  CELLPADDING=\"0\" CELLSPACING=\"0\" BORDER=\"0\" WIDTH=\"100%\">" );
			out.println( "<TR>" );
			out.println( "<TD>" );
			out.println( "</TD>" );

			out.println( level == 1 ? "<TD CLASS=\"c2\">" : "<TD CLASS=\""+(isVisible? "c1" : "c3")+"\">" );
			// ������ ����������
			out.print( "<A HREF=\"page_add.jsp?pageId=" );
			out.print( id );
			out.print( "\"><IMG SRC=\"/admin/img/ico1.gif\" WIDTH=\"28\" HEIGHT=\"20\" ALT=\"���������� ��������\" BORDER=\"0\">" );
			out.println( "</A><BR>" );
				
			out.println( "</TD>" );

			// ������ �������������
			out.println( level == 1 ? "<TD CLASS=\"c2\">" : "<TD CLASS=\""+(isVisible? "c1" : "c3")+"\">" );
			out.print( "<INPUT TYPE=\"IMAGE\" NAME=\"attach\" onClick=\"button_attach_click(this, '" );
			out.print( id );
			out.println( "')\" SRC=\"/admin/img/ico2.gif\" WIDTH=\"28\" HEIGHT=\"20\" ALT=\"������������� ��������\" BORDER=\"0\"><BR>" ); 
			out.println( "</TD>" );
			
			out.println( "<TD><IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"1\" HEIGHT=\"1\" ALT=\"\" BORDER=\"0\"><BR></TD>" );
			
			out.println( level == 1 ? "<TD CLASS=\"c2\">" : "<TD CLASS=\""+(isVisible? "c1" : "c3")+"\">" );
			
			out.print( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=2 HEIGHT=1 ALT=\"\" BORDER=\"0\">" );
			
			// checkbox
			if( level == 1 )
			{
				out.print( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=15 HEIGHT=15>" );
			}
			else
			{
				out.print( "<INPUT TYPE=\"CHECKBOX\" NAME=\"CHECK-" );
				out.print( id );
				out.print( "\" onClick=\"checkbox_click( this )\" VALUE=\"" );
				out.print( level );
				out.println( "\" STYLE=\"width:15;height:15;\" BORDER=\"0\">" );
			}
			out.println( "</TD>" );
			
			// ������� ������� � ��������
			int indent = (level-1) * 24;	
			out.println( level == 1 ? "<TD CLASS=\"c2\">" : "<TD CLASS=\""+(isVisible? "c1" : "c3")+"\">" );
			out.print( "<!-- �������� --><IMG SRC=\"/admin/img/blank.gif\" WIDTH=" );
			out.print( indent );
			out.println( " HEIGHT=1 ALT=\"\" BORDER=\"0\"><BR></TD>" );
			
			out.println( level == 1 ? "<TD CLASS=\"c2\">" : "<TD CLASS=\""+(isVisible? "c1" : "c3")+"\">" );
			
			// ������ - ����������/��������, ���������� ���� ��� ��������
			if( !wp.hasChilds() )
			{
				out.print( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"\" BORDER=\"0\">" );
			}
			else if( expandedNodes != null && expandedNodes.contains( id ) )
			{
				out.print( "<A HREF=\"xt_tree.jsp?mode=collaps&node=" );
				out.print( id );
				out.print( "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico3.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"��������\" BORDER=\"0\">" );
				out.println( "</A><BR>" );
			}
			else
			{
				out.print( "<A HREF=\"xt_tree.jsp?mode=expand&node=" );
				out.print( id );
				out.print( "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico4.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"����������\" BORDER=\"0\">" );
				out.println( "</A><BR>" );
			}
			
			out.println( "</TD>" );
			out.println( level == 1 ? "<TD WIDTH=100% CLASS=\"c2\">" : "<TD WIDTH=100% CLASS=\""+(isVisible? "c1" : "c3")+"\">" );
			out.println( "<TABLE CELLPADDING=\"0\" CELLSPACING=\"0\" BORDER=\"0\">" );
			out.println( "<TR>" );
			out.println( "<TD>" );
			out.println( "<DIV STYLE=\"padding-left:6px;padding-right:6px;font-size: 10px;font-family : Verdana;font-weight : normal;color : #3C3C3C;\">" );
			
			out.print( "<A HREF=\"tree_node_edit.jsp?id=" + id + "\" CLASS=\"tr\">" );
			out.print( wp.getNameRus() + "&nbsp;(" + wp.getNameEng() + ")" );
			out.print( "</A> " );
			out.println( friendlyType );
			
			out.println( "</DIV>" );
			out.println( "</TD>" );
			
			out.println( "<TD>" );
			if( level > 1 )
			{
				// ������ ������������ ����� ����, ����������� ��� ������� ������
				out.print( "<A HREF=\"xt_tree.jsp?mode=down&node=" );
				out.print( id );
				out.print( "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico5.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"����������� ���� �� ������� ������\" BORDER=\"0\">" );
				out.println( "</A><BR>" );
			}
			out.println( "</TD>" );
			
			out.println( "<TD>" );
			if( level > 1 )
			{
				// ������ ����������� ����� �����, ����������� ��� ������� ������
				out.print( "<A HREF=\"xt_tree.jsp?mode=up&node=" );
				out.print( id );
				out.print( "\">" );
				out.print( "<IMG SRC=\"/admin/img/ico6.gif\" WIDTH=\"20\" HEIGHT=\"20\" ALT=\"����������� ����� �� ������� ������\" BORDER=\"0\">" );
				out.println( "</A><BR>" );
			}
			out.println( "</TD>" );
			out.println( "</TR>" );
			out.println( "</TABLE>" );

			out.println( "</TD>" );

			String href = "�� ����������� ���� :(((";
			
			out.println( "<TD><A HREF=\""+href+"\"><IMG SRC=\"/admin/img/ico10.gif\" WIDTH=25 HEIGHT=20 ALT=\"���������� ��������(RUS)\" BORDER=\"0\"></A><BR></TD>" );
			href = href.indexOf("?") != -1 ? href+"&lang=E": href+"?lang=E";
			out.println( "<TD><A HREF=\""+href+"\"><IMG SRC=\"/admin/img/ico10.gif\" WIDTH=25 HEIGHT=20 ALT=\"���������� ��������(ENG)\" BORDER=\"0\"></A><BR></TD>" );
			
			out.println( "</TR>" );
			out.println( "</TABLE>" );

			out.println( "<IMG SRC=\"/admin/img/blank.gif\" WIDTH=1 HEIGHT=3 ALT=\"\" BORDER=\"0\"><BR>" );

			out.println( "</TD>" );
			out.println( "</TR>" );
	
			// �������� ���� �������� ������� ���� ���� �� ���������
			if( expandedNodes != null && expandedNodes.contains( id ) )
			{
				printTree( ses, out, wp.getChilds(), level+1);
			}
		}
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//RU">
<HTML>
<HEAD>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
<META HTTP-EQUIV=Content-language CONTENT=RU>
<META NAME=description CONTENT="">
<META NAME=keywords CONTENT="">
<META NAME=autor CONTENT="">
<!-- "$Revision::                    $" -->
<!-- "$Author::                        $" -->
<!-- "$Date::                           $"-->
<TITLE>������ �����</TITLE>

<SCRIPT LANGUAGE="JavaScript">

var checkedLevel = -1;
var checkedItems = 0;

function button_click(obj)
{
	obj.form.mode.value = obj.name;
}

// 
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
		alert( "�������� ����������� �� ������ ������� �� ����� ���� �������." );
		obj.checked = "";
		checkedItems--;
		return false;
	}

}

function openGraph() 
{ 
	window.open("http://nikel.customers.acn.ru/test.html", 'nornikel', 'width=450,height=375,toolbar=0,directories=0,menubar=0,status=no,resizable=no,location=0,scrollbars=0,copyhistory=0'); 
}

</SCRIPT>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">

</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>

������ �������
<BR>
<BR>
<%
if( error.equals("1"))
{
	out.println("<B>�������� ����� ����������� ��������. �������� ���������.</B>");
}
else if( error.equals("2"))
{
	out.println("<B>�������� �������������� ������� ���������.</B>");
}
%>
<FORM ACTION="xt_tree.jsp" METHOD="POST">
<INPUT TYPE="HIDDEN" name="mode" value="NO">
<INPUT TYPE="HIDDEN" name="node" value="">
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>

<TD>
<INPUT TYPE="IMAGE" NAME="expand_all" onClick="button_click(this)" SRC="/admin/img/open.gif" WIDTH="52" HEIGHT="14" ALT="��������" BORDER="0"><INPUT TYPE="IMAGE" NAME="collaps_all" onClick="button_click(this)" SRC="/admin/img/close.gif" WIDTH="51" HEIGHT="14" ALT="��������" BORDER="0"><INPUT TYPE="IMAGE" NAME="delete" onClick="button_click(this)" SRC="/admin/img/del.gif" WIDTH="44" HEIGHT="14" ALT="�������" BORDER="0"><BR>
<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="3" ALT="" BORDER="0"><BR>
</TD>
</TR>
<TR>
	<TD>
		<TABLE  CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="100%">
			<TR>
				<TD>
				</TD>
				<TD>
					<IMG SRC="/admin/img/blank.gif" WIDTH="28" HEIGHT="20"><BR>
				</TD>
				<TD>
					<IMG SRC="/admin/img/blank.gif" WIDTH="28" HEIGHT="20"><BR>
				</TD>
				<TD><IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="1" ALT="" BORDER="0"><BR></TD>
				<TD CLASS="c2">
					<IMG SRC="/admin/img/blank.gif" WIDTH=2 HEIGHT=1 ALT="" BORDER="0"><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=15></TD>
				<TD CLASS="c2">
					<!-- �������� --><IMG SRC="/admin/img/blank.gif" WIDTH=0 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
				<TD CLASS="c2">
					<IMG SRC="/admin/img/blank.gif" WIDTH="20" HEIGHT="20"><BR>
				</TD>
				<TD WIDTH=100% CLASS="c2">
					<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
						<TR>
							<TD>
								<DIV STYLE="padding-left:6px;padding-right:6px;font-size: 10px;font-family : Verdana;font-weight : normal;color : #3C3C3C;">
									<B>������� ��������</B>
								</DIV>
							</TD>
							<TD></TD>
							<TD></TD>
						</TR>
					</TABLE>
				</TD>
				<TD><IMG SRC="/admin/img/blank.gif" WIDTH="25" HEIGHT="20"><BR></TD>
				<TD><IMG SRC="/admin/img/blank.gif" WIDTH="25" HEIGHT="20"><BR></TD>
			</TR>
		</TABLE>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=3 ALT="" BORDER="0"><BR>
	</TD>
</TR>
<%
printTree( session, out, root.getChilds(), 1 );
%>
<TR>
<TD>
<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="3" ALT="" BORDER="0"><BR>
<INPUT TYPE="IMAGE" NAME="expand_all" onClick="button_click(this)" SRC="/admin/img/open.gif" WIDTH="52" HEIGHT="14" ALT="��������" BORDER="0"><INPUT TYPE="IMAGE" NAME="collaps_all" onClick="button_click(this)" SRC="/admin/img/close.gif" WIDTH="51" HEIGHT="14" ALT="��������" BORDER="0"><INPUT TYPE="IMAGE" NAME="delete" onClick="button_click(this)" SRC="/admin/img/del.gif" WIDTH="44" HEIGHT="14" ALT="�������" BORDER="0"><BR>
</TD>

</TR>
</TABLE>

</FORM>

</BODY>
</HTML>
