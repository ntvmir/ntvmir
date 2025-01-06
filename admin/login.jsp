<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="tengry.cms.*" %>
<%@ page import="java.util.*" %>
<%
    response.setHeader( "Pragma", "no-cache" );
%>
<jsp:include page="/admin/inc/page_header.jsp" flush="true">
<jsp:param name="title" value="Авторизация администратора"/>
</jsp:include>
<BR><BR>
<% if( "1".equals( request.getParameter( "err" ))){ %>
<B>Ошибка авторизации</B><BR>
<%	} %>
<FORM ACTION="xt_login.jsp" METHOD="POST">
<TABLE WIDTH="350" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<TR ALIGN="center">
<TD CLASS="titnew" HEIGHT="20" COLSPAN="2">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="titnew">Авторизация</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Login:</DIV>
</TD>
<TD CLASS="c2">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="text" NAME="login" VALUE="" SIZE="30"></DIV>
</TD>
</TR>

<TR>
<TD CLASS="c2" HEIGHT="20" WIDTH="30%">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">Пароль:</DIV>
</TD>
<TD CLASS="c2">
<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="password" NAME="password" VALUE="" SIZE="30"></DIV>
</TD>
</TR>


<TR ALIGN="center">
<TD CLASS="c2" COLSPAN=2>
<INPUT TYPE="submit" VALUE="Войти в систему">
</TD>
</TR>
</TABLE>
</FORM>

</BODY>
</HTML>
