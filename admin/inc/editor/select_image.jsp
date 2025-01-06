<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*" %>
<%@ page import="tengry.cms.*"%>

<%!
	public static final String [] TYPES = new String [] {"gif", "jpg"};
	public static final int W = 150;
	public static final int H = 200;

	public int cmp(File f1, File f2)
	{
		if(f1.isDirectory() != f2.isDirectory())
			return f2.isDirectory() ? -1 : 1;
		return f2.getName().compareTo(f1.getName());
	}
	
	public void orderList(File [] list)
	{
		for(int i = 0; list != null && i < list.length - 1; i++)
		{
			int pMin = i;
			for(int j = i + 1; j < list.length; j++)
			{
				if(cmp(list[pMin], list[j]) < 0)
					pMin = j;
			}
			if(i != pMin)
			{
				File f = list[pMin];
				list[pMin] = list[i];
				list[i] = f;
			}
		}
	}
%>


<%
	String	rootPath	= request.getServerName() + File.separator + "upload" + File.separator;
	
	String	folder = request.getParameter( "folder" );
	if ( folder == null ) folder	= "";

	String	uploadDir	= CMSApplication.getApplication().getProperty( "upload.dir" );
	if( ! uploadDir.endsWith(File.separator))
		uploadDir += File.separator;
	
	String	parentFolder	= "";
	
	int index	= folder.lastIndexOf( File.separator.charAt( 0 ) );
	if ( index != -1 )	parentFolder = folder.substring( 0, index );

	String file = request.getParameter("file");
	if(file == null)
		file = "";
%>

<HTML>
<HEAD>
<META HTTP-EQUIV=Content-type CONTENT="text/html; charset=windows-1251">
<META HTTP-EQUIV=Content-language CONTENT=RU>
<META NAME=description CONTENT="">
<META NAME=keywords CONTENT="">
<META NAME=autor CONTENT="">
<TITLE>Выбор изображения.</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">
<%
	if(file.length() > 0)
	{
%>
<SCRIPT LANGUAGE="javascript">
	var img = new Image();
	img.src = "/upload/<%=folder%>/<%=file%>";
</SCRIPT>
<%	} %>

<SCRIPT LANGUAGE="javascript">
function submitWin()
{
<%
	if(file.length() == 0)
	{
%>
	alert("Изображение не выбрано");
<%
	} else {
%>

	opener.imageSelected("/upload/<%=folder%>/<%=file%>", 
		document.all['img_w'].value, 
		document.all['img_h'].value,
		document.all['img_alt'].value
		);
	self.close();
<%	} %>
}

function closeWin()
{
	self.close();
}
</SCRIPT>
</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5
<%
	if(file.length() > 0)
	{
%>onload="gogo();"<%	} %>>
	
<%
	if(file.length() > 0)
	{
%>
<SCRIPT>
function gogo()
{
	var w = img.width;
	var h = img.height;
	if(w > 0 && h > 0)
	{
		document.all['img_w'].value = w;
		document.all['img_h'].value = h;
		
		var k = 1;
		if(w > <%=W%> || h > <%=H%>)
		{
			if(h / <%=H%>  >  w / <%=W%>)
				k = h / <%=H%>;
			else
				k = w / <%=W%>;
		}
		document.all['imgimg'].width = w / k;
		document.all['imgimg'].height = h / k;
		document.all['imgimg'].border=0;
		document.all['imgimg'].src = "/upload/<%=folder%>/<%=file%>";
	}
}
</SCRIPT>
<%	} %>



					

<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR BGCOLOR="#C0C0C0">
<TD HEIGHT="20" COLSPAN="2" CLASS="titnew" ALIGN="center"><DIV STYLE="padding-left:6px;padding-right:6px" CLASS="titnew"><B>
Директория "<%=rootPath + folder%>"
</B></DIV></TD>
</TR>
<TR>
<%
	String pic = "/admin/img/blank.gif";
	if(file.length() > 0)
	{
		pic = "/upload/";
		if(folder.length() > 0)
			pic += folder + "/";
		pic += file;
	}
