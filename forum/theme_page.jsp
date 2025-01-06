<%
    Forum forum = new Forum();
    ForumGroup group = new ForumGroup();
    ForumItem  theme = new ForumItem();
    theme.load(themeId);
    forum.load(forumId);
    if(forum != null)
        group.load(forum.getForumGroupId());
        
    boolean isModerator = (user != null && forum != null && forum.isModerator(user.getId()) && !user.isDisabled());
    boolean visibleOnly = !isModerator;

    if(forum != null && group != null && theme != null &&
        forum.isVisible() && group.isVisible() && (theme.getPublicDate() != null || isModerator))
    {
        try
        {
            ForumItem.increaseViewCount(themeId);
        }
        catch(Exception e){}
        
        
        int pageNumber = 1;
        int pageSize = 10;
        try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}

        Date startDate = null;
        String  showPeriod = request.getParameter("period");
        String order = request.getParameter("order");
        
        if(!"desc".equals(order))
            order = "asc";
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        
        if("1".equals(showPeriod))
            cal.add(Calendar.DATE, -1);
        else if("2".equals(showPeriod))
            cal.add(Calendar.DATE, -7);
        else if("3".equals(showPeriod))
            cal.add(Calendar.MONTH, -1);
        else if("4".equals(showPeriod))
            cal.add(Calendar.MONTH, -6);
        else if("5".equals(showPeriod))
            cal.add(Calendar.MONTH, -12);
        else {
            cal = null;
            showPeriod = "0";
        }

        if(cal != null)
            startDate = cal.getTime();


        String href = "/pages/" + langCode + "/forum/?forum_id=" + forumId + "&theme_id=" + themeId + "&period=" + showPeriod;
        int num = ForumItem.getAnswerNum(themeId, startDate, visibleOnly);
        Enumeration enum = ForumItem.getAnswers(themeId, startDate, "desc".equals(order), pageNumber, pageSize, visibleOnly).elements();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm");
%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign="top" class="XsmallFont">
<div style="margin-top:8px">
<%  
        for(int i = 0; i < pagePath.size(); i++)
        {
            WebTreeNode treeNode = (WebTreeNode)pagePath.elementAt(i);
%>  
<a href="<%=nodePath(treeNode)%>"><%=CMSApplication.toHTML(treeNode.getName())%></a> /
<%
        }
%>
<a href="<%=nodePath(pageId)%>?forum_id=<%=forum.getId()%>"><%=CMSApplication.toHTML(forum.getName())%></a> /
<%=CMSApplication.toHTML(theme.getHeader())%>
</div>
</td>
<!--заголовок страницы--><td align="right"><img src="<%=des%>/<%=sectionImg%>/ttl.gif" height="47" alt="<%=sectionName%>" border="0"></td>
</tr>
</table>




<%---- заголовочек -----%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=des%>/blu-ttl-bg.gif" bgcolor="#004896">
	<tr>
		<td nowrap><img src="<%=des%>/blu-ttl-lft.gif" width="16" height="19" border="0"><img src="<%=des%>/2lev/ttl-thms.gif" width="131" height="19" alt="Темы для обсуждения" border="0"></td>
		<td align="right"><img src="<%=des%>/blu-ttl-rght.gif" width="16" height="19" border="0"></td>
	</tr>
	</table>
<%----//заголовочек -----%>

<%---- пораздел -----%>

<div style="margin:8px 0px 0px 0px;font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;"><b class="bluTtl"><%=CMSApplication.toHTML(theme.getHeader())%></b></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<td height="22" valign="top">
<SPAN class="smallFont"><img src="<%=des%>/ans-all.gif" width="18" height="8" border="0" align="absmiddle"><SPAN class="c66">Сообщений:</SPAN> <%=num%></SPAN></td>
<td valign="bottom" align="right" class="smallFont"><SPAN class="c66"><%printPagebar(pageNumber, pageSize, num, href, out);%></SPAN></td>
</tr>
</table>
<%----//пораздел -----%>

