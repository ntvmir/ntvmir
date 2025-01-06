<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<% String pageId = "tree"; %>
<%@ include file="/admin/inc/page_init.jsp"%>
<%@ include file="/admin/inc/functions/is_page_private.jsp"%>
<%
// определим все полученные параметры
String mode = request.getParameter( "mode" );
String node	 = request.getParameter( "node" );
String redirect = null;
String error = "";

WebTreeNode webPage = null;
if(node != null && node.length() > 0)
    webPage = (WebTreeNode)CMSApplication.getApplication().lookup(node);

int pageAccess = currentAdmin.getAccessCode(node);

String section = null; // им€ секции (используетс€ дл€ поиска)

if(mode != null && mode.equals("add"))
{
	String type = request.getParameter("page_type");
	boolean visible = "1".equals(request.getParameter("visible"));
	boolean isPrivate = "1".equals(request.getParameter("private"));
	String name = request.getParameter("name");
	String code = request.getParameter("code");
	String linkId =  request.getParameter("link_id");
	if(linkId != null)
		type = "link";
	PageType pageType = CMSApplication.getApplication().getPageTypeByCode(type);

	if(pageType==null || webPage == null)
		response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
	
	if(!Admin.isC(pageAccess) || (visible && !Admin.isP(pageAccess)))
	{
		response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	WebTreeNode wp = new WebTreeNode();
	wp.setLinkId(linkId);
	wp.setParent(webPage);
	wp.setPageType(pageType);
	wp.setName(name);
	wp.setCode(code);
	wp.setVisible( visible );
	try
	{
		wp.save();
		if(isPrivate)
		{
			Group gr = CMSApplication.getApplication().getGroupByName("private");
			if(gr != null)
			{
				gr.setAccessCode(wp.getId(), Group.ACCESS_READ);
				gr.saveAccessCodes();
			}
		}
		else
		{
			Group gr = CMSApplication.getApplication().getGroupByName("default");
			if(gr != null)
			{
				gr.setAccessCode(wp.getId(), Group.ACCESS_READ);
				gr.saveAccessCodes();
			}
		}
	}
	catch(Exception we)
	{
		response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
	if("static".equals(pageType.getCode()))
	{
		StaticPage sc = new StaticPage();
		String str = request.getParameter( "content_0" );
		str = str == null ? "" : str;
		sc.setContent( str );
		sc.setWebPageId(wp.getId());
		sc.setOrderNumber(1);
		
		try
		{
			sc.save();
		}
		catch(Exception we )
		{
			response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
			return;
		}
	}
	/* дадим админу права на новую страницу, такие же как и у родительской */
	try{
		currentAdmin.setAccessCode( wp.getId(), pageAccess );
		currentAdmin.saveAccessCodes();	
	}catch(Exception e){}


	// запись в журнал.
	try{
		Journal.newRecord( currentAdmin, wp, pageId, Journal.ACTION_CREATE, "ѕодстраница дл€ \"" + 
			webPage.getName() + " (" + webPage.getCode() + ")" + "\"" ).save();
		if( visible )
			Journal.newRecord( currentAdmin, wp, pageId, Journal.ACTION_PUBLIC, "" ).save();
	}catch(Exception e){}
	response.sendRedirect("tree.jsp?action_done=1");
	return;
}





else if( mode != null && mode.equals( "edit" ) )
{
//
//	–едактирование статической
//
	String backOnSavingError;
	if("static".equals(request.getParameter("page_type")))
		backOnSavingError = "page_edit.jsp";
	else
		backOnSavingError = "custom_page_edit.jsp";
	boolean visible = "1".equals(request.getParameter( "visible" ));
	boolean isPrivate = "1".equals(request.getParameter( "private" ));
	String name = request.getParameter( "name" );
	if( name == null ) name = "";
	String code = request.getParameter( "code" );
	if( code == null ) code = "";
	
	String linkId =  request.getParameter("link_id");

	// провер€ем на наличие каких-либо изменений (в имени, в содержании..)
	boolean modified = false;

	int num;
	try{ num = Integer.parseInt( request.getParameter( "frame_num" )); }catch( Exception e ){ num = -1; }

    // нельз€ мен€ть код на первых двух уровн€х
    if(!webPage.getCode().equals(code) && (webPage.getParent() == null || webPage.getParent().getParent() == null))
    {
        response.sendRedirect(backOnSavingError + "?mode=edit&page_id=" + webPage.getId() + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}

	Vector content = null;
	if(linkId != null && ! linkId.equals(webPage.getLinkId()))
		modified = true;

	if(!name.equals( webPage.getName()) || !code.equals( webPage.getCode()))
	{ 
		modified = true;
	}
	else
	{
		if(webPage.getPageType().getCode().equals("static"))
		{
			content = StaticPage.getStaticPages(webPage.getId());
			if( content == null ) content = new Vector();
			if( content.size() != num )
			{
				modified = true;
			}
			else
			{
				int i = 0;
				for( i = 0; i < content.size(); i ++ )
				{
					StaticPage sc = (StaticPage) content.elementAt(i);
					String str;		
					str = request.getParameter( "content_" + i );
					if( str == null ) str = "";
					if(!str.equals(sc.getContent()))
					{
						modified = true;
						break;
					}
				}
			}
		}
	}

	boolean changePubl = (webPage.isVisible() != visible);
	boolean changePriv = isPagePrivate(webPage.getId()) != isPrivate;

	// проверка прав админа на изменение и публикацию
	if( ( modified && !Admin.isW( pageAccess )) ||
		( changePubl && !Admin.isP( pageAccess )) ||
		( changePriv && !Admin.isP( pageAccess )) ||
		( modified && visible && !Admin.isP( pageAccess )))
	{
		response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}

	webPage.setLinkId( linkId );
	webPage.setName( name );
	webPage.setCode( code );
	webPage.setVisible( visible );

	try
	{
		// сохран€ем данные
		webPage.save();
		if(changePriv)
		{
			Group gr = CMSApplication.getApplication().getGroupByName("private");
			if(gr != null)
			{
				gr.setAccessCode(webPage.getId(), isPrivate ? Group.ACCESS_READ : 0);
				gr.saveAccessCodes();
			}
			gr = CMSApplication.getApplication().getGroupByName("default");
			if(gr != null)
			{
				gr.setAccessCode(webPage.getId(), isPrivate ? 0 : Group.ACCESS_READ);
				gr.saveAccessCodes();
			}
		}
	}
	catch(Exception we)
	{
		response.sendRedirect(backOnSavingError + "?mode=edit&page_id=" + webPage.getId() + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}

	if(webPage.getPageType().getCode().equals( "static" ) && modified )
	{
		if( content == null )
			content = StaticPage.getStaticPages(webPage.getId());
		if( content == null ) 
			content = new Vector();
		int i = 0;
		for( i = 0; i < num; i ++ ){
			StaticPage sc;
			if(i < content.size()) 
				sc = (StaticPage) content.elementAt(i);
			else 
				sc = new StaticPage();
			try
			{
				String str;
				sc.setWebPageId(webPage.getId());
				sc.setOrderNumber( i );
				str = request.getParameter( "content_" + i );
				str = str == null ? "" : str;
				sc.setContent( str );
				sc.save();
			}
			catch(Exception we)
			{
				//error = "ќшибка при сохранении контента статической страницы";
				//out.println( we.getOriginal().getMessage() );
				response.sendRedirect( "page_edit.jsp?mode=edit&page_id=" + webPage.getId() + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
				return;
			}
		}
		for( ; i < content.size(); i++ )
			((StaticPage)content.elementAt(i)).remove();
	}
	
	if( modified )
		try{ Journal.newRecord( currentAdmin, webPage, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
	if( changePubl && visible )
		try{ Journal.newRecord( currentAdmin, webPage, pageId, Journal.ACTION_PUBLIC, "" ).save(); }catch( Exception e ){}
	if( changePubl && ! visible )
		try{ Journal.newRecord( currentAdmin, webPage, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}
	
	response.sendRedirect("tree.jsp?action_done=2");
	return;
}
else if( mode != null && mode.equals( "add_frame" ))
{
	// проверка прав админа
	if( ! Admin.isW( pageAccess ))
	{
		response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	// добавление кадра
	try{
		StaticPage.create(webPage);
	}catch( DBException e ){
		response.sendRedirect( "page_edit.jsp?mode=edit&page_id=" + webPage.getId() + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
	
	// запись в журнал
	try
	{ 
		Journal.newRecord( currentAdmin, webPage, pageId, Journal.ACTION_MODIFY, "добавление кадра" ).save();
	}
	catch( Exception e ){}
	
	response.sendRedirect("page_edit.jsp?mode=edit&page_id=" + webPage.getId() + "&action_done=1");
	return;
}
else if( mode != null && mode.equals( "del_frame" ))
{
	// проверка прав админа
	if( ! Admin.isW( pageAccess ))
	{
		response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}

	// удаление кадра

	String frameId = request.getParameter("frame_id");
	StaticPage frame = new StaticPage();
	frame.load(frameId);
	frame.remove();
	
	// запись в журнал
	try
	{ 
		Journal.newRecord( currentAdmin, webPage, pageId, Journal.ACTION_MODIFY, "удаление кадра" ).save();
	}
	catch( Exception e ){}
	response.sendRedirect("page_edit.jsp?mode=edit&page_id=" + webPage.getId() + "&action_done=2");
	return;
}





else if( mode != null && mode.equals( "delete" ) )
{
//
//	”даление страниц из дерева
//
	for( java.util.Enumeration e = request.getParameterNames(); e.hasMoreElements(); )
	{
		String prmName = (String) e.nextElement();
		String delNodeId = null;
		if(prmName !=null && prmName.startsWith( "CHECK-" ) )
		{
			delNodeId = prmName.substring( "CHECK-".length() );
		}
		else
		{
			continue;
		}
		
		WebTreeNode wp = (WebTreeNode) CMSApplication.getApplication().lookup(delNodeId);
		// узлы первого уровн€, узлы с потомками удал€ть нельз€ и 
		if ( wp == null )
		{
			continue;
		}
		else if (wp.hasChilds())
			continue;
//		else if (wp.getType().equals("custom"))
//			continue;
		else
		{
			if( !currentAdmin.isC(wp.getId()))
			{
				response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			
			if("static".equals(wp.getPageType().getCode()))
			{
				try
				{
					StaticPage.remove(wp.getId());
				}
				catch(DBException we){}
			}
			Journal rec = Journal.newRecord(currentAdmin, wp, pageId, Journal.ACTION_DELETE, "");
			
			try
			{
			    wp.remove();
            }
            catch(Exception ee)
            {
                response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
				return;
            }
			Enumeration groupEnum = CMSApplication.getApplication().getGroups();
			while(groupEnum.hasMoreElements())
			{
				Group gr = (Group)groupEnum.nextElement();
				gr.clearAccessCode(delNodeId);
				// no need to save codes. they where removed by cascade delete
			}
			
			try{ rec.save(); }catch( Exception ex ){}
		}
	}
	response.sendRedirect("tree.jsp?action_done=3");
	return;

}
else if( mode != null && mode.equals( "expand" ) )
{
//
//	–аспахивание узла
//
	ArrayList exp = (ArrayList) session.getValue( "tree.expanded.nodes" );
	if( exp == null )
	{
		exp = new ArrayList();
	}
	exp.add( node );
	
	session.putValue( "tree.expanded.nodes", exp );
}
else if( mode != null && mode.equals( "collaps" ) )
{
//
//	—хлопывание узла
//
	ArrayList exp = (ArrayList) session.getValue( "tree.expanded.nodes" );
	if( exp == null )
	{
		exp = new ArrayList();
	}
	else
	{
		int p = exp.indexOf( node );
		if( p >= 0 )
			exp.remove( p );
	}
	session.putValue( "tree.expanded.nodes", exp );
}
else if( mode != null && mode.equals( "expand_all" ) )
{
//
//	–асхлапывание всего дерева
//
	ArrayList exp = new ArrayList();
	Enumeration enum = CMSApplication.getApplication().getAllNodeIds();
	while(enum.hasMoreElements())
	{
		exp.add((String)enum.nextElement());
	}
	session.putValue( "tree.expanded.nodes", exp );
}
else if( mode != null && mode.equals( "collaps_all" ) )
{
//
//	—хлапывание всего дерева
//
	ArrayList exp = exp = new ArrayList();
	session.putValue( "tree.expanded.nodes", exp );
}




else if( mode != null && mode.equals( "up" ) )
{
//
//	ѕеремещение узла вверх
//
	WebTreeNode parent = webPage.getParent();
	if(parent != null)
	{
		if(!currentAdmin.isW(parent.getId()))
		{
			response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		webPage.up();	
		try
		{ 
			Journal.newRecord( currentAdmin, parent, pageId, Journal.ACTION_MODIFY, 
				"подстраница \"" + webPage.getName() + " (" + webPage.getCode() + ")\" перемещена вверх" ).save(); 
		}
		catch( Exception e ){}
	}
	response.sendRedirect("tree.jsp?action_done=4");
	return;
}




else if( mode != null && mode.equals( "down" ) )
{
//
//	ѕеремещение узла вниз
//
	WebTreeNode parent = (WebTreeNode)webPage.getParent();
	if( parent != null )
	{
		if(!currentAdmin.isW(parent.getId()))
		{
			response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		webPage.down();
		
		try
		{
			Journal.newRecord( currentAdmin, parent, pageId, Journal.ACTION_MODIFY, 
				"подстраница \"" + webPage.getName() + " (" + webPage.getCode() + ")\" перемещена вниз" ).save(); 
		}
		catch( Exception e ){}
	}
	response.sendRedirect("tree.jsp?action_done=5");
	return;
}




else if( mode != null && mode.equals( "attach" ) )
{
//
//	ѕрисоединение выбранных узлов к указанному
//
	// проверка прав админа на модификацию нового родительского узла
	if( ! Admin.isW( pageAccess ))
	{
		response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	int count = 0;
loop:
	for( java.util.Enumeration e = request.getParameterNames(); e.hasMoreElements(); )
	{
		String prmName = (String) e.nextElement();
		if( prmName !=null && prmName.startsWith( "CHECK-" ) )
		{
			String attachedNodeId = prmName.substring( "CHECK-".length() );
			WebTreeNode wp = CMSApplication.getApplication().lookup( attachedNodeId );
			WebTreeNode parent = wp.getParent();
			// корневые страница трогать нельз€!
			if( parent == null ) continue;
			
			// нельз€ присоедин€ть узел к своему потомку (зацикливание)
			WebTreeNode parentParent = webPage;
			while(parentParent != null)
			{
				if(parentParent.equals(wp))
					continue loop;
				parentParent = parentParent.getParent();
			}
			
			// проверка прав админа на модификацию родительского узла
			if( ! currentAdmin.isW(parent.getId()))
			{
				response.sendRedirect( "tree.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			try
			{
				wp.setParent(webPage);
				wp.save();
				count ++;
				
				try{ Journal.newRecord( currentAdmin, parent, pageId, Journal.ACTION_MODIFY, 
						"отсоединение подстраницы \"" + wp.getName() + " (" + wp.getCode() + ")\"" ).save(); }catch( Exception ex ){}
				try{ Journal.newRecord( currentAdmin, webPage, pageId, Journal.ACTION_MODIFY, 
						"присоединение подстраницы \"" + wp.getName() + " (" + wp.getCode() + ")\"" ).save(); }catch( Exception ex ){}
			}catch( Exception ex ){}
		}
	}
	response.sendRedirect("tree.jsp?action_done=6&count=" + count);
	return;
}

if( redirect == null ) 
	redirect = "tree.jsp" + error;
response.sendRedirect( redirect );
%>

