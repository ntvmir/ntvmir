<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Forum.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/print_navigator.jsp"%>

<%
	String id = request.getParameter("id");
    String mode = request.getParameter("mode");
    String order = request.getParameter("order");
    
    if(order == null || order.length() != 2)
        order = "1!";
    String orderClause;
    if(order.startsWith("1"))
        orderClause = "m_login";
    else if(order.startsWith("2"))
        orderClause = "m_email";
    else if(order.startsWith("3"))
        orderClause = "m_create_date";
    else if(order.startsWith("4"))
        orderClause = "m_country";
    else if(order.startsWith("5"))
        orderClause = "m_city";
    else
        orderClause = "m_login";

    if(order.endsWith("-"))
        orderClause += " desc";

    if(!"moder".equals(mode))
        mode = "user";
    boolean userMode = "user".equals(mode);

    Forum forum = new Forum();
    forum.load(id);
    
	
	int pageNumber = 1;
	int pageSize = 15;
	try{ pageNumber = Integer.parseInt(request.getParameter("page_number")); }catch(Exception e){}
	
	String header = userMode ? "Назначение модераторов" : "Модераторы";
	
	int num;
	Enumeration enum;
	
	if(userMode)
	{
	    num = User.getUserCount();
	    enum = User.getUsers(orderClause, pageNumber, pageSize).elements();
	}
	else
	{
	    num = forum.getModeratorCount();
	    enum = forum.getModerators(orderClause, pageNumber, pageSize).elements();
	}
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");
	
	String message = "";
	String actionDone = request.getParameter("action_done");
	if("del".equals(actionDone))
		message = "Выбранные новости были удалены.";
	else if("add".equals(actionDone))
		message = "Новость добавлена";
	else if("save".equals(actionDone))
		message = "Новость сохранена";
%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Модераторы форума"/>
<jsp:param name="header" value="<%=header%>"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<SCRIPT LANGUAGE="javascript">
function submitForm()
{
	if(confirm("<%=userMode? "Назначить модераторов?" : "Отстранить модераторов?"%>"))
		document.main_form.submit();
}

function checkAll()
{
    var ch = document.getElementById("user_all").checked;
    for(var i = 0; true; i++)
    {
        if(document.getElementById("user_id" + i) != null)
            document.getElementById("user_id" + i).checked = ch;
        else
            break;
    }
}
</SCRIPT>
<%
	if(num > 0)
		printNavigator(pageNumber, pageSize, num, "forum_moderator.jsp?id=" + id + "&mode=" + mode + "&order=" + order, "700", out);
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="700">
<FORM ACTION="xt_forum_moderator.jsp" METHOD="post" NAME="main_form">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=id%>">
<INPUT TYPE="hidden" NAME="mode" VALUE="<%=mode%>">
<TR>
<TD COLSPAN="6" ALIGN="right" HEIGHT="16"><A HREF="forum_moderator.jsp?id=<%=id%>&mode=<%=userMode ? "moder":"user"%>"><%=userMode ? "Список модераторов" : "Назначить модераторов"%></A>&nbsp;<BR>
</TD>
</TR>

<TR>
<TD COLSPAN="6" ALIGN="center" CLASS="c2" HEIGHT="20">
<B>Подраздел "<%=forum.getName()%>"</B><BR>
<B><%=userMode ? "Пользователи" : "Модераторы"%></B>
</TD>
</TR>

<TR>
<TD VALIGN="middle" CLASS="c2" WIDTH="1%">
<INPUT TYPE="checkbox" ID="user_all" onClick="checkAll();"> </TD>
<TD CLASS="c2" WIDTH="20%"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="forum_moderator.jsp?id=<%=forum.getId()%>&mode=<%=mode%>&order=1<%=order.equals("1!") ? "-" : "!" %>">Login<%=order.startsWith("1") ? ('-' == order.charAt(1) ? "-" : "+"): ""%></A></DIV></TD>
<TD CLASS="c2" WIDTH="20%"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="forum_moderator.jsp?id=<%=forum.getId()%>&mode=<%=mode%>&order=2<%=order.equals("2!") ? "-" : "!" %>">Email<%=order.startsWith("2") ? ('-' == order.charAt(1) ? "-" : "+"): ""%></A></DIV></TD>
<TD CLASS="c2" WIDTH="20%"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="forum_moderator.jsp?id=<%=forum.getId()%>&mode=<%=mode%>&order=3<%=order.equals("3!") ? "-" : "!" %>">Регистрация<%=order.startsWith("3") ? ('-' == order.charAt(1) ? "-" : "+"): ""%></A></DIV></TD>
<TD CLASS="c2" WIDTH="20%"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="forum_moderator.jsp?id=<%=forum.getId()%>&mode=<%=mode%>&order=4<%=order.equals("4!") ? "-" : "!" %>">Страна<%=order.startsWith("4") ? ('-' == order.charAt(1) ? "-" : "+"): ""%></A></DIV></TD>
<TD CLASS="c2" WIDTH="20%"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="forum_moderator.jsp?id=<%=forum.getId()%>&mode=<%=mode%>&order=5<%=order.equals("5!") ? "-" : "!" %>">Город<%=order.startsWith("5") ?('-' == order.charAt(1) ? "-" : "+"): ""%></A></DIV></TD>
</DIV></TD>

</TR>
<%
	int l = 0;
	while(enum.hasMoreElements())
	{
		User user = (User)enum.nextElement();
		String style = "c3";
%>
<TR>
<TD WIDTH="1%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle">
<INPUT TYPE="checkbox" NAME="user_id" VALUE="<%=user.getId()%>" ID="user_id<%=l%>"> </TD>
<TD WIDTH="20%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<B><%=user.getLogin()%></B></DIV></TD>
<TD WIDTH="20%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<A HREF="mailto:<%=user.getEmail()%>"><%=user.getEmail()%></A></DIV></TD>
<TD WIDTH="20%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=sdf.format(user.getCreateDate())%></DIV></TD>
<TD WIDTH="20%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=user.getCountry()%></DIV></TD>
<TD WIDTH="20%" HEIGHT="20" CLASS="<%=style%>" VALIGN="middle"><DIV STYLE="padding-left:6px;padding-right:6px">
<%=user.getCity()%></DIV></TD>
</TR>
<%	
		l++;
	} 
%>
<TR>
<TD COLSPAN="6" HEIGHT="20" ALIGN="center"><BR><A HREF="javascript: submitForm();"><%=userMode ? "назначить модераторов" : "отстранить модераторов"%></A><BR></TD>
</TR>
</FORM>
</TABLE>

<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
