<%!
	public static final String [] headerNamesRus = new String [] {
		"Главная", "Новости", "Ссылки", "Контакты", "Обратная связь", "Нортгаз" };
	public static final String [] headerNamesEng = new String [] {
		"Home", "News", "Links", "Contacts", "Feedback", "Northgas" };
	
	public String headerText(int p, char lang)
	{
		return lang == CMSApplication.LANG_ENG ? headerNamesEng[p] : headerNamesRus[p];
	}
%>
<%
String changeLangUrl;
if(request.getParameter("id") == null && request.getParameter("section") == null)
	changeLangUrl = "/index.jsp";
else
	changeLangUrl = "/page.jsp";
changeLangUrl += "?lang=" + (lang == E ? R : E);
for(int i = 0; i < parameters.length; i++)
	if(!parameters[i].startsWith("lang="))
		changeLangUrl += "&" + parameters[i];
%>
<% if(!sectionCode.equals(SectionCode.ROOT)) {%>
<map name="logo">
<area shape="poly" coords="42,0,29,34,6,40,30,48,43,76,48,52,74,40,51,30,42,0" href="#" >
<area shape="rect" coords="53,49,146,77" href="<% if(previewInfo == null){ %>/?lang=<%=lang%><%}else{%>#<%}%>" TITLE="Нортгаз">
</map>
<% } %>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR VALIGN="top">
<TD><IMG SRC="<%=des%>/top/logo.gif" WIDTH="146" HEIGHT="85" ALT="<%=headerText(5, lang)%>" BORDER="0"<% if(!sectionCode.equals(SectionCode.ROOT)) {%> USEMAP="#logo"<% } %>><IMG SRC="<%=des%>/top/x.gif" WIDTH="30" HEIGHT="85" ALT="" BORDER="0"></TD>
<TD>
<IMG SRC="<%=des%>/top/xeng.gif" WIDTH="140" HEIGHT="30" ALT="" BORDER="0"><BR>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR ALIGN="right">
<TD><A HREF="<% if(previewInfo == null){ %><%=changeLangUrl%><%}else{%>#<%}%>"><IMG SRC="<%=des%>/top/ch_lang.gif" WIDTH="140" HEIGHT="16" ALT="english version" BORDER="0"></A></TD>
<TD><IMG SRC="<%=des%>/top/ftn_lft.gif" WIDTH="7" HEIGHT="16"></TD>
<TD><IMG SRC="<%=des%>/top/ftn_blt<% if(sectionCode.equals(SectionCode.ROOT)) {%>_cur<% } %>.gif" WIDTH="16" HEIGHT="16"></TD>
<TD BGCOLOR="#FFFFFF"><A<% if(!sectionCode.equals(SectionCode.ROOT)) {%> HREF="<% if(previewInfo == null){ %>/?lang=<%=lang%><%}else{%>#<%}%>"<% } %> CLASS="tn"><%=headerText(0, lang)%></A></TD>
<TD BGCOLOR="#FFFFFF" WIDTH="22"><IMG SRC="<%=des%>/top/ftn_blt<% if(sectionCode.equals(SectionCode.NEWS)) {%>_cur<% } %>.gif" WIDTH="16" HEIGHT="16"></TD>
<TD BGCOLOR="#FFFFFF"><A<% if(!sectionCode.equals(SectionCode.NEWS)) {%> HREF="<% if(previewInfo == null){ %>/page.jsp?section=<%=SectionCode.NEWS%>&lang=<%=lang%><%}else{%>#<%}%>"<% } %> CLASS="tn"><%=headerText(1, lang)%></A></TD>
<TD BGCOLOR="#FFFFFF" WIDTH="22"><IMG SRC="<%=des%>/top/ftn_blt<% if(sectionCode.equals(SectionCode.LINK)) {%>_cur<% } %>.gif" WIDTH="16" HEIGHT="16"></TD>
<TD BGCOLOR="#FFFFFF"><A<% if(!sectionCode.equals(SectionCode.LINK)) {%> HREF="<% if(previewInfo == null){ %>/page.jsp?section=<%=SectionCode.LINK%>&lang=<%=lang%><%}else{%>#<%}%>"<% } %> CLASS="tn"><%=headerText(2, lang)%></A></TD>
<TD BGCOLOR="#FFFFFF" WIDTH="22"><IMG SRC="<%=des%>/top/ftn_blt<% if(sectionCode.equals(SectionCode.CONTACT)) {%>_cur<% } %>.gif" WIDTH="16" HEIGHT="16"></TD>
<TD BGCOLOR="#FFFFFF"><A<% if(!sectionCode.equals(SectionCode.CONTACT)) {%> HREF="<% if(previewInfo == null){ %>/page.jsp?section=<%=SectionCode.CONTACT%>&lang=<%=lang%><%}else{%>#<%}%>"<% } %> CLASS="tn"><%=headerText(3, lang)%></A></TD>
<TD BGCOLOR="#FFFFFF" WIDTH="22"><IMG SRC="<%=des%>/top/ftn_blt<% if(sectionCode.equals(SectionCode.FEEDBACK)) {%>_cur<% } %>.gif" WIDTH="16" HEIGHT="16"></TD>
<TD BGCOLOR="#FFFFFF"><A<% if(!sectionCode.equals(SectionCode.FEEDBACK)) {%> HREF="<% if(previewInfo == null){ %>/page.jsp?section=<%=SectionCode.FEEDBACK%>&lang=<%=lang%><%}else{%>#<%}%>"<% } %> CLASS="tn"><%=headerText(4, lang)%></A></TD>
<TD BGCOLOR="#FFFFFF" WIDTH="15"><IMG SRC="<%=des%>/top/ftn_rght.gif" WIDTH="7" HEIGHT="16"></TD>
</TR>
</TABLE><IMG SRC="<%=des%>/top/xengln.gif" WIDTH="140" HEIGHT="1"><BR><IMG SRC="<%=des%>/top/xtn.gif" WIDTH="604" HEIGHT="18"><BR>
<SCRIPT language="JavaScript" SRC="/inc/tn.js"></SCRIPT>
<SCRIPT language="JavaScript">
function rollz(itemNav)
{
<% if(sectionCode.equals(SectionCode.PRODUCT)) {%>
if (itemNav=="HM_Menu1_1") MM_swapImage('tn2','','<%=des%>/tn/tn2f2f3.gif','tn1','','<%=des%>/tn/tn1f2.gif',1);
if (itemNav=="HM_Menu3_1") MM_swapImage('tn5','','<%=des%>/tn/tn5f4.gif','tn4','','<%=des%>/tn/tn2f2f3.gif','tn6','','<%=des%>/tn/tn2f2.gif',1);
<% } else if(sectionCode.equals(SectionCode.INVESTOR)) {%>
if (itemNav=="HM_Menu1_1") MM_swapImage('tn2','','<%=des%>/tn/tn2f2.gif','tn1','','<%=des%>/tn/tn1f2.gif',1);
if (itemNav=="HM_Menu3_1") MM_swapImage('tn5','','<%=des%>/tn/tn5f4.gif','tn4','','<%=des%>/tn/tn2f3.gif','tn6','','<%=des%>/tn/tn2f2f3.gif',1);
<% } else {%>
if (itemNav=="HM_Menu1_1") MM_swapImage('tn2','','<%=des%>/tn/tn2f2.gif','tn1','','<%=des%>/tn/tn1f2.gif',1);
if (itemNav=="HM_Menu3_1") MM_swapImage('tn5','','<%=des%>/tn/tn5f4.gif','tn4','','<%=des%>/tn/tn2f3.gif','tn6','','<%=des%>/tn/tn2f2.gif',1);
<% } %>
<% if(sectionCode.equals(SectionCode.COMPANY)) {%>
if (itemNav=="HM_Menu2_1") MM_swapImage('tn3','','<%=des%>/tn/tn3f3.gif','tn2','','<%=des%>/tn/tn2f2f3.gif','tn4','','<%=des%>/tn/tn2f2.gif',1);
<% } else if(sectionCode.equals(SectionCode.PROJECT)) {%>
if (itemNav=="HM_Menu2_1") MM_swapImage('tn3','','<%=des%>/tn/tn3f3.gif','tn2','','<%=des%>/tn/tn2f3.gif','tn4','','<%=des%>/tn/tn2f2f3.gif',1);
<% } else {%>
if (itemNav=="HM_Menu2_1") MM_swapImage('tn3','','<%=des%>/tn/tn3f3.gif','tn2','','<%=des%>/tn/tn2f3.gif','tn4','','<%=des%>/tn/tn2f2.gif',1);
<% } %>
<% if(sectionCode.equals(SectionCode.PROJECT)) {%>
if (itemNav=="HM_Menu4_1") MM_swapImage('tn7','','<%=des%>/tn/tn7f5.gif','tn6','','<%=des%>/tn/tn2f2f3.gif','tn8','','<%=des%>/tn/tn2f2.gif',1);
<% } else if(sectionCode.equals(SectionCode.SUPPLIER)) {%>
if (itemNav=="HM_Menu4_1") MM_swapImage('tn7','','<%=des%>/tn/tn7f5.gif','tn6','','<%=des%>/tn/tn2f3.gif','tn8','','<%=des%>/tn/tn2f2f3.gif',1);
<% } else {%>
if (itemNav=="HM_Menu4_1") MM_swapImage('tn7','','<%=des%>/tn/tn7f5.gif','tn6','','<%=des%>/tn/tn2f3.gif','tn8','','<%=des%>/tn/tn2f2.gif',1);
<% } %>
<% if(sectionCode.equals(SectionCode.INVESTOR)) {%>
if (itemNav=="HM_Menu5_1") MM_swapImage('tn9','','<%=des%>/tn/tn9f6.gif','tn8','','<%=des%>/tn/tn2f2f3.gif','tn10','','<%=des%>/tn/tn2f2.gif',1);
<% } else if(sectionCode.equals(SectionCode.PARTNER)) {%>
if (itemNav=="HM_Menu5_1") MM_swapImage('tn9','','<%=des%>/tn/tn9f6.gif','tn8','','<%=des%>/tn/tn2f3.gif','tn10','','<%=des%>/tn/tn2f2f3.gif',1);
<% } else {%>
if (itemNav=="HM_Menu5_1") MM_swapImage('tn9','','<%=des%>/tn/tn9f6.gif','tn8','','<%=des%>/tn/tn2f3.gif','tn10','','<%=des%>/tn/tn2f2.gif',1);
<% } %>
<% if(sectionCode.equals(SectionCode.SUPPLIER)) {%>
if (itemNav=="HM_Menu6_1") MM_swapImage('tn11','','<%=des%>/tn/tn11f7.gif','tn10','','<%=des%>/tn/tn2f2f3.gif',1);
<% } else {%>
if (itemNav=="HM_Menu6_1") MM_swapImage('tn11','','<%=des%>/tn/tn11f7.gif','tn10','','<%=des%>/tn/tn2f3.gif',1);
<% } %>
}
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/inc/HM_Loader.jsp?lang=<%=lang%>" TYPE='text/javascript'></SCRIPT>
<TABLE border="0" cellpadding="0" cellspacing="0">
<SCRIPT language="JavaScript">
if (document.images) {
tn2_f2_f3 = new Image(); tn2_f2_f3.src = "<%=des%>/tn/tn2f2f3.gif";
tn2_f2 = new Image(); tn2_f2.src = "<%=des%>/tn/tn2f2.gif";
tn2_f1 = new Image(); tn2_f1.src = "<%=des%>/tn/tn2.gif";
tn1_f2 = new Image(); tn1_f2.src = "<%=des%>/tn/tn1f2.gif";
tn1_f1 = new Image(); tn1_f1.src = "<%=des%>/tn/tn1.gif";
tn3_f3 = new Image(); tn3_f3.src = "<%=des%>/tn/tn3f3.gif";
tn3_f1 = new Image(); tn3_f1.src = "<%=des%>/tn/tn3.gif";
tn2_f3 = new Image(); tn2_f3.src = "<%=des%>/tn/tn2f3.gif";
tn5_f4 = new Image(); tn5_f4.src = "<%=des%>/tn/tn5f4.gif";
tn5_f1 = new Image(); tn5_f1.src = "<%=des%>/tn/tn5.gif";
tn7_f5 = new Image(); tn7_f5.src = "<%=des%>/tn/tn7f5.gif";
tn7_f1 = new Image(); tn7_f1.src = "<%=des%>/tn/tn7.gif";
tn9_f6 = new Image(); tn9_f6.src = "<%=des%>/tn/tn9f6.gif";
tn9_f1 = new Image(); tn9_f1.src = "<%=des%>/tn/tn9.gif";
tn11_f7 = new Image(); tn11_f7.src = "<%=des%>/tn/tn11f7.gif";
tn11_f1 = new Image(); tn11_f1.src = "<%=des%>/tn/tn11.gif";
}
</SCRIPT>
<TR>
<%
	WebTreeNode node222 = CMSApplication.getApplication().getSectionNode(SectionCode.COMPANY);
	String func = node222.hasVisibleChilds() ? "HM_f_PopDown('HM_Menu1_1');" : "MM_swapImgRestore();";
