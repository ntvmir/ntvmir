<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = "journal";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	int pageNum = -1;
	int pageSize = -1;
	String sDate1 = request.getParameter( "date1" );  // date1 - since
	String sDate2 = request.getParameter( "date2" );  // date2 - till
	
	
	if( sDate1 == null ) sDate1 = "";
	if( sDate2 == null ) sDate2 = "";
	
	Date date1 = null;
	Date date2 = null;
	
	boolean badDate1 = false;
	boolean badDate2 = false;
	
	try{ pageNum = Integer.parseInt( request.getParameter( "pageNum" )); }catch( Exception e ){}
	try{ pageSize = Integer.parseInt( request.getParameter( "pageSize" )); }catch( Exception e ){}
	
	if( pageNum <= 0 ) pageNum = 1;
	if( pageSize <= 0 ) pageSize = 30;

	
	SimpleDateFormat sdf = new SimpleDateFormat( "dd.MM.yyyy" );

	if( sDate1 == null || sDate1.trim().length() == 0 ) date1 = null;
	else
	{
		try
		{ 
			date1 = sdf.parse( sDate1 ); 
		}
		catch( Exception e )
		{
			badDate1 = true;
		}
	}

	if( sDate2 == null || sDate2.trim().length() == 0 ) date2 = null;
	else
	{
		try
		{ 
			date2 = sdf.parse( sDate2 ); 
		}
		catch( Exception e )
		{
			badDate2 = true;
		}
	}
	if( date1 == null && date2 == null )
	{
		Calendar cal = Calendar.getInstance();
		date2 = cal.getTime();
		cal.add( Calendar.DATE, -14 );  // на две недели назад
		date1 = cal.getTime();	
	}
	
	
%>


<%!
	String actionTypeName( int type )
	{
		switch( type )
		{
			case Journal.ACTION_CREATE: return "Создание"; 
			case Journal.ACTION_MODIFY: return "Изменение";
			case Journal.ACTION_DELETE: return "Удаление";
			case Journal.ACTION_PUBLIC: return "Публикация";
			case Journal.ACTION_UNPUBL: return "Снятие с публ."; 
			default: return "---";
		}
	}
	
	String sectionName( String s )
	{
		if( s == null ) return "---";
		Service service =  CMSApplication.getApplication().getServiceByCode(s);
		if( service == null ) return s;
		return service.getName();
	}

%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Журнал изменений"/>
<jsp:param name="header" value="Журнал изменений"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>


<TABLE WIDTH="500" BORDER="0" CELLPADDING="0" CELLSPACING="1">
<FORM ACTION="journal.jsp" METHOD="post">
<TR>
	<TD CLASS="c2" HEIGHT="16" COLSPAN="2" ALIGN="center">
		<B>Показать изменения</B>
	</TD>
</TR>
<TR>
	<TD CLASS="edit" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">дата начала</DIV>
	</TD>
	<TD CLASS="edit">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="text" NAME="date1" VALUE="<%=date1 != null ? sdf.format( date1 ) : ""%>"> (в формате "ДД.ММ.ГГГГ")</DIV>
	</TD>
</TR>
<TR>
	<TD CLASS="edit" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">дата окончания</DIV>
	</TD>
	<TD CLASS="edit">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS=""><INPUT TYPE="text" NAME="date2" VALUE="<%=date2 != null ? sdf.format( date2 ) : ""%>"> (в формате "ДД.ММ.ГГГГ")</DIV>
	</TD>
</TR>
<TR>
	<TD CLASS="edit" HEIGHT="20" WIDTH="30%">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">записей на странице</DIV>
	</TD>
	<TD CLASS="edit">
		<DIV STYLE="padding-left:6px;padding-right:6px;" CLASS="">
		<SELECT NAME="pageSize">
			<OPTION VALUE="30"<%=pageSize == 30 ? " SELECTED" : ""%>> 30 </OPTION>
			<OPTION VALUE="50"<%=pageSize == 50 ? " SELECTED" : ""%>> 50 </OPTION>
			<OPTION VALUE="100"<%=pageSize == 100 ? " SELECTED" : ""%>> 100 </OPTION>
			<OPTION VALUE="150"<%=pageSize == 150 ? " SELECTED" : ""%>> 150 </OPTION>
			<OPTION VALUE="200"<%=pageSize == 200 ? " SELECTED" : ""%>> 200 </OPTION>
		</SELECT>
		</DIV>
	</TD>
