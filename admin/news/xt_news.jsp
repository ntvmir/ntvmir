<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = News.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
String node = request.getParameter( "page_id" );
String mode = request.getParameter( "mode" );
String href = "news.jsp";

//tengry.northgas.HomePage hp = tengry.northgas.HomePage.getHomePage();
//boolean clearHPNews = (node != null && node.equals(hp.getNewsNodeId()));

if( mode != null && mode.equals( "del" ) )
{
	int nodeAccessCode = currentAdmin.getAccessCode(node);
	if(!currentAdmin.isC(node))
	{
		response.sendRedirect("news_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
	}
	try
	{
		String [] newsCol = request .getParameterValues("news");
		if ( newsCol != null )
		{
			for (int i=0; i < newsCol.length ;i++)
			{
				News news	= new News(DBObject.LOAD_LIST);
				news.load(newsCol[i]);
				if((news.isVisible()) && ! Admin.isP( nodeAccessCode ))
				{
					response.sendRedirect( "news_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS);
					
					//if(clearHPNews)
					//	hp.clearNewsBlock();
					return;
				}
				
				Journal rec = Journal.newRecord( currentAdmin, news, pageId, Journal.ACTION_DELETE, "" );
				news.remove();
				try{ rec.save(); }catch( Exception e ){}
			}
			//if(clearHPNews)
			//	hp.clearNewsBlock();
		}
		href	=  "news_list.jsp?action_done=del&page_id=" + node;
	}catch(Exception e)
	{
		response.sendRedirect( "news_list.jsp?page_id=" + node+ "&err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
		return;
	}
}


else if("set_num".equals(mode))
{
	int n = -1;
	try{ n = Integer.parseInt(request .getParameter("press_num")); }catch(Exception e){}
	if(n > 0)
		News.setPagePressAmount(n);
	href = "news.jsp";
}
response.sendRedirect( href );
%>



