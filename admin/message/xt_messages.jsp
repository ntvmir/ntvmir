<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Message.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
int CAN_T_DEL1	= CMSApplication.PAGE_ERROR_NO_PERMISSIONS;
int CAN_T_DEL2	= CMSApplication.PAGE_ERROR_WHILE_REMOVING;
%>

<%

String href = "messages.jsp?";

String []del		= request.getParameterValues( "del" );
String sender = request.getParameter("sender");

if( del	== null ) del			= new String[0];

if( del.length > 0 ){
	try
	{
		for( int i = 0; i < del.length; i++ )
		{
			if( !Admin.isC( pageAccessCode ))
			{
				response.sendRedirect( href + "&err=" + CAN_T_DEL1 );
				return;
			}
			
			Message mes = new Message();
			mes.load( del[i] );
			Journal rec = Journal.newRecord( currentAdmin, mes, pageId, Journal.ACTION_DELETE, "" );
			mes.remove();
			try{ rec.save(); }catch( Exception ee ){}
		}
	}
	catch( Exception e )
	{
		response.sendRedirect( href + "&err=" + CAN_T_DEL2 );
		return;
	}
	response.sendRedirect(href + "&action_done=del");
	return;
}

if(sender != null && sender.length() > 0)
{
    try
    {
        Delivery delivery = null;
        Enumeration enum = Delivery.getDeliveries(langCode);
        while(enum.hasMoreElements())
        {
            Delivery dlv = (Delivery)enum.nextElement();
            if("message".equals(dlv.getCode()))
            {
                delivery = dlv;
                break;
            }
        }
        if(delivery != null)
        {
            delivery.setSender(sender);
            delivery.save();
            Journal.newRecord( currentAdmin, delivery, pageId, Journal.ACTION_MODIFY, "изменен адрес отправителя" ).save();
        }
   	}catch( Exception e )
	{
		response.sendRedirect( href + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING);
		return;
	}
	response.sendRedirect(href + "&action_done=sender");
}

response.sendRedirect( href );
%>