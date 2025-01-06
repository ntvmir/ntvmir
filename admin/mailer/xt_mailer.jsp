<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = MailerTask.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
CMSApplication APP = CMSApplication.getApplication();

Vector error = new Vector();

String message = "";

if(request.getParameter("action_stopMail") != null)
{
	if( ! Admin.isP( pageAccessCode ))
	{
		response.sendRedirect( "mailer.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	MailerTask.stopMail();
	message = "Рассыльщик остановлен";
	try{Journal.newRecord( currentAdmin, null, pageId, Journal.ACTION_MODIFY, "остановка рассыльщика" ).save();}catch(Exception e){}
	response.sendRedirect( "mailer.jsp?action=action_stopMail");
    return;
}


else if(request.getParameter("action_startMail") != null)
{
	if( ! Admin.isP( pageAccessCode ))
	{
		response.sendRedirect( "mailer.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}
	MailerTask.restartDemon();
	message = "Рассыльщик запущен";
	try{Journal.newRecord( currentAdmin, null, pageId, Journal.ACTION_MODIFY, "запуск рассыльщика" ).save();}catch(Exception e){}
    response.sendRedirect( "mailer.jsp?action=action_startMail");
	return;
}




else if(request.getParameter("action_editTextField") != null)
{
	if( ! Admin.isW( pageAccessCode ))
	{
		response.sendRedirect( "mailer.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}

    String [] deliveryId = request.getParameterValues("delivery_id");
    String [] letterSender = request.getParameterValues("letter_sender");
    String [] letterSubject = request.getParameterValues("letter_subject");
    String [] letterHeader = request.getParameterValues("letter_header");
    String [] letterFooter = request.getParameterValues("letter_footer");
    String [] letterSeparator = request.getParameterValues("letter_separator");
    
    for(int i = 0; deliveryId != null && i < deliveryId.length; i++)
    {
        LetterFields fields = new LetterFields();
        try
        {
            fields.load(deliveryId[i]);
        }
        catch(Exception e)
        {
            fields.setSuperId(deliveryId[i]);
        }
        
        Delivery dlv = null;
        Enumeration dlvEnum = Delivery.getDeliveries(langCode);
        while(dlvEnum.hasMoreElements())
        {
            Delivery dlvTmp = (Delivery)dlvEnum.nextElement();
            if(dlvTmp.getId().equals(deliveryId[i]))
            {
                dlv = dlvTmp;
                break;
            }
        }
        if(dlv != null)
        {
            dlv.setSender(letterSender[i]);
            dlv.save();
        }
        
        fields.setSubject(letterSubject != null && i < letterSubject.length ? letterSubject[i] : "");
        fields.setHeader(letterHeader != null && i < letterHeader.length ? letterHeader[i] : "");
        fields.setFooter(letterFooter != null && i < letterFooter.length ? letterFooter[i] : "");
        fields.setSeparator(letterSeparator != null && i < letterSeparator.length ? letterSeparator[i] : "");
        fields.save();
    }

	try{Journal.newRecord( currentAdmin, null, pageId, Journal.ACTION_MODIFY, "изменение текстовых параметров рассыльщика" ).save();}catch(Exception e){}
	response.sendRedirect( "mailer.jsp?action=action_editTextField");
	return;
}


else if(request.getParameter("action_set_times") != null)
{
	if( ! Admin.isW( pageAccessCode ) || ! Admin.isP( pageAccessCode ))
	{
		response.sendRedirect( "mailer.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
		return;
	}

    
    String [] deliveryId = request.getParameterValues("delivery_id");
    String [] dlvDay = request.getParameterValues("dlv_day");
    String [] dlvTime = request.getParameterValues("dlv_time");
    
    for(int i = 0; deliveryId != null && i < deliveryId.length; i++)
    {
        Delivery dlv = null;
        Enumeration dlvEnum = Delivery.getDeliveries(langCode);
        while(dlvEnum.hasMoreElements())
        {
            Delivery dlvTmp = (Delivery)dlvEnum.nextElement();
            if(dlvTmp.getId().equals(deliveryId[i]))
            {
                dlv = dlvTmp;
                break;
            }
        }
        if(dlv == null)
            continue;

        String time = dlvTime != null && i < dlvTime.length ? dlvTime[i] : "";
        if(dlv.getFrequency() == Delivery.WEEKLY)
            time = (dlvDay != null && i < dlvDay.length ? dlvDay[i] : "") + "-" + time;
        
        if(!time.equals(dlv.getStartTime()))
        {
            dlv.setStartTime(time);
            dlv.save();
        }
    }
    
	int period = -1;
	try{ period = Integer.parseInt(request.getParameter("sleepTime")); }catch(Exception e){}

	APP.setStoredProperty(MailerTask.MAIL_INTERVAL_PROP, ""+ (period * 60 * 60 * 1000));
//	APP.setStoredProperty(MailerTask.MAIL_INTERVAL_PROP, ""+ (period));

	MailerTask.restartDemon();
	try{Journal.newRecord( currentAdmin, null, pageId, Journal.ACTION_MODIFY, "изменение временных параметров и перезапуск рассыльщика" ).save();}catch(Exception e){}
	response.sendRedirect( "mailer.jsp?action=action_set_times");
	return;
}
%>