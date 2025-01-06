<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = Term.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter( "id" );
	String req  = request.getParameter( "request" );
	if("".equals(id))
		id = null;
	if("".equals(req))
		req = null;
	
	if( req != null && ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "request.jsp?id=" + req + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	

	String letter = request.getParameter( "letter" );
	if( letter == null ) letter = "";
	char lang = (request.getParameter( "lang" ) != null ? request.getParameter( "lang" ).charAt(0) : CMSApplication.LANG_RUS);
	
	if( id != null && ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "terms.jsp?letter=" + java.net.URLEncoder.encode( letter ) + "&lang=" + lang + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	Term t = new Term();
	if( req != null )
	{
		TermRequest tr = new TermRequest();
		tr.load( req );
		if( tr.getLang() == CMSApplication.LANG_RUS )
		{
			t.setTermRus( tr.getTerm());
			t.setDescrRus( tr.getDescr());
		}
		else
		{
			t.setTermEng( tr.getTerm());
			t.setDescrEng( tr.getDescr());
		}
	}
	else 
		if( id != null )
			t.load( id );
	
%>

<%!
	String toHex( String s ) throws Exception{
		if( s == null || s.length() == 0 ) return "";
		byte [] b = s.getBytes( "Cp1251" );
		return "%" + Integer.toString( (int)(b[0]<0? 256 + b[0] : b[0]), 16 ).toUpperCase();
	}
%>

<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Словарь"/>
<jsp:param name="header" value="Термин словаря"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function submitForm(){
	if(confirm("Сохранить изменения?"))
	{
		var form = document.main_form;
		if( trim(form.term_R.value) == '' &&  trim(form.term_E.value) == '' ){
			alert( 'Хотя бы одно поле "термин" должно быть заполнено.' );
			form.term_R.focus();
			return ;
		}
		if( trim(form.term_R.value) == '' && form.pub_R.checked ){
			alert( 'Нельзя публиковать пустой термин.' );
			form.term_R.focus();
			return ;
		}
		if( trim(form.term_E.value) == '' && form.pub_E.checked ){
			alert( 'Нельзя публиковать пустой термин.' );
			form.term_E.focus();
			return ;
		}
		if( trim(form.descr_R.value) == '' && form.pub_R.checked ){
			alert( 'Публикуемый термин должен иметь описание.' );
			form.descr_R.focus();
			return ;
		}
		if( trim(form.descr_E.value) == '' && form.pub_E.checked ){
			alert( 'Публикуемый термин должен иметь описание.' );
			form.descr_E.focus();
			return ;
		}
		form.submit();
	}
}
</SCRIPT>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="700">

<FORM NAME="main_form" ACTION="xt_term.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=t.getId() != null ? t.getId() : ""%>">
<INPUT TYPE="hidden" NAME="letter" VALUE="<%=letter%>">
<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
<%	if( req != null )
	{ %>
<INPUT TYPE="hidden" NAME="request" VALUE="<%=req%>">
<%	} %>


<TR>
	<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;<B>Термин</B></TD>
	<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR></TD>
	<TD CLASS="c2" WIDTH="50%">&nbsp;<B>Term</B></TD>
</TR>

<TR>
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<INPUT TYPE="text" NAME="term_<%=CMSApplication.LANG_RUS%>" VALUE="<%=CMSApplication.toHTML( t.getTermRus())%>" STYLE="width:100%" SIZE="59"><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
	</TD>
	<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR></TD>
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<INPUT TYPE="text" NAME="term_<%=CMSApplication.LANG_ENG%>" VALUE="<%=CMSApplication.toHTML( t.getTermEng())%>" STYLE="width:100%" SIZE="59"><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
	</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Описание</B>
</TD>
<TD><IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR></TD>
<TD CLASS="c2" HEIGHT="16">&nbsp;<B>Description</B>
</TD>
</TR>

<!-- белая полоска --><TR><TD COLSPAN="3"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>
<TR BGCOLOR="#F0F7FF">
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<TEXTAREA NAME="descr_<%=CMSApplication.LANG_RUS%>" ROWS=15 STYLE="width:100%" COLS="58" WRAP="PHYSICAL"><%=CMSApplication.toHTML( t.getDescrRus())%></TEXTAREA><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=10><BR>
	</TD>
	<TD>
		<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
	</TD>
	<TD ALIGN="center">
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=6><BR>
		<TEXTAREA NAME="descr_<%=CMSApplication.LANG_ENG%>" ROWS=15 STYLE="width:100%" COLS="58" WRAP="PHYSICAL"><%=CMSApplication.toHTML( t.getDescrEng())%></TEXTAREA><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=10><BR>
	</TD>
</TR>

<INPUT TYPE="hidden" NAME="pub_orig_<%=CMSApplication.LANG_RUS%>" VALUE="<%=t.isVisibleRus() ? 1 : 0%>" >
<INPUT TYPE="hidden" NAME="pub_orig_<%=CMSApplication.LANG_ENG%>" VALUE="<%=t.isVisibleEng() ? 1 : 0%>">

<TR>
	<TD ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Checkbox" NAME="pub_<%=CMSApplication.LANG_RUS%>" VALUE="1" <%=t.isVisibleRus() ? "CHECKED" : ""%>>публиковать в русской части
	</TD>
	<TD>
		<IMG SRC="/admin/img/blank.gif" WIDTH=15 HEIGHT=1><BR>
	</TD>
	<TD ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Checkbox" NAME="pub_<%=CMSApplication.LANG_ENG%>" VALUE="1" <%=t.isVisibleEng() ? "CHECKED" : ""%>>публиковать в английской части
	</TD>
</TR>	
<TR>
<TD COLSPAN="3" ALIGN="center">
<INPUT TYPE="button" VALUE="Сохранить изменения" ONCLICK="submitForm();">
</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
