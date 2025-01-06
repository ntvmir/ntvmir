<%!
	static java.util.Vector    componentIds	= new java.util.Vector();
	static java.util.Hashtable components = new java.util.Hashtable();

	static {
		
		componentIds.add( "comp.tree" );
		components.put( "comp.tree", new String[] {
			"Дерево страниц",
			"/admin/tree/tree.jsp",
			"R - просмотр дерева;\n",
			"1000" } );
		

		componentIds.add( "comp.hotlink" );
		components.put( "comp.hotlink", new String[] {
			"Горячая ссылка",
			"/admin/hotlink/hotlink.jsp",	
			"R - просмотр содержимого блока;\n"+
			"W - изменение содержимого блока;\n"+
			"P - публикация блока;",
			"1101" } );

		componentIds.add( "comp.vote" );
		components.put( "comp.vote", new String[] {
			"Голосования",
			"/admin/vote/votes.jsp",	
			"R - просмотр голосований и результатов голосований;\n"+
			"W - изменение голосований;\n"+
			"C - создание и удаление голосований;\n"+
			"P - публикация голосований и размещение голосований в дереве страниц;" } );

		componentIds.add( "SEPARATOR" );
		
		componentIds.add( "comp.dictionary" );
		components.put( "comp.dictionary", new String[] {
			"Металлургический словарь",
			"/admin/dict/terms.jsp",
			"R - просмотр словаря и заявок;\n"+
			"W - редактирование терминов;\n"+
			"C - добавление, удаление терминов, удаление заявок, добавление термина по заявке;\n"+
			"P - публикация терминов;" } );

		componentIds.add( "comp.design" );
		components.put( "comp.design", new String[] {
			"Варианты дизайна",
			"/admin/design/design.jsp",
			"R - просмотр раздела;\n"+
			"W - установка дизайна сайта;\n",
			"1100" } );

		componentIds.add( "comp.stock.course" );
		components.put( "comp.stock.course", new String[] {
			"Курс акций",
			"/admin/stock/markets.jsp",
			"R - просмотр курса акций и информации о биржах;\n"+
			"W - изменение бирж, типов акций и курса акций;\n" +
			"C - добавление, удаление бирж и типов акций, очистка курсов акций;\n" +
			"P - публикация бирж и типов акций;\n",
			"1111" } );

	
		componentIds.add( "SEPARATOR" );

		componentIds.add( "comp.order" );
		components.put( "comp.order", new String[] {
			"Заказы",
			"/admin/order/order_menu.jsp",
			"R - просмотр заказов и продуктов;\n"+
			"W - редактирование заказов и продуктов;\n"+
			"C - добавление и удаление заказов и продуктов;\n" + 
			"P - публикация продуктов;" } );


		componentIds.add( "comp.file" );
		components.put( "comp.file", new String[] {
			"Файлы",
			"/admin/upload/upload.jsp",
			"R - просмотр файлов и директорий;\n"+
			"W - переименование файлов и директорий;\n"+
			"C - создание директорий, загрузка файлов, удаление файлов и директорий;\n",
			"1110" } );

		

		componentIds.add( "SEPARATOR" );

		componentIds.add( "comp.message" );
		components.put( "comp.message", new String[] {
			"Сообщения для рассылки",
			"/admin/message/messages.jsp",
			"R - просмотр сообщений;\n"+
			"W - редактирование сообщений;\n"+
			"С - добавление и удаление сообщений;\n"+
			"P - постановка сообщения в очередь на рассылку или снятие сообщения из очереди на рассылку;",
			"1111" } );

		/*
		componentIds.add( "comp.unsubscribe" );
		components.put( "comp.unsubscribe", new String[] {
			"Отключение от подписки",
			"/admin/unsubscribe.jsp",
			"R - использование раздела",
			"1000" } );
		*/

		componentIds.add( "comp.subscribers" );
		components.put( "comp.subscribers", new String[] {
			"Подписчики",
			"/admin/subscribers.jsp",
			"R - просмотр списка подписчиков;\n"+
			"W - редактирование подписчиков;",
			"1100" } );

		componentIds.add( "comp.news_maler" );
		components.put( "comp.news_maler", new String[] {
			"Параметры рассылки новостей",
			"/admin/news_mailer.jsp",
			"R - просмотр новостных параметров;\n"+
			"W - редактирование новостных параметров;",
			"1100" } );

		componentIds.add( "comp.mailer" );
		components.put( "comp.mailer", new String[] {
			"Рассылка",
			"/admin/mailer.jsp",
			"R - просмотр параметров рассылки;\n"+
			"W - редактирование параметров рассылки;\n"+
			"P - запуск, активизация и останов рассылки;",
			"1101" } );

		
		componentIds.add( "SEPARATOR" );
		
		componentIds.add( "global.news" );
		components.put( "global.news", new String[] {
			"Новости",
			"/admin/news/news.jsp?mode=edit&pageId=global.news",
			"R - просмотр новостей;\n"+
			"W - редактирование новостей;\n"+
			"C - добавление и удаление новостей;\n" +
			"P - публикация новостей;" } );


		componentIds.add( "comp.press.release" );
		components.put( "comp.press.release", new String[] {
			"Пресс-релизы",
			"/admin/pressa/release.jsp",
			"R - просмотр пресс-релизов;\n"+
			"W - редактирование пресс-релизов;\n"+
			"C - добавление и удаление пресс-релизов;\n" +
			"P - публикация пресс-релизов;" } );

		componentIds.add( "comp.press.digest" );
		components.put( "comp.press.digest", new String[] {
			"Пресса о ГМК",
			"/admin/pressa/digest.jsp",
			"R - просмотр статей;\n"+
			"W - редактирование статей;\n"+
			"C - добавление и удаление статей;\n" + 
			"P - публикация статей;" } );
		

		componentIds.add( "comp.faq.themes" );
		components.put( "comp.faq.themes", new String[] {
			"Вопрос-ответы",
			"/admin/faq/index.jsp",
			"R - просмотр тем и вопросов;\n" +
			"W - редактирование тем и вопросов;\n" + 
			"С - создание и удаление тем, удаление вопросов;\n" + 
			"P - публикация тем и вопросов;\n" } );


		componentIds.add( "SEPARATOR" );

		componentIds.add( "comp.admin" );
		components.put( "comp.admin", new String[] {
			"Администраторы",
			"/admin/admin/admins.jsp",
			"R - просмотр раздела;\n"+
			"W - изменение свойств и прав доступа администраторов;\n"+
			"C - регистрация и удаление администраторов;\n",
			"1110" } );



		

			
		componentIds.add( "comp.journal" );
		components.put( "comp.journal", new String[] {
			"Журнал изменений",
			"/admin/journal.jsp",
			"R - просмотр журнала;\n",
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