<%---- Фильтр -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:8px 0px 0px 0px;">
<tr><form action="/pages/<%=langCode%>/forum">
<input type="hidden" name="forum_id" value="<%=forumId%>">
<input type="hidden" name="theme_id" value="<%=themeId%>">
<%  if(user != null && !user.isDisabled() && theme.getStatus() != ForumItem.CLOSED_THEME){ %>
<td><a href="/pages/<%=langCode%>/forum?forum_id=<%=forumId%>&theme_id=<%=themeId%>&create=1"><img src="<%=des%>/forum/btn-add-msg.gif" height="18" alt="Добавить сообщение" border="0"></a></td>
<%  } %>
<td align="right"><NOBR><SPAN class="smallFont"><b class="c66">Показать:</b></SPAN>
<SPAN class="SELnn"><SELECT NAME="period">
<OPTION value=0<%="0".equals(showPeriod) ? " SELECTED":""%>>все темы</OPTION>
<OPTION value=1<%="1".equals(showPeriod) ? " SELECTED":""%>>за последний день</OPTION>
<OPTION value=2<%="2".equals(showPeriod) ? " SELECTED":""%>>за последние 7 дней</OPTION>
<OPTION value=3<%="3".equals(showPeriod) ? " SELECTED":""%>>за последний месяц</OPTION>
<OPTION value=4<%="4".equals(showPeriod) ? " SELECTED":""%>>за последние 6 месяцев</OPTION>
<OPTION value=5<%="5".equals(showPeriod) ? " SELECTED":""%>>за последний год</OPTION></SELECT>
<SELECT name=order>
<OPTION value=asc<%="asc".equals(order) ? " SELECTED":""%>>начиная со старых</OPTION>
<OPTION value=desc<%="desc".equals(order) ? " SELECTED":""%>>начиная с новых</OPTION>
</SELECT></SPAN><input type="Image"src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" align="absmiddle"></NOBR></td>
</form></tr>
</table>
<%----//Фильтр -----%>

<table width="100%" border="0" cellpadding="1" cellspacing="0" style="margin:8px 0px 0px 0px;">

<%---- заголовок раздела -----%>
<tr bgcolor="#DDF3E1">
	<td><div style="width:3"><SPACER TYPE="block" HEIGHT="1" WIDTH="3"></div></td>
	<td width="13%" class="defFont" height="19"><b class="grnTtl">Автор</b></td>
	<td><div style="width:10"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td width="87%" class="defFont" colspan="2"><b class="grnTtl">Сообщение</b></td>
</tr>
<%----//заголовок раздела -----%>

<!--отступ--><tr><td height="10" colspan="5"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%
    int i = 0;
    while(enum.hasMoreElements())
    {
        i++;
        ForumItem answer = (ForumItem)enum.nextElement();
        String bgcolor = "";
        if(answer.getId().equals(themeId))
            bgcolor = " bgcolor=\"#DDF3E1\"";
        else if(i%2 == 1)
            bgcolor = " bgcolor=\"#F1F1F1\"";
        String text = (new ForumText(CMSApplication.toHTML(answer.getText()))).getText();
%>
<%---- 1 -----%>
<tr valign="top"<%=bgcolor%>>
	<td rowspan="3"><div style="width:3"><SPACER TYPE="block" HEIGHT="1" WIDTH="3"></div></td>
	<td class="defFont">
	<a href="/pages/<%=langCode%>/forum/profile?login=<%=CMSApplication.toHTML(answer.getUserLogin())%>"><b class="bluTtl"><%=CMSApplication.toHTML(answer.getUserLogin())%></b></a>
	</td>
	<td rowspan="3"><div style="width:10"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td class="defFont"><b class="bluTtl"><%=CMSApplication.toHTML(answer.getHeader())%></b></td>
	<td class="smallFont" align="right" nowrap><img src="<%=des%>/ans-lst.gif" width="8" height="7" border="0" hspace="1" align="baseline">&nbsp;<SPAN class="c66">Добавлено:</SPAN> <%=sdf.format(answer.getCreateDate())%></td>
</tr>
<tr<%=bgcolor%>><td><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td><td colspan="2" height="7"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<tr valign="top"<%= bgcolor%>>
		<td class="smallFont" valign="bottom">
		<a href="/pages/<%=langCode%>/forum/profile?login=<%=CMSApplication.toHTML(answer.getUserLogin())%>"><img src="<%=des%>/forum/ico-prifile.gif" alt="Посмотреть регистрационные данные" width="10" height="10" border="0"></a><img src="<%=des%>/dvder.gif" width="9" height="9" border="0"><a href="mailto:<%=answer.getUserEmail()%>"><img src="<%=des%>/forum/ico-eml.gif" alt="Отправить e-mail" width="10" height="10" border="0"></a>
		</td>
		<td class="smallFont" colspan="2"><%  if(user != null  && !user.isDisabled() && theme.getStatus() != ForumItem.CLOSED_THEME){ %><a href="/pages/<%=langCode%>/forum?forum_id=<%=forumId%>&theme_id=<%=themeId%>&create=1&cite_id=<%=answer.getId()%>&cite_login=<%=CMSApplication.toHTML(answer.getUserLogin())%>"><img src="<%=des%>/forum/btn-quote.gif" height="18" alt="Цитировать" border="0" align="right" hspace="5"></a><% }%>
        <%=text%>
		</td>
</tr>
<%          if(isModerator)
            {
%>
<tr valign="top"<%=bgcolor%>>
	<td><div style="width:3"><SPACER TYPE="block" HEIGHT="1" WIDTH="3"></div></td>
	<td></td>
	<td><div style="width:10"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
	<td class="defFont">
	<a href="/pages/<%=langCode%>/forum?forum_id=<%=forumId%>&theme_id=<%=themeId%>&edit=1&item_id=<%=answer.getId()%>">редактировать</a>&nbsp;
<%              if(num == 1 || !answer.getId().equals(themeId)){ %>
	<a href="/forum/xt_forum.jsp?action=del&forum_id=<%=forumId%>&theme_id=<%=themeId%>&item_id=<%=answer.getId()%>">удалить</a>
<%              } %>
<%              if(answer.getPublicDate() == null && (theme.isPublic() || answer.getId().equals(themeId))){ %>
	<a href="/forum/xt_forum.jsp?action=publ&forum_id=<%=forumId%>&theme_id=<%=themeId%>&item_id=<%=answer.getId()%>">опубликовать</a>
<%              } %>
<%              if(answer.getPublicDate() == null && !theme.isPublic() && !answer.getId().equals(themeId)){ %>
	не опубликовано
<%              } %>
	</td>
	<td></td>
</tr>
<%          } %>
<%----//1 -----%>

<!-- divider --><tr><td height="11" colspan="5" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  } %>
</table>

