<%
    Forum forum = new Forum();
    ForumGroup group = new ForumGroup();    
    forum.load(forumId);
    if(forum != null)
        group.load(forum.getForumGroupId());

    if(forum != null && group != null && forum.isVisible() && group.isVisible())
    {
        int pageNumber = 1;
        int pageSize = 10;
        try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}

        Date startDate = null;
        String  showPeriod = request.getParameter("period");
        
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
        
        boolean isModerator = (user != null && forum.isModerator(user.getId())  && !user.isDisabled());
        
        boolean visibleOnly = !isModerator;
        
        String href = "/pages/" + langCode + "/forum/?forum_id=" + forumId + "&period=" + showPeriod;
        int num = ForumItem.getForumItemNum(forumId, startDate, visibleOnly);
        
        Enumeration enum = ForumItem.getForumItems(forumId, startDate, pageNumber, pageSize, visibleOnly).elements();
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
<%=CMSApplication.toHTML(forum.getName())%>
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


<div style="margin:8px 0px 0px 0px;font-family: Geneva CY, Verdana, Tahoma, Arial, sans-serif;"><b class="bluTtl"><%=CMSApplication.toHTML(forum.getName())%></b></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<td height="22" valign="top">
<SPAN class="smallFont"><img src="<%=des%>/ans-all.gif" width="18" height="8" border="0" align="absmiddle"><SPAN class="c66">Тем:</SPAN> <%=num%></SPAN></td>
<td valign="bottom" align="right" class="smallFont"><SPAN class="c66"><%printPagebar(pageNumber, pageSize, num, href, out);%></SPAN></td>
</tr>
</table>

<%----//пораздел -----%>

<%---- Фильтр -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:8px 0px 0px 0px;">
<tr><form action="/pages/<%=langCode%>/forum">
<input type="hidden" name="forum_id" value="<%=forumId%>">
<%  if(user != null && !user.isDisabled()){ %>
    <td><a href="/pages/<%=langCode%>/forum?forum_id=<%=forumId%>&create=1"><img src="<%=des%>/forum/btn-add-thm.gif" height="18" alt="Добавить тему" border="0"></a></td>
<%  } %>
<td align="right"><NOBR><SPAN class="smallFont"><b class="c66">Показать:</b></SPAN>
<SPAN class="SELnn"><SELECT NAME="period">
<OPTION value=0<%="0".equals(showPeriod) ? " SELECTED":""%>>все темы</OPTION>
<OPTION value=1<%="1".equals(showPeriod) ? " SELECTED":""%>>за последний день</OPTION>
<OPTION value=2<%="2".equals(showPeriod) ? " SELECTED":""%>>за последние 7 дней</OPTION>
<OPTION value=3<%="3".equals(showPeriod) ? " SELECTED":""%>>за последний месяц</OPTION>
<OPTION value=4<%="4".equals(showPeriod) ? " SELECTED":""%>>за последние 6 месяцев</OPTION>
<OPTION value=5<%="5".equals(showPeriod) ? " SELECTED":""%>>за последний год</OPTION></SELECT></SPAN><input type="Image"src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" align="absmiddle"></NOBR></td>
</form></tr>
</table>
<%----//Фильтр -----%>

<table width="100%" border="0" cellpadding="1" cellspacing="0" style="margin:8px 0px 0px 0px;">

<%---- заголовок раздела -----%>
<tr bgcolor="#DDF3E1">
	<td class="defFont">&nbsp;</td>
	<td width="55%" class="defFont" height="19"><b class="grnTtl">Темы</b></td>
	<td width="15%" align="center" class="defFont"><b class="grnTtl">Автор</b></td>
	<td width="15%" align="center" class="defFont"><b class="grnTtl">&nbsp;&nbsp;Сообщений&nbsp;&nbsp;</b></td>
	<td width="15%" align="center" class="defFont"><b class="grnTtl">Просмотров&nbsp;</b></td>
</tr>
<%----//заголовок раздела -----%>