%>
<TD WIDTH="<%=W + 20%>" VALIGN="bottom">
	<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="<%=W + 20%>">
	<TR>
	<TD COLSPAN="2" ALIGN="center">
	<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="20"><br>
	<IMG SRC="<%=pic%>" ID="imgimg" BORDER="1"	WIDTH="<%=W%>" HEIGHT="<%=H%>"><BR>
	<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="20">
	</TD>
	</TR>
	<TR>
	<TD><DIV STYLE="padding-left:6px;padding-right:6px">ширина:</DIV></TD>
	<TD><DIV STYLE="padding-left:6px;padding-right:6px"><INPUT ID="img_w"></DIV></TD>
	</TR>
	<TR>
	<TD><DIV STYLE="padding-left:6px;padding-right:6px">высота:</DIV></TD>
	<TD><DIV STYLE="padding-left:6px;padding-right:6px"><INPUT ID="img_h"></DIV></TD>
	</TR>
	<TR>
	<TD><DIV STYLE="padding-left:6px;padding-right:6px">текст:</DIV></TD>
	<TD><DIV STYLE="padding-left:6px;padding-right:6px"><INPUT ID="img_alt"></DIV></TD>
	</TR>
	</TABLE>
</TD>
<TD WIDTH="100%" VALIGN="top">
	<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<%	if(folder.length() > 0)
	{
%>
	<TR CLASS="c2">
	<TD WIDTH="1%"><IMG SRC="/admin/img/editor/file_dir.gif" WIDTH="12" HEIGHT="11"></TD>
	<TD WIDTH="100%"><DIV STYLE="padding-left:6px;padding-right:6px"><A HREF="select_image.jsp?folder=<%=parentFolder%>">../</A></DIV></TD>
	<TD WIDTH="1%" ALIGN="right"><DIV STYLE="padding-left:6px;padding-right:6px">&nbsp;</DIV></TD>
<%
	}
	
	File	dir	= new File(uploadDir + folder);
	File[]	files	= dir.listFiles();

	orderList(files);
	
	for(int i=0; files != null && i < files.length; i++)
	{
		String pix = "";
		String href = "";
		if(files[i].isDirectory())
		{
			pix  = "file_dir.gif";
			href = "folder=" + (folder.length() > 0 ? (folder + File.separator) : "") + files[i].getName();
		}
		else
		{
			String fName = files[i].getName().toLowerCase();
			int k;
			for(k = 0; k < TYPES.length; k++)
			{
				if(fName.endsWith(TYPES[k]))
					break;
			}
			if(k == TYPES.length)
				continue;
			pix = "file_" + TYPES[k] + ".gif";
			href = "folder=" + folder + "&file=" + files[i].getName();
		}
%>
	<TR CLASS="c2">
	<TD WIDTH="1%"><IMG SRC="/admin/img/editor/<%=pix%>" WIDTH="12" HEIGHT="11"></TD>
	<TD WIDTH="100%"><DIV STYLE="padding-left:6px;padding-right:6px"><A HREF="select_image.jsp?<%=href%>"><%=files[i].getName()%></A></DIV></TD>
	<TD WIDTH="1%" ALIGN="right"><DIV STYLE="padding-left:6px;padding-right:6px"><%=files[i].length()%></DIV></TD>
	</TR>
<%
	}
%>
	</TABLE>
</TD>
</TR>
<TR>
<TD COLSPAN="2">
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR CLASS="c2">
<TD WIDTH="50%" ALIGN="center">
<A HREF="javascript:submitWin();">Выбрать изображение</A>
</TD>
<TD WIDTH="50%" ALIGN="center">
<A HREF="#" onClick="closeWin();">Закрыть окно</A>
</TD>
</TR>
</TABLE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>