%>
<TD><A href="<% if(previewInfo == null){%>/page.jsp?section=<%=SectionCode.COMPANY%>&lang=<%=lang%><%}else{%>#<%}%>" onMouseOut="<%=func%>" onMouseOver="HM_f_PopUp('HM_Menu1_1',event);"><IMG name="tn1" src="<%=des%>/tn/tn1<% if(sectionCode.equals(SectionCode.COMPANY)) {%>f2<% } %>.gif" width="<%=lang == R ? 95 : 78%>" height="20" border="0"></A></TD>
<TD><IMG name="tn2" src="<%=des%>/tn/tn2<% if(sectionCode.equals(SectionCode.COMPANY)) {%>f2<% } %><% if(sectionCode.equals(SectionCode.PRODUCT)) {%>f3<% } %>.gif" width="10" height="20" border="0"></TD>
<%
	node222 = CMSApplication.getApplication().getSectionNode(SectionCode.PRODUCT);
	func = node222.hasVisibleChilds() ? "HM_f_PopDown('HM_Menu2_1');" : "MM_swapImgRestore();";
%>
<TD><A href="<% if(previewInfo == null){%>/page.jsp?section=<%=SectionCode.PRODUCT%>&lang=<%=lang%><%}else{%>#<%}%>" onMouseOut="<%=func%>" onMouseOver="HM_f_PopUp('HM_Menu2_1',event);"><IMG name="tn3" src="<%=des%>/tn/tn3<% if(sectionCode.equals(SectionCode.PRODUCT)) {%>f3<% } %>.gif" width="<%=lang == R ? 72 : 83%>" height="20" border="0"></A></TD>
<TD><IMG name="tn4" src="<%=des%>/tn/tn2<% if(sectionCode.equals(SectionCode.PRODUCT)) {%>f2<% } %><% if(sectionCode.equals(SectionCode.PROJECT)) {%>f3<% } %>.gif" width="10" height="20" border="0"></TD>
<%
	node222 = CMSApplication.getApplication().getSectionNode(SectionCode.PROJECT);
	func = node222.hasVisibleChilds() ? "HM_f_PopDown('HM_Menu3_1');" : "MM_swapImgRestore();";
