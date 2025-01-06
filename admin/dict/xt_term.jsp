<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251" %>
<%
	// set the Service name for authorization
	String pageId = Term.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%!
	String toHex( String s ) throws Exception{
		if( s == null || s.length() == 0 ) return "";
		byte [] b = s.getBytes( "Cp1251" );
		return "%" + Integer.toString( (int)(b[0]<0? 256 + b[0] : b[0]), 16 ).toUpperCase();
	}
%>
<%

int CAN_T_PUBL	= CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_CREATE = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_MODIFY = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_SAVE	= CMSApplication.PAGE_ERROR_WHILE_SAVING;




String letter =  toHex( request.getParameter( "letter" ));
String lang = request.getParameter( "lang" );
if( lang == null ) lang = "";
if( letter == null ) letter = "";

String id = request.getParameter( "id" );
String req = request.getParameter( "request" );
if("".equals(id))
	id = null;
if("".equals(req))
	req = null;

String href = "term.jsp?request=" + (req==null ? "" : req) + "&letter=" + letter + "&lang=" + lang;

	
Term t = new Term();
if( id != null )
	t.load( id );

if( t.getId() != null)
	href += "&id=" + t.getId();

String termRus = request.getParameter( "term_" + CMSApplication.LANG_RUS );
String termEng = request.getParameter( "term_" + CMSApplication.LANG_ENG );
String descrRus = request.getParameter( "descr_" + CMSApplication.LANG_RUS );
String descrEng = request.getParameter( "descr_" + CMSApplication.LANG_ENG );

if( termRus == null ) termRus = "";
if( termEng == null ) termEng = "";
if( descrRus == null ) descrRus = "";
if( descrEng == null ) descrEng = "";


boolean pubRus = false;
if( "1".equals( request.getParameter( "pub_" + CMSApplication.LANG_RUS )))
	pubRus = true;
boolean pubOrigRus = false;
if( "1".equals( request.getParameter( "pub_orig_" + CMSApplication.LANG_RUS )))
	pubOrigRus = true;


boolean pubEng = false;
if( "1".equals( request.getParameter( "pub_" + CMSApplication.LANG_ENG )))
	pubEng = true;
boolean pubOrigEng = false;
if( "1".equals( request.getParameter( "pub_orig_" + CMSApplication.LANG_ENG )))
	pubOrigEng = true;


boolean rusChanged = false;
if( ! termRus.equals( t.getTermRus()) || ! descrRus.equals( t.getDescrRus()))
{
	t.setTermRus( termRus );
	t.setDescrRus( descrRus );
	rusChanged = true;
}

boolean engChanged = false;
if( ! termEng.equals( t.getTermEng()) || ! descrEng.equals( t.getDescrEng()))
{		
	t.setTermEng( termEng );
	t.setDescrEng( descrEng );
	engChanged = true;
}

t.setVisibleRus( pubRus );
t.setVisibleEng( pubEng );


if( ! Admin.isP( pageAccessCode ) &&                               // если нет прав на публикацию и
	((( pubRus && rusChanged ) || pubRus != pubOrigRus ) ||  // хотят изменить опубл. термин или изменить флаг публ. для рус.
	 (( pubEng && engChanged ) || pubEng != pubOrigEng )))   // или хотят изменить опубл. термин или изменить флаг публ. для eng.
{
	response.sendRedirect( href + "&err=" + CAN_T_PUBL );
	return;
}

if( ! Admin.isC( pageAccessCode ) && t.getId() == null )
{
	response.sendRedirect( href + "&err=" + CAN_T_CREATE );
	return;
}

if( ! Admin.isW( pageAccessCode ) && ( rusChanged || engChanged ) && t.getId() != null )
{
	response.sendRedirect( href + "&err=" + CAN_T_MODIFY );
	return;
}


try
{
	boolean wasNew = t.getId() == null;
	t.save();
	href += "&id=" + (t.getId() != null ? t.getId() : "");
	if( req != null )
	{
		TermRequest tr = new TermRequest();
		tr.load( req );
		tr.setStatus( TermRequest.STATUS_DONE );
		tr.save();
		
	}
	try
	{
		if( wasNew )
			Journal.newRecord( currentAdmin, t, pageId, Journal.ACTION_CREATE, "" ).save();
		else
			if( rusChanged || engChanged )
				Journal.newRecord( currentAdmin, t, pageId, Journal.ACTION_MODIFY, "" ).save();
		if( pubRus != pubOrigRus )
			Journal.newRecord( currentAdmin, t, pageId, pubRus ? Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "в русской части" ).save();
		if( pubEng != pubOrigEng )
			Journal.newRecord( currentAdmin, t, pageId, pubEng ? Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, "в английской части" ).save();
	}
	catch( Exception ee ){}
}
catch( Exception e ){
	response.sendRedirect( href + "&err=" + CAN_T_SAVE );
	return;
}
if( req == null )
	response.sendRedirect( "terms.jsp?letter=" + letter + "&lang=" + lang + "&action_done=save" );
else
	response.sendRedirect( "requests.jsp?action_done=save" );
%>