<%---- Фильтр -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:4px 0px 0px 0px;">
<tr><form action="/pages/<%=langCode%>/forum">
<input type="hidden" name="forum_id" value="<%=forumId%>">
<input type="hidden" name="theme_id" value="<%=themeId%>">
<%  if(user != null  && !user.isDisabled() && theme.getStatus() != ForumItem.CLOSED_THEME){ %>
<td><a href="/pages/<%=langCode%>/forum?forum_id=<%=forumId%>&theme_id=<%=themeId%>&create=1"><img src="<%=des%>/forum/btn-add-msg.gif" height="18" alt="Добавить сообщение" border="0"></a></td>
<%  } %>
<td align="right"><NOBR><SPAN class="smallFont"><b class="c66">Показать:</b></SPAN>
<SPAN class="SELnn"><SELECT NAME="period">
<OPTION value=0<%="0".equals(showPeriod) ? " SELECTED":""%>>все темы</OPTION>
<OPTION value=1<%="1".equals(showPeriod) ? " SELECTED":""%>>за последний день</OPTION>
<OPTION value=2<%="2".equals(showPeriod) ? " SELECTED":""%>>за последние 7 дней</OPTION>
<OPTION value=3<%="3".equals(showPeriod) ? " SELECTED":""%>>за последний месяц</OPTION>
<OPTION value=4<%="4".equals(showPeriod) ? " SELECTED":""%>>за последние 6 месяцев</OPTION>
<OPTION value=5<%="5".equals(showPeriod) ? " SELECTED":""%>>за последний год</OPTION></SELECT>
<SELECT name=order>
<OPTION value=asc<%="asc".equals(order) ? " SELECTED":""%>>начиная со старых</OPTION>
<OPTION value=desc<%="desc".equals(order) ? " SELECTED":""%>>начиная с новых</OPTION>
</SELECT>
</SPAN><input type="Image"src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" align="absmiddle"></NOBR></td>
</form></tr>
</table>
<%----//Фильтр -----%>

<%---- пораздел -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:8px 0px 0px 0px;">
<tr>
<td align="right" class="smallFont"><SPAN class="c66"><%printPagebar(pageNumber, pageSize, num, href, out);%></SPAN></td>
</tr>
</table>
<%----//пораздел -----%>
<%----//Форум  -----%>
<%  } %>