%>
<TD><A href="<% if(previewInfo == null){%>/page.jsp?section=<%=SectionCode.PROJECT%>&lang=<%=lang%><%}else{%>#<%}%>" onMouseOut="<%=func%>" onMouseOver="HM_f_PopUp('HM_Menu3_1',event);"><IMG name="tn5" src="<%=des%>/tn/tn5<% if(sectionCode.equals(SectionCode.PROJECT)) {%>f4<% } %>.gif" width="<%=lang == R ? 54 : 60%>" height="20" border="0"></A></TD>
<TD><IMG name="tn6" src="<%=des%>/tn/tn2<% if(sectionCode.equals(SectionCode.PROJECT)) {%>f2<% } %><% if(sectionCode.equals(SectionCode.INVESTOR)) {%>f3<% } %>.gif" width="10" height="20" border="0"></TD>
<%
	node222 = CMSApplication.getApplication().getSectionNode(SectionCode.INVESTOR);
	func = node222.hasVisibleChilds() ? "HM_f_PopDown('HM_Menu4_1');" : "MM_swapImgRestore();";
%>
<TD><A href="<% if(previewInfo == null){%>/page.jsp?section=<%=SectionCode.INVESTOR%>&lang=<%=lang%><%}else{%>#<%}%>" onMouseOut="<%=func%>" onMouseOver="HM_f_PopUp('HM_Menu4_1',event);"><IMG name="tn7" src="<%=des%>/tn/tn7<% if(sectionCode.equals(SectionCode.INVESTOR)) {%>f5<% } %>.gif" width="<%=lang == R ? 79 : 87%>" height="20" border="0"></A></TD>
<TD><IMG name="tn8" src="<%=des%>/tn/tn2<% if(sectionCode.equals(SectionCode.INVESTOR)) {%>f2<% } %><% if(sectionCode.equals(SectionCode.SUPPLIER)) {%>f3<% } %>.gif" width="10" height="20" border="0"></TD>
<%
	node222 = CMSApplication.getApplication().getSectionNode(SectionCode.SUPPLIER);
	func = node222.hasVisibleChilds() ? "HM_f_PopDown('HM_Menu5_1');" : "MM_swapImgRestore();";
