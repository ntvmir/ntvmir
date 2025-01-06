<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Article.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
String node = request.getParameter( "page_id" );
String mode = request.getParameter( "mode" );
String href = "articles.jsp";


if( mode != null && mode.equals( "del" ) )
{
	int nodeAccessCode = currentAdmin.getAccessCode(node);
	if(!currentAdmin.isC(node))
	{
		response.sendRedirect("article_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
	}
	try
	{
		String [] articlesCol = request .getParameterValues("articles");
		if ( articlesCol != null )
		{
			for (int i=0; i < articlesCol.length ;i++)
			{
				Article article	= new Article(DBObject.LOAD_LIST);
				article.load(articlesCol[i]);
				if((article.isVisible()) && ! Admin.isP( nodeAccessCode ))
				{
					response.sendRedirect( "article_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
//					clearFrontEntries();
					return;
				}
				
				Journal rec = Journal.newRecord( currentAdmin, article, pageId, Journal.ACTION_DELETE, "" );
				article.remove();
				try{ rec.save(); }catch( Exception e ){}
			}
//			clearFrontEntries();
		}
		href	=  "article_list.jsp?action_done=del&page_id=" + node;
	}catch(Exception e)
	{
		response.sendRedirect( "article_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
		return;
	}
}



else if("set_num".equals(mode))
{
	int n = -1;
	try{ n = Integer.parseInt(request .getParameter("press_num")); }catch(Exception e){}
	if(n > 0)
		Article.setPagePressAmount(n);
	href = "articles.jsp";
}
response.sendRedirect( href );
%>

