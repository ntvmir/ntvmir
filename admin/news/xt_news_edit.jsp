<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = News.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String node = request.getParameter( "page_id" );
	String id = request.getParameter( "id" );


//	tengry.northgas.HomePage hp = tengry.northgas.HomePage.getHomePage();
//	boolean clearHPNews = (node != null && node.equals(hp.getNewsNodeId()));


	int pageAccess = currentAdmin.getAccessCode( node );
	String mode = null;
	if(id == null || id.length() == 0)
		mode = "add";
	else
		mode = "edit";
	
	boolean visible = "1".equals(request .getParameter("visible"));
	String caption = request.getParameter("caption");
	String source = request.getParameter("source");
	
	String brief = request.getParameter("brief");
	String content = request.getParameter("content");
	String recordDate = request.getParameter("recorddate");
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy"); 

	String redirect = null;
if(mode != null && mode.equals("add"))
{
	News news = new News();
	try
	{
		if( !Admin.isC(pageAccessCode) || (visible && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "news.jsp?&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		boolean modified = true;
		boolean changePubl = false;
		
		
		news.setWebPageId(node);
		news.setRecordDate( sdf.parse( recordDate ) );

		news.setCaption( caption );
		news.setSource( source );
		news.setBrief( brief );
		news.setContent( content );
		news.setVisible( visible );

		news.save();

		if(visible)
			try{ 
			    Journal.newRecord( currentAdmin, news, pageId, Journal.ACTION_PUBLIC, "публикация на сайте").save(); 
			}catch( Exception e ){}
		try{ Journal.newRecord( currentAdmin, news, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		
		// invalidate cached values
/*
		if(clearHPNews)
			hp.clearNewsBlock();
*/

		redirect	= "news_list.jsp?action_done=add&page_id=" + node;
	}catch(Exception e)
	{
		news.remove();
		response.sendRedirect( "news_list.jsp?page_id=" + node + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if( mode != null && mode.equals( "edit" ) )
{
	News news = new News();
	try
	{
		news.load(id);
		
		boolean modif = true;
		boolean publ = visible;
		boolean chPubl = (news.isVisible() != visible);
		
		if(	news.getWebPageId().equals(node) &&
			sdf.format(news.getRecordDate()).equals(recordDate) &&
			news.getCaption().equals(caption) &&
			news.getBrief().equals(brief) &&
			news.getContent().equals(content) &&
			news.getSource().equals(source)) 
			    modif = false;

		if( ( modif && !Admin.isW(pageAccessCode)) ||
			( chPubl && ! Admin.isP( pageAccessCode )) ||
			( modif && publ && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "news.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		
		news.setRecordDate( sdf.parse( recordDate ) );
		news.setWebPageId( node );

		news.setCaption( caption);
		news.setSource( source);
		news.setBrief( brief);
		news.setContent( content );
		news.setVisible( visible );

		news.save();
		
		if( modif )
			try{ Journal.newRecord( currentAdmin, news, node, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( publ && chPubl )
			try{ Journal.newRecord( currentAdmin, news, node, Journal.ACTION_PUBLIC, "публикация на сайте" ).save();
			}catch( Exception e ){}
		if( !publ && chPubl )
				try{ Journal.newRecord( currentAdmin, news, node, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}

		// invalidate cached values
/*
		if(clearHPNews)
			hp.clearNewsBlock();
*/
		redirect	=  "news_list.jsp?action_done=save&page_id=" + node;
	}catch(Exception e)
	{
		response.sendRedirect( "news.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

if( redirect == null ) 
	redirect = "/admin/news/news_list.jsp?page_id=" + node;
response.sendRedirect( redirect );

%>
