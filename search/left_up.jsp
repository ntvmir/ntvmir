<%
    String query = request.getParameter("f_query");
    if(query == null)
    	query = "";
    else
        query = query.trim();
    	
    String mode = request.getParameter("f_mode");
    if( ! ("and".equals(mode) || "or".equals(mode) || "full".equals(mode)))
    	mode = "and";
    if(query.length() > 0)
    {
%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" BACKGROUND="" STYLE="margin-top:8px;" width="100%">
<tr><form action=""><td><div style="width:6;"><SPACER TYPE="block" HEIGHT="1" WIDTH="6"></div></td>
<td width="100%"><INPUT TYPE="Text" NAME="f_query" SIZE="15" STYLE="width:139;" VALUE="<%=CMSApplication.toHTML(query)%>"></td>
<TD><input type="Image" src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5"></TD>
<td><div style="width:1;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></div></td>
</tr>
</table>
<table BORDER="0" CELLPADDING="0" CELLSPACING="2" BACKGROUND="" STYLE="margin-top:2px;" width="100%">
<TR>
<td><div style="width:2;"><SPACER TYPE="block" HEIGHT="1" WIDTH="2"></div></td>
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="and" <%="and".equals(mode) ? "CHECKED" : ""%> id="1"></TD><TD CLASS="XsmallFont" WIDTH="15"> <LABEL for="1">и</LABEL>&nbsp;&nbsp;</TD>
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="or" <%="or".equals(mode) ? "CHECKED" : ""%> id="2"></TD><TD CLASS="XsmallFont" WIDTH="25"> <LABEL for="2">или</LABEL>&nbsp;&nbsp;</TD>
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="full" <%="full".equals(mode) ? "CHECKED" : ""%> id="3"></TD><TD CLASS="XsmallFont" nowrap> <LABEL for="3">фраза целиком</LABEL>&nbsp;&nbsp;</TD>
</form></TR>
</TABLE>
<%  }
    else
    {
%>
<%@include file="/user/left_up.jsp"%>
<%  } %>