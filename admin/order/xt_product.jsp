<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Product.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>


<%

String mode = request.getParameter( "mode" );

String prodId	= request.getParameter( "prodId" );	// id товара

String typerus	= request.getParameter( "typerus" );
String typeeng	= request.getParameter( "typeeng" );

String markrus	= request.getParameter( "markrus" );
String markeng	= request.getParameter( "markeng" );

String shiprus	= request.getParameter( "shiprus" );
String shipeng	= request.getParameter( "shipeng" );
boolean isvisible = request.getParameter( "isVisible" )!=null;

String href = "product.jsp";
String error = "";

Product product	= new Product();

try
{
	if( prodId != null && !prodId.equals("") )
			product.load( prodId );
	
	if( mode != null && mode.equals("delete") )
	{
		try
		{
			if( ! Admin.isC( pageAccessCode ))
			{
				response.sendRedirect( "product.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			Journal rec = Journal.newRecord( currentAdmin, product, pageId, Journal.ACTION_DELETE, "" );
			product.remove();
			try{ rec.save(); }catch( Exception e ){}
			
		}
		catch( Exception e )
		{
			response.sendRedirect( "product.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
			return;
		}
	}
	else
	{
		error = "?error=on_update";
		
		boolean modified = true;
		boolean changePubl = false;
		boolean isNew = product.getId() == null;
		if( ! isNew &&
			product.getTypeRus().equals( typerus ) &&
			product.getTypeEng().equals( typeeng ) &&
			product.getMarkRus().equals( markrus==null? "" : markrus ) &&
			product.getMarkEng().equals( markeng==null? "" : markeng ) &&
			product.getDeliveryRus().equals( shiprus==null? "" : shiprus ) &&
			product.getDeliveryEng().equals( shipeng==null? "" : shipeng )) modified = false;
		
		if( product.isVisible() != isvisible ) changePubl = true;
		
		if( ( isNew && ! Admin.isC( pageAccessCode )) ||
			( !isNew && modified && ! Admin.isW( pageAccessCode )) ||
			( ! isNew && changePubl && ! Admin.isP( pageAccessCode )) ||
			( isvisible && modified && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "product.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
	
		if( modified )
		{
			product.setTypeRus( typerus );
			product.setTypeEng( typeeng );
		
			product.setMarkRus( markrus==null? "" : markrus );
			product.setMarkEng( markeng==null? "" : markeng );
		
			product.setDeliveryRus( shiprus==null? "" : shiprus );
			product.setDeliveryEng( shipeng==null? "" : shipeng );
		}
		if( changePubl )
			product.setVisible( isvisible );
		if( changePubl || modified )
			product.save();
			
		if( isNew )
			try{ Journal.newRecord( currentAdmin, product, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		if( ! isNew && modified )
			try{ Journal.newRecord( currentAdmin, product, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if(( isNew && isvisible ) || ( changePubl && isvisible ))
			try{ Journal.newRecord( currentAdmin, product, pageId, Journal.ACTION_PUBLIC, "" ).save(); }catch( Exception e ){}
		if( !isNew && changePubl && ! isvisible )
			try{ Journal.newRecord( currentAdmin, product, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}
	}
}
catch( Exception e )
{
	response.sendRedirect( "product.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
	return;
}

response.sendRedirect( href );
%>