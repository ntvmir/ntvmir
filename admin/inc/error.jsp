<%	
	try
	{
		int PAGE_ERROR = -1;
		try
		{ 
			PAGE_ERROR = Integer.parseInt( request.getParameter( "err" )); 
		}
		catch( Exception e )
		{
			PAGE_ERROR = -1;
		}
		
		if( PAGE_ERROR >= 0 )
		{
%>
<B STYLE="color: red">
<%
			switch( PAGE_ERROR )
			{
				case tengry.cms.CMSApplication.PAGE_ERROR_NO_PERMISSIONS:
					out.println( "Нет прав для выполнения данной операции." ); break;
				case tengry.cms.CMSApplication.PAGE_ERROR_WHILE_SAVING:
					out.println( "Ошибка при сохранении." ); break;
				case tengry.cms.CMSApplication.PAGE_ERROR_WHILE_REMOVING:
					out.println( "Ошибка при удалении." ); break;
				case tengry.cms.CMSApplication.PAGE_ERROR_ACCESS_DENIED:
					out.println( "Доступ закрыт." ); break;
				default:
					out.println( "Ошибка." ); break;
			}
%>
</B><BR><BR><BR>
<%
		} 
	}
	catch( Exception e ){}
%>

