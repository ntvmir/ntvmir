<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page import="tengry.ntvmir.tvschedule.TimeZone"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Tvschedule.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
String mode = request.getParameter( "mode" );
String href = "tvschedule.jsp?";
String sDate = request.getParameter("date");
SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
Date date = sdf.parse(sDate);

ShowPlace sp = ShowPlace.getDefaultShowPlace(langCode);
TimeZone tz = (sp != null ? sp.getTimeZone() : TimeZone.getGmtTimeZone());
int gmtShift = tz.getGmtShift();
String langRootId = CMSApplication.getApplication().getWebRoot(langCode).getId();

Calendar ccc = Calendar.getInstance();
ccc.setTime(date);
String attr = "&year=" + ccc.get(Calendar.YEAR) + "&month=" + (ccc.get(Calendar.MONTH));

if(!Admin.isW(pageAccessCode))
{
	response.sendRedirect("tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS + attr);
	return;
}

if("save".equals(mode))
{
	try
	{
        String [] itemIds = request.getParameterValues("item_id");
        String [] itemTimes = request.getParameterValues("item_time");
        String [] itemNames = request.getParameterValues("item_name");
        String [] itemDescrs = request.getParameterValues("item_descr");

        if(itemIds == null) itemIds = new String[0];
        if(itemTimes == null) itemTimes = new String[0];
        if(itemNames == null) itemNames = new String[0];
        if(itemDescrs == null) itemDescrs = new String[0];
        
        Enumeration enum = Tvschedule.getItems(langCode, date, 1).elements();
        int i = 0;
        int ch = 0;
        int ad = 0;
        while(enum.hasMoreElements() && i < itemIds.length)
        {
            
            Tvschedule item = (Tvschedule)enum.nextElement();
            if(item.getId().equals(itemIds[i]))
            {
                if( ! ( item.getTime(gmtShift).equals(itemTimes[i]) &&
                        item.getName().equals(itemNames[i]) &&
                        item.getDescription().equals(itemDescrs[i])) )
                {
                    if(!Admin.isP(pageAccessCode) && item.isVisible())
                    {
                        response.sendRedirect("tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS + attr);
                        return;
                    }
                    item.setTime(langCode, date, itemTimes[i], gmtShift);
                    item.setName(itemNames[i]);
                    item.setDescription(itemDescrs[i]);
                    item.save();
                    ch++;
                }
            }
            i++;
        }


        String [] newTimes = request.getParameterValues("new_time");
        String [] newNames = request.getParameterValues("new_name");
        String [] newDescrs = request.getParameterValues("new_descr");

        if(newTimes == null) newTimes = new String[0];
        if(newNames == null) newNames = new String[0];
        if(newDescrs == null) newDescrs = new String[0];

        for(i = 0; i < newTimes.length; i++)
        {
            if(newTimes[i] == null || newTimes[i].trim().length() == 0)
                continue;
            if(!Admin.isC(pageAccessCode))
            {
                response.sendRedirect("tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS + attr);
                return;
            }

            Tvschedule item = new Tvschedule();
            item.setLangRootId(langRootId);
            item.setTime(langCode, date, newTimes[i], gmtShift);
            item.setName(newNames[i]);
            item.setDescription(newDescrs[i]);
            item.setVisible(false);
            item.save();
            ad++;
        }
        Tvschedule ttt = new Tvschedule();
        ttt.setTime(langCode, date, "00:00", 0);
        if(ch + ad > 0)
		    try{ Journal.newRecord( currentAdmin, ttt, pageId, Journal.ACTION_MODIFY, "Изменено " + ch + "; Добавлено " + ad + ";" ).save(); }catch( Exception e ){}
		href	=  "tvschedule.jsp?action_done=tvsave";
	}catch(Exception e)
	{
	    //e.printStackTrace(new PrintWriter(out));
		response.sendRedirect( "tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING + attr );
		return;
	}
}
else if("del".equals(mode))
{
	try
	{
        String [] delIds = request.getParameterValues("del_id");
        
        if(delIds != null && delIds.length > 0)
        {
            Enumeration enum = Tvschedule.getItems(langCode, date, 1).elements();
            int del = 0;
            while(enum.hasMoreElements())
            {
                Tvschedule item = (Tvschedule)enum.nextElement();
                int i;
                for(i = 0; i < delIds.length; i++)
                    if(item.getId().equals(delIds[i]))
                        break;
                if(i < delIds.length)
                {
                    if(!Admin.isC(pageAccessCode) || (item.isVisible() && !Admin.isP(pageAccessCode)))
                    {
                        response.sendRedirect("tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS + attr);
                        return;
                    }
                    item.remove();
                    del ++;
                }
            }
            Tvschedule ttt = new Tvschedule();
            ttt.setTime(langCode, date, "00:00", 0);
            if(del > 0)
		        try{ Journal.newRecord( currentAdmin, ttt, pageId, Journal.ACTION_DELETE, "Удалено " + del + ";" ).save(); }catch( Exception e ){}
		    href	=  "tvschedule.jsp?action_done=tvdel";
		}
	}catch(Exception e)
	{
	    //e.printStackTrace(new PrintWriter(out));
		response.sendRedirect( "tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING + attr );
		return;
	}
}
else if("publ".equals(mode) || "unpub".equals(mode))
{
	try
	{
	    if(!Admin.isP(pageAccessCode))
        {
            response.sendRedirect("tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS + attr);
            return;
        }
        int num = 7;
        try{ num = Integer.parseInt(request.getParameter("num")); }catch(Exception e){}

        boolean publ = "publ".equals(mode);
        
        String [] pubIds = request.getParameterValues("pub_id");
        
        if(pubIds != null && pubIds.length > 0)
        {
            Enumeration enum = Tvschedule.getItems(langCode, date, num).elements();
            int pub = 0;
            while(enum.hasMoreElements())
            {
                Tvschedule item = (Tvschedule)enum.nextElement();
                int i;
                for(i = 0; i < pubIds.length; i++)
                    if(item.getId().equals(pubIds[i]))
                        break;
                if(i < pubIds.length)
                {
                    item.setVisible(publ);
                    item.save();
                    pub ++;
                }
            }
            Tvschedule ttt = new Tvschedule();
            if(num > 1)
            {
                Calendar c = Calendar.getInstance();
                c.setTime(date);
                c.add(Calendar.DATE, num-1);
                ttt.setName("Телепрограмма с " + sdf.format(date) + " по " + sdf.format(c.getTime()));
            }
            else
            {
                ttt.setTime(langCode, date, "00:00", 0);
            }
            
            if(pub > 0)
		        try{ Journal.newRecord( currentAdmin, ttt, pageId, 
		            publ ? Journal.ACTION_PUBLIC : Journal.ACTION_UNPUBL, 
		            "Всего пунктов: " + pub + ";" ).save(); }catch( Exception e ){}
		    href	=  "tvschedule.jsp?action_done=tv" + mode;
		}
	}catch(Exception e)
	{
//	    e.printStackTrace(new PrintWriter(out));
		response.sendRedirect( "tvschedule.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING + attr );
		return;
	}
}

response.sendRedirect( href + attr);
%>