%>
<TD><A href="<% if(previewInfo == null){%>/page.jsp?section=<%=SectionCode.SUPPLIER%>&lang=<%=lang%><%}else{%>#<%}%>" onMouseOut="<%=func%>" onMouseOver="HM_f_PopUp('HM_Menu5_1',event);"><IMG name="tn9" src="<%=des%>/tn/tn9<% if(sectionCode.equals(SectionCode.SUPPLIER)) {%>f6<% } %>.gif" width="<%=lang == R ? 90 : 78%>" height="20" border="0"></A></TD>
<TD><IMG name="tn10" src="<%=des%>/tn/tn2<% if(sectionCode.equals(SectionCode.SUPPLIER)) {%>f2<% } %><% if(sectionCode.equals(SectionCode.PARTNER)) {%>f3<% } %>.gif" width="10" height="20" border="0"></TD>
<%
	node222 = CMSApplication.getApplication().getSectionNode(SectionCode.PARTNER);
	func = node222.hasVisibleChilds() ? "HM_f_PopDown('HM_Menu6_1');" : "MM_swapImgRestore();";
%>
<TD><A href="<% if(previewInfo == null){%>/page.jsp?section=<%=SectionCode.PARTNER%>&lang=<%=lang%><%}else{%>#<%}%>" onMouseOut="<%=func%>" onMouseOver="HM_f_PopUp('HM_Menu6_1',event);"><IMG name="tn11" src="<%=des%>/tn/tn11<% if(sectionCode.equals(SectionCode.PARTNER)) {%>f7<% } %>.gif" width="<%=lang == R ? 71 : 75%>" height="20" border="0"></A></TD>
<TD><DIV STYLE="font-family:arial;font-size:10px;color:#FFFFFF;margin:3 0 0 <%=lang == E ? 1 : 3%>;"><%=HomePage.getHomePage().getDate(lang)%></DIV></TD>
</TR>
</TABLE>
</TD>
</TR>
</TABLE>