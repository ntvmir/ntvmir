<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

<%@ page import="tengry.northgas.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>



<% String pageId = "comp.faq.themes"; %>
<%@ include file="/admin/inc/authorize.jsp"%>




<%
    response.setHeader( "Pragma", "no-cache" );
%>
<%!
	//функция вывода тумы форума
	private void showFAQCategories( JspWriter out, String name, long id, String lang ) throws IOException
	{
		out.println("<TR BGCOLOR=\"#E9E9E9\">");
		out.println("<TD WIDTH=\"1%\" HEIGHT=\"20\" CLASS=\"c1\">");
		out.print("<INPUT TYPE=\"checkbox\" NAME=\"category\" VALUE=\""+id+"\">");
		out.println("</TD>");
		out.println("<TD  CLASS=\"c1\" WIDTH=\"97%\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
		out.println("<A HREF=\"faq_category.jsp?mode=edit_category&id="+id+"&lang="+lang+"\">");
		out.println( name );
		out.println("</A>");
		out.println("</DIV></TD>");
		out.println("<TD  CLASS=\"c1\" WIDTH=\"1%\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
		out.println("<A HREF=\"faqs.jsp?id="+id+"&lang="+lang+"\">");
		out.println( "сообщения" );
		out.println("</A>");
		out.println("</DIV></TD>");
		out.println("</TR>");
	}

	//функция вывода списка тем форума
	private void showFAQCategories( JspWriter out, String lang ) throws IOException
	{
		Connection 			con  	= null;
		PreparedStatement	stmt	= null;
		ResultSet	rs	= null;

		try
		{
			con	 = WebApp.getConnection();
			stmt = con.prepareStatement( "SELECT faq_category.*, (select count(faq_question#) from faq_question where faq_category#=faq_category.faq_category# AND isPublished='0') q_new, " +
				"(select count(faq_question#) from faq_question where faq_category#=faq_category.faq_category# AND isPublished='2') q_unpub, " +
				"(select count(faq_question#) from faq_question where faq_category#=faq_category.faq_category#) q_total " +
				"FROM faq_category WHERE lang='"+lang+"' ORDER BY name" );

			rs	= stmt.executeQuery();

			out.println("<TABLE BORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"1\" WIDTH=\"655\">");
			out.println("<TR>");
			out.println("	<TD COLSPAN=\"3\" ALIGN=\"CENTER\">");
			out.println("		<B>Темы вопросов-ответов</B><BR>");
			out.println("		<IMG SRC=\"/admin/img/blank.gif\" WIDTH=1 HEIGHT=20><BR>");
			out.println("	</TD>");
			out.println("</TR>");

			out.println("<TR BGCOLOR=\"#C0C0C0\">");
			out.println("<TD HEIGHT=\"20\" CLASS=\"titnew\" COLSPAN=\"3\" ALIGN=\"center\"><DIV STYLE=\"padding-left:6px;padding-right:6px\" CLASS=\"titnew\"><B>");
			out.println("Темы вопросов-ответов <A HREF=\"faq_category.jsp?mode=add&lang="+lang+"\">добавить тему</A>");
			out.println("</B></DIV></TD>");
			out.println("</TR>");

			out.println("<TR BGCOLOR=\"#C0C0C0\">");
			out.println("<TD WIDTH=\"1%\" HEIGHT=\"20\" CLASS=\"c2\">");
			out.println("&nbsp;");
			out.println("</TD>");
			out.println("<TD CLASS=\"c2\" WIDTH=\"97%\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("Тема");
			out.println("</B></DIV></TD>");
			out.println("<TD CLASS=\"c2\" WIDTH=\"1%\">");
			out.println("&nbsp;");
			out.println("</TD>");
			out.println("</TR>");
			for ( ; rs.next(); )
			{
				String	name	= rs.getString( "name" );
				long	id	= rs.getLong( "faq_category#" );
//				showFAQCategories( out, name, id, lang, q_new, q_pub );
				out.println("<TR BGCOLOR=\"#E9E9E9\">");
				out.println("<TD WIDTH=\"1%\" HEIGHT=\"20\" CLASS=\"c1\">");
				if( rs.getInt("q_total")==0 )
					out.print("<INPUT TYPE=\"checkbox\" NAME=\"category\" VALUE=\""+id+"\">");
				out.println("</TD>");
				out.println("<TD  CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
				out.println("<A HREF=\"faq_category.jsp?mode=edit_category&id="+id+"&lang="+lang+"\">");
				out.println( name );
				out.println("</A>");
				out.println("</DIV></TD>");
				out.println("<TD NOWRAP CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
				out.println("<A HREF=\"faqs.jsp?id="+id+"&lang="+lang+"\">");
				out.println( "сообщения" );
				out.println("</A>");
				out.println( "(новые: " + rs.getString("q_new") );
				out.println( "неопубликованные: " + rs.getString("q_unpub") );
				out.println(")</DIV></TD>");
				out.println("</TR>");

			}
			out.println("</TABLE>");
		} catch( Exception e ) {
			//out.print( "Exception^"+e );
		} finally {
			try	{ if (rs != null) rs.close(); } catch (Exception e) {}
			try { if (stmt != null) stmt.close(); } catch (Exception e){}
			try { if (con != null) con.close(); } catch (Exception e){}
		}
	}
%>

<%
	String	mode	= request.getParameter("mode");
	if ( mode == null ) mode	= "";

	String	lang	= request.getParameter( "lang" );
	if ( lang == null || lang.length() == 0 )	lang	= "Z";

	if( "add".equals( mode ) && ! isC( pageAccessCode ))
	{
		response.sendRedirect( "faq_category.jsp?lang="+lang+"&err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
%>

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
<TITLE>Вопрос-ответ</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">
</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<jsp:include page="/admin/inc/menu.jsp" flush="true" /> 
<%@ include file="/admin/inc/error.jsp"%>


<%
	
	
	if ( mode.equalsIgnoreCase("add") )
	{
		%>
<FORM NAME="FORM2" ACTION="xt_faq_category.jsp" METHOD="post">
<INPUT TYPE="Hidden" NAME="action" VALUE="add_category">
<INPUT TYPE="Hidden" NAME="lang" VALUE="<%=lang%>">
<TABLE WIDTH="655" BORDER="0" CELLSPACING="0" CELLPADDING="0">
<TR>
	<TD COLSPAN="1" ALIGN="CENTER">
		<B>Темы вопросов-ответов</B><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
	</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Тема:</B>
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20"><INPUT TYPE="text" NAME="name" STYLE="width:655" SIZE="34">
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="Checkbox" NAME="isPublished" VALUE="1"> - публиковать
</DIV>
</TD>
</TR>
</TABLE>
<INPUT TYPE="button" VALUE="добавить" ONCLICK="if (document.FORM2.name.value=='') {alert('Тема не может быть пустой!');}else{document.FORM2.submit();}">
</FORM>
		<%
	}
	else if  ( mode.equalsIgnoreCase("edit_category") )
	{
		String	categoryIdParam	= request.getParameter("id");
		long	categoryId	= -1;
		if ( categoryIdParam != null ) categoryId	= Long.parseLong( categoryIdParam );
		
		FAQCategory	fc	= new FAQCategory();
		try
		{
			fc.load( categoryId );
			%>
<A HREF="faq_category.jsp?lang=<%=request.getParameter("lang")%>">назад</A><BR><BR>
<FORM NAME="FORM3" ACTION="xt_faq_category.jsp" METHOD="post">
<INPUT TYPE="Hidden" NAME="action" VALUE="edit_category">
<INPUT TYPE="Hidden" NAME="id" VALUE="<%=categoryId%>">
<INPUT TYPE="Hidden" NAME="lang" VALUE="<%=lang%>">
<TABLE WIDTH="655" BORDER="0" CELLSPACING="0" CELLPADDING="0">
<TR>
	<TD COLSPAN="5" ALIGN="CENTER">
		<B>Темы вопросов-ответов</B><BR>
		<IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=20><BR>
	</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<B>Тема:</B>
</DIV>
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20"><INPUT TYPE="text" NAME="name" VALUE="<%=WebUtil.toHTML( fc.getName() )%>" STYLE="width:620" SIZE="34">
</TD>
</TR>
<TR>
<TD CLASS="c2" HEIGHT="20">
<DIV STYLE="padding-left:6px;padding-right:6px">
<INPUT TYPE="Checkbox" NAME="isPublished" VALUE="1" <%=fc.isPublished()==1? "CHECKED": ""%>> - публиковать
</DIV>
</TD>
</TR>
<TR>
<TD HEIGHT="20" ALIGN="center">
<INPUT TYPE="button" VALUE="Сохранить" ONCLICK="if(confirm('Сохранить изменения?')) { if (document.FORM3.name.value=='') {alert('Тема не может быть пустой!');}else{document.FORM3.submit();}}">
</TD>
</TR>
</TABLE>
</FORM>
			<%
		}catch(Exception e)
		{
			out.print("Произошла ошибка при чтении темы. Попробуйте еще раз.");
		}
	}
	else if  ( mode.equalsIgnoreCase("error") )
	{
		%>
		<B>Произошла ошибка. Попробуйте еще раз.</B><BR>
		<%
	}
	else if  ( mode.equalsIgnoreCase("isExist") )
	{
		%>
		<B>Тема с указанным именем уже существует.</B><BR>
		<%
	}
	else
	{
%>
<FORM NAME="FORM1" ACTION="xt_faq_category.jsp" METHOD="post">
<INPUT TYPE="Hidden" NAME="action" VALUE="del_categories">
<INPUT TYPE="Hidden" NAME="lang" VALUE="<%=lang%>">
<A HREF="index.jsp">назад</A><BR><BR>
<%
	showFAQCategories( out, lang );
%>
<BR><A HREF="javascript:if (confirm('Удалить тему?')) {this.FORM1.submit();}">удалить</A><BR>
</FORM>
<%
	}
%>
</BODY>
</HTML>
