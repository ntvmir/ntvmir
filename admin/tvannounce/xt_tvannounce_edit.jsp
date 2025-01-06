<%@ page language="Java" %>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%@ page import="tengry.ntvmir.tvschedule.TimeZone"%>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Tvannounce.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter( "id" );

	String mode = null;
	if(id == null || id.length() == 0)
		mode = "add";
	else
		mode = "edit";
	
	boolean visible = "1".equals(request .getParameter("visible"));
	boolean important = "1".equals(request .getParameter("important"));
	String img = request.getParameter("img");
	String name = request.getParameter("name");
	String brief = request.getParameter("brief");
	String text = request.getParameter("content");
	String startDate = request.getParameter("start_date");
	String startTime = request.getParameter("start_time");
	String finishDate = request.getParameter("finish_date");
	if(finishDate != null && finishDate.length() == 0)
	    finishDate = null;

    ShowPlace sp = ShowPlace.getDefaultShowPlace(langCode);
    TimeZone tz = (sp != null ? sp.getTimeZone() : TimeZone.getGmtTimeZone());
    int gmtShift = tz.getGmtShift();


	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy"); 

	String redirect = null;
if(mode != null && mode.equals("add"))
{
	Tvannounce tvannounce = new Tvannounce();
	try
	{
		if( !Admin.isC(pageAccessCode) || (visible && ! Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "tvannounces.jsp?&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

		boolean modified = true;
		boolean changePubl = false;
		
		
		tvannounce.setLangRootId(CMSApplication.getApplication().getWebRoot(langCode).getId());
		
//		tvannounce.setStartDate( sdf.parse(startDate));
		tvannounce.setTime(langCode, sdf.parse(startDate), startTime, gmtShift);
		
		if(finishDate != null)
		    tvannounce.setFinishDate( sdf.parse(finishDate));

		tvannounce.setName( name );
		tvannounce.setImg( img );
		tvannounce.setBrief( brief );
		tvannounce.setText( text );
		tvannounce.setVisible( visible );
		tvannounce.setImportant( important );

		tvannounce.save();

        if(important)
            tengry.ntvmir.HomePage.getInstance(langCode).dropAnnounces();
            
		try{ Journal.newRecord( currentAdmin, tvannounce, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		if(visible)
			try{ Journal.newRecord( currentAdmin, tvannounce, pageId, Journal.ACTION_PUBLIC, "").save(); 
	        }catch( Exception e ){}

		// invalidate cached values
//		clearFrontEntries();
		
		redirect = "tvannounces.jsp?action_done=add";
	}catch(Exception e)
	{
		tvannounce.remove();
		response.sendRedirect( "tvannounces.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}
else if( mode != null && mode.equals( "edit" ) )
{
	Tvannounce tvannounce = new Tvannounce();
	try
	{
		tvannounce.load(id);
		
		boolean modif = true;
		boolean publ = visible;
		boolean chPubl = (tvannounce.isVisible() != visible);
		
		if(	sdf.format(tvannounce.getStartDate()).equals(startDate) &&
		    ((tvannounce.getFinishDate() == null && finishDate == null) ||
		      finishDate != null && finishDate.equals(sdf.format(tvannounce.getFinishDate()))) &&
			tvannounce.getName().equals(name) &&
			tvannounce.getBrief().equals(brief) &&
			tvannounce.getText().equals(text) &&
			tvannounce.getImg().equals(img) &&
			tvannounce.isImportant() == important) modif= false;

		if( ((modif) && !Admin.isW(pageAccessCode)) ||
			( chPubl && ! Admin.isP( pageAccessCode )) ||
			( modif && publ && !Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( "tvannounces.jsp?err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		
		tvannounce.setTime(langCode, sdf.parse(startDate), startTime, gmtShift);
		//tvannounce.setStartDate( sdf.parse( startDate ) );
		if(finishDate != null)
		    tvannounce.setFinishDate( sdf.parse( finishDate ) );
        else
            tvannounce.setFinishDate( null );

		tvannounce.setName( name);
		tvannounce.setImg( img);
		tvannounce.setBrief( brief);
		tvannounce.setText( text);
		tvannounce.setVisible( visible );
		tvannounce.setImportant( important );

		tvannounce.save();
		
		tengry.ntvmir.HomePage.getInstance(langCode).dropAnnounces();
		
		if( modif )
			try{ Journal.newRecord( currentAdmin, tvannounce, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( (publ) && chPubl )
			try{ Journal.newRecord( currentAdmin, tvannounce, pageId, Journal.ACTION_PUBLIC, "публикация на сайте" ).save();
			}catch( Exception e ){}
		if( !publ && chPubl )
				try{ Journal.newRecord( currentAdmin, tvannounce, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}

		// invalidate cached values
//		clearFrontEntries();
		
		redirect	=  "tvannounces.jsp?action_done=save";
	}catch(Exception e)
	{
		response.sendRedirect( "tvannounces.jsp?err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

if( redirect == null ) 
	redirect = "/admin/tvannounce/tvannounces.jsp?";
response.sendRedirect( redirect );
%>