</TR>


<TR><TD COLSPAN="2"><IMG SRC="/admin/img/blank.gif" WIDTH=1 HEIGHT=1><BR></TD></TR>
	<TR ALIGN="center">
		<TD COLSPAN="2">
			<INPUT TYPE="submit" VALUE="Показать">
		</TD>
	</TR>
</TABLE>
</FORM><BR>

<%	if( badDate1 || badDate2 )
	{
%>
<B STYLE="color: red">
Не верный формат даты.

</B><BR><BR><BR>
<%	}
	else
	{
		int nRec = Journal.getRecordsNum( date1, date2 );
		Enumeration enum = Journal.getRecords( date1, date2, pageNum, pageSize );
		if( nRec > pageSize )
		{
%>

<HR>
<BR>
<B>Всего:</B>&nbsp;&nbsp;<%=nRec%><BR><BR>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD><A HREF="journal.jsp?pageNum=<%=pageNum-1%>&pageSize=<%=pageSize%>&date1=<%=sDate1%>&date2=<%=sDate2%>"><IMG SRC="/img/2l/nav/_arr.gif" WIDTH=6 HEIGHT=9 ALT="" BORDER="0"></A><IMG SRC="/img/blank.gif" WIDTH=5 HEIGHT=1 ALT="" BORDER="0"><BR></TD>
<TD>
<%			for( int i = 1; i <= (nRec-1) / pageSize + 1; i++ )
			{
				if( i == pageNum )
				{
%>
<%= i > 1 ? " | " : " " %><A CLASS="mcur"><%=i%></A>
<%				}
				else
				{
%>
<%= i > 1 ? " | " : " " %><A CLASS="m" HREF="journal.jsp?pageNum=<%=i%>&pageSize=<%=pageSize%>&date1=<%=sDate1%>&date2=<%=sDate2%>"><%=i%></A>
<%				}
			}
%>
</TD>
<TD><IMG SRC="/img/blank.gif" WIDTH=10 HEIGHT=1 ALT="" BORDER="0"><A HREF="news.jsp?mode=folder&folder=R&pageNum=2"><IMG SRC="/img/2l/nav/arr.gif" WIDTH=6 HEIGHT=9 ALT="" BORDER="0"></A><BR></TD>
</TR>
</TABLE>
<%		} %>

<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="1" WIDTH="100%">
<TR>
	<TD CLASS="c2" HEIGHT="16" COLSPAN="8" ALIGN="center">
		<B>Список изменений</B>
	</TD>
</TR>


<TR>
	<TD CLASS="c2" HEIGHT="16" WIDTH="1%">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		Дата
		</DIV>
	</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		Login
		</DIV>
	</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		ФИО
		</DIV>
	</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		Действие
		</DIV>
	</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		Раздел
		</DIV>
	</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		Тип объекта
		</DIV>
	</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		Имя объекта
		</DIV>
	</TD>
	<TD CLASS="c2" HEIGHT="16" WIDTH="">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		Дополнительная информация
		</DIV>
	</TD>

</TR>
<%		SimpleDateFormat sdf2 = new SimpleDateFormat( "dd.MM.yyyy'<BR>'HH:mm" );
		while( enum.hasMoreElements())
		{
			Journal rec = (Journal)enum.nextElement();
%>
<TR CLASS="edit">
	<TD ALIGN="right">
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<%=sdf2.format( rec.getActionDate())%>
		</DIV>
	</TD>
	<TD>
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<%= CMSApplication.toHTML( rec.getAdminLogin())%>
		</DIV>
	</TD>
	<TD>
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<%= CMSApplication.toHTML( rec.getAdminName())%>
		</DIV>
	</TD>
	<TD>
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<%= actionTypeName( rec.getActionType())%>
		</DIV>
	</TD>
	<TD>
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<%= sectionName( rec.getSectionName())%>
		</DIV>
	</TD>
	<TD>
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<%= rec.getObjectType()%>
		</DIV>
	</TD>
	<TD>
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<%= CMSApplication.toHTML( rec.getObjectName())%>
		</DIV>
	</TD>
	<TD>
		<DIV STYLE="padding-left:6px;padding-right:6px;">
		<%= CMSApplication.toHTML( rec.getDescription())%>
		</DIV>
	</TD>
</TR>
<%
	
	}
%>
</TABLE>
<%	} %>
<HR>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>
