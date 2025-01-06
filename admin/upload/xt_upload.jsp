<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%@page import="tengry.servlet.MultipartRequest"%>
<%
	// set the Service name for authorization
	String pageId = "upload";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%

String	separator	= File.separator;

String	folderPath	= CMSApplication.getApplication().getProperty( "upload.dir" )+separator;

// определим все полученные параметры
String action = request.getParameter( "action" );
String folder		= request.getParameter("folder");
if ( folder == null ) folder = "";
if ( folder.length() > 0 )
{
	folderPath	+= folder+separator;
}

String	href	= "upload.jsp?mode=error&folder="+folder;
// инициируем событие определенного типа

// обрабатываем событие и отображаем подходящее представление
if( action != null && action.equals( "upload" ) )
{
	if( ! Admin.isC( pageAccessCode ))
	{
		response.sendRedirect( "upload.jsp?folder="+folder + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	try
	{
		MultipartRequest multi =  new MultipartRequest( request, folderPath, 5*1024*1024, false, false );
		java.io.File uploadedFile = multi.getFile( "file" );
		String fileName	= multi.getOriginName( "file" );
		if( uploadedFile != null && uploadedFile.length() > 0 )
		{
			uploadedFile.createNewFile();
			try{ Journal.newRecord( currentAdmin, new FileObject(uploadedFile), pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
			href	= "upload.jsp?folder="+folder + "&action_done=upload";
		}
		else
		{
			href	= "upload.jsp?mode=error&folder="+folder;
		}
	}catch( Exception e )
	{
		href	= "upload.jsp?mode=error&folder="+folder;
	}
}
else if( action != null && action.equals( "edit" ) )
{
	String fileName	= request.getParameter( "fileName" );
	String oldName	= request.getParameter( "oldName" );
	if ( oldName != null && !oldName.equals( fileName ) )
	{
		try
		{
			File	file	= new File( folderPath+oldName );
			if ( file.exists() )
			{
				fileName = fileName.trim();
				File	newFile	= new File( folderPath+fileName );
				if ( !newFile.exists() )
				{
					if( ! Admin.isW( pageAccessCode ))
					{
						response.sendRedirect( "upload.jsp?folder="+folder + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
						return;
					}
					Journal rec = Journal.newRecord( currentAdmin, new FileObject(file), pageId, Journal.ACTION_MODIFY, "переименован в \"" + fileName + "\"" );
					file.renameTo( newFile );
					try{ rec.save(); }catch( Exception e ){}
					href	= "upload.jsp?folder="+folder + "&action_done=edit";
				}
				else
				{
					href	= "upload.jsp?mode=isExist&folder="+folder;
				}
			}
			else
			{
				href	= "upload.jsp?mode=error&folder="+folder;
			}
		}catch( Exception e )
		{
			href	= "upload.jsp?mode=error&folder="+folder;
		}
	}
	else
	{
		href	= "upload.jsp?folder="+folder;
	}
}
else if( action != null && action.equals( "add_folder" ) )
{
	String folderName	= request.getParameter( "folderName" );
	try
	{
		if( ! Admin.isC( pageAccessCode ))
		{
			response.sendRedirect( "upload.jsp?folder="+folder + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		File	file	= new File( folderPath, folderName );
		if ( file.mkdir() )
		{
			try{ Journal.newRecord( currentAdmin, new FileObject(file), pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
			href	= "upload.jsp?folder="+folder + "&action_done=new_folder";
		}
		else href	= "upload.jsp?mode=error&folder="+folder;
	}catch( Exception e )
	{
		href	= "upload.jsp?mode=error&folder="+folder;
	}
}
else if( action != null && action.equals( "delete" ) )
{
	String fileName	= request.getParameter( "fileName" );
	try
	{
		if( ! Admin.isC( pageAccessCode ))
		{
			response.sendRedirect( "upload.jsp?folder="+folder + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		
		File	file	= new File( folderPath+fileName );
		Journal rec = Journal.newRecord( currentAdmin, new FileObject(file), pageId, Journal.ACTION_DELETE, "" );
		boolean isDir = file.isDirectory();
		file.delete();
		if ( file.exists() )
		{
			if ( file.isDirectory() )
			{
				href	= "upload.jsp?mode=error&folder="+folder+"&res=notEmpty";
			}
			else
			{
				href	= "upload.jsp?mode=error&folder="+folder;
			}
		}
		else
		{
			try{ rec.save(); }catch( Exception e ){}
			href	= "upload.jsp?folder="+folder + "&action_done=" + (isDir ? "dir_" : "file_") + "del";
		}
	}catch( Exception e )
	{
		href	= "upload.jsp?mode=error&folder="+folder;
	}
}
else
{
	// не найдено подходящее событие
	href	= "upload.jsp";
}

response.sendRedirect( href );
%>