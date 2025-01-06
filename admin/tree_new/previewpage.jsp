<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%@ page import="tengry.northgas.*" %>
<%@ page import="java.util.Vector" %>

<%@ include file = "/inc/init.jsp" %>

<%

    response.setHeader("Pragma","no-cache");
	
	String lang	= request.getParameter( "lang" );
	if ( lang == null )	lang	= "";
	
	String nodeId = request.getParameter( "node" );
	String mode = request.getParameter( "mode" );

//	WebPage wp = (WebPage) WebApp.getApp().getWebRoot().lookup( pageId );

	String visible = request.getParameter( "visible" );
	if( visible == null ) visible = "";



	int frame;
	try{ 
		frame = Integer.parseInt( request.getParameter( "frame" )); 
	}catch( Exception e ){ frame = 0; }


	int num;
	try{ 
		num = Integer.parseInt( request.getParameter( "frame_num" )); 
	}catch( Exception e ){ num = -1; }

%><HTML>
<HEAD>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
<META HTTP-EQUIV=Content-language CONTENT=RU>
<META NAME=description CONTENT="">
<META NAME=keywords CONTENT="">
<META NAME=autor CONTENT="">
<!-- "$Revision::                    $" -->
<!-- "$Author::     GorinD                   $" -->
<!-- "$Date::                           $"-->
<LINK REL="STYLESHEET" TYPE="text/css" HREF="<%=des%>img/2lev/css.css">
<TITLE><%=lang.equals("E") ? "JSC MMC \"Norilsk Nickel\". " + request.getParameter( "nameeng" ) : "ОАО \"ГМК \"Норильский никель\" " + request.getParameter( "namerus" )%></TITLE>
</HEAD>
<BODY  BGCOLOR="#FFFFFF" LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>

<CENTER>

<jsp:include page="/inc/header.jsp" flush="true">  <jsp:param name="des" value="<%=des%>"/>
<jsp:param name="des" value="<%=des%>"/>
<jsp:param name="pageId" value="<%=nodeId%>"/>
<jsp:param name="lang" value="<%=lang%>"/>
<jsp:param name="admin_mode" value="<%=mode%>"/>
</jsp:include>

<TABLE WIDTH="780" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR VALIGN="TOP">

<jsp:include page="/inc/left.jsp" flush="true">
<jsp:param name="des" value="<%=des%>"/>
<jsp:param name="pageId" value="<%=nodeId%>"/>
<jsp:param name="lang" value="<%=lang%>"/>
<jsp:param name="admin_mode" value="<%=mode%>"/>
</jsp:include>

<TD WIDTH="100%" STYLE="background:#FFFFFF url(<%=des%>img/2lev/bg.gif) no-repeat">

<DIV STYLE="padding-left:15px;">



<jsp:include page="/inc/nav.jsp" flush="true">
<jsp:param name="des" value="<%=des%>"/>
<jsp:param name="lang" value="<%=lang%>"/>
<jsp:param name="pageId" value="<%=nodeId%>"/>
<jsp:param name="admin_mode" value="<%=mode%>"/>
<jsp:param name="page_name" value="<%= WebUtil.encodeURL( "E".equals( lang ) ? WebUtil.toHTML(request.getParameter( "nameeng" )) : WebUtil.toHTML(request.getParameter( "namerus" )))%>"/>
</jsp:include>


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="530" BACKGROUND="">
<TR>
<TD CLASS="sm">
<A HREF="javascript:document.main_form.action='page_edit.jsp'; document.main_form.submit();" CLASS="tn"><IMG SRC="<%=des%>img/2lev/3arr.gif" WIDTH=19 HEIGHT=5 ALT="" BORDER="0"><B>Вернуться в режим редактирования</B><IMG SRC="<%=des%>img/2lev/arr_tn.gif" WIDTH=9 HEIGHT=5 ALT="" BORDER="0"></A>
</TD>
<TD ALIGN="RIGHT">
</TD>
</TR>
</TABLE>
<BR>
<SPAN CLASS="color1"><B>
<%= "E".equals( lang ) ? WebUtil.toHTML(request.getParameter( "nameeng" )) : WebUtil.toHTML(request.getParameter( "namerus" ))%>
</B></SPAN>
<BR>
<BR>

<FORM ACTION="previewpage.jsp" NAME="main_form" METHOD="post">
<INPUT TYPE="Hidden" NAME="from_preview" VALUE="1">
<INPUT TYPE="Hidden" NAME="mode" VALUE="<%=mode%>">
<INPUT TYPE="Hidden" NAME="node" VALUE="<%=nodeId%>">
<INPUT TYPE="Hidden" NAME="pageId" VALUE="<%=nodeId%>">
<INPUT TYPE="Hidden" NAME="lang" VALUE="<%=lang%>">
<INPUT TYPE="Hidden" NAME="visible" VALUE="<%= visible %>">
<INPUT TYPE="Hidden" NAME="namerus" VALUE="<%=WebUtil.toHTML(request.getParameter( "namerus" ))%>">
<INPUT TYPE="Hidden" NAME="nameeng" VALUE="<%=WebUtil.toHTML(request.getParameter( "nameeng" ))%>">
<INPUT TYPE="Hidden" NAME="frame_num" VALUE="<%= num %>">
<INPUT TYPE="Hidden" NAME="frame" VALUE="<%= num %>">