<!--отступ--><tr><td height="10" colspan="5"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%





    java.text.SimpleDateFormat forumSdf = new java.text.SimpleDateFormat("dd.MM.yyyy-HH.mm.ss");
        
    Date lastForumVisitDate = null;
    try
    {
        String sLastForumVisitDate = CMSApplication.getCookie(request, "forum.last_view." + forum.getId());
        lastForumVisitDate = forumSdf.parse(sLastForumVisitDate);
                
    }
    catch(Exception e)
    {
        lastForumVisitDate = null;
    }
                

    while(enum.hasMoreElements())
    {
        ForumItem theme = (ForumItem)enum.nextElement();
        Date lastMessageDate = theme.getLastMessageDate();
        if(lastMessageDate == null)
            lastMessageDate = new Date();
%>
<%---- 1 -----%>
<tr valign="top">
	<td rowspan="3"><a href="/pages/<%=langCode%>/forum?forum_id=<%=forum.getId()%>&theme_id=<%=theme.getId()%>"><%
if(theme.getStatus() == ForumItem.CLOSED_THEME){
%><img src="<%=des%>/forum/ico-frm-lock.gif" width="13" height="15" border="0" hspace="4"><%
}else if(theme.getStatus() == ForumItem.HOT_THEME || theme.getStatus() == ForumItem.MAIN_PAGE_THEME){
%><img src="<%=des%>/forum/ico-frm-hot.gif" width="13" height="15" border="0" hspace="4"><%
}else{
%><img src="<%=des%>/ico-frm.gif" width="13" height="15" border="0" hspace="4"><%
} 
%></a></td>
	<td class="defFont" colspan="2"><a href="/pages/<%=langCode%>/forum?forum_id=<%=forum.getId()%>&theme_id=<%=theme.getId()%>" class="nonUa"><b class="bluTtl"><%=CMSApplication.toHTML(theme.getHeader())%></b>
<%  if((lastForumVisitDate == null || lastForumVisitDate.before(lastMessageDate)))
    {
%>
	&nbsp;<img src="<%=des%>/forum/ico-new-ms.gif" width="9" height="7" alt="" border="0">
<%
	} 
%>

</a></td>
	<td></td>
	<td></td>
	<td></td>
</tr>
<%
    int publAmount = theme.getAnswerAmount();
    if(theme.isPublic())
        publAmount ++;

    int allAmount = theme.getAllAnswerAmount() + 1;
        
%>
<tr valign="top">
	<td class="smallFont" nowrap>
	<img src="<%=des%>/ans-lst.gif" width="8" height="7" border="0" hspace="1" align="baseline">&nbsp;<SPAN class="c66">Посл. ответ:</SPAN> <%=sdf.format(lastMessageDate)%> от <a href="/pages/<%=langCode%>/forum/profile?login=<%=CMSApplication.toHTML(theme.getLastMessageLogin())%>" class="nonUa"><b><%=CMSApplication.toHTML(theme.getLastMessageLogin())%></b></a>
	</td>
	<td class="smallFont" align="center"><a href="/pages/<%=langCode%>/forum/profile?login=<%=CMSApplication.toHTML(theme.getUserLogin())%>" class="nonUa"><b><%=CMSApplication.toHTML(theme.getUserLogin())%></b></a></td>
	<td class="smallFont" align="center"><%=publAmount%><%
	if(isModerator){
	    out.println("<br>(новых &#151 " + (allAmount - publAmount) + ")");
	}
	%></td>
	<td class="smallFont" align="center"><%=theme.getViewCount()%></td>
</tr>

<tr valign="top">
	<td class="XsmallFont"><SPAN class="c66">[<img src="<%=des%>/forum/ico-pg.gif" width="8" height="10" alt="" border="0" align="absbottom" hspace="2">&nbsp;На страницу:
<%
    int themePages = (theme.getAnswerAmount()+1) / pageSize + 1;
    for(int i = 1; i <= themePages; i++)
    {
%>
	<a href="/pages/<%=langCode%>/forum?forum_id=<%=forum.getId()%>&theme_id=<%=theme.getId()%>&page_number=<%=i%>"><%=i%></a><%= i== themePages ? "":", "%>
<%  } %>
	]</SPAN> </td>
	<td></td>
	<td></td>
	<td></td>
</tr>
<%----//1 -----%>

<%          if(isModerator)
            {
%>
<tr valign="top">
	<td><div style="width:3"><SPACER TYPE="block" HEIGHT="1" WIDTH="3"></div></td>
	<td class="defFont">
<%          if(theme.getPublicDate() != null)
            {
                if(theme.getStatus() == ForumItem.SIMPLE_THEME || theme.getStatus() == ForumItem.HOT_THEME){ %>
	<a href="/forum/xt_forum.jsp?action=close&forum_id=<%=forumId%>&theme_id=<%=theme.getId()%>" onClick="return confirm('Закрыть тему?');">закрыть</a>
<%              } %>
<%              if(theme.getStatus() == ForumItem.SIMPLE_THEME){ %>
	<a href="/forum/xt_forum.jsp?action=hot&forum_id=<%=forumId%>&theme_id=<%=theme.getId()%>%>">горячая</a>
<%              } %>
<%              if(theme.getStatus() == ForumItem.HOT_THEME){ %>
	<a href="/forum/xt_forum.jsp?action=simple&forum_id=<%=forumId%>&theme_id=<%=theme.getId()%>%>">обычная</a>
<%              }
            }
            else
            {
%>
тема не опубликована
<%          } %>
	</td>
	<td></td>
	<td></td>
	<td></td>
</tr>
<%
            } 
%>


<!-- divider --><tr><td height="11" colspan="5" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%  } %>

</table>

<%---- Фильтр -----%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:4px 0px 0px 0px;">
<tr><form action="/pages/<%=langCode%>/forum">
<input type="hidden" name="forum_id" value="<%=forumId%>">
<%  if(user != null && !user.isDisabled()){ %>
<td><a href="/pages/<%=langCode%>/forum?forum_id=<%=forumId%>&create=1"><img src="<%=des%>/forum/btn-add-thm.gif" height="18" alt="Добавить тему" border="0"></a></td>
<%  } %>
<td align="right"><NOBR><SPAN class="smallFont"><b class="c66">Показать:</b></SPAN>
<SPAN class="SELnn"><SELECT>
<OPTION value=0<%="0".equals(showPeriod) ? " SELECTED":""%>>все темы</OPTION>
<OPTION value=1<%="1".equals(showPeriod) ? " SELECTED":""%>>за последний день</OPTION>
<OPTION value=2<%="2".equals(showPeriod) ? " SELECTED":""%>>за последние 7 дней</OPTION>
<OPTION value=3<%="3".equals(showPeriod) ? " SELECTED":""%>>за последний месяц</OPTION>
<OPTION value=4<%="4".equals(showPeriod) ? " SELECTED":""%>>за последние 6 месяцев</OPTION>
<OPTION value=5<%="5".equals(showPeriod) ? " SELECTED":""%>>за последний год</OPTION></SELECT></SPAN><input type="Image"src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" align="absmiddle"></NOBR></td>
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