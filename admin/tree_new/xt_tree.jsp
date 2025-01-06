<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>

<%@ page import="tengry.northgas.*" %>

<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>



<% String pageId = "comp.tree"; %>
<%@ include file="/admin/inc/authorize.jsp"%>




<%
    response.setHeader("Pragma","no-cache");

// определим все полученные параметры
String mode = request.getParameter( "mode" );
String node	 = request.getParameter( "node" );
String redirect = null;
String error = "";

WebPage webroot = WebApp.getApp().getWebRoot();
WebPage webpage = (WebPage) webroot.lookup( node );

int pageAccess = currentAdmin.getAccessCode( node );

String section = null; // имя секции (используется для поиска)

if( mode != null && mode.equals( "add" ) )
{
// добавление статической страницы
//

	boolean visible = request.getParameter( "visible" ) != null;

	if( !isC( pageAccess ) || ( visible && ! isP( pageAccess )))
	{
		response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	WebPage wp = new WebPage( );
	StaticContent sc = new StaticContent();

	String str = request.getParameter( "namerus" );
	str = str == null ? "" : str;
	wp.setNameRus( str );
	sc.setNameRus( str );
	
	str = request.getParameter( "nameeng" );
	str = str == null ? "" : str;
	wp.setNameEng( str );
	sc.setNameEng( str );

	str = request.getParameter( "contentrus_0" );
	str = str == null ? "" : str;
	sc.setContentRus( str );

	str = request.getParameter( "contenteng_0" );
	str = str == null ? "" : str;
	sc.setContentEng( str );
	
	wp.setVisible( visible );
	sc.setVisible( visible );
	
	// добавляем страницу в дерево
	webpage.addChild( wp );
	
	// сохраняем данные
	WebApp.getApp().saveTree();
	sc.setPageId( wp.getId() );
	
	// определим секцию в которую попадает страница
	sc.setSection( wp.getSection() );


	try
	{
		sc.save();
//		DatabaseObject.executeUpdate( "begin INDEX_REBUILD('STATIC_PAGE'); end;" );

	}
	catch( WebException we )
	{
		//error = "Ошибка при сохранении контента статической страницы";
		//out.println( (WebException)we.getOriginal() );
		response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_WHILE_SAVING );
		return;
	}

	/* дадим админу права на новую страницу, такие же как и у родительской */
	try{
		currentAdmin.setAccessCode( wp.getId(), pageAccess );
		currentAdmin.saveAccessCodes();	
	}catch( Exception e ){}


	// запись в журнал.
	try{
		Journal.newRecord( currentAdmin, wp, pageId, Journal.ACTION_CREATE, "Подстраница для \"" + 
			webpage.getNameRus() + " (" + webpage.getNameEng() + ")" + "\"" ).save();
		if( visible )
			Journal.newRecord( currentAdmin, wp, pageId, Journal.ACTION_PUBLIC, "" ).save();
	}catch( WebException e ){}
		
}
else if( mode != null && mode.equals( "edit" ) )
{
//
//	Редактирование статической и custom страниц
//

	boolean visible = request.getParameter( "visible" ) != null;

	int num;
	try{ num = Integer.parseInt( request.getParameter( "frame_num" )); }catch( Exception e ){ num = -1; }

	String nameRus = request.getParameter( "namerus" );
	if( nameRus == null ) nameRus = "";
	String nameEng = request.getParameter( "nameeng" );
	if( nameEng == null ) nameEng = "";
	

	Vector content = null;

	/* проверяем на наличие каких-либо изменений (в имени, в содержании..)*/

	boolean modified = false;
	
	if( ! nameRus.equals( webpage.getNameRus()) || !nameEng.equals( webpage.getNameEng()))
	{ 
		modified = true;
	}
	else
	{
		if( !webpage.getType().equals( "custom" ) )
		{
			content = StaticContent.load( webpage.getId(), -1 );
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
					StaticContent sc = (StaticContent) content.elementAt(i);
					String str;		
					str = request.getParameter( "contentrus_" + i );
					if( str == null ) str = "";
					if( ! str.equals( sc.getContentRus()))
					{
						modified = true;
						break;
					}
					
					str = request.getParameter( "contenteng_" + i );
					if( str == null ) str = "";
					if( ! str.equals( sc.getContentEng()))
					{
						modified = true;
						break;
					}
				}
			}
		}
	}


	boolean changePubl = webpage.isVisible() != visible;
					
	// проверка прав админа на изменение и публикацию
	if( ( modified && !isW( pageAccess )) ||
		( changePubl && ! isP( pageAccess )) ||
		( modified && visible && ! isP( pageAccess )))
	{
		response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}




	
	webpage.setNameRus( nameRus );
	webpage.setNameEng( nameEng );
	webpage.setVisible( visible );
	
	// сохраняем данные
	WebApp.getApp().saveTree();
	

	if( !webpage.getType().equals( "custom" ) && modified )
	{
		if( content == null )
			content = StaticContent.load( webpage.getId(), -1 );
		if( content == null ) 
			content = new Vector();
		int i = 0;
		for( i = 0; i < num; i ++ ){
			StaticContent sc;
			if( i < content.size() ) sc = (StaticContent) content.elementAt(i);
			else sc = new StaticContent();
			try
			{
				String str;
				sc.setPageId( webpage.getId());
				sc.setFrameNum( i );
				sc.setNameRus( webpage.getNameRus() );
				sc.setNameEng( webpage.getNameEng() );
				sc.setVisible( webpage.isVisible() ); 
				
				str = request.getParameter( "contentrus_" + i );
				str = str == null ? "" : str;
				sc.setContentRus( str );
			
				str = request.getParameter( "contenteng_" + i );
				str = str == null ? "" : str;
				sc.setContentEng( str );
				
				sc.save();
			}
			catch( WebException we )
			{
				//error = "Ошибка при сохранении контента статической страницы";
				//out.println( we.getOriginal().getMessage() );
				response.sendRedirect( "page_edit.jsp?mode=edit&pageId=" + webpage.getId() + "&err=" + WebApp.PAGE_ERROR_WHILE_SAVING );
				return;
			}
		}
		for( ; i < content.size(); i++ )
			((StaticContent)content.elementAt(i)).remove();
	}
	
	if( modified )
		try{ Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
	if( changePubl && visible )
		try{ Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_PUBLIC, "" ).save(); }catch( Exception e ){}
	if( changePubl && ! visible )
		try{ Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}
}
else if( mode != null && mode.equals( "add_frame" ))
{
	// проверка прав админа
	if( ! isW( pageAccess ))
	{
		response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	// добавление кадра
	try{
		StaticContent.create( webpage );
	}catch( WebException e ){
		response.sendRedirect( "page_edit.jsp?mode=edit&pageId=" + webpage.getId() + "&err=" + WebApp.PAGE_ERROR_WHILE_SAVING );
		return;
	}
	
	// запись в журнал
	try
	{ 
		Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_MODIFY, "добавление кадра" ).save();
	}
	catch( Exception e ){}
			
	redirect = "page_edit.jsp?mode=edit&pageId=" + webpage.getId();
}
else if( mode != null && mode.equals( "del_frame" ))
{
	// проверка прав админа
	if( ! isW( pageAccess ))
	{
		response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}

	// удаление кадра

	int num = -1;
	try{
		num = Integer.parseInt( request.getParameter( "num" ));
	}catch( Exception e ){ num = -1; }
	if( num >= 0 )
		StaticContent.removeFrame( webpage.getId(), num );
	
	// запись в журнал
	try
	{ 
		Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_MODIFY, "удаление кадра" ).save();
	}
	catch( Exception e ){}

	redirect = "page_edit.jsp?mode=edit&pageId=" + webpage.getId();
}
else if( mode != null && mode.equals( "edit_title" ))
{
//
//	Редактирование заголовка и признака видимости в страницах любого типа
//

	String nameRus = request.getParameter( "namerus" );
	if( nameRus == null ) nameRus = "";
	String nameEng = request.getParameter( "nameeng" );
	if( nameEng == null ) nameEng = "";

	boolean modified =	! nameRus.equals( webpage.getNameRus()) || 
						! nameEng.equals( webpage.getNameEng());

	boolean visible = request.getParameter( "visible" ) != null;
	boolean changePubl = visible != webpage.isVisible();
	

	// проверка прав админа на изменение и публикацию
	if( ( modified && !isW( pageAccess )) ||
		( changePubl && ! isP( pageAccess )) ||
		( modified && visible && ! isP( pageAccess )))
	{
		response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	if( modified || changePubl )
	{
		webpage.setNameRus( nameRus );
		webpage.setNameEng( nameEng );
		webpage.setVisible( visible );
		WebApp.getApp().saveTree();
		
		if( modified )
			try{ Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( changePubl && visible )
			try{ Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_PUBLIC, "" ).save(); }catch( Exception e ){}
		if( changePubl && ! visible )
			try{ Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}
	}
}
else if( mode != null && mode.equals( "delete" ) )
{
//
//	Удаление страниц из конфигурационного дерева
//
	for( java.util.Enumeration e = request.getParameterNames(); e.hasMoreElements(); )
	{
		String prmName = (String) e.nextElement();
		String delNodeId = null;
		if( prmName !=null && prmName.startsWith( "CHECK-" ) )
		{
			delNodeId = prmName.substring( "CHECK-".length() );
		}
		else
		{
			continue;
		}
		
		WebPage wp = (WebPage) webroot.lookup( delNodeId );
		if ( wp == null )
		{
			// узлы первого уровня, узлы с потомками удалять нельзя и 
			// custom страницы удалять нельзя
			continue;
		}
		else if ( wp.hasChilds() )
			continue;
		else if ( wp.getType().equals( "custom" ) )
			continue;
		else
		{
			if( ! isC ( currentAdmin.getAccessCode( wp.getId())))
			{
				response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			
			if( wp.getType().equals( "news" ) )
			{
				DatabaseObject.executeUpdate( "DELETE FROM news WHERE pageid='" + wp.getId() + "'" );
				DatabaseObject.executeUpdate( "DELETE FROM user_news WHERE pageid='" + wp.getId() + "'" );
				DatabaseObject.executeUpdate( "DELETE FROM news_fields WHERE pageid='" + wp.getId() + "'" );
			}
		
			try
			{
				DatabaseObject.executeUpdate( "DELETE FROM static_page WHERE pageid='" + wp.getId() + "'" );
			}
			catch( WebException we ) {}
			
			Journal rec = Journal.newRecord( currentAdmin, wp, pageId, Journal.ACTION_DELETE, "" );
			
			wp.remove();
			
			try{ rec.save(); }catch( Exception ex ){}
		}
	}

	WebApp.getApp().saveTree();
}
else if( mode != null && mode.equals( "expand" ) )
{
//
//	Распахивание узла
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
//	Схлопывание узла
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
//	Расхлапывание всего дерева
//
	ArrayList exp = (ArrayList) session.getValue( "tree.expanded.nodes" );
	if( exp == null )
	{
		exp = new ArrayList();
	}

	// получим все id существующие в сессии	
	exp = webroot.getAllIds();
	
	if( exp != null )
	{
		session.putValue( "tree.expanded.nodes", exp );
	}
}
else if( mode != null && mode.equals( "collaps_all" ) )
{
//
//	Схлапывание всего дерева
//
	ArrayList exp = (ArrayList) session.getValue( "tree.expanded.nodes" );
	if( exp == null )
	{
		exp = new ArrayList();
	}
	exp.clear();
	
	session.putValue( "tree.expanded.nodes", exp );
}
else if( mode != null && mode.equals( "up" ) )
{
//
//	Перемещение узла вверх
//
	WebPage parent = (WebPage)webpage.getParent();
	if( parent != null )
	{
		if( ! isW( currentAdmin.getAccessCode( parent.getId())))
		{
			response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		webpage.up();	
		WebApp.getApp().saveTree();
		try
		{ 
			Journal.newRecord( currentAdmin, parent, pageId, Journal.ACTION_MODIFY, 
				"подстраница \"" + webpage.getNameRus() + " (" + webpage.getNameEng() + ")\" перемещена вверх" ).save(); 
		}
		catch( Exception e ){}
	}
}
else if( mode != null && mode.equals( "down" ) )
{
//
//	Перемещение узла вниз
//
	WebPage parent = (WebPage)webpage.getParent();
	if( parent != null )
	{
		if( ! isW( currentAdmin.getAccessCode( parent.getId())))
		{
			response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		webpage.down();
		WebApp.getApp().saveTree();
		
		try
		{
			Journal.newRecord( currentAdmin, parent, pageId, Journal.ACTION_MODIFY, 
				"подстраница \"" + webpage.getNameRus() + " (" + webpage.getNameEng() + ")\" перемещена вниз" ).save(); 
		}
		catch( Exception e ){}
	}
}
else if( mode != null && mode.equals( "attach" ) )
{
//
//	Присоединение выбранных узлов к указанному
//
	// проверка прав админа на модификацию нового родительского узла
	if( ! isW( pageAccess ))
	{
		response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	
	for( java.util.Enumeration e = request.getParameterNames(); e.hasMoreElements(); )
	{
		String prmName = (String) e.nextElement();
		if( prmName !=null && prmName.startsWith( "CHECK-" ) )
		{
			String attachedNodeId = prmName.substring( "CHECK-".length() );
			WebPage wp = (WebPage)webroot.lookup( attachedNodeId );
			WebPage parent = (WebPage)wp.getParent();

			// корневые страница трогать нельзя!
			if( parent == null ) continue;

			// проверка прав админа на модификацию родительского узла
			if( ! isW( currentAdmin.getAccessCode( parent.getId())))
			{
				response.sendRedirect( "tree.jsp?err=" + WebApp.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			try
			{
				webpage.attach( wp );
				DatabaseObject.executeUpdate( "UPDATE static_page SET section='" + webpage.getSection() + "' WHERE pageid='" + attachedNodeId + "'" );
				
				try{ Journal.newRecord( currentAdmin, parent, pageId, Journal.ACTION_MODIFY, 
						"отсоединение подстраницы \"" + wp.getNameRus() + " (" + wp.getNameEng() + ")\"" ).save(); }catch( Exception ex ){}
				try{ Journal.newRecord( currentAdmin, webpage, pageId, Journal.ACTION_MODIFY, 
						"присоединение подстраницы \"" + wp.getNameRus() + " (" + wp.getNameEng() + ")\"" ).save(); }catch( Exception ex ){}
			}catch( Exception ex ){}
		}
	}
	
	WebApp.getApp().saveTree();
}

if( redirect == null ) 
	redirect = "tree.jsp" + error;
response.sendRedirect( redirect );
%>

