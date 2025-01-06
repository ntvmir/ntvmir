<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = Term.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String abcRus = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЭЮЯ";
	String abcEng = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	String letter = request.getParameter( "letter" );
	if( letter == null ) letter = "";
	
	char lang = (request.getParameter( "lang" ) == null ? CMSApplication.LANG_RUS : request.getParameter( "lang" ).charAt(0));
	char ex_lang;
	
	if( lang == CMSApplication.LANG_RUS ) ex_lang = CMSApplication.LANG_ENG;
	else ex_lang = CMSApplication.LANG_RUS;
	
	Enumeration enum = null;
	if( letter != null && lang >= 0 ){
		if( "_".equals( letter ))
			enum = Term.getAdminTerms( null, lang );
		else
			enum = Term.getAdminTerms( letter, lang );
	}
	if( enum == null ) enum = (new Vector()).elements();
%>

<%!
	String toHex( String s ) throws Exception{
		if( s == null || s.length() == 0 ) return "";
		byte [] b = s.getBytes( "Cp1251" );
		return "%" + Integer.toString( (int)(b[0]<0? 256 + b[0] : b[0]), 16 ).toUpperCase();
	}
%>
<%!
	void abcNavigation( JspWriter out, String abc, char lang ) throws Exception{
		out.println( "<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=2>" );
		out.println(
			"<TR><TD WIDTH=15><A HREF=\"terms.jsp?letter=_&lang=" + lang + 
			"\" TITLE=\"Все термины\">--</A></TD>" );
		for( int i = 0; i < abc.length(); i++ ){
			out.println(
				"<TD WIDTH=15><A HREF=\"terms.jsp?letter=" + toHex(  abc.substring( i, i+1 )) + "&lang=" + lang + "\">" + 
				abc.substring( i, i+1 ) + "</A></TD>" );
			if( abc.length()/2 == (i+1) ) out.println( "</TR>\n<TR>" );
		}
		out.println( "</TR>\n</TABLE>" );
	}
	
%>
<%
	String message = "";
	if("changed".equals(request.getParameter("action_done")))
		message = "Изменения сохранены.";
	else if("save".equals(request.getParameter("action_done")))
		message = "Термин сохранен.";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Словарь"/>
<jsp:param name="header" value="Словарь"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="700">
<TR>
	<TD HEIGHT="16" COLSPAN="5">
		Выберете первую букву русского термина:<br>
		<% abcNavigation( out, abcRus, CMSApplication.LANG_RUS );%>
	</TD>
</TR>
<!-- белая полоска --><TR><TD COLSPAN="5"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=5><BR></TD></TR>
<TR>
	<TD HEIGHT="16" COLSPAN="5">
		Выберете первую букву английского термина:<br>
		<% abcNavigation( out, abcEng, CMSApplication.LANG_ENG );%>
	</TD>
</TR>
<!-- белая полоска --><TR><TD COLSPAN="5"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=10><BR></TD></TR>
<TR>
	<TD HEIGHT="16" COLSPAN="5" ALIGN="right">
		<A HREF="requests.jsp">запросы на добавление терминов</A>
	</TD>
</TR>
<TR>
	<TD CLASS="c2" HEIGHT="16" COLSPAN="5" ALIGN="center">
		<B>Термины (<A HREF="term.jsp?letter=<%=toHex( letter )%>&lang=<%=lang%>">добавить термин</A>)</B>
	</TD>
</TR>


<TR>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">публиковать (<%=lang==CMSApplication.LANG_RUS ? "рус." : "англ."%>)</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;Термин (<%=lang==CMSApplication.LANG_RUS ? "рус." : "англ."%>)</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">публиковать (<%=lang==CMSApplication.LANG_RUS ? "англ." : "рус."%>)</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="50%">&nbsp;Термин (<%=lang==CMSApplication.LANG_RUS ? "англ." : "рус."%>)</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">удалить</TD>
</TR>
<FORM ACTION="xt_terms.jsp" METHOD="POST" NAME="FORM">
<INPUT TYPE="hidden" NAME="letter" VALUE="<%=letter%>">
<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
<%
	while( enum.hasMoreElements()){
		Term t = (Term)enum.nextElement();
%>
<%		if( t.isVisibleRus()){ %>
<INPUT TYPE="hidden" NAME="orig_pub_<%=CMSApplication.LANG_RUS%>" VALUE="<%=t.getId()%>">
<%		}
		if( t.isVisibleEng()){ %>
<INPUT TYPE="hidden" NAME="orig_pub_<%=CMSApplication.LANG_ENG%>" VALUE="<%=t.getId()%>">
<%		} %>
<INPUT TYPE="hidden" NAME="id" VALUE="<%=t.getId()%>">
<TR BGCOLOR="#F0F7FF">
	<TD ALIGN="center">
		<INPUT TYPE="checkbox" <%=t.getTerm(lang) == null || t.getTerm(lang).trim().length()==0 ? "DISABLED " : ""%>NAME="pub_<%=lang%>" VALUE="<%=t.getId()%>"<%=t.isVisible( lang ) ? " CHECKED":""%>>
	</TD>
	<TD>
		<A HREF="term.jsp?id=<%=t.getId()%>&letter=<%=toHex( letter )%>&lang=<%=lang%>"><%=CMSApplication.toHTML(t.getTerm( lang ))%></A>
	</TD>
	<TD ALIGN="center">
		<INPUT TYPE="checkbox" <%=t.getTerm(ex_lang) == null || t.getTerm(ex_lang).trim().length()==0 ? "DISABLED " : ""%> NAME="pub_<%=ex_lang%>" VALUE="<%=t.getId()%>"<%=t.isVisible( ex_lang ) ? " CHECKED":""%>>
	</TD>
	<TD>
		<A HREF="term.jsp?id=<%=t.getId()%>&letter=<%=toHex( letter )%>&lang=<%=lang%>"><%=CMSApplication.toHTML(t.getTerm( ex_lang ))%></A>
	</TD>
	<TD ALIGN="center">
		<INPUT TYPE="checkbox" NAME=del VALUE="<%=t.getId()%>">
	</TD>
</TR>
<%
	}
%>
<TR>
	<TD COLSPAN="5" ALIGN="center" HEIGHT="30">
		<INPUT TYPE="Submit" VALUE="Сохранить изменения" ONCLICK="return confirm('Сохранить изменения?');">
	</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>

