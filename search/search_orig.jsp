<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.press.*"%>
<%@ page import="tengry.northgas.*"%>
<%!	String [][] pageTexts = new String [][] {

/*  0 */ {	"Поиск по сайту",
			"Site Search" },

/*  1 */ {	"Отметьте разделы, в которых будет осуществляться поиск:",
			"Select sections to be searched:" },

/*  2 */ {	"и",
			"and" },

/*  3 */ {	"или",
			"or" },

/*  4 */ {	"фраза целиком",
			"entire phrase" },

/*  5 */ {	"О компании",
			"About company" },

/*  6 */ {	"Инвесторам",
			"For investors" },

/*  7 */ {	"Новости",
			"News" },

/*  8 */ {	"Поставщикам",
			"For suppliers" },

/*  9 */ {	"Продукция",
			"Products" },

/* 10 */ {	"Партнеры",
			"Partners" },

/* 11 */ {	"Проекты",
			"Projects" },

/* 12 */ {	"Поиск по словарю",
			"Dictionary search" },

/* 13 */ {	"Фраза для поиска:",
			"Search phrase:" },

/* 14 */ {	"Всего найдено:",
			"Total found:" },

/* 15 */ {	"показано с",
			"displayed" },

/* 16 */ {	"Раздел:",
			"Section:" },

/* 17 */ {	"по",
			"through" },

/* 18 */ {	"поиск",
			"search" },

/* 19 */ {	"Ничего не найдено.",
			"No search results." }
	};
	
	public String text(char lang, int p)
	{
		return text(p, lang);
	}
	public String text(int p, char lang)
	{
		if(lang == CMSApplication.LANG_ENG)
			return pageTexts[p][1];
		else
			return pageTexts[p][0];
	}
%>

<%!
public static final char E = CMSApplication.LANG_ENG;
public static final char R = CMSApplication.LANG_RUS;
%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
char lang = R;
if(("" + E).equals(request .getParameter("lang")))
	lang = E;

String des = CMSApplication.getApplication().getCurrentDesignPath();
des += (lang == E ? "/eng": "/rus");


String pageId = request.getParameter("id");
if("".equals(pageId))
	pageId = null;


String f1 = (request.getParameter("f_1") != null ? "&f_1=1" : null);
String f2 = (request.getParameter("f_2") != null ? "&f_2=1" : null);
String f3 = (request.getParameter("f_3") != null ? "&f_3=1" : null);
String f4 = (request.getParameter("f_4") != null ? "&f_4=1" : null);
String f5 = (request.getParameter("f_5") != null ? "&f_5=1" : null);
String f6 = (request.getParameter("f_6") != null ? "&f_6=1" : null);
String f7 = (request.getParameter("f_7") != null ? "&f_7=1" : null);

boolean isSearch = "1".equals(request.getParameter("search"));
String query = request.getParameter("f_query");
if(query == null)
	query = "";
query = query.trim();
if(query.length() == 0)
	isSearch = false;
	
String mode = request.getParameter("f_mode");
if( ! ("and".equals(mode) || "or".equals(mode) || "full".equals(mode)))
	mode = "and";

