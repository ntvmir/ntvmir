<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD BGCOLOR="#FFFFFF">
	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#FFFFFF">
	<TR BGCOLOR="#FFFFFF" VALIGN="top">
	<FORM ACTION="/page.jsp" METHOD="post" NAME="l2_search_form">
	<INPUT TYPE="hidden" NAME="section" VALUE="<%=SectionCode.SEARCH%>">
	<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
	<INPUT TYPE="hidden" NAME="search" VALUE="1">
	<INPUT TYPE="hidden" NAME="f_1" VALUE="1">
	<INPUT TYPE="hidden" NAME="f_2" VALUE="1">
	<INPUT TYPE="hidden" NAME="f_3" VALUE="1">
	<INPUT TYPE="hidden" NAME="f_4" VALUE="1">
	<INPUT TYPE="hidden" NAME="f_5" VALUE="1">
	<INPUT TYPE="hidden" NAME="f_6" VALUE="1">
	<INPUT TYPE="hidden" NAME="f_7" VALUE="1">
	<INPUT TYPE="hidden" NAME="f_mode" VALUE="and">
	<TD><IMG SRC="<%=des%>/d_dde6f0.gif" WIDTH="295" HEIGHT="1"><BR>
			<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="margin-top:15;" WIDTH="284">
			<TR VALIGN="top">
			<% if(!sectionCode.equals(SectionCode.SEARCH)) {%><TD WIDTH="40"></TD>
			<TD WIDTH="105"><INPUT TYPE="text" NAME="f_query" STYLE="font-family:Verdana;font-size:10px;width:100;" SIZE="12"></TD><% } %>
			<TD<% if(!sectionCode.equals(SectionCode.MAP)) {%> ALIGN="right"<% } %>><% if(!sectionCode.equals(SectionCode.SEARCH)) {%><A HREF="javascript: document.l2_search_form.submit();"><IMG SRC="<%=des%>/btnz/srch.gif" WIDTH="50" HEIGHT="16" ALT="<%=lang == E ? "search" : "поиск"%>" BORDER="0" HSPACE="3" VSPACE="2"></A><% } %><IMG SRC="<%=des%>/main/v_dotz.gif" WIDTH="1" HEIGHT="16" ALT="" BORDER="0" HSPACE="0" VSPACE="2"><% if(!sectionCode.equals(SectionCode.MAP)) {%><A HREF="page.jsp?section=<%=SectionCode.MAP%>&lang=<%=lang%>"><IMG SRC="<%=des%>/btnz/map.gif" WIDTH="76" HEIGHT="16" ALT="<%=lang==E ? "site map" : "карта сайта"%>" BORDER="0" HSPACE="3" VSPACE="2"></A><% } %></TD>
			</TR>
			</TABLE>
	</TD>
	<TD WIDTH="1"><IMG SRC="<%=des%>/d_dde6f0.gif" WIDTH="1" HEIGHT="1"></TD>
	<TD WIDTH="1" BGCOLOR="#DDE6F0"><IMG SRC="<%=des%>/blank.gif" WIDTH="1" HEIGHT="1"></TD>
	</TR>
	<TR BGCOLOR="#FFFFFF" VALIGN="top">
	<TD BACKGROUND="<%=des%>/main/bg_td_bot.gif" HEIGHT="28"><% if(!sectionCode.equals(SectionCode.SEARCH)) {%><DIV STYLE="margin:0 10 0 40;"><A HREF="page.jsp?section=<%=SectionCode.SEARCH%>&lang=<%=lang%>" CLASS="sm"><%=lang == E ? "advanced search" : "расширенный поиск"%></A></DIV><% } else {%><SPACER TYPE="block" HEIGHT="1" WIDTH="1"><% } %></TD>
	<TD><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
	<TD BGCOLOR="#DDE6F0"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
	<% if(!sectionCode.equals(SectionCode.SEARCH)) {%></FORM><% } %></TR>
	</TABLE>
</TD>
<TD BGCOLOR="#FFFFFF" VALIGN="bottom" WIDTH="100%"><TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0"><TR><TD BACKGROUND="<%=des%>/main/bg_td_bot.gif"><IMG SRC="<%=des%>/main/bg_td_bot.gif" WIDTH="483" HEIGHT="28"></TD></TR></TABLE>
</TD>
</TR>
</TABLE>