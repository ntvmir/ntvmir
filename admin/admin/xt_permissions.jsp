<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = "admin";
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	int CAN_T_SAVE = CMSApplication.PAGE_ERROR_WHILE_SAVING;
	int CAN_T_MODIFY = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
%>

<%!
	int getCode( String id, String[] orig_r, String[] r,
							String[] orig_w, String[] w,
							String[] orig_c, String[] c,
							String[] orig_p, String[] p )
	{
		int i1, i2;
		int c1, c2, c3, c4;
		boolean changed = false;
		
		i1 = indexOf( id, orig_r );
		i2 = indexOf( id, r );
		if(( i2 >= 0 && i1 < 0 ) || ( i1 >= 0 && i2 < 0 )) changed = true;
		c1 = i2 < 0 ? 0 : 1;
		
		i1 = indexOf( id, orig_w );
		i2 = indexOf( id, w );
		if(( i2 >= 0 && i1 < 0 ) || ( i1 >= 0 && i2 < 0 )) changed = true;
		c2 = i2 < 0 ? 0 : 1;
		
		i1 = indexOf( id, orig_c );
		i2 = indexOf( id, c );
		if(( i2 >= 0 && i1 < 0 ) || ( i1 >= 0 && i2 < 0 )) changed = true;
		c3 = i2 < 0 ? 0 : 1;
		
		i1 = indexOf( id, orig_p );
		i2 = indexOf( id, p );
		if(( i2 >= 0 && i1 < 0 ) || ( i1 >= 0 && i2 < 0 )) changed = true;
		c4 = i2 < 0 ? 0 : 1;
		
		if( ! changed  ) return -1;
		
		return (c1 * Admin.ACCESS_READ) | (c2 * Admin.ACCESS_WRITE) |
				(c3 * Admin.ACCESS_CREATE) | (c4 * Admin.ACCESS_PUBL);
		
	
	}
	
	int indexOf( String str, String[] a ){
		for( int i = 0; i < a.length; i++ )
			if( str.equals( a[i] )) return i;
		return -1;
	}
	
	void printArray( JspWriter out, String [] a, String name ) throws Exception{
		for( int i = 0; i < a.length; i++ ){
			out.println( name + "[" + i + "] = " );
			out.println( "" + (a[i]) + "<br>" );
			
		}
		out.println( "<br><br>" );
			
	}
%>

<%


String id = request.getParameter( "id" );
if("".equals(id))
	id = null;
String href = "admin.jsp?id=" + (id == null ? "" : id);

if( ! Admin.isW( pageAccessCode ))
{
	response.sendRedirect( "admin.jsp?id=" + (id == null ? "" : id) + "&err=" + CAN_T_MODIFY );
	return;
}

Admin admin = new Admin();
if( id != null )
	admin.load( id );
if( admin.getId() != null )
{
	/*
	идея такая:

	page_id        ид всех страниц, учавствовавших в форме
	page_orig_     ид страниц на корорые админ владел правом (r w c p)
	page_          ид страниц на корорые админу дают права (r w c p)
	page_colapsed  ид страниц с нераскрытыми подстраницами

	итак, бежим по всем присланным страницам (по page_id) и если
	изменился хоты бы один флажок, то назначаем админу новые права на страницу.
	если страница "схлопнута", даем админу те же права на все ее подстраницы.
	изменение флажка P (например) у страницы можно понять так:
	пусть было 1, стало 0 => страница попала в page_orig_p и не попала в page_p
	и наоборот.
	*/


	String []page_id		= request.getParameterValues( "page_id" );
	String []page_orig_r	= request.getParameterValues( "page_orig_r" );
	String []page_orig_w	= request.getParameterValues( "page_orig_w" );
	String []page_orig_c	= request.getParameterValues( "page_orig_c" );
	String []page_orig_p	= request.getParameterValues( "page_orig_p" );
	String []page_r			= request.getParameterValues( "page_r" );
	String []page_w			= request.getParameterValues( "page_w" );
	String []page_c			= request.getParameterValues( "page_c" );
	String []page_p			= request.getParameterValues( "page_p" );
	String []page_collapsed	= request.getParameterValues( "page_collapsed" );

	if( page_id == null ) 		page_id = new String [0];
	if( page_orig_r == null )	page_orig_r = new String [0];
	if( page_orig_w == null )	page_orig_w = new String[0];
	if( page_orig_c == null )	page_orig_c = new String[0];
	if( page_orig_p == null )	page_orig_p = new String[0];
	if( page_r == null )		page_r = new String[0];
	if( page_w == null )		page_w = new String[0];
	if( page_c == null )		page_c = new String[0];
	if( page_p == null )		page_p = new String[0];
	if( page_collapsed == null ) page_collapsed = new String[0];
	
	
	int l = 0;
	for( int i = 0; i < page_id.length; i++ )
	{
		int c = getCode( page_id[i], 
						 page_orig_r, page_r,
						 page_orig_w, page_w,
						 page_orig_c, page_c,
						 page_orig_p, page_p );
		if( c >= 0 )
		{
			l++;
			admin.setAccessCode( page_id[i], c, indexOf( page_id[i], page_collapsed ) >= 0 );
		}
	}
	if( l > 0 )
	{
		try
		{
			admin.saveAccessCodes();
		}
		catch( Exception e )
		{
			response.sendRedirect( "admin.jsp?id=" + (id == null ? "" : id) + "&err=" + CAN_T_SAVE );
		}
		try
		{
			Journal.newRecord( currentAdmin, admin, pageId, Journal.ACTION_MODIFY, "изменение прав доступа" ).save();
		}
		catch( Exception e ){}
	}
		
	response.sendRedirect( href );
}
else
	response.sendRedirect( "/admin/admin/admins.jsp" );
%>