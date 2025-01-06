<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.dict.*"%>
<%@ page import="tengry.northgas.*"%>

<%!	String [][] pageTexts = new String [][] {

/*  0 */ {	"Выберите первую букву термина:",
			"Select the word's first letter" },

/*  1 */ {	"Поиск по словарю",
			"Search through the dictionary" },

/*  2 */ {	"и",
			"and" },

/*  3 */ {	"или",
			"or" },

/*  4 */ {	"фраза целиком",
			"entire phrase" },

/*  5 */ {	"Добавить термин",
			"Add your article" },

/*  6 */ {	"Поля отмеченные",
			"Fields marked with" },

/*  7 */ {	"являются обязательными для заполнения",
			"are mandatory" },

/*  8 */ {	"Термин",
			"Term" },

/*  9 */ {	"Комментарий",
			"Your comments" },

/* 10 */ {	"Имя",
			"Name" },

/* 11 */ {	"E-mail",
			"E-mail" },

/* 12 */ {	"Поле Термин должно быть заполнено",
			"The Term field are mandatory" },

/* 13 */ {	"Поле Комментарий должно быть заполнено",
			"The Your comments field are mandatory" },

/* 14 */ {	"Поле Имя должно быть заполнено",
			"The Name field are mandatory" },

/* 15 */ {	"Поле E-mail должно быть заполнено",
			"The E-mil field are mandatory" },

/* 16 */ {	"Ваш термин был добавлен и будет рассматриваться.",
			"The term you've added has been queued for consideration." },

/* 17 */ {	"Произошла ошибка при добавлении термина.",
			"Error on adding the term." }
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
public static final String ABC_R = "АБВГДЕЖЗИКЛМНОПРСТУФХЦЧШЩЭЮЯ";
public static final String ABC_E = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

public void printABC(int letter, String url, char lang, JspWriter out) throws IOException
{
	int dl = 0;
	if(lang == CMSApplication.LANG_RUS)
	{
		dl = ABC_R.length();
		for(int i = 0; i < ABC_R.length(); i++)
		{
			out.print((i==0 ? "" : "|") + 
				"<A " + 
				(letter == i ? "STYLE=\"color:#D0E4F4;\"" : "HREF=\"" + url + "&letter=" + i + "\"") +
				"><B>" + 
				ABC_R.charAt(i) + "</B></A>");
		}
		out.println("<BR>");
	}
	for(int i = 0; i < ABC_E.length(); i++)
	{
		out.print((i==0 ? "" : "|") + 
			"<A " + 
			(letter-dl == i ? "STYLE=\"color:#D0E4F4;\"" : "HREF=\"" + url + "&letter=" + (i + dl) + "\"") +
			"><B>" + 
			ABC_E.charAt(i) + "</B></A>");
	}
	
}
%>

<%!
public static final char E = CMSApplication.LANG_ENG;
public static final char R = CMSApplication.LANG_RUS;
%>
<%
	response.setHeader("Pragma","no-cache");
	char lang = R;
	if(("" + E).equals(request .getParameter("lang")))
		lang = E;

	String des = CMSApplication.getApplication().getCurrentDesignPath();
	des += (lang == E ? "/eng": "/rus");

	String nodeId = request.getParameter("id");
	
	String searchQuery = request.getParameter("search_query");
	String searchMode = request.getParameter("search_mode");
	if(!"or".equals(searchMode) && !"full".equals(searchMode))
		searchMode = "and";

	int searchType = Search.SEARCH_AND;
	if("or".equals(searchMode))
		searchType = Search.SEARCH_OR;
	else if("full".equals(searchMode))
		searchType = Search.SEARCH_FULL;
	if(searchQuery == null || searchQuery.trim().length() == 0)
		searchQuery = null;
	
	int letter = -1;
	try{ letter = Integer.parseInt(request.getParameter("letter")); }catch(Exception e){}
	if((letter < 0 || (lang == E && letter >= ABC_E.length() || lang == R && letter >= ABC_R.length() + ABC_E.length())) && searchQuery == null)
	{
%>
<!---- CONTENT ----->

<STYLE>
.alf {font-size:10px;}
.alf A {text-decoration:none;}
</STYLE>

<%=text(lang, 0)%><BR>
<DIV STYLE="letter-spacing:2px;margin:5 0 0 0;" CLASS="alf">
<%printABC( -1, "/page.jsp?id=" + nodeId + "&lang=" + lang, lang,  out );%>
</DIV>
		
<TABLE  BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="480" STYLE="margin-top:12;">
<TR VALIGN="top">
<FORM NAME="dict_search" ACTION="/page.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=nodeId%>">
<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
<TD WIDTH="250">
<DIV CLASS="ttl"><%=text(lang, 1)%></DIV>
<INPUT TYPE="Text" NAME="search_query" SIZE="23" STYLE="font-family:sans-serif;width:225;margin:7 0 3 6;" VALUE="">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" BACKGROUND="">
<TR VALIGN="bottom">
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="and" STYLE="height:12;background:#FFFFFF;" CHECKED></TD><TD CLASS="sm" WIDTH="15"> <%=text(lang, 2)%></TD>
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="or" STYLE="height:12;background:#FFFFFF;"></TD><TD CLASS="sm" WIDTH="25"> <%=text(lang, 3)%></TD>
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="full" STYLE="height:12;background:#FFFFFF;"></TD><TD CLASS="sm"> <%=text(lang, 4)%></TD>
<TD><INPUT TYPE="image" SRC="<%=des%>/btnz/ok.gif" WIDTH="33" HEIGHT="16" ALT="" BORDER="0" STYLE="margin:0 0 0 10;"></TD>
</FORM></TR>
</TABLE>

</TD>
<TD STYLE="padding:0 0 0 15"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD BGCOLOR="#DDE6F0" WIDTH="1"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD STYLE="padding:0 0 0 15"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD WIDTH="199">
<DIV CLASS="ttl"><%=text(lang, 5)%></DIV>
<%
	String okStr = request.getParameter("ok");
	if("1".equals(okStr))
	{
%><BR>
<SPAN STYLE="font-size:12px;Font-family:verdana;color:#FF0000;"><%=text(lang, 16)%></SPAN><BR><BR>
<%
	}
	else if("0".equals(okStr))
	{
%><BR>
<SPAN STYLE="font-size:12px;Font-family:verdana;color:#FF0000;"><%=text(lang, 17)%></SPAN><BR><BR>
<%
	}
%>
<DIV STYLE="margin:10 0 0 0;" CLASS="sm">
<SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF0000;"><B>!</B></SPAN>
<%=text(lang, 6)%> 
<SPAN  STYLE="font-size:10px;Font-family:verdana;color:#FF5400;">*</SPAN>
<%=text(lang, 7)%>
</DIV>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">
function submitRequest()
{
	var frm = document.request_form;
	if(trim(frm.f_term.value)=='')
	{
		alert('<%=text(lang, 12)%>');
		frm.f_term.focus();
		return;
	}
	if(trim(frm.f_descr.value)=='')
	{
		alert('<%=text(lang, 13)%>');
		frm.f_descr.focus();
		return;
	}
	if(trim(frm.f_name.value)=='')
	{
		alert('<%=text(lang, 14)%>');
		frm.f_name.focus();
		return;
	}
	if(trim(frm.f_email.value)=='')
	{
		alert('<%=text(lang, 15)%>');
		frm.f_email.focus();
		return;
	}
	frm.submit();
}
</SCRIPT>

<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="10"><BR>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
	<TR>
	<FORM ACTION="/dict/xt_request.jsp" METHOD="post" NAME="request_form">
	<INPUT TYPE="hidden" NAME="id" VALUE="<%=nodeId%>">
	<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
		<TD CLASS="sm">
		<SPAN><%=text(lang, 8)%></SPAN><SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
		<BR><IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="3" BORDER="0"><BR>
		<DIV><INPUT TYPE="Text" NAME="f_term" SIZE="18" STYLE="font-family:sans-serif;width:190;"></DIV>
		<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="7" BORDER="0"><BR>
		</TD>
	</TR>
	<TR>
		<TD CLASS="sm" VALIGN="TOP">
		<SPAN><%=text(lang, 9)%></SPAN><SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
		<BR><IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="3" BORDER="0"><BR>
		<DIV><TEXTAREA NAME="f_descr" COLS="16" ROWS="5" WRAP="ON" STYLE="font-family:sans-serif;width:190;"></TEXTAREA></DIV>
		<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="7" BORDER="0"><BR>
		</TD>
	</TR>	
	<TR>
		<TD CLASS="sm">
		<SPAN><%=text(lang, 10)%></SPAN><SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
		<BR><IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="3" BORDER="0"><BR>
		<DIV><INPUT TYPE="Text" NAME="f_name" SIZE="18" STYLE="font-family:sans-serif;width:190;"></DIV>
		<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="7" BORDER="0"><BR>
		</TD>
	</TR>
	<TR>
		<TD CLASS="sm">
		<SPAN><%=text(lang, 11)%></SPAN><SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
		<BR><IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="3" BORDER="0"><BR>
		<INPUT TYPE="Text" NAME="f_email" SIZE="18" STYLE="font-family:sans-serif;width:190;margin:3 0 0 0;">
		</TD>
	</TR>
	<TR>
	<TD ALIGN="right">
	<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="5" BORDER="0"><BR>
	<A HREF="javascript:submitRequest();"><IMG SRC="<%=des%>/btnz/ok.gif" WIDTH="33" HEIGHT="16" ALT="" BORDER="0"></A>
	</TD>
	</FORM></TR>
</TABLE>

</TD>
</TR>			
</TABLE>	
<!----//CONTENT ----->
<%	}























	else
	{
		char CCC = ' ';
		Enumeration terms;
		if(searchQuery != null)
		{
			Search search = new Search(lang, searchQuery, searchType);
			terms = search.dictionarySearch().elements();
		}
		else
		{
			if(lang == E)
				CCC = ABC_E.charAt(letter);
			else
			{
				if(letter < ABC_R.length())
					CCC = ABC_R.charAt(letter);
				else
					CCC = ABC_E.charAt(letter - ABC_R.length());
			}
			terms = Term.getFrontTerms("" + CCC, lang);
			
		}
		
		boolean msie = false;
		if( request.getHeader( "User-Agent" ) != null && 
		request.getHeader( "User-Agent" ).indexOf( "MSIE" ) != -1 )
		{
			msie = true;
		}
%>

<!---- CONTENT ----->

<STYLE>
.alf {font-size:10px;}
.alf A {text-decoration:none;}
</STYLE>

<%=text(lang, 0)%><BR>
<DIV STYLE="letter-spacing:2px;margin:5 0 0 0;" CLASS="alf">
<% printABC(letter, "/page.jsp?id=" + nodeId + "&lang=" + lang, lang, out);%>
</DIV>
		
<TABLE  BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="480" STYLE="margin-top:12;">
<TR VALIGN="top">
<TD WIDTH="250">


<%	if(searchQuery == null){ %>
<DIV STYLE="font-size:22px;margin:0 0 10 0;"><A><%=CCC%></A></DIV>
<%	} %>

<SCRIPT>
nn = (document.layers)? true : false;
ie = (document.all)? true : false;

var visible = new Array()

function showLeer(which) {
	if (ie) document.all[which].style.display = "";
}

function hideLeer(which) {
	if (ie) document.all[which].style.display = "none";
}

function toggle(objid)
{
	for( i in visible )	
	{
		if( visible[i] == objid )
		{
			hideLeer( objid );
			delete visible[i];
			return;
		}
	}
	
	visible[visible.length] = objid;
	showLeer( objid );
}

</SCRIPT>




<%
	int l = 0;
	while(terms.hasMoreElements())
	{
		l++;
		Term term = (Term)terms.nextElement();
%>
<DIV STYLE="margin-top:5;">
<A HREF="javascript:toggle('term_<%=l%>' );" CLASS="sm"><B><%=lang == E ? term.getTermEng() : term.getTermRus()%></B></A>
</DIV>


<DIV ID="term_<%=l%>" <%= msie ? "STYLE=\"position:relative; display: none;padding-left:10;margin-top:5;\"" : ""%> CLASS="sm">	
<%=CMSApplication.toHTML(lang == E ? term.getDescrEng() : term.getDescrRus())%>
</DIV>

<%	} %>

</TD>
<TD STYLE="padding:0 0 0 15"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD BGCOLOR="#DDE6F0" WIDTH="1"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD STYLE="padding:0 0 0 15"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD>
<TD WIDTH="199">
<FORM NAME="dict_search" ACTION="/page.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=nodeId%>">
<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
<DIV CLASS="ttl"><%=text(lang, 1)%></DIV>
<INPUT TYPE="Text" NAME="search_query" SIZE="18" STYLE="font-family:sans-serif;width:190;margin:7 0 3 0;" VALUE="<%=searchQuery != null ? searchQuery : ""%>">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" STYLE="margin:0 0 0 -6;" WIDTH="196">
<TR VALIGN="bottom">
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="and" STYLE="height:12;background:#FFFFFF;"<%="and".equals(searchMode) ? " CHECKED" : ""%>></TD><TD CLASS="sm" WIDTH="15"> <%=text(lang, 2)%></TD>
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="or" STYLE="height:12;background:#FFFFFF;"<%="or".equals(searchMode) ? " CHECKED" : ""%>></TD><TD CLASS="sm" WIDTH="25"> <%=text(lang, 3)%></TD>
<TD><INPUT TYPE="Radio" NAME="search_mode" VALUE="full" STYLE="height:12;background:#FFFFFF;"<%="full".equals(searchMode) ? " CHECKED" : ""%>></TD><TD CLASS="sm"> <%=text(lang, 4)%></TD>
</TR>
<TR>
<TD COLSPAN="6" ALIGN="right"><INPUT TYPE="image" SRC="<%=des%>/btnz/ok.gif" WIDTH="33" HEIGHT="16" ALT="" BORDER="0" STYLE="margin:3 0 0 8;"></TD>
</FORM></TR>
</TABLE>



<DIV CLASS="ttl" STYLE="margin:10 0 0 0;"><%=text(lang, 5)%></DIV>

<DIV STYLE="margin:10 0 0 0;" CLASS="sm">
<SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF0000;"><B>!</B></SPAN>
<%=text(lang, 6)%> 
<SPAN  STYLE="font-size:10px;Font-family:verdana;color:#FF5400;">*</SPAN>
<%=text(lang, 7)%>
</DIV>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="/admin/inc/functions.js" TYPE='text/javascript'></SCRIPT>
<SCRIPT LANGUAGE="javascript">
function submitRequest()
{
	var frm = document.request_form;
	if(trim(frm.f_term.value)=='')
	{
		alert('<%=text(lang, 12)%>');
		frm.f_term.focus();
		return;
	}
	if(trim(frm.f_descr.value)=='')
	{
		alert('<%=text(lang, 13)%>');
		frm.f_descr.focus();
		return;
	}
	if(trim(frm.f_name.value)=='')
	{
		alert('<%=text(lang, 14)%>');
		frm.f_name.focus();
		return;
	}
	if(trim(frm.f_email.value)=='')
	{
		alert('<%=text(lang, 15)%>');
		frm.f_email.focus();
		return;
	}
	frm.submit();
}
</SCRIPT>


<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="10"><BR>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
	<TR>
	<FORM ACTION="/dict/xt_request.jsp" METHOD="post" NAME="request_form">
	<INPUT TYPE="hidden" NAME="id" VALUE="<%=nodeId%>">
	<INPUT TYPE="hidden" NAME="lang" VALUE="<%=lang%>">
	<INPUT TYPE="hidden" NAME="letter" VALUE="<%=letter%>">
		<TD CLASS="sm">
		<SPAN><%=text(lang, 8)%></SPAN><SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
		<BR><IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="3" BORDER="0"><BR>
		<DIV><INPUT TYPE="Text" NAME="f_term" SIZE="18" STYLE="font-family:sans-serif;width:190;"></DIV>
		<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="7" BORDER="0"><BR>
		</TD>
	</TR>
	<TR>
		<TD CLASS="sm" VALIGN="TOP">
		<SPAN><%=text(lang, 9)%></SPAN><SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
		<BR><IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="3" BORDER="0"><BR>
		<DIV><TEXTAREA NAME="f_descr" COLS="16" ROWS="5" WRAP="ON" STYLE="font-family:sans-serif;width:190;"></TEXTAREA></DIV>
		<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="7" BORDER="0"><BR>
		</TD>
	</TR>	
	<TR>
		<TD CLASS="sm">
		<SPAN><%=text(lang, 10)%></SPAN><SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
		<BR><IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="3" BORDER="0"><BR>
		<DIV><INPUT TYPE="Text" NAME="f_name" SIZE="18" STYLE="font-family:sans-serif;width:190;"></DIV>
		<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="7" BORDER="0"><BR>
		</TD>
	</TR>
	<TR>
		<TD CLASS="sm">
		<SPAN><%=text(lang, 11)%></SPAN><SPAN STYLE="font-size:11px;Font-family:verdana;color:#FF5400;">*</SPAN>
		<BR><IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="3" BORDER="0"><BR>
		<INPUT TYPE="Text" NAME="f_email" SIZE="18" STYLE="font-family:sans-serif;width:190;margin:3 0 0 0;">
		</TD>
	</TR>
	<TR>
	<TD ALIGN="right">
	<IMG SRC="/img/rus/blank.gif" WIDTH="1" HEIGHT="5" BORDER="0"><BR>
	<A HREF="javascript:submitRequest();"><IMG SRC="<%=des%>/btnz/ok.gif" WIDTH="33" HEIGHT="16" ALT="" BORDER="0"></A>
	</TD>
	</FORM></TR>
</TABLE>


</TD>
</TR>			
</TABLE>	
<!----//CONTENT ----->


<%	} %>