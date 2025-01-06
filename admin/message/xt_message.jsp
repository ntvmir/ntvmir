<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Message.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%

int CAN_T_PUBL	= CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_CREATE = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_MODIFY = CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_SAVE	= CMSApplication.PAGE_ERROR_WHILE_SAVING;


String id =  request.getParameter( "id" );
if("".equals(id))
	id = null;

String href = "messages.jsp?";

SimpleDateFormat sdfLong = new SimpleDateFormat( "dd.MM.yyyy HH:mm" );
SimpleDateFormat sdfShort = new SimpleDateFormat( "dd.MM.yyyy" );

	
Message m = new Message();
if( id != null )
	m.load( id );


String subject = request.getParameter( "subject" );
String caption = request.getParameter( "caption" );
String content = request.getParameter( "content" );
String recordDate = request.getParameter( "send_date" );

if( subject == null )
    subject = "";
if( caption == null )
    caption = "";
if( content == null )
    content = "";

SimpleDateFormat sdf = null;

try {
    sdfLong.parse( recordDate );
    sdf = sdfLong;
} catch( Exception e ) {
	try {
        sdfShort.parse( recordDate );
        sdf = sdfShort;
    } catch( Exception e1 ) {
        response.sendRedirect( "message.jsp?id=" + m.getId() + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
        return;
    }
}

java.util.Date d = new java.util.Date();
if ( sdfShort.format( d ).equals( recordDate ) )
    d = d;
else
	d = sdf.parse( recordDate );

String lang = "";

boolean modif = true;
boolean publ = false;
boolean chPubl = false;
boolean isNew = m.getId() == null;

if( subject.equals( m.getSubject()) &&
	caption.equals( m.getCaption()) &&
	content.equals( m.getContent())) modif = false;

publ = "1".equals(request.getParameter("visible"));

if( ! publ == m.isVisible()) chPubl = true;

if( ( isNew && !Admin.isC( pageAccessCode )) ||
	( modif && !Admin.isW( pageAccessCode )) ||
	( chPubl && ! Admin.isP( pageAccessCode ) && ! isNew ) ||
	( modif && publ && ! Admin.isP( pageAccessCode )))

{
	response.sendRedirect( href + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
	return;
}



m.setSubject( subject );
m.setCaption( caption );
m.setContent( content );
m.setVisible(publ);
m.setSendDate( d );


try
{
	boolean wasNew = m.getId() == null;
	m.save();
	href += "&id=" + m.getId();
	try
	{
		if( wasNew )
			Journal.newRecord( currentAdmin, m, pageId, Journal.ACTION_CREATE, "" ).save();
		else
			if( modif )
				Journal.newRecord( currentAdmin, m, pageId, Journal.ACTION_MODIFY, "" ).save();
		
		if( ( isNew || chPubl ) && publ)
		{
			Journal.newRecord( currentAdmin, m, pageId, Journal.ACTION_PUBLIC, "" ).save();
		}
		if( chPubl && !publ)
		{
			Journal.newRecord( currentAdmin, m, pageId, Journal.ACTION_UNPUBL, "" ).save();
		}
	}
	catch( Exception ee ){}
}
catch(Exception e ){
	response.sendRedirect( href + "&err=" + CAN_T_SAVE );
	return;
}

response.sendRedirect( "messages.jsp?action_done=save" );
%>