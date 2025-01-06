<%
    Forum       forum   = new Forum();
    ForumGroup  group   = new ForumGroup();
    ForumItem   theme   = null;
    ForumItem   cite    = null;
    ForumItem   item    = null;
    
    
    String citeId = request.getParameter("cite_id");
    String itemId = request.getParameter("item_id");
    String citeLogin = request.getParameter("cite_login");
    if(citeLogin == null)
        citeLogin = "";
        
    forum.load(forumId);
    if(forum != null)
        group.load(forum.getForumGroupId());
    if(themeId != null)
    {
        theme = new ForumItem();
        theme.load(themeId);
    }
    
    boolean isModerator = (user != null && !user.isDisabled() && forum != null && forum.isModerator(user.getId()));
    boolean visibleOnly = !isModerator;

    if(forum != null && group != null &&
        forum.isVisible() && group.isVisible() && (theme == null || theme.getPublicDate() != null || isModerator))
    {
        if(citeId != null && citeId.length() > 0)
        {
            cite = new ForumItem();
            cite.load(citeId);
            if(!cite.isPublic() && ! isModerator)
                cite = null;
        }
        if(itemId != null && itemId.length() > 0)
        {
            item = new ForumItem();
            item.load(itemId);
        }
        
        String text = "";
        if(item != null)
            text = CMSApplication.toHTML(item.getText());
		            
        else if(cite != null)
            text = "\n[cite]\n[b]" + CMSApplication.toHTML(citeLogin) + " писал(а):[/b]\n" + CMSApplication.toHTML(cite.getText()) + "[/cite]\n";
        if(user != null)
            text += CMSApplication.toHTML(user.getForumSign());
%>
<script language="JavaScript">

function txt(text1, text2)
{
    insertText(text1, text2);
}

function smile(txt)
{
    insertText(txt, '');
}

function insertText(text1, text2)
{
    if (document.selection) {
    	document.message_form.message.focus();
    	var ttt = document.message_form.message.document.selection.createRange().text;
    	document.message_form.message.document.selection.createRange().text = text1 + ttt + text2;
    	//document.message_form.message.document.selection.createRange().text = text;
    }
    else
        document.message_form.message.value += text1 + text2;
        
}

function preview()
{
	window.open('','preview','');
	document.forms.message_form.target = 'preview';
	document.forms.message_form.action = '/forum/preview.jsp';
	document.forms.message_form.submit();
	document.forms.message_form.action = '/forum/xt_answer.jsp';
	document.forms.message_form.target='_self';
}

function submitMessage()
{
    var frm = document.message_form;
    if(frm.header.value == '')
    {
        alert('Не указан заголовок.');
        frm.header.focus();
        return;
    }
    frm.submit();
}

</script>

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

<%
    String header = "";
    if(item != null)
        header = CMSApplication.toHTML(item.getHeader());
    else if(theme != null)
        header = "Re: " + CMSApplication.toHTML(theme.getHeader());
%>

<%---- ОТВЕТ -----%>
<table width="100%" border="0" cellpadding="1" cellspacing="0" style="margin:8px 0px 0px 0px;">
<tr>
<form action="/forum/xt_answer.jsp" METHOD=post name="message_form">
<input type="hidden" name="forum_id" value="<%=forumId%>">
<input type="hidden" name="theme_id" value="<%=themeId != null ? themeId : ""%>">
<%  if(item != null){ %>
<input type="hidden" name="item_id" value="<%=item.getId()%>">
<%  } %>
<td><div style="width:12;"><SPACER TYPE="block" HEIGHT="1" WIDTH="12"></div></td>
<td class="defFont"><div style="width:160;"><SPACER TYPE="block" HEIGHT="1" WIDTH="160"></div>Заголовок:</td>
<td width="100%"><input type="text" name="header" value="<%=header%>" style="width:100%;font-size:10px;font-family:Tahoma;" size="38" maxlength="100"></td>
<td><div style="width:12;"><SPACER TYPE="block" HEIGHT="1" WIDTH="12"></div></td>
</tr>
<!-- divider --><tr><td height="11" colspan="4" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<tr>
<td></td>
<td class="defFont">Форматирование:</td>
<td class="defFont"><A href="javascript: txt('[b]', '[/b]');"><IMG alt="Жирный" border=0 height=18 src="<%=des%>/forum/ico-bld.gif" width=18></A><A href="javascript: txt('[i]', '[/i]');"><IMG alt="Наклонный" border=0 height=18 src="<%=des%>/forum/ico-itlc.gif" width=18 hspace="4"></A><A href="javascript: txt('[u]', '[/u]');"><IMG alt="Подчеркнутый" border=0 height=18 src="<%=des%>/forum/ico-undrln.gif" width=18></A><A href="javascript: txt('\n[ul]\n [*] ', '\n[/ul]');"><IMG alt="Список" border=0 height=18 src="<%=des%>/forum/ico-ul.gif" width=18 hspace="4"></A><A href="javascript: txt('\n [*] ', '');"><IMG alt="Элемент списка" border=0 height=18 src="<%=des%>/forum/ico-li.gif" width=18></A><A href="javascript: txt('\n   [p] ', '');"><IMG alt="Новый абзац" border=0 height=18 src="<%=des%>/forum/ico-p.gif" width=18 hspace="4"></A></td>
<td></td>
</tr>
<!-- divider --><tr><td height="11" colspan="4" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>

<tr valign="top">
<td></td>
<td><SPAN class="defFont">Сообщение:</SPAN><br>

<div align="right">
<table border="0" cellpadding="2" cellspacing="0" style="margin-top:8px;">
	<tr>
	<td><A href="javascript:smile(':mad:');"><IMG alt="" border=0 height=20 src="<%=des%>/forum/ico-smile-1.gif" width=18></A></td>
	<td><A href="javascript:smile(';)');"><IMG alt="" border=0 height=20 src="<%=des%>/forum/ico-smile-2.gif" width=18></A></td>
	</tr>
	<tr>	
	<td><A href="javascript:smile(':D');"><IMG alt="" border=0 height=20 src="<%=des%>/forum/ico-smile-3.gif" width=18></A></td>
	<td><A href="javascript:smile(':lol:');"><IMG alt="" border=0 height=20 src="<%=des%>/forum/ico-smile-4.gif" width=18></A></td>
	</tr>		
	<tr>
	<td><A href="javascript:smile(':-/');"><IMG alt="" border=0 height=20 src="<%=des%>/forum/ico-smile-5.gif" width=18></A></td>
	<td><A href="javascript:smile(':confused:');"><IMG alt="" border=0 height=20 src="<%=des%>/forum/ico-smile-6.gif" width=18></A></td>
	</tr>
	<tr>
	<td><A href="javascript:smile(':)');"><IMG alt="" border=0 height=20 src="<%=des%>/forum/ico-smile-7.gif" width=18></A></td>
	<td><A href="javascript:smile(':(');"><IMG alt="" border=0 height=20 src="<%=des%>/forum/ico-smile-8.gif" width=18></A></td>
	</tr>
</table>
</div>

<SPAN class="smallFont">
<b style="color:#D82E12;">!</b>&nbsp;Не разрешено<br>
&nbsp;&nbsp;использовать HTML 
</SPAN>

</td>
<td height="100%"><textarea name="message" cols="38" rows="8" style="width:100%;height:100%;font-size:10px;font-family:Tahoma;"  maxlength="8000" wrap="on"><%=text%></textarea></td>
<td></td>
</tr>

<!-- divider --><tr><td height="11" colspan="4" background="<%=des%>/greyln2.gif"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></td></tr>
<tr>
<td></td>
<td></td>
<td><a href="javascript: preview();"><img src="<%=des%>/forum/btn-preview.gif" height="18" alt="Предварительный просмотр" border="0"></a><a href="javascript: submitMessage();"><img src="<%=des%>/forum/btn-post.gif" height="18" alt="Отправить для публикации на сайте" border="0" hspace="10"></a></td>
<td></td>
</form>
</tr>

</table>
<%---- //ОТВЕТ -----%>
<%----//Форум  -----%>
<%  } %>