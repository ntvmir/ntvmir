<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = FaqCategory.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String nodeId = request.getParameter( "page_id" );
	String id = request.getParameter( "id" );

	String mode = null;
	if(id == null || id.length() == 0)
		mode = "add";
	else
		mode = "edit";
	
	boolean visible = "1".equals(request .getParameter("visible"));
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");

	String redirect = null;
if(mode != null && mode.equals("add"))
{
	FaqCategory fqc = new FaqCategory();
	try
	{
		if( !Admin.isC(pageAccessCode) || (visible && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "faq.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		boolean modified = true;
		boolean changePubl = false;
		
		
		fqc.setWebPageId(nodeId);

		fqc.setName( name );
		fqc.setDescription( descr );
		fqc.setVisible( visible );

		fqc.save();

		try{ Journal.newRecord( currentAdmin, fqc, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		if(visible)
			try{ Journal.newRecord( currentAdmin, fqc, pageId, Journal.ACTION_PUBLIC, "").save(); }catch( Exception e ){}
		
		redirect	= "faq.jsp?action_done=add";
	}catch(Exception e)
	{
		fqc.remove();
		response.sendRedirect( "faq.jsp?&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if( mode != null && mode.equals( "edit" ) )
{
	FaqCategory fqc = new FaqCategory();
	try
	{
		fqc.load(id);
		nodeId = fqc.getWebPageId();
		
		boolean modif = true;
		boolean publ = visible;
		boolean chPubl = (fqc.isVisible() != visible);
		
		if(	fqc.getName().equals(name) &&
			fqc.getDescription().equals(descr)) modif= false;

		if( (( modif) && !Admin.isW(pageAccessCode)) ||
			( chPubl && ! Admin.isP( pageAccessCode )) ||
			( modif && publ && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "faq.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		
		fqc.setName( name);
		fqc.setDescription( descr);

		fqc.setVisible( visible );

		fqc.save();
		
		if( modif )
			try{ Journal.newRecord( currentAdmin, fqc, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( (publ) && chPubl )
			try{ Journal.newRecord( currentAdmin, fqc, pageId, Journal.ACTION_PUBLIC, "" ).save();
			}catch( Exception e ){}
		if( !publ && chPubl )
				try{ Journal.newRecord( currentAdmin, fqc, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}

		redirect	=  "faq.jsp?action_done=save";
	}catch(Exception e)
	{
		response.sendRedirect( "faq.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

if( redirect == null ) 
	redirect = "/admin/faq/faq.jsp?";
response.sendRedirect( redirect );

%>