if(!isSearch)
{
if( f1 == null &&
	f2 == null &&
	f3 == null &&
	f4 == null &&
	f5 == null &&
	f6 == null &&
	f7 == null )
		f1 = f2 = f3 = f4 = f5 = f6 = f7 = "some not null string";
%>
<!---- CONTENT ----->
		
<TABLE  BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="480">
<TR VALIGN="top">
<FORM NAME="search_form" ACTION="/page.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=pageId%>">
<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
<INPUT TYPE="hidden" NAME="search" VALUE="1">

<TD WIDTH="250">
<DIV CLASS="ttl"><%=text(lang, 0)%></DIV>
<INPUT TYPE="Text" NAME="f_query" SIZE="23" STYLE="width:225;margin:7 0 0 6;" VALUE="<%=CMSApplication.toHTML(query)%>">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" BACKGROUND="" STYLE="margin-top:3;">
<TR VALIGN="bottom">
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="and" STYLE="height:12;background:#FFFFFF;"<%="and".equals(mode) ? " CHECKED" : ""%>></TD><TD CLASS="sm" WIDTH="15"> <%=text(lang, 2)%></TD>
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="or" STYLE="height:12;background:#FFFFFF;"<%="or".equals(mode) ? " CHECKED" : ""%>></TD><TD CLASS="sm" WIDTH="25"> <%=text(lang, 3)%></TD>
<TD><INPUT TYPE="Radio" NAME="f_mode" VALUE="full" STYLE="height:12;background:#FFFFFF;"<%="full".equals(mode) ? " CHECKED" : ""%>></TD><TD CLASS="sm"> <%=text(lang, 4)%></TD>
<TD><INPUT TYPE="image" SRC="<%=des%>/btnz/ok.gif" WIDTH="33" HEIGHT="16" ALT="" BORDER="0" STYLE="margin:0 0 0 10;" id=image1 name=image1></TD>
</TR>
</TABLE>

<DIV STYLE="margin:7 0 7 0;" CLASS="sm"><%=text(lang, 1)%></DIV>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" STYLE="margin:0 0 0 6">
<TR>
<TD><%=text(lang, 5)%></TD>
<TD ALIGN="right" WIDTH="30"><INPUT TYPE="Checkbox" NAME="f_1"<%= f1 != null ? " CHECKED":""%>></TD><TD WIDTH="25"></TD>
<TD><%=text(lang, 6)%></TD>
<TD ALIGN="right"><INPUT TYPE="Checkbox" NAME="f_2"<%= f2 != null ? " CHECKED":""%>></TD>
</TR>

<TR>
<TD><%=text(lang, 7)%></TD>
<TD ALIGN="right"><INPUT TYPE="Checkbox" NAME="f_3"<%= f3 != null ? " CHECKED":""%>></TD><TD></TD>
<TD><%=text(lang, 8)%></TD>
<TD ALIGN="right"><INPUT TYPE="Checkbox" NAME="f_4"<%= f4 != null ? " CHECKED":""%>></TD>
</TR>

<TR>
<TD><%=text(lang, 9)%></TD>
<TD ALIGN="right"><INPUT TYPE="Checkbox" NAME="f_5"<%= f5 != null ? " CHECKED":""%>></TD><TD></TD>
<TD><%=text(lang, 10)%></TD>
<TD ALIGN="right"><INPUT TYPE="Checkbox" NAME="f_6"<%= f6 != null ? " CHECKED":""%>></TD>
</TR>

<TR>
<TD><%=text(lang, 11)%></TD>
<TD ALIGN="right"><INPUT TYPE="Checkbox" NAME="f_7"<%= f7 != null ? " CHECKED":""%>></TD><TD></TD>
<TD></TD>
<TD ALIGN="right"></TD>
</FORM></TR>
</TABLE>



</TD>
<TD STYLE="padding:0 0 0 15"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD BGCOLOR="#DDE6F0" WIDTH="1"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD STYLE="padding:0 0 0 15"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD WIDTH="199">
<FORM NAME="dict_search" ACTION="/page.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="section" VALUE="<%=SectionCode.DICT%>">
<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">

<DIV CLASS="ttl"><%=text(lang, 12)%></DIV>
<INPUT TYPE="Text" NAME="search_query" SIZE="18" STYLE="width:190;margin:7 0 0 0;" VALUE="">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" STYLE="margin:0 0 3 -6;" WIDTH="196">
<TR VALIGN="bottom">
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="and" STYLE="height:12;background:#FFFFFF;" CHECKED></TD><TD CLASS="sm" WIDTH="15"> <%=text(lang, 2)%></TD>
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="or" STYLE="height:12;background:#FFFFFF;"></TD><TD CLASS="sm" WIDTH="25"> <%=text(lang, 3)%></TD>
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="full" STYLE="height:12;background:#FFFFFF;"></TD><TD CLASS="sm"> <%=text(lang, 4)%></TD>
</TR>
<TR>
<TD COLSPAN="6" ALIGN="right"><INPUT TYPE="image" SRC="<%=des%>/btnz/ok.gif" WIDTH="33" HEIGHT="16" ALT="" BORDER="0" STYLE="margin:3 0 0 8;" id=image2 name=image2></TD>
</FORM></TR>
</TABLE>



</TD>
</TR>			
</TABLE>	
<!----//CONTENT ----->

<%

//////////////////////////////////////////////////////////////////////////////////////
}
else
{
//////////////////////////////////////////////////////////////////////////////////////


	

	int searchMode = Search.SEARCH_AND;
	if("or".equals(mode))
		searchMode = Search.SEARCH_OR;
	else if("full".equals(mode))
		searchMode = Search.SEARCH_FULL;
	
	int pageSize = 10;
	int pageNumber = 1;
	try{ pageNumber = Integer.parseInt(request.getParameter("f_page_number")); }catch(Exception e){}

	Search search = new Search(lang, query, searchMode, pageNumber, pageSize);
	
	
	String sLang = (lang == R ? "r" : "e");
	String siteSections = "";
	
	if(f1 != null) siteSections += "&sub=" + SectionCode.COMPANY + "_" + sLang;
	if(f2 != null) siteSections += "&sub=" + SectionCode.INVESTOR + "_" + sLang;
	
	if(f3 != null) siteSections += "&sub=" + SectionCode.NEWS + "_" + sLang;
	if(f4 != null) siteSections += "&sub=" + SectionCode.SUPPLIER + "_" + sLang;
	
	if(f5 != null) siteSections += "&sub=" + SectionCode.PRODUCT + "_" + sLang;
	if(f6 != null) siteSections += "&sub=" + SectionCode.PARTNER + "_" + sLang;

	if(f7 != null) siteSections += "&sub=" + SectionCode.PROJECT + "_" + sLang;

	String hndlQuery = request.getParameter("query_num");
	String pageNum = request.getParameter("f_page_number");
	
	URL url = new URL(new URL(request.getRequestURL().toString()),
		"/cgi-bin/yandsearch?lang=" + lang +
		(hndlQuery != null && hndlQuery.length() > 0? "&HndlQuery=" + hndlQuery : "") +
		(pageNum != null && pageNum.length() > 0? "&PageNum=" + pageNum : "") +
		"&id=" + pageId +
		"&f_mode=" + mode +
		"&des=" + des + 
		"&where=0&text=" + CMSApplication.URLEncode(query) +
		"&query=" + CMSApplication.URLEncode(query) + siteSections);
	BufferedReader ios = new BufferedReader(new InputStreamReader(url.openStream(), "Cp1251"));
	String ss = null;
	while((ss = ios.readLine()) != null)
	{
		out.println(ss);
	}
%>
<% } %>
