<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.db.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.user.*"%>
<%@ page import="tengry.northgas.*"%>
<%@ page import="tengry.northgas.mailer.Mailer"%>
<%
	String profilePageId = request.getParameter("profile_page_id");
	String backPageId = request.getParameter("back_page_id");
	
	char lang = ((""+CMSApplication.LANG_ENG).equals(request.getParameter("lang")) ? CMSApplication.LANG_ENG : CMSApplication.LANG_RUS);
	String mode = request.getParameter("mode");
	if("new_user".equals(mode))
	{
		String login = request.getParameter("f_login");
		String pass1 = request.getParameter("f_password");
		String pass2 = request.getParameter("f_password2");
		String company = request.getParameter("f_company");
		String name = request.getParameter("f_name");
		String position = request.getParameter("f_position");
		String countryId = request.getParameter("f_country_id");
		String city = request.getParameter("f_city");
		String address = request.getParameter("f_address");
		String phone = request.getParameter("f_phone");
		String fax = request.getParameter("f_fax");
		String email = request.getParameter("f_email");
		String url = request.getParameter("f_url");
		
		String release = request.getParameter("f_release");
		
		
		String params = "&lang=" + lang +
						"&f_login=" + CMSApplication.URLEncode(login) + "&f_company=" + CMSApplication.URLEncode(company) + 
						"&f_name=" + CMSApplication.URLEncode(name) + "&f_position=" + CMSApplication.URLEncode(position) + 
						"&f_country_id=" + countryId + "&f_city=" + CMSApplication.URLEncode(city) + 
						"&f_address=" + CMSApplication.URLEncode(address) + "&f_phone=" + CMSApplication.URLEncode(phone) + 
						"&f_fax=" + CMSApplication.URLEncode(fax) + "&f_email=" + CMSApplication.URLEncode(email) + 
						"&f_url=" + CMSApplication.URLEncode(url) + "&f_release=" + CMSApplication.URLEncode(release);
		
		if(pass1 == null || pass2 == null || !pass1.equals(pass2))
		{
			response.sendRedirect("/page.jsp?id=" + profilePageId + "&registration=1&error=1" + params);
			return;
		}
		Group priv = CMSApplication.getApplication().getGroupByName("private");
		User user = new User();
		user.setLogin(login);
		user.setPassword(pass1);
		user.setCompany(company);
		user.setFirstName(name);
		user.setLastName(name);
		user.setPosition(position);
		user.setCountryId(countryId);
		user.setCity(city);
		user.setAddress(address);
		user.setPhone(phone);
		user.setFax(fax);
		user.setEmail(email);
		user.setUrl(url);
		
		String ss = request.getParameter("f_release_lang");
		int n = -1;
		try{ n = Integer.parseInt(request.getParameter("f_release_interval")); }catch(Exception e){}
		
		user.setLang(ss != null && ss.length() > 0 ? ss.charAt(0) : 'Z');
		user.setSendintervalPress( n );
		
		try
		{
			user.save();
			user.attachToGroup(priv);
			session.setAttribute("northgas.user", user);

			int newsNum = 0;
			try{ newsNum = Integer.parseInt(request.getParameter("f_news")); }catch(Exception e){}
			for(int i = 0; i < newsNum; i++)
			{
				String newsNodeId = request.getParameter("f_news_id_" + (i+1));
				String lll = request.getParameter("f_news_lang_" + (i+1));
				int nnn = -1;
				try{ nnn = Integer.parseInt(request.getParameter("f_news_interval_" + (i+1))); }catch(Exception e){}
				user.setNewsSubscription(newsNodeId, (lll != null && lll.length() > 0 ? lll.charAt(0): lang), nnn);
			}
		
			String senderEmail = CMSApplication.getApplication().getProperty("mail.sender");
			String body;
			if(lang == CMSApplication.LANG_ENG)
				body = "Congratulations!<br>\n"+
						"You have been successfully registered at Northgas web site<br>\n" + 
						"Your Login: " + login + "<br>\n" + 
						"Your Password: " + pass1 + "<br>\n";
			else
				body =  "Поздравляем!<br>\n" + 
						"Вы успешно прошли регистрацию на сайте Нортгаз<br>\n" + 
						"Ваш Логин: " + login + "<br>\n" + 
						"Ваш Пароль: " + pass1 + "<br>\n";
		
			Mailer letter = new Mailer();
			letter.setRecipient(email);
			letter.setSender( senderEmail);
			letter.setSubject(lang == CMSApplication.LANG_ENG ? "Northgas user registration successful" : "Нортгаз: пользователь зарегистрирован.");
			letter.setBody(body);
			try
			{
				letter.send();
			}
			catch(Exception e){}
		}
		catch(DBException e)
		{
			if(e.getOriginal() != null && e.getOriginal().getMessage() != null && e.getOriginal().getMessage().indexOf("USR_LOGIN_AK") >= 0)
				response.sendRedirect("/page.jsp?id=" + profilePageId + "&registration=1&error=4" + params);
			else if(e.getOriginal() != null && e.getOriginal().getMessage() != null && e.getOriginal().getMessage().indexOf("USR_EMAIL_AK") >= 0)
				response.sendRedirect("/page.jsp?id=" + profilePageId + "&registration=1&error=5" + params);
			else
				response.sendRedirect("/page.jsp?id=" + profilePageId + "&registration=1&error=3" + params);
			return;
		}
		if(backPageId == null || backPageId.length() == 0)
			response.sendRedirect("/page.jsp?id=" + profilePageId + "&reg_ok=1&login=" + login + "&lang=" + lang);
		else
			response.sendRedirect("/page.jsp?id=" + backPageId + "&reg_ok=1&lang=" + lang);
		return;
	}
	



	else if("save_user".equals(mode))
	{
		String pass1 = request.getParameter("f_password");
		String pass2 = request.getParameter("f_password2");
		String company = request.getParameter("f_company");
		String name = request.getParameter("f_name");
		String position = request.getParameter("f_position");
		String countryId = request.getParameter("f_country_id");
		String city = request.getParameter("f_city");
		String address = request.getParameter("f_address");
		String phone = request.getParameter("f_phone");
		String fax = request.getParameter("f_fax");
		String email = request.getParameter("f_email");
		String url = request.getParameter("f_url");
		
		String release = request.getParameter("f_release");
		
		String params = "&lang=" + lang+
						"&f_company=" + CMSApplication.URLEncode(company) + 
						"&f_name=" + CMSApplication.URLEncode(name) + "&f_position=" + CMSApplication.URLEncode(position) + 
						"&f_country_id=" + countryId + "&f_city=" + CMSApplication.URLEncode(city) + 
						"&f_address=" + CMSApplication.URLEncode(address) + "&f_phone=" + CMSApplication.URLEncode(phone) + 
						"&f_fax=" + CMSApplication.URLEncode(fax) + "&f_email=" + CMSApplication.URLEncode(email) + 
						"&f_url=" + CMSApplication.URLEncode(url) + "&f_release=" + CMSApplication.URLEncode(release);
		
		if(pass1 == null || pass2 == null || !pass1.equals(pass2))
		{
			response.sendRedirect("/page.jsp?id=" + profilePageId + "&error=1" + params);
			return;
		}
		
		User user = (User)session.getAttribute("northgas.user");
		if(user == null)
		{
			response.sendRedirect("/page.jsp?id=" + profilePageId + "&error=2" + params);
			return;
		}

		user.setPassword(pass1);
		user.setCompany(company);
		user.setFirstName(name);
		user.setLastName(name);
		user.setPosition(position);
		user.setCountryId(countryId);
		user.setCity(city);
		user.setAddress(address);
		user.setPhone(phone);
		user.setFax(fax);
		user.setEmail(email);
		user.setUrl(url);
		
		String ss = request.getParameter("f_release_lang");
		int n = -1;
		try{ n = Integer.parseInt(request.getParameter("f_release_interval")); }catch(Exception e){}
		
		user.setLang(ss != null && ss.length() > 0 ? ss.charAt(0) : 'Z');
		user.setSendintervalPress( n );
		
		try
		{
			user.save();
			
			int newsNum = 0;
			try{ newsNum = Integer.parseInt(request.getParameter("f_news")); }catch(Exception e){}
			for(int i = 0; i < newsNum; i++)
			{
				String newsNodeId = request.getParameter("f_news_id_" + (i+1));
				String lll = request.getParameter("f_news_lang_" + (i+1));
				int nnn = -1;
				try{ nnn = Integer.parseInt(request.getParameter("f_news_interval_" + (i+1))); }catch(Exception e){}
				
				user.setNewsSubscription(newsNodeId, (lll != null && lll.length() > 0 ? lll.charAt(0): lang), nnn);
			}
		}
		catch(DBException e)
		{
			if(e.getOriginal() != null && e.getOriginal().getMessage() != null && e.getOriginal().getMessage().indexOf("USR_EMAIL_AK") >= 0)
				response.sendRedirect("/page.jsp?id=" + profilePageId + "&error=5" + params);
			else
				response.sendRedirect("/page.jsp?id=" + profilePageId + "&error=3" + params);
			return;
		}
		response.sendRedirect("/page.jsp?id=" + profilePageId + "&lang=" + lang);
		return;
	}


	else if("login".equals(mode))
	{
		String login = request.getParameter("f_login");
		if(login == null)
			login = "";
		User user = User.authorize(request.getParameter("f_login"), request.getParameter("f_password"));
		if(user == null)
		{
			response.sendRedirect("/page.jsp?id=" + profilePageId + "&lang=" + lang + "&error=1&login=" + login);
			return;
		}
		session.setAttribute("northgas.user", user);
		if(backPageId == null && backPageId.length() == 0)
			backPageId = profilePageId;
		response.sendRedirect("/page.jsp?id=" + backPageId + "&lang=" + lang );
		return;
	}
	
	
	
	else if("send_pass".equals(mode))
	{
		String senderEmail = CMSApplication.getApplication().getProperty("mail.sender");
		String email = request.getParameter("email");
		
		DBStatement st = new DBStatement("SELECT m_login, m_password FROM ent_user WHERE lower(m_email)=?");
		RS rs;
		String body = "";
		try
		{
			st.setString(1,email);
			rs = st.executeQuery();
			while(rs.next())
			{
				if(body.length() > 0)
					body += "-------------------------------------------------<br>";
				body += (lang == CMSApplication.LANG_ENG ? "Your login: " : "Ваш логин: ");
				body += rs.getString("m_login") + "<BR>";
				body += (lang == CMSApplication.LANG_ENG ? "Your password: " : "Ваш пароль: ");
				body += rs.getString("m_password") + "<BR>";
			}
		}
		catch(Exception e){}
		
		if(body.length() == 0)
		{
			response.sendRedirect("/page.jsp?id=" + profilePageId + "&lang=" + lang + "&error=2");
			return;
		}
		
		Mailer letter = new Mailer();
		letter.setRecipient(email);
		letter.setSender( senderEmail);
		letter.setSubject(lang == CMSApplication.LANG_ENG ? "Northgas user's password" : "Нортгаз: пароль пользователя.");
		letter.setBody(body);
		try
		{
			letter.send();
			response.sendRedirect("/page.jsp?id=" + profilePageId + "&lang=" + lang + "&ok=1");
			return;
		}
		catch(Exception e)
		{
			response.sendRedirect("/page.jsp?id=" + profilePageId + "&lang=" + lang + "&error=3");
			return;
		}
	}
	
	
	
	
	else if("logout".equals(mode))
	{
		session.setAttribute("northgas.user", null);
		response.sendRedirect("/page.jsp?id=" + profilePageId + "&lang=" + lang );
	}
%>