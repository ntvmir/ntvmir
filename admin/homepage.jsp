<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="tengry.ntvmir.*"%>
<%
	// set the Service name for authorization
	String pageId = HomePage.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%
	HomePage hp = HomePage.getInstance(langCode);
	String message = "";

	Enumeration enum = CMSApplication.getApplication().getNodesByTypeCode(langCode, News.SERVICE_CODE);
%>
<%!
	private final String	separator	= File.separator;
	
	private void drawFolders(JspWriter out, File folder, String path, String url, String selected, String tab) throws IOException
	{
		boolean	isEmpty	= false;
		try
		{
			String sss = path + File.separator + folder.getName();
			
			File[]	files = folder.listFiles();
			
			out.println("<OPTION VALUE=\"" + sss + "\"" + (sss.equals(selected) ? " SELECTED" : "") +">");
			out.println(sss + "</OPTION>");
			for( int i=0; files != null && i < files.length ; i++ )
			{
				if ( files[i].isDirectory() )
					drawFolders(out, files[i], sss, url + File.separator + folder.getName(), selected, tab+tab);
			}
		}catch( Exception e )
		{}
	}
	
	String buildPath(WebTreeNode node)
	{
		if(node == null) return "";
		if(node.getParent() == null)
			return node.getName();
		return buildPath(node.getParent()) + "/" + node.getName();
	}
%>
<%
	String actionDone = request.getParameter("action_done");
	if("news".equals(actionDone))
		message = "Параметры новостей на главной странице установлены.";
	if("banner".equals(actionDone))
		message = "Баннеры главной странице установлены.";
	if("themes".equals(actionDone))
		message = "Статус тем форума изменен.";
	else if("img".equals(actionDone))
		message = "Банк фотографий для ротации установлен.";
	else if("announce".equals(actionDone))
		message = "Анонс сохранен.";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Главная страница"/>
<jsp:param name="header" value="Настройки главной страницы"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>

<SCRIPT LANGUAGE="javascript">
function submitNewsForm()
{
	if(confirm("Установить?"))
		document.forms['news_form'].submit();
}
function submitBannerForm()
{
	if(confirm("Установить?"))
		document.forms['banner_form'].submit();
}
function submitThemeForm(pub)
{
    document.theme_form.submode.value=pub;
	if(confirm("Изменить статус?"))
		document.theme_form.submit();
}
</SCRIPT>



<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM NAME="theme_form" ACTION="xt_homepage.jsp">
<INPUT TYPE="hidden" NAME="mode" VALUE="themes">
<INPUT TYPE="hidden" NAME="submode" VALUE="publ">
<TR>
<TD HEIGHT="20" CLASS="c2" COLSPAN="5" ALIGN="center">
<B>Горячие темы форума</B>
</TD>
</TR>
<TR>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2" VALIGN="middle"></TD>
<TD HEIGHT="20" WIDTH="100%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px">
    Заголовок темы</DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px">
    отв.</DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="c2"><DIV STYLE="padding-left:6px;padding-right:6px">
    <NOBR>посл. ответ</NOBR></DIV>
</TD>
</TR>

<%
    java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm");
    Enumeration themeEnum = ForumItem.getHotThemes(langCode, false).elements();
    while(themeEnum.hasMoreElements())
    {
        ForumItem forumTheme = (ForumItem)themeEnum.nextElement();
        String ss = null;
        if(forumTheme.getStatus() == ForumItem.HOT_THEME)
            ss = "c1";
        else
            ss = "c3";
%>
<TR>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=ss%>" VALIGN="middle">
    <INPUT TYPE="checkbox" NAME="theme_id" VALUE="<%=forumTheme.getId()%>">
</TD>
<TD HEIGHT="20" WIDTH="100%" CLASS="<%=ss%>"><DIV STYLE="padding-left:6px;padding-right:6px">
    <A><%=CMSApplication.toHTML(forumTheme.getHeader())%></A></DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=ss%>"><DIV STYLE="padding-left:6px;padding-right:6px">
    <NOBR><%=forumTheme.getAnswerAmount()%></NOBR></DIV>
</TD>
<TD HEIGHT="20" WIDTH="1%" CLASS="<%=ss%>"><DIV STYLE="padding-left:6px;padding-right:6px">
    <NOBR><%=forumTheme.getLastMessageDate() != null ? sdf.format(forumTheme.getLastMessageDate()) : ""%></NOBR></DIV>
</TD>
</TR>
<%  } %>
<TR>
<TD ALIGN="center" COLSPAN="4">
<A HREF="javascript: submitThemeForm('publ');">Разместить</A> |
<A HREF="javascript: submitThemeForm('unpubl');">Снять</A> |
<A HREF="javascript: submitThemeForm('unhot');">Убрать из "горячих"</A>
</TD>
</TR>
</FORM>
</TABLE>
<BR>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD ROWSPAN="2" WIDTH="10"><IMG SRC="/admin/img/blank.gif" WIDTH="10" HEIGHT="1"><BR></TD>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">тема размещена на главной странице;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">тема не размещена на главной странице;</TD>
</TR>
</TABLE>



