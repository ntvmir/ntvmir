<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = Term.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
int CAN_T_PUBL1	= CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_PUBL2	= CMSApplication.PAGE_ERROR_WHILE_SAVING;
int CAN_T_DEL1	= CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_DEL2	= CMSApplication.PAGE_ERROR_WHILE_REMOVING;
%>

<%!
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
<%!
	String toHex( String s ) throws Exception{
		if( s == null || s.length() == 0 ) return "";
		byte [] b = s.getBytes( "Cp1251" );
		return "%" + Integer.toString( (int)(b[0]<0? 256 + b[0] : b[0]), 16 ).toUpperCase();
	}
%>

<%
String letter = toHex( request.getParameter( "letter" ));
String lang = request.getParameter( "lang" );
if( letter == null ) letter = "";
if( lang == null ) lang = "";

String href = "terms.jsp?letter=" + letter + "&lang=" + lang;

String []id			= request.getParameterValues( "id" );
String []del		= request.getParameterValues( "del" );
String []pub_1		= request.getParameterValues( "pub_R" );
String []pub_2		= request.getParameterValues( "pub_E" );
String []orig_pub_1	= request.getParameterValues( "orig_pub_R" );
String []orig_pub_2	= request.getParameterValues( "orig_pub_E" );

if( id			== null ) id			= new String[0];
if( del			== null ) del			= new String[0];
if( pub_1		== null ) pub_1			= new String[0];
if( pub_2		== null ) pub_2			= new String[0];
if( orig_pub_1	== null ) orig_pub_1	= new String[0];
if( orig_pub_2	== null ) orig_pub_2	= new String[0];

if( id.length > 0 && (  del.length > 0 || pub_1.length > 0 || pub_2.length > 0  || orig_pub_1.length > 0  || orig_pub_2.length > 0 )){
	try
	{
		for( int i = 0; i < id.length; i++ )
		{
			int p1 = indexOf( id[i], pub_1 );
			int p2 = indexOf( id[i], orig_pub_1 );
			if( (p1 >= 0 && p2 < 0) || (p1 < 0 && p2 >=0) ){
				if( ! Admin.isP( pageAccessCode ))
				{
					response.sendRedirect( href + "&err=" + CAN_T_PUBL1 );
					return;
				}
				Term term = new Term();
				term.load(id[i]);
				term.setVisibleRus( p1 >= 0 );
				term.save();
				try{
					Journal.newRecord( currentAdmin, term, pageId, p1>=0?Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "в русской части" ).save();
				}catch( Exception ee ){}
			}
		}

		for( int i = 0; i < id.length; i++ )
		{
			int p1 = indexOf( id[i], pub_2 );
			int p2 = indexOf( id[i], orig_pub_2 );
			if( (p1 >= 0 && p2 < 0) || (p1 < 0 && p2 >=0)){
				if( ! Admin.isP( pageAccessCode ))
				{
					response.sendRedirect( href + "&err=" + CAN_T_PUBL1 );
					return;
				}
				Term term = new Term();
				term.load(id[i]);
				term.setVisibleEng( p1 >= 0 );
				term.save();
				try{
					Journal.newRecord( currentAdmin, term, pageId, p1>=0?Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "в английской части" ).save();
				}catch( Exception ee ){}
			}
		}
	}
	catch( Exception e )
	{
		response.sendRedirect( href + "&err=" + CAN_T_PUBL2 );
		return;
	}
	
	try
	{
		for( int i = 0; i < del.length; i++ )
		{
			if( !Admin.isC( pageAccessCode ))
			{
				response.sendRedirect( href + "&err=" + CAN_T_DEL1 );
				return;
			}
			Term term = new Term();
			term.load(del[i]);
			if(( term.isVisibleRus() || term.isVisibleEng()) && ! Admin.isP( pageAccessCode ))
			{
				response.sendRedirect( href + "&err=" + CAN_T_DEL1 );
				return;
			}
		
			Journal rec = Journal.newRecord( currentAdmin, term, pageId, Journal.ACTION_DELETE, "" );
			term.remove();
			try{ rec.save(); }catch( Exception ee ){}
		}
	}
	catch( Exception e )
	{
		response.sendRedirect( href + "&err=" + CAN_T_DEL2 );
		return;
	}
	response.sendRedirect( href + "&action_done=changed");
	return;
}
response.sendRedirect( href );
%>