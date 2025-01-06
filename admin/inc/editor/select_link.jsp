<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%!
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

	public String path(WebTreeNode node)
	{
		String res = node.getName();
		while(node.getParent() != null)
		{
			res = node.getParent().getName() + "/" + res;
			node = node.getParent();
		}
		return res;
	}
	
	public void printTree(WebTreeNode node, String link, JspWriter out) throws IOException
	{
		if(node.getPageType().getCode().equals("link"))
			return;
		out.println("<OPTION VALUE=\"" + node.getId() + "\" " + (node.getId().equals(link) ? "SELECTED" : "") +  ">" + path(node) + "</OPTION>");
		Enumeration enum = node.getChilds();
		while(enum.hasMoreElements())
		{
			printTree((WebTreeNode)enum.nextElement(), link, out);
		}
	}
%>


<%
	// параматр mode имеет значения file и page
	// для выбора файла из директории upload или страницы сайта соответственно.

    String langCode = request.getParameter("lang_code");
    if(langCode == null || langCode.trim().length() == 0)
        langCode = CMSApplication.getApplication().getPrimaryLangCode();
    
	boolean selectFile = true;
	if( "page".equals(request.getParameter("mode")))
		selectFile = false;
		
	String mode = request.getParameter("mode");
	
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
<TITLE>Выбор ссылки.</TITLE>

<LINK REL="STYLESHEET" TYPE="text/css" HREF="/admin/css.css">

<SCRIPT LANGUAGE="javascript">
function submitWin()
{
<%
	if(selectFile)
	{
		if(file.length() == 0)
		{
%>
	alert("Файл не выбран");
<%
		} else {
%>
	opener.linkSelected("/upload/<%=(folder.length() > 0 ? folder + "/" : "")%><%=file%>");
	self.close();
<%
		}
	} else {
%>
	if(document.all['link_id'].value == "")
		alert("Не выбрана страница");
	opener.linkSelected("/page.jsp?id=" + document.all['link_id'].value);
	self.close();
<%	} %>
}

function closeWin()
{
	self.close();
}
</SCRIPT>
</HEAD>
<BODY BGCOLOR="#FFFFFF" MARGINHEIGHT=5 MARGINWIDTH=5 LEFTMARGIN=5 TOPMARGIN=5>

<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="5" WIDTH="100%">
<TR>
<TD WIDTH="1%" STYLE="border-bottom: 1 solid #000000;">
<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="1">
</TD>
<TD ALIGN="center" WIDTH="50%" <%=selectFile ? "" : "CLASS=\"c1\""%> STYLE="border-left: 1 solid #000000; border-right: 1 solid #000000; border-top: 1 solid #000000;<%=selectFile ? "" : " border-bottom: 1 solid #000000;"%>">
<%	if(selectFile){ %>
<B>Ссылка на загруженный файл</B>
<%	} else { %>
<A HREF="?mode=file">Ссылка на загруженный файл</A>
<%	} %>
</TD>
<TD WIDTH="1%" STYLE="border-bottom: 1 solid #000000;">
<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="1">
</TD>
<TD ALIGN="center" WIDTH="50%" <%=selectFile ? "CLASS=\"c1\"" : ""%> STYLE="border-left: 1 solid #000000; border-right: 1 solid #000000; border-top: 1 solid #000000; <%=selectFile ? " border-bottom: 1 solid #000000;" : ""%>">
<%	if(!selectFile){ %>
<B>Ссылка на страницу сайта</B>
<%	} else { %>
<A HREF="?mode=page">Ссылка на страницу сайта</A>
<%	} %>
</TD>
<TD WIDTH="1%" STYLE="border-bottom: 1 solid #000000;">
<IMG SRC="/admin/img/blank.gif" WIDTH="1" HEIGHT="1">
</TD>
</TR>
</TABLE>
<BR><BR>
					

<%
	if(selectFile)
	{
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR BGCOLOR="#C0C0C0">
<TD HEIGHT="20" COLSPAN="2" CLASS="titnew" ALIGN="center"><DIV STYLE="padding-left:6px;padding-right:6px" CLASS="titnew"><B>
Директория "<%=rootPath + folder%>"
</B></DIV></TD>
</TR>
<TR>
<TD WIDTH="1%" VALIGN="bottom">
<DIV STYLE="padding-left:20px;padding-right:20px">
<%	if(file.length() > 0)
	{
%>
<B>Файл:</B><BR>
/upload/<%=(folder.length() > 0 ? folder + "/" : "")%><%= file %>
<%	} else { %>
<B>Файл не выбран.</B><BR>
<%	} %>
</DIV>
<BR>
</TD>

<TD WIDTH="100%" VALIGN="top">
	<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<%	if(folder.length() > 0)
	{
%>
	<TR CLASS="c2">
	<TD WIDTH="1%"><IMG SRC="/admin/img/editor/file_dir.gif" WIDTH="12" HEIGHT="11"></TD>
	<TD WIDTH="100%"><DIV STYLE="padding-left:6px;padding-right:6px"><A HREF="select_link.jsp?mode=file&folder=<%=parentFolder%>">../</A></DIV></TD>
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
			pix = "file.gif";
			href = "folder=" + folder + "&file=" + files[i].getName();
		}
%>
	<TR CLASS="c2">
	<TD WIDTH="1%"><IMG SRC="/admin/img/editor/<%=pix%>" WIDTH="12" HEIGHT="11"></TD>
	<TD WIDTH="100%"><DIV STYLE="padding-left:6px;padding-right:6px"><A HREF="select_link.jsp?mode=file&<%=href%>"><%=files[i].getName()%></A></DIV></TD>
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
	<A HREF="javascript:submitWin();">Вставить ссылку</A>
	</TD>
	<TD WIDTH="50%" ALIGN="center">
	<A HREF="#" onClick="closeWin();">Закрыть окно</A>
	</TD>
	</TR>
	</TABLE>
</TD>
</TR>
</TABLE>


<%	}
	else
	{
%>
<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
<TR BGCOLOR="#C0C0C0">
<TD HEIGHT="20" CLASS="titnew" ALIGN="center"><DIV STYLE="padding-left:6px;padding-right:6px" CLASS="titnew"><B>
Ссылка на страницу
</B></DIV></TD>
</TR>

<TR>
<TD ALIGN="center">
<SELECT STYLE="width: 620" SIZE="20" MULTIPLE ID="link_id">
<%
	WebTreeNode rootNode = CMSApplication.getApplication().getWebRoot(langCode);
	printTree(rootNode, rootNode.getId(), out);
%>
</SELECT>
</TD>
</TR>


<TR>
<TD>
	<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1" WIDTH="100%">
	<TR CLASS="c2">
	<TD WIDTH="50%" ALIGN="center">
	<A HREF="javascript:submitWin();">Вставить ссылку</A>
	</TD>
	<TD WIDTH="50%" ALIGN="center">
	<A HREF="#" onClick="closeWin();">Закрыть окно</A>
	</TD>
	</TR>
	</TABLE>
</TD>
</TR>
</TABLE>

<%	} %>
</BODY>
</HTML>