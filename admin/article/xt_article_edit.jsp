<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Article.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String node = request.getParameter( "page_id" );
	String id = request.getParameter( "id" );

	int pageAccess = currentAdmin.getAccessCode( node );
	String mode = null;
	if(id == null || id.length() == 0)
		mode = "add";
	else
		mode = "edit";
	
	boolean visible = "1".equals(request .getParameter("visible"));
	String caption = request.getParameter("caption");
	String brief = request.getParameter("brief");
	String content = request.getParameter("content");
	String recordDate = request.getParameter("recorddate");
	
	String author	= request.getParameter("author");
	String publisher = request.getParameter("publisher");
	String aShort		= request.getParameter("short");
	String puburl	= request.getParameter("puburl");
	String ref		= request.getParameter("ref");
	String web		= request.getParameter("webpages");
	
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy"); 

	String redirect = null;
if(mode != null && mode.equals("add"))
{
	Article article = new Article();
	try
	{
		if( !Admin.isC(pageAccessCode) || (visible && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "articles.jsp?&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		boolean modified = true;
		boolean changePubl = false;
		
		
		article.setWebPageId(node);
		article.setRecordDate( sdf.parse( recordDate ) );

		article.setCaption( caption );
		article.setBrief( brief );
		article.setContent( content );
		article.setVisible( visible );
		
		article.setAuthor(author);
		article.setPublisher(publisher);
		article.setAnnounce(aShort);
		article.setPublisherurl(puburl);
		article.setExtrainfourl(ref);
		article.setWebpagesurl(web);

		article.save();

		try{ Journal.newRecord( currentAdmin, article, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		if(visible)
			try{ Journal.newRecord( currentAdmin, article, pageId, Journal.ACTION_PUBLIC, "" ).save(); 
			}catch( Exception e ){}

		redirect	= "article_list.jsp?action_done=add&page_id=" + node;
	}catch(Exception e)
	{
		article.remove();
		response.sendRedirect( "article_list.jsp?page_id=" + node + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if( mode != null && mode.equals( "edit" ) )
{
	Article article = new Article();
	try
	{
		article.load(id);
		
		boolean modif = true;
		boolean publ = visible;
		boolean chPubl = (article.isVisible() != visible);
		
		if(	article.getWebPageId().equals(node) &&
			sdf.format(article.getRecordDate()).equals(recordDate) &&
			article.getCaption().equals(caption) &&
			article.getBrief().equals(brief) &&
			article.getContent().equals(content) &&
			article.getAuthor().equals(author) &&
			article.getPublisher().equals(publisher) &&
			article.getAnnounce().equals(aShort) &&
			article.getPublisherurl().equals(puburl) &&
			article.getExtrainfourl().equals(ref) &&
			article.getWebpagesurl().equals(web))
				modif = false;

		if( (( modif ) && !Admin.isW(pageAccessCode)) ||
			( chPubl && ! Admin.isP( pageAccessCode )) ||
			( modif && publ && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "articles.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		article.setRecordDate( sdf.parse( recordDate ) );
		article.setWebPageId( node );

		article.setCaption( caption);
		article.setBrief( brief);
		article.setContent( content );
		article.setVisible( visible);

		article.setAuthor(author);
		article.setPublisher(publisher);
		article.setAnnounce(aShort);
		article.setPublisherurl(puburl);
		article.setExtrainfourl(ref);
		article.setWebpagesurl(web);

		article.save();

		if( modif)
			try{ Journal.newRecord( currentAdmin, article, node, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( (publ) && chPubl )
			try{ Journal.newRecord( currentAdmin, article, node, Journal.ACTION_PUBLIC, "").save();
			}catch( Exception e ){}
		if( !publ && chPubl )
				try{ Journal.newRecord( currentAdmin, article, node, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}

		redirect	=  "article_list.jsp?action_done=save&page_id=" + node;
	}catch(Exception e)
	{
		response.sendRedirect( "articles.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

if( redirect == null ) 
	redirect = "/admin/article/article_list.jsp?page_id=" + node;

 response.sendRedirect( redirect );

%>
