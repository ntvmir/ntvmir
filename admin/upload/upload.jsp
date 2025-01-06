<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = FileObject.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String	rootPath	= request.getServerName()+separator+"upload"+separator;
	
	String	mode	= request.getParameter("mode");
	if ( mode == null ) mode	= "";

	String	folder	= "";
	folder	= request.getParameter( "folder" );
	if ( folder == null ) folder	= "";


	if( (( mode.equalsIgnoreCase("upload") || mode.equalsIgnoreCase("add_folder")) && ! Admin.isC( pageAccessCode )) ||
		(( mode.equalsIgnoreCase("edit_file") || mode.equalsIgnoreCase("edit_folder")) && ! Admin.isW( pageAccessCode )))
	{
		response.sendRedirect( "upload.jsp?folder=" + folder + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
%>
<%!
	private final String	separator	= File.separator;
	
	private void drawFolders( JspWriter out, String folder, String rootPath, String folderPath, String parentFolder ) throws IOException
	{
		boolean	isEmpty	= false;
		try
		{
			out.println("<TABLE BORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"1\" WIDTH=\"700\">");
			out.println("<TR>");
			out.print("<TD COLSPAN=\"3\" HEIGHT=\"20\" CLASS=\"titnew\" ALIGN=\"center\"><DIV STYLE=\"padding-left:6px;padding-right:6px\" CLASS=\"titnew\"><B>");
			out.print("Директории ");
			out.print("<A HREF=\"upload.jsp?mode=add_folder&folder="+folder+"\">(создать поддиректорию)</A>");
			out.println("</B></DIV></TD>");
			out.println("</TR>");
			out.println("<TR CLASS=\"c1\">");
			out.println("<TD HEIGHT=\"20\" CLASS=\"c2\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("директория");
			out.println("</B></DIV></TD>");
			out.println("<TD COLSPAN=\"2\" CLASS=\"c2\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("действия");
			out.println("</B></DIV></TD>");
			out.println("</TR>");

			if ( parentFolder.length() > 0 || folder.length() > 0 )
			{
				out.println("<TR>");
				out.println("<TD COLSPAN=\"3\" HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
				out.println( "<A HREF=\"upload.jsp?folder="+parentFolder+"\">"+separator+"..</A><BR>" );
				out.println("</DIV></TD>");
				out.println("</TR>");
			}

			File	file	= new File( folderPath );
			File[]	files	= file.listFiles();

			if ( files != null && files.length != 0 )
			{
				for( int i=0; i < files.length ; i++ )
				{
					if ( files[i].isDirectory() )
					{
						isEmpty	= true;
						out.println("<TR>");
						out.println("<TD HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
						out.println( "<A HREF=\"upload.jsp?folder="+folder+(folder.length()>0?"/":"")+files[i].getName()+"\">"+rootPath+folder+(folder.length()>0?"/":"")+files[i].getName()+separator+"</A><BR>" );
						out.println("</DIV></TD>");
						out.println("<TD HEIGHT=\"20\" WIDTH=\"1%\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
						out.print("<A HREF=\"upload.jsp?mode=edit_folder&folder="+folder+"&folderName="+files[i].getName()+"\">");
						out.println("переименовать");
						out.println("</A>");
						out.println("</DIV></TD>");
						out.println("<TD HEIGHT=\"20\" WIDTH=\"1%\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
						out.print("<A HREF=\"xt_upload.jsp?action=delete&folder="+folder+"&fileName="+files[i].getName()+"\" onClick=\"return confirm('Вы уверены?');\">");
						out.println("удалить");
						out.println("</A>");
						out.println("</DIV></TD>");
						out.println("</TR>");
					}
				}
			}
			if ( !isEmpty )
			{
				out.println("<TR>");
				out.println("<TD COLSPAN=\"3\" HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
				out.println( "нет поддиректорий" );
				out.println("</DIV></TD>");
				out.println("</TR>");
			}
			out.println("</TABLE>");
		}catch( Exception e )
		{}
	}

	private void showFiles( JspWriter out, String folder, String folderPath, String rootPath,String parentFolder ) throws IOException
	{
		drawFolders( out, folder, rootPath, folderPath, parentFolder );
		
		try
		{
			File	file	= new File( folderPath );
			File[]	files	= file.listFiles();

			out.println("<TABLE BORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"1\" WIDTH=\"700\">");
			out.println("<TR>");
			out.println("<TD HEIGHT=\"20\" COLSPAN=\"6\" CLASS=\"titnew\" ALIGN=\"center\"><DIV STYLE=\"padding-left:6px;padding-right:6px\" CLASS=\"titnew\"><B>");
			out.println("Директория \""+rootPath+folder+"\"");
			out.println("</B></DIV></TD>");
			out.println("</TR>");

			out.println("<TR>");
			out.println("<TD HEIGHT=\"20\" CLASS=\"c2\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("имя файла");
			out.println("</B></DIV></TD>");
			out.println("<TD CLASS=\"c2\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("обновлен");
			out.println("</B></DIV></TD>");
			out.println("<TD CLASS=\"c2\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("размер");
			out.println("</B></DIV></TD>");
			out.println("<TD CLASS=\"c2\" COLSPAN=\"3\"><DIV STYLE=\"padding-left:6px;padding-right:6px\"><B>");
			out.println("действия");
			out.println("</B></DIV></TD>");
			out.println("</TR>");
			if ( files != null && files.length != 0 )
			{
				for( int i=0; i < files.length ; i++ )
				{
					if ( !files[i].isDirectory() )
					{
						java.util.Date	theDate	= new java.util.Date( files[i].lastModified() );
						java.util.Calendar	date	= java.util.Calendar.getInstance();
						date.setTime( theDate );
						String	year	= String.valueOf( date.get( java.util.Calendar.YEAR ) );
						String	month	= String.valueOf( date.get( java.util.Calendar.MONTH )+1 );
						if ( month.length() == 1 ) month	= "0"+month;
						String	day		= String.valueOf( date.get( java.util.Calendar.DAY_OF_MONTH ) );
						if ( day.length() == 1 ) day	= "0"+day;
						String	hour		= String.valueOf( date.get( java.util.Calendar.HOUR_OF_DAY ) );
						if ( hour.length() == 1 ) hour	= "0"+hour;
						String	minute		= String.valueOf( date.get( java.util.Calendar.MINUTE ) );
						if ( minute.length() == 1 ) minute	= "0"+minute;
						String	recordDate	= day+"."+month+"."+year+" "+hour+":"+minute;

						out.println("<TR>");
						out.println("<TD HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
						out.print("<A HREF=\"/servlet/tengry.servlet.FILEServlet?folder="+folder+"&fileName="+files[i].getName()+"\">");
						out.print( files[i].getName() );
						out.println("</A>");
						out.println("</DIV></TD>");
						out.println("<TD HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
						out.println( recordDate );
						out.println("</DIV></TD>");
						out.println("<TD HEIGHT=\"20\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
						out.println( files[i].length()+" bytes" );
						out.println("</DIV></TD>");
						out.println("<TD HEIGHT=\"20\" WIDTH=\"1%\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
						out.print("<A HREF=\"upload.jsp?mode=edit_file&folder="+folder+"&fileName="+files[i].getName()+"\">");
						out.println("переименовать");
						out.println("</A>");
						out.println("</DIV></TD>");
						out.println("<TD HEIGHT=\"20\" WIDTH=\"1%\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
						out.print("<A HREF=\"xt_upload.jsp?action=delete&folder="+folder+"&fileName="+files[i].getName()+"\" onClick=\"return confirm('Вы уверены?');\">");
						out.println("удалить");
						out.println("</A>");
						out.println("</DIV></TD>");
						out.println( "<TD CLASS=\"c1\"><A HREF=\"/upload"+(folder.length()>0?"/"+folder:"")+"/"+files[i].getName()+"\"><IMG SRC=\"/admin/img/ico10.gif\" WIDTH=25 HEIGHT=20 ALT=\"ссылка на файл\" BORDER=\"0\"></A><BR></TD>" );
						out.println("</TR>");
					}
				}
			}
			else
			{
				out.println("<TR>");
				out.println("<TD HEIGHT=\"20\" COLSPAN=\"6\" CLASS=\"c1\"><DIV STYLE=\"padding-left:6px;padding-right:6px\">");
				out.println( "каталог пуст" );
				out.println("</DIV></TD>");
				out.println("</TR>");
			}
	
			out.println("</TABLE>");
		}catch( Exception e )
		{
			out.println( "There was an Exception: "+e );
		}
	}
%>
<%
	String actionDone = request.getParameter("action_done");
	String message = "";
	if("upload".equals(actionDone))
		message = "Файл загружен.";
	else if("edit".equals(actionDone))
		message = "Имя изменено.";
	else if("new_folder".equals(actionDone))
		message = "Директория создана.";
	else if("dir_del".equals(actionDone))
		message = "Директория удалена.";
	else if("file_del".equals(actionDone))
		message = "Файл удален.";

%>
<jsp:include page="/admin/inc/page_start.jsp" flush="true">
<jsp:param name="title" value="Работа с файлами"/>
<jsp:param name="header" value="Работа с файлами"/>
<jsp:param name="message" value="<%=message%>"/>
<jsp:param name="width" value="700"/>
<jsp:param name="err" value="<%=request.getParameter("err")%>"/>
</jsp:include>
<%
	String	folderPath	= CMSApplication.getApplication().getProperty( "upload.dir" );
	
	String	parentFolder	= "";
	
	int index	= folder.lastIndexOf( separator.charAt( 0 ) );
	if ( index != -1 )	parentFolder = folder.substring( 0, index );

	
	if  ( mode.equalsIgnoreCase("upload") )
	{
		%>
		<FORM NAME="FORM3" ACTION="xt_upload.jsp?action=upload&folder=<%=folder%>" METHOD="post" ENCTYPE="multipart/form-data" onSubmit="if(confirm('Закачать файл')) { if (document.FORM3.file.value=='') {alert('Укажите файл для закачки!'); return false;}else{ return true;}}else return false;">
		<TABLE WIDTH="700" BORDER="0" CELLSPACING="1" CELLPADDING="1">
		<TR>
		<TD CLASS="c2" HEIGHT="20">
		<DIV STYLE="padding-left:6px;padding-right:6px">
		<B>Директория "<%=rootPath+folder%>"</B>
		</DIV>
		</TD>
		</TR>
		<TR>
		<TD CLASS="c2" HEIGHT="20">
		<DIV STYLE="padding-left:6px;padding-right:6px">
		<B>Имя локального файла(для отправки его на сервер):</B>
		</DIV>
		</TD>
		</TR>
		<TR>
		<TD CLASS="c1" HEIGHT="20">
		<DIV STYLE="padding-left:6px;padding-right:6px">
		<INPUT TYPE="File" NAME="file" STYLE="width:470" SIZE="34">
		</DIV>
		</TD>
		</TR>
		</TABLE>
		<INPUT TYPE="button" VALUE="Закачать" ONCLICK="if(confirm('Закачать файл')) { if (document.FORM3.file.value=='') {alert('Укажите файл для закачки!');}else{document.FORM3.submit();}}">
		</FORM>
		<%
	}
	else if  ( mode.equalsIgnoreCase("edit_file") )
	{
		String	fileName	= request.getParameter( "fileName" );
		
		if ( folder.length() > 0 )
		{
			folderPath	+= separator+folder+separator;
		}
		else
		{
			folderPath	+= separator;
		}
		fileName	= folderPath+fileName;
		File	file	= null;
		try
		{
			file	= new File( fileName );
			if ( file.exists() )
			{
				String	name	= file.getName();
				%>
				<FORM NAME="FORM3" ACTION="xt_upload.jsp" METHOD="post" onSubmit="if(confirm('Переименовать?')){ if (document.FORM3.fileName.value=='') {alert('Укажите имя файла!'); return false;}else{return true;}}else {return false;}">
				<INPUT TYPE="Hidden" NAME="folder" VALUE="<%=folder%>">
				<INPUT TYPE="Hidden" NAME="action" VALUE="edit">
				<INPUT TYPE="Hidden" NAME="oldName" VALUE="<%=name%>">
				<TABLE WIDTH="700" BORDER="0" CELLSPACING="1" CELLPADDING="1">
				<TR>
				<TD CLASS="c2" HEIGHT="20">
				<DIV STYLE="padding-left:6px;padding-right:6px">
				<B>Директория "<%=rootPath+folder%>"</B>
				</DIV>
				</TD>
				</TR>
				<TR>
				<TD CLASS="c2" HEIGHT="20">
				<DIV STYLE="padding-left:6px;padding-right:6px">
				<B>Имя файла:</B>
				</DIV>
				</TD>
				</TR>
				<TR>
				<TD CLASS="c1" HEIGHT="20">
				<DIV STYLE="padding-left:6px;padding-right:6px">
				<INPUT TYPE="text" NAME="fileName" STYLE="width:700" SIZE="34" VALUE="<%=name%>">
				</DIV>
				</TD>
				</TR>
				</TABLE>
				<INPUT TYPE="button" VALUE="переименовать" ONCLICK="if(confirm('Переименовать?')){ if (document.FORM3.fileName.value=='') {alert('Укажите имя файла!');}else{document.FORM3.submit();}}">
				</FORM>
				<%
			}
			else
			{
				out.println( "<B STYLE=\"color: red;\">Файл не найден.</B><BR>" );
			}
		}catch( Exception e )
		{
			out.println( "<B STYLE=\"color: red;\">Произошла ошибка при чтении файла.</B><BR>" );
		}
	}
	else if  ( mode.equalsIgnoreCase("edit_folder") )
	{
		String	folderName	= request.getParameter( "folderName" );
		
		if ( folder.length() > 0 )
		{
			folderPath	+= separator+folder+separator;
		}
		else
		{
			folderPath	+= separator;
		}
		folderName	= folderPath+folderName;
		File	file	= null;
		try
		{
			file	= new File( folderName );
			if ( file.exists() )
			{
				String	name	= file.getName();
				%>
				<FORM NAME="FORM3" ACTION="xt_upload.jsp" METHOD="post" onSubmit="if(confirm('Переименовать?')){ if (document.FORM3.fileName.value=='') {alert('Укажите имя поддиректории!'); return false;}else{return true;}}else {return false;}">
				<INPUT TYPE="Hidden" NAME="folder" VALUE="<%=folder%>">
				<INPUT TYPE="Hidden" NAME="action" VALUE="edit">
				<INPUT TYPE="Hidden" NAME="oldName" VALUE="<%=name%>">
				<TABLE WIDTH="700" BORDER="0" CELLSPACING="1" CELLPADDING="1">
				<TR>
				<TD CLASS="c2" HEIGHT="20">
				<DIV STYLE="padding-left:6px;padding-right:6px">
				<B>Директория "<%=rootPath+folder%>"</B>
				</DIV>
				</TD>
				</TR>
				<TR>
				<TD CLASS="c2" HEIGHT="20">
				<DIV STYLE="padding-left:6px;padding-right:6px">
				<B>Имя поддиректории:</B>
				</DIV>
				</TD>
				</TR>
				<TR>
				<TD CLASS="c1" HEIGHT="20">
				<DIV STYLE="padding-left:6px;padding-right:6px">
				<INPUT TYPE="text" NAME="fileName" STYLE="width:700" SIZE="34" VALUE="<%=name%>">
				</DIV>
				</TD>
				</TR>
				</TABLE>
				<INPUT TYPE="button" VALUE="переименовать" ONCLICK="if(confirm('Переименовать?')){ if (document.FORM3.fileName.value=='') {alert('Укажите имя поддиректории!');}else{document.FORM3.submit();}}">
				</FORM>
				<%
			}
			else
			{
				out.println( "<B STYLE=\"color: red;\">Поддиректория не найдена.</B><BR>" );
			}
		}catch( Exception e )
		{
			out.println( "<B STYLE=\"color: red;\">Произошла ошибка при чтении файла.</B><BR>" );
		}
	}
	else if  ( mode.equalsIgnoreCase("add_folder") )
	{
		if ( folder.length() > 0 )
		{
			folderPath	+= separator+folder+separator;
		}
		else
		{
			folderPath	+= separator;
		}
		%>
		<FORM NAME="FORM3" ACTION="xt_upload.jsp" METHOD="post" onSubmit="if(confirm('Сохранить')){ if (document.FORM3.folderName.value=='') {alert('Укажите имя поддиректории!'); return false;}else{return true;}} else return false;">
		<INPUT TYPE="Hidden" NAME="folder" VALUE="<%=folder%>">
		<INPUT TYPE="Hidden" NAME="action" VALUE="add_folder">
		<TABLE WIDTH="700" BORDER="0" CELLSPACING="1" CELLPADDING="1">
		<TR>
		<TD CLASS="c2" HEIGHT="20">
		<DIV STYLE="padding-left:6px;padding-right:6px">
		<B>Директория "<%=rootPath+folder%>"</B>
		</DIV>
		</TD>
		</TR>
		<TR>
		<TD CLASS="c2" HEIGHT="20">
		<DIV STYLE="padding-left:6px;padding-right:6px">
		<B>Имя поддиректории:</B>
		</DIV>
		</TD>
		</TR>
		<TR>
		<TD CLASS="c1" HEIGHT="20">
		<DIV STYLE="padding-left:6px;padding-right:6px">
		<INPUT TYPE="text" NAME="folderName" STYLE="width:700" SIZE="34" VALUE="">
		</DIV>
		</TD>
		</TR>
		</TABLE>
		<INPUT TYPE="button" VALUE="Сохранить" ONCLICK="if(confirm('Сохранить')){ if (document.FORM3.folderName.value=='') {alert('Укажите имя поддиректории!');}else{document.FORM3.submit();}}">
		</FORM>
		<%
	}
	else
	{
		if  ( mode.equalsIgnoreCase("error") )
		{
			%>
			<B STYLE="color: red;">Произошла ошибка. Попробуйте еще раз.</B><BR>
			<%
			String	res	= request.getParameter( "res" );
			if ( res != null && res.equals( "notEmpty" ) )
			{
			%>
			<B STYLE="color: red;">Возможно директория содержит файлы или поддиректории.</B><BR>
			<%
			}
		}
		if  ( mode.equalsIgnoreCase("isExist") )
		{
			%>
			<B STYLE="color: red;">Файл с таким именем уже существует. Удалите одноименный файл, если вы хотите заменить его на новый.</B><BR><BR>
			<%
		}
		if ( folder.length() > 0 )
		{
			folderPath	+= separator+folder+separator;
		}
%>
<FORM NAME="FORM1" ACTION="xt_upload.jsp" METHOD="post">
<INPUT TYPE="Hidden" NAME="action" VALUE="del_messages">
<INPUT TYPE="Hidden" NAME="folder" VALUE="<%=folder%>">
<%
	showFiles( out, folder, folderPath, rootPath, parentFolder );
%>
<BR><A HREF="upload.jsp?mode=upload&folder=<%=folder%>">загрузить новый файл</A><BR>
</FORM>
<%	} %>
<jsp:include page="/admin/inc/page_finish.jsp" flush="true"/>