<%	

		for( int i = 0; i < num; i ++ ){
%>
<INPUT TYPE="hidden" NAME="contentrus_<%=i%>" VALUE="<%=WebUtil.toHTML(request.getParameter( "contentrus_" + i ))%>">
<INPUT TYPE="hidden" NAME="contenteng_<%=i%>" VALUE="<%=WebUtil.toHTML(request.getParameter( "contenteng_" + i ))%>">
<INPUT TYPE="hidden" NAME="fnum_<%=i%>" VALUE="<%= request.getParameter( "fnum_" + i )%>">
<%		
		}
%>
<%= request.getParameter( "content" + (lang.equals( "E" ) ? "eng" : "rus" ) + "_" + frame ) %>
<BR>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="530" BACKGROUND="">
<TR>
<TD WIDTH="33%">
<%			if( frame > 0 ){ %>
<A HREF="javascript:document.main_form.frame.value=<%=frame-1%>;document.main_form.submit();" CLASS="tn"><IMG SRC="<%=des%>img/2lev/3arr.gif" WIDTH=19 HEIGHT=5
ALT="" BORDER="0"><B><%= lang.equals( "E" ) ? "back" :"назад" %></B><IMG SRC="<%=des%>img/2lev/arr_tn.gif" WIDTH=9
HEIGHT=5 ALT="" BORDER="0"></A>
<%			} else { %>
&nbsp;
<%			}%>
</TD>
<TD WIDTH="33%" ALIGN="center">
<%			if( frame > 0 ){ %>
<A HREF="javascript:document.main_form.frame.value=<%=0%>;document.main_form.submit();" CLASS="tn"><IMG SRC="<%=des%>img/2lev/3arr.gif" WIDTH=19 HEIGHT=5
ALT="" BORDER="0"><B><%= lang.equals( "E" ) ? "first page" :"в начало"%></B><IMG SRC="<%=des%>img/2lev/arr_tn.gif" WIDTH=9
HEIGHT=5 ALT="" BORDER="0"></A>
<%			}else{ %>
&nbsp;
<%			} %>
</TD>
<TD WIDTH="33%" ALIGN="RIGHT">
<%			if( frame + 1 < num ){ %>
<A HREF="javascript:document.main_form.frame.value=<%=frame + 1%>;document.main_form.submit();" CLASS="tn"><IMG SRC="<%=des%>img/2lev/3arr.gif" WIDTH=19 HEIGHT=5
ALT="" BORDER="0"><B><%= lang.equals( "E" ) ? "next" :"далее"%></B><IMG SRC="<%=des%>img/2lev/arr_tn.gif" WIDTH=9
HEIGHT=5 ALT="" BORDER="0"></A>
<%			}else{ %>
&nbsp;
<%			}%>
</TD>
</TR>
</TABLE>
<BR>


</FORM>
</DIV>

</TD>
<TD><IMG SRC="<%=des%>img/blank.gif" WIDTH=48 HEIGHT=1><BR></TD>
</TR>
</TABLE>


<!------ !!!!!!!  ЗАМЕНА ВСЕГО БОТТОМА   ------->
<TABLE WIDTH="780" BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="margin-top:7;">
<TR VALIGN="TOP">
<TD><IMG SRC="<%=des%>img/blank.gif" WIDTH=198 HEIGHT=1><BR></TD>
<TD>
<IMG SRC="<%=des%><%=lang.equals("E")? "/eng":""%>/img/2lev/bot_fn.gif" WIDTH="534" HEIGHT="21" ALT="" BORDER="0"><BR>
</TD>
<TD><IMG SRC="<%=des%>img/blank.gif" WIDTH=48 HEIGHT=1><BR></TD>
</TR>
<TR VALIGN="TOP">
<TD></TD>
<TD ALIGN="right" CLASS="copy" VALIGN="bottom" HEIGHT="20"><A CLASS="tn"><%=lang.equals("E")? "Copyright &copy; 2001 JSC MMC \"Norilsk Nickel\"":"&copy; 2001 ОАО \"ГМК \"Норильский Никель\""%></A></TD>
<TD></TD>
</TR>
</TABLE>
<IMG SRC="<%=des%>img/blank.gif" WIDTH=1 HEIGHT=5><BR>
<!---\\  ЗАМЕНА ВСЕГО БОТТОМА  ------->


</CENTER>
</BODY>
</HTML>
