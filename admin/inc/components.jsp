<%!
	static java.util.Vector    componentIds	= new java.util.Vector();
	static java.util.Hashtable components = new java.util.Hashtable();

	static {
		
		componentIds.add( "comp.tree" );
		components.put( "comp.tree", new String[] {
			"������ �������",
			"/admin/tree/tree.jsp",
			"R - �������� ������;\n",
			"1000" } );
		

		componentIds.add( "comp.hotlink" );
		components.put( "comp.hotlink", new String[] {
			"������� ������",
			"/admin/hotlink/hotlink.jsp",	
			"R - �������� ����������� �����;\n"+
			"W - ��������� ����������� �����;\n"+
			"P - ���������� �����;",
			"1101" } );

		componentIds.add( "comp.vote" );
		components.put( "comp.vote", new String[] {
			"�����������",
			"/admin/vote/votes.jsp",	
			"R - �������� ����������� � ����������� �����������;\n"+
			"W - ��������� �����������;\n"+
			"C - �������� � �������� �����������;\n"+
			"P - ���������� ����������� � ���������� ����������� � ������ �������;" } );

		componentIds.add( "SEPARATOR" );
		
		componentIds.add( "comp.dictionary" );
		components.put( "comp.dictionary", new String[] {
			"���������������� �������",
			"/admin/dict/terms.jsp",
			"R - �������� ������� � ������;\n"+
			"W - �������������� ��������;\n"+
			"C - ����������, �������� ��������, �������� ������, ���������� ������� �� ������;\n"+
			"P - ���������� ��������;" } );

		componentIds.add( "comp.design" );
		components.put( "comp.design", new String[] {
			"�������� �������",
			"/admin/design/design.jsp",
			"R - �������� �������;\n"+
			"W - ��������� ������� �����;\n",
			"1100" } );

		componentIds.add( "comp.stock.course" );
		components.put( "comp.stock.course", new String[] {
			"���� �����",
			"/admin/stock/markets.jsp",
			"R - �������� ����� ����� � ���������� � ������;\n"+
			"W - ��������� ����, ����� ����� � ����� �����;\n" +
			"C - ����������, �������� ���� � ����� �����, ������� ������ �����;\n" +
			"P - ���������� ���� � ����� �����;\n",
			"1111" } );

	
		componentIds.add( "SEPARATOR" );

		componentIds.add( "comp.order" );
		components.put( "comp.order", new String[] {
			"������",
			"/admin/order/order_menu.jsp",
			"R - �������� ������� � ���������;\n"+
			"W - �������������� ������� � ���������;\n"+
			"C - ���������� � �������� ������� � ���������;\n" + 
			"P - ���������� ���������;" } );


		componentIds.add( "comp.file" );
		components.put( "comp.file", new String[] {
			"�����",
			"/admin/upload/upload.jsp",
			"R - �������� ������ � ����������;\n"+
			"W - �������������� ������ � ����������;\n"+
			"C - �������� ����������, �������� ������, �������� ������ � ����������;\n",
			"1110" } );

		

		componentIds.add( "SEPARATOR" );

		componentIds.add( "comp.message" );
		components.put( "comp.message", new String[] {
			"��������� ��� ��������",
			"/admin/message/messages.jsp",
			"R - �������� ���������;\n"+
			"W - �������������� ���������;\n"+
			"� - ���������� � �������� ���������;\n"+
			"P - ���������� ��������� � ������� �� �������� ��� ������ ��������� �� ��������� ��������;",
			"1111" } );

		/*
		componentIds.add( "comp.unsubscribe" );
		components.put( "comp.unsubscribe", new String[] {
			"���������� �� ��������",
			"/admin/unsubscribe.jsp",
			"R - ������������� �������",
			"1000" } );
		*/

		componentIds.add( "comp.subscribers" );
		components.put( "comp.subscribers", new String[] {
			"����������",
			"/admin/subscribers.jsp",
			"R - �������� ������ �����������;\n"+
			"W - �������������� �����������;",
			"1100" } );

		componentIds.add( "comp.news_maler" );
		components.put( "comp.news_maler", new String[] {
			"��������� �������� ��������",
			"/admin/news_mailer.jsp",
			"R - �������� ��������� ����������;\n"+
			"W - �������������� ��������� ����������;",
			"1100" } );

		componentIds.add( "comp.mailer" );
		components.put( "comp.mailer", new String[] {
			"��������",
			"/admin/mailer.jsp",
			"R - �������� ���������� ��������;\n"+
			"W - �������������� ���������� ��������;\n"+
			"P - ������, ����������� � ������� ��������;",
			"1101" } );

		
		componentIds.add( "SEPARATOR" );
		
		componentIds.add( "global.news" );
		components.put( "global.news", new String[] {
			"�������",
			"/admin/news/news.jsp?mode=edit&pageId=global.news",
			"R - �������� ��������;\n"+
			"W - �������������� ��������;\n"+
			"C - ���������� � �������� ��������;\n" +
			"P - ���������� ��������;" } );


		componentIds.add( "comp.press.release" );
		components.put( "comp.press.release", new String[] {
			"�����-������",
			"/admin/pressa/release.jsp",
			"R - �������� �����-�������;\n"+
			"W - �������������� �����-�������;\n"+
			"C - ���������� � �������� �����-�������;\n" +
			"P - ���������� �����-�������;" } );

		componentIds.add( "comp.press.digest" );
		components.put( "comp.press.digest", new String[] {
			"������ � ���",
			"/admin/pressa/digest.jsp",
			"R - �������� ������;\n"+
			"W - �������������� ������;\n"+
			"C - ���������� � �������� ������;\n" + 
			"P - ���������� ������;" } );
		

		componentIds.add( "comp.faq.themes" );
		components.put( "comp.faq.themes", new String[] {
			"������-������",
			"/admin/faq/index.jsp",
			"R - �������� ��� � ��������;\n" +
			"W - �������������� ��� � ��������;\n" + 
			"� - �������� � �������� ���, �������� ��������;\n" + 
			"P - ���������� ��� � ��������;\n" } );


		componentIds.add( "SEPARATOR" );

		componentIds.add( "comp.admin" );
		components.put( "comp.admin", new String[] {
			"��������������",
			"/admin/admin/admins.jsp",
			"R - �������� �������;\n"+
			"W - ��������� ������� � ���� ������� ���������������;\n"+
			"C - ����������� � �������� ���������������;\n",
			"1110" } );



		

			
		componentIds.add( "comp.journal" );
		components.put( "comp.journal", new String[] {
			"������ ���������",
			"/admin/journal.jsp",
			"R - �������� �������;\n",
			"1000" } );

	}
	
	java.util.Enumeration getComponentIds()
	{
		return componentIds.elements();
	}	
	
	String getComponentName( String id )
	{
		String[] a = (String[])components.get( id );
		if( a != null ) return a[0];
		return "";
	}
	String getComponentURL( String id )
	{
		String[] a = (String[])components.get( id );
		if( a != null ) return a[1];
		return "";
	}
	
	String getComponentAccessDescription( String id )
	{
		String[] a = (String[])components.get( id );
		if( a != null ) return a[2];
		return "";
	}

	int getComponentCheckboxes( String id )
	{
		int r = tengry.northgas.Admin.ACCESS_READ;
		int w = tengry.northgas.Admin.ACCESS_WRITE;
		int c = tengry.northgas.Admin.ACCESS_CREATE;
		int p = tengry.northgas.Admin.ACCESS_PUBL;
		
		String[] a = (String[])components.get( id );
		if( a != null && a.length > 3 )
		{
			int res = 0;
			String s = a[3];
			if( '1' == s.charAt( 0 )) res |= r;
			if( '1' == s.charAt( 1 )) res |= w;
			if( '1' == s.charAt( 2 )) res |= c;
			if( '1' == s.charAt( 3 )) res |= p;
			return res;
		}
		return r | w | c | p ;
	}
%>
