<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = Product.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>

<%
String mode = request.getParameter( "mode" );

String orderId	= request.getParameter( "orderId" );	// id заказа
String name	= request.getParameter( "name" );		// имя заказчика
String title = request.getParameter( "title" );		// Должность
String organization	= request.getParameter( "organization" );	// компания
String organizationType	= request.getParameter( "comtype" );


String country = request.getParameter( "country" );	// страна
String city = request.getParameter( "city" );	// страна
String address = request.getParameter( "address" );	// страна

String phone = request.getParameter( "phone" );
String fax = request.getParameter( "fax" );
String email = request.getParameter( "email" );

String cond = request.getParameter( "conditions" );


String[] orders	= request.getParameterValues( "orders" );
String[] orderproduct	= request.getParameterValues( "orderproduct" );

SimpleDateFormat sdf = new SimpleDateFormat( "dd.MM.yyyy" );

String href = "orders.jsp";

if( mode != null && (mode.equals( "order_edit" ) || mode.equals( "order_add" ) ) )
{
	Order order	= new Order();

	try
	{
		if( mode.equals( "order_edit" ) )
			order.load( orderId );
		
		boolean isNew = order.getId() == null;
		
		if( ( isNew && ! Admin.isC( pageAccessCode )) ||
			( ! isNew && ! Admin.isW( pageAccessCode )))
		{
			response.sendRedirect( "order_edit.jsp?mode=order_edit&orderId=" + order.getId() + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		
		order.setName( name );
		order.setPosition( title );
		order.setCompany( organization );
		order.setCompanyType( "P".equals(organizationType) ? Order.COMPANY_PRODUCER : Order.COMPANY_TRADER );
		order.setCountryId( country );
		order.setCity( city );
		order.setAddress( address );
		order.setPhone( phone );
		order.setFax( fax );
		order.setEmail( email );
		order.setUrl(request.getParameter("url"));
		order.setFrequency( "Y".equals(request.getParameter("periodic")) ? Order.FREQUENCY_MANY : Order.FREQUENCY_ONE );
		order.setExperience("Y".equals(request.getParameter("reccurance")));
		order.setConditions(cond);
		
		order.save();
		
		int pnum = 0;
		try{ pnum = Integer.parseInt(request.getParameter("f_prod_num")); }catch(Exception e){}
		for(int i = 1; i <= pnum; i++)
		{
			String prodId = request.getParameter("f_prod_id_" + i);
			int prodVal = 0;
			try{ prodVal = Integer.parseInt(request.getParameter("f_volume_" + i)); }catch(Exception e){}
			order.setProduct(prodId, prodVal);
		}
		
		if( isNew )
			try{ Journal.newRecord( currentAdmin, order, pageId, Journal.ACTION_CREATE, "" ).save(); }catch( Exception e ){}
		else
			try{ Journal.newRecord( currentAdmin, order, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		
		orderId = order.getId();
	}
	catch( Exception e )
	{
		response.sendRedirect( "orders.jsp?&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
	
	href = "orders.jsp?action_done=save";
}
else if( mode != null && mode.equals( "del" ) )
{
	try
	{
		if ( orders != null )
		{
			if( orders.length > 0 && ! Admin.isC( pageAccessCode ))
			{
				response.sendRedirect( "orders.jsp?&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}
			for (int i=0; i< orders.length ;i++)
			{
				out.println(orders[ i ]);
				Order ord = new Order();
				ord.load( orders[i] );
				Journal rec = Journal.newRecord( currentAdmin, ord, pageId, Journal.ACTION_DELETE, "" );
				ord.remove();
				try{ rec.save(); }catch( Exception e ){}
			}
		}
		href = "orders.jsp?action_done=del";
	}catch( Exception e )
	{
		response.sendRedirect( "order_edit.jsp?mode=order_edit&orderId=" + orderId + "&err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING );
		return;
	}

	href = "orders.jsp?action_done=del";
}


else if( mode != null && (mode.equals( "set_product" ) ))
{
	String productId = request.getParameter( "product" );
	int quantity = -1;
	try{ quantity = Integer.parseInt(request.getParameter( "quantity" )); }catch(Exception e){}
	
	try
	{
		if( !Admin.isW( pageAccessCode ))
		{
			response.sendRedirect( "order_edit.jsp?mode=order_edit&orderId=" + orderId + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}
		if(productId != null && productId.length() > 0 && quantity > 0)
		{
			Order order = new Order();
			order.load( orderId );
			order.setProduct(productId, quantity);
			Journal rec = Journal.newRecord( currentAdmin, order, pageId, Journal.ACTION_MODIFY, "" );
			try{ rec.save(); }catch( Exception e ){}
		}
	}
	catch( Exception we )
	{
		out.println( we);
	}
	
	href = "order_edit.jsp?mode=order_edit&orderId=" + orderId;
}


else if( mode != null && mode.equals( "order_products_delete" ) )
{
	try
	{
		if ( orderproduct != null )
		{
			if( orderproduct.length > 0 && ! Admin.isW( pageAccessCode ))
			{
				response.sendRedirect( "order_edit.jsp?mode=order_edit&orderId=" + orderId + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
				return;
			}

			Order order = new Order();
			order.load(orderId);
		
			String sProd = "";
			
			for (int i=0; i< orderproduct.length ;i++)
			{
				order.setProduct(orderproduct[ i ], -1);
			}
			try{ Journal.newRecord( currentAdmin, order, pageId, Journal.ACTION_MODIFY, "удаление продуктов").save(); }catch( Exception e ){}
		}
		href = "order_edit.jsp?mode=order_edit&orderId=" + orderId;
	}catch( Exception e )
	{
		href = "order_edit.jsp?mode=order_edit&orderId=" + orderId + "&err=" + CMSApplication.PAGE_ERROR_WHILE_REMOVING;
	}
}

response.sendRedirect( href );
%>