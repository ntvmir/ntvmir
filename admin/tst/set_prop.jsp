<%@ page import="java.util.Enumeration"%>
<%@page import="tengry.cms.db.*"%>
<%@page import="tengry.cms.*"%>
<%@page import="tengry.cms.core.*"%>
<%@page import="tengry.northgas.*"%>
<%
String name = request.getParameter("name");
if(name != null && name.length() > 0)
	CMSApplication.getApplication().setStoredProperty(name,request.getParameter("val"));


DBStatement st = new DBStatement ("select * from ent_property order by m_name");
Enumeration enum = st.executeQuery(new Property()).elements();
%>
<TABLE>
<%
while(enum.hasMoreElements())
{
	Property prop = (Property)enum.nextElement();
%>
<TR>
<FORM ACTION=set_prop.jsp>
<INPUT TYPE="hidden" NAME="name" VALUE="<%=prop.getName()%>">
<TD><%=prop.getName()%></TD>
<TD><TEXTAREA NAME="val" cols=30 rows=2><%=prop.getValue()%></TEXTAREA></TD>
<TD><INPUT TYPE=SUBMIT VALUE="go"></TD>
</FORM>
</TR>
<%
}
%>
</TABLE>