<BR><BR>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM NAME="news_form" ACTION="xt_homepage.jsp">
<INPUT TYPE="hidden" NAME="mode" VALUE="news">
<TR>
<TD COLSPAN="2" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Новостная лента для главной страницы</B>
</TD>
</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		WebTreeNode node = (WebTreeNode)enum.nextElement();
		String style = node.isVisible() ? "c3" : "c1";
		String sPrivate = isPagePrivate(node.getId()) ? "<B STYLE=\"color: red;\">*</B>" : "";
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="radio" NAME="news_page_id" VALUE="<%=node.getId()%>"<%=node.getId().equals(hp.getNewsNodeId()) ? " CHECKED" : ""%>>
</TD>

<TD HEIGHT="20" CLASS="<%=style%>">
<DIV STYLE="padding-left:6px;padding-right:6px">
<%=sPrivate + buildPath(node)%>
</DIV></TD>
</TR>
<%	
		l++;
	} 
%>
<TR>
<TD COLSPAN="2" HEIGHT="20" CLASS="c3">
<INPUT TYPE="checkbox" NAME="news_show" SIZE="5" VALUE="1" ID="ccc0" <%=hp.isShowNews() ? " CHECKED" : ""%>> <LABEL FOR="ccc0">Показывать блок "Топ новость" на главной странице</LABEL><BR>
</TD>
</TR>
<TR>
<TD ALIGN="center" COLSPAN="2">
<INPUT TYPE="button" VALUE="Установить" onClick="submitNewsForm();">
</TD>
</TR>
</FORM>
</TABLE>
<BR>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<TR>
<TD ROWSPAN="3" WIDTH="10"><IMG SRC="/admin/img/blank.gif" WIDTH="10" HEIGHT="1"><BR></TD>
<TD WIDTH="15" ALIGN="center"><B STYLE="color: red;">*</B></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">просмотр ленты доступен только для зарегистрированных пользователей;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c3"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">лента опубликована в пользовательской части;</TD>
</TR>
<TR>
<TD WIDTH="15" CLASS="c1"><IMG SRC="/admin/img/blank.gif" WIDTH="15" HEIGHT="15"><BR></TD><TD ALIGN="center"> &#151; </TD>
<TD ALIGN="left">лента не опубликована в пользовательской части;</TD>
</TR>
</TABLE>


<BR><BR>

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM NAME="banner_form" ACTION="xt_homepage.jsp">
<INPUT TYPE="hidden" NAME="mode" VALUE="banner">
<TR>
<TD COLSPAN="2" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Первый баннер</B>
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<DIV STYLE="padding-left:6px;padding-right:6px">
<NOBR>Адрес баннера</NOBR>
</DIV>
</TD>
<TD WIDTH="1%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<INPUT TYPE="text" STYLE="width: 100%" NAME="banner_img" VALUE="<%=hp.getBannerImg(1)%>">
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<DIV STYLE="padding-left:6px;padding-right:6px">
<NOBR>Ссылка баннера</NOBR>
</DIV>
</TD>
<TD WIDTH="1%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<INPUT TYPE="text" STYLE="width: 100%" NAME="banner_url" VALUE="<%=hp.getBannerUrl(1)%>">
</TD>
</TR>

<TR>
<TD COLSPAN="2" HEIGHT="20" CLASS="c3">
<INPUT TYPE="checkbox" NAME="banner_show_1" SIZE="5" VALUE="1" ID="ccc1" <%=hp.isBannerShow(1) ? " CHECKED" : ""%>> <LABEL FOR="ccc1">Показывать первый баннер на главной странице</LABEL><BR>
</TD>
</TR>






<TR>
<TD COLSPAN="2" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Второй баннер</B>
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<DIV STYLE="padding-left:6px;padding-right:6px">
<NOBR>Адрес баннера</NOBR>
</DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<INPUT TYPE="text" STYLE="width: 100%" NAME="banner_img" VALUE="<%=hp.getBannerImg(2)%>">
</TD>
</TR>

<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<DIV STYLE="padding-left:6px;padding-right:6px">
<NOBR>Ссылка баннера</NOBR>
</DIV>
</TD>
<TD WIDTH="100%" HEIGHT="20" CLASS="c3" VALIGN="middle">
<INPUT TYPE="text" STYLE="width: 100%" NAME="banner_url" VALUE="<%=hp.getBannerUrl(2)%>">
</TD>
</TR>

<TR>
<TD COLSPAN="2" HEIGHT="20" CLASS="c3">
<INPUT TYPE="checkbox" NAME="banner_show_2" SIZE="5" VALUE="1" ID="ccc2" <%=hp.isBannerShow(2) ? " CHECKED" : ""%>> <LABEL FOR="ccc2">Показывать второй баннер на главной странице</LABEL><BR>
</TD>
</TR>


<TR>
<TD ALIGN="center" COLSPAN="2">
<INPUT TYPE="button" VALUE="Установить" onClick="submitBannerForm();">
</TD>
</TR>
</FORM>
</TABLE>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
