

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign="top" class="XsmallFont">
<%
    if(pagePath.size() > 1)
    {
%>
<div style="margin-top:8px">
<%  
        for(int i = 0; i < pagePath.size(); i++)
        {
            WebTreeNode treeNode = (WebTreeNode)pagePath.elementAt(i);
            if(i+1 == pagePath.size())
                out.println(CMSApplication.toHTML(treeNode.getName()));
            else
            {
%>  
<a href="<%=nodePath(treeNode)%>"><%=CMSApplication.toHTML(treeNode.getName())%></a> /
<%
            }
        }
%>
</div>
<%  } %>
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
<%---- ГЛАВНАЯ -----%>
<table width="100%" border="0" cellpadding="1" cellspacing="0" style="margin:8px 0px 0px 0px;">
<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm");
    Hashtable forumHash = Forum.getForums(langCode, true);
    Enumeration groups = ForumGroup.getForumGroups(langCode, true).elements();
    boolean firstLoop1 = true;
	while(groups.hasMoreElements())
	{
    	ForumGroup group = (ForumGroup)groups.nextElement();
    	if(firstLoop1)
    	    firstLoop1 = false;
    	else
    	{
%>
<!--отступ--><tr><td height="13" colspan="5"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%      } %>
<%---- заголовок раздела -----%>
<tr bgcolor="#DDF3E1">
	<td class="defFont">&nbsp;</td>
	<td width="70%" class="defFont" height="19"><b class="grnTtl"><%=CMSApplication.toHTML(group.getName())%></b></td>
	<td width="15%" align="center" class="defFont"><b class="grnTtl">&nbsp;&nbsp;Темы&nbsp;&nbsp;</b></td>
	<td width="15%" align="center" class="defFont"><b class="grnTtl">Сообщений&nbsp;</b></td>
</tr>
<%----//заголовок раздела -----%>
<!--отступ--><tr><td height="10" colspan="5"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<%
        java.text.SimpleDateFormat forumSdf = new java.text.SimpleDateFormat("dd.MM.yyyy-HH.mm.ss");
        Vector vf = (Vector)forumHash.get(group.getId());
        if(vf == null)
            vf = new Vector();
        Enumeration enum = vf.elements();
        boolean firstLoop2 = true;
        while(enum.hasMoreElements())
        {
            Forum forum = (Forum)enum.nextElement();
            Date lastMessageDate = forum.getLastMessageDate();
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
            
            if(lastMessageDate == null)
                lastMessageDate = new Date();
             
		    if(firstLoop2)
		        firstLoop2 = false;
		    else
		    {
%>
<!-- divider --><tr><td height="11" colspan="4" background="<%=des%>/greyln2.gif" width="100%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td><td height="11" colspan="4" background="<%=des%>/greyln2.gif" width="100%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<%          } %>
<%---- 1 -----%>
<tr valign="top">
	<td rowspan="3"><a href=""><img src="<%=des%>/ico-frm.gif" width="13" height="15" alt="Форум закрыт" border="0" hspace="4"></a></td>
	<td width="70%" class="defFont"><a href="/pages/<%=langCode%>/forum?forum_id=<%=forum.getId()%>" class="nonUa"><b class="bluTtl"><%=CMSApplication.toHTML(forum.getName())%></b>
<br>
<%  if((lastForumVisitDate == null || lastForumVisitDate.before(lastMessageDate)) && forum.getThemeAmount() > 0)
    {
%>
	&nbsp;<img src="<%=des%>/forum/ico-new-ms.gif" width="9" height="7" alt="" border="0">
<%
	} 
%></a></td>
	<td></td>
	<td></td>
</tr>

<tr valign="top">
	<td class="smallFont"><%=CMSApplication.toHTML(forum.getDescription())%></td>
	<td class="smallFont" align="center"><%=forum.getThemeAmount()%></td>
	<td class="smallFont" align="center"><%=forum.getMessageAmount()%><%
if(user != null && forum.isModerator(user.getId())  && !user.isDisabled())
{
    out.println("<br> (новых &#151; " + (forum.getAllMessageAmount() - forum.getMessageAmount()) + ")");
}
	%></td>
</tr>

<tr valign="top">
	<td class="smallFont" nowrap>
	<img src="<%=des%>/ans-lst.gif" width="8" height="7" border="0" hspace="1" align="baseline">&nbsp;<SPAN class="c66">Посл. ответ:</SPAN>
<%  if(forum.getThemeAmount() > 0){ %>
	<%=sdf.format(lastMessageDate)%> от <a href="/pages/<%=langCode%>/forum/profile?login=<%=CMSApplication.toHTML(forum.getLastMessageLogin())%>" class="nonUa"><b><%=CMSApplication.toHTML(forum.getLastMessageLogin())%></b></a>
<%  } %>
	</td>
	<td></td>
	<td></td>
</tr>
<%----//1 -----%>
<%
        }
    }
%>
</table>
<%----//ГЛАВНАЯ-----%>
<%----//Форум  -----%>