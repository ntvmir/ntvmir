<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.mailer.Mailer"%>
<%@ include file="/inc/init_global.jsp"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%
    String action = request.getParameter("action");
    String backPageId = request.getParameter("back_page_id");
    if("".equals(backPageId) || "null".equals(backPageId))
        backPageId = null;
    if("out".equals(action))
    {
        session.setAttribute("ntvmir.user", null);
        CMSApplication.delCookie(response, "user.id");
        response.sendRedirect(nodePath(pageId));
        return;
    }
    else if("login".equals(action))
    {
        try
        {
            String login    = request.getParameter("login");
            String password = request.getParameter("password");
            user = User.authorize(login, password);
            if(user != null)
            {
                if("1".equals(request.getParameter("quick_auth")))
                    CMSApplication.setCookie(response, "user.id", user.getIdentifier());
                else
                    CMSApplication.delCookie(response, "user.id");

                session.setAttribute("ntvmir.user", user);
                String redirect = null;
                if(backPageId != null)
                {
                    redirect = nodePath(backPageId);
                }
                else
                {
                    redirect = nodePath(pageId);
                }
                response.sendRedirect(redirect);
                return;
            }
            else
            {
                response.sendRedirect(nodePath(pageId) + "?err=auth");
                return;
            }
        }catch(Exception e){
            response.sendRedirect(nodePath(pageId) + "?err=auth");
            return;
        }
    }
    else if("save".equals(action) && user == null)
    {
		String login = request.getParameter("login");
//		String pass1 = request.getParameter("password");
//		String pass2 = request.getParameter("password2");
		String name = request.getParameter("name");
		String country = request.getParameter("country");
		String city = request.getParameter("city");
		String icq = request.getParameter("icq");
		String email = request.getParameter("email");
		String url = request.getParameter("url");
		String extra = request.getParameter("extra");
		String sign = request.getParameter("sign");
		String visible = request.getParameter("visible");
        
		String params = "";
/*
		String params = "&f_login=" + CMSApplication.URLEncode(login) + "&f_company=" + CMSApplication.URLEncode(company) + 
						"&f_name=" + CMSApplication.URLEncode(name) + "&f_position=" + CMSApplication.URLEncode(position) + 
						"&f_country_id=" + countryId + "&f_city=" + CMSApplication.URLEncode(city) + 
						"&f_address=" + CMSApplication.URLEncode(address) + "&f_phone=" + CMSApplication.URLEncode(phone) + 
						"&f_fax=" + CMSApplication.URLEncode(fax) + "&f_email=" + CMSApplication.URLEncode(email) + 
						"&f_url=" + CMSApplication.URLEncode(url) + "&f_release=" + CMSApplication.URLEncode(release);
*/
/*
		if(pass1 == null || pass2 == null || !pass1.equals(pass2))
		{
			response.sendRedirect(nodePath(pageId) + "?create=1&err=1" + params);
			return;
		}
*/
		try
		{
		    Group priv = CMSApplication.getApplication().getGroupByName("private");

            String pass = User.createPassword();
		    user = new User();
		    user.setLogin(login);
		    user.setPassword(pass);
		    user.setName(name);
		    user.setCountry(country);
		    user.setCity(city);
		    user.setEmail(email);
		    user.setUrl(url);
		    user.setIcq(icq);
		    user.setDescription(extra);
		    user.setForumSign(sign);
		    user.setVisible("1".equals(visible));

    		user.save();
			user.attachToGroup(priv);

            /* не будем логинить нового юзера...  путь авторизуется сам.
			    session.setAttribute("ntvmir.user", user);
            */
            
            String dlvNewsId = request.getParameter("subscr_news");
            String dlvTvId = request.getParameter("subscr_tv");
            String showPlaceId = request.getParameter("show_place_id");
            
            if("1".equals(request.getParameter("cookie_gmt")))
                CMSApplication.setCookie(response, "tvschedule.showplace", showPlaceId);

            try
            {
                if(dlvNewsId != null && dlvNewsId.length() > 0)
                    user.subscribe(dlvNewsId);
                if(dlvTvId != null && dlvTvId.length() > 0)
                    user.subscribe(dlvTvId, showPlaceId);
            }
            catch(Exception e){}
            
            
			String senderEmail = CMSApplication.getApplication().getProperty("mail.sender");
			String body =  "Поздравляем!<br>\n" + 
						"Вы успешно прошли регистрацию на сайте НТВ-Мир<br>\n" + 
						"Ваш Логин: " + login + "<br>\n" + 
						"Ваш Пароль: " + pass + "<br>\n";
		
			Mailer letter = new Mailer();
			letter.setRecipient(email);
			letter.setSender(senderEmail);
			letter.setSubject("НТВ-Мир: пользователь зарегистрирован.");
			letter.setBody(body);
			try
			{
				letter.send();
			}
			catch(Exception e){}
		}
		catch(DBException e)
		{
			if(e.getOriginal() != null && e.getOriginal().getMessage() != null && e.getOriginal().getMessage().indexOf("USR_UNI_LOGIN") >= 0)
				response.sendRedirect(nodePath(pageId) + "?create=1&err=login" + params);
			else if(e.getOriginal() != null && e.getOriginal().getMessage() != null && e.getOriginal().getMessage().indexOf("USR_UNI_EMAIL") >= 0)
				response.sendRedirect(nodePath(pageId) + "?create=1&err=email" + params);
			else
				response.sendRedirect(nodePath(pageId) + "?create=1&err=save" + params);
			return;
		}
		if(backPageId != null)
            response.sendRedirect(nodePath(backPageId));
        else
            response.sendRedirect(nodePath(pageId) + "?reg_ok=1");
		return;
    }
    else if("save".equals(action) && user != null)
    {
		String pass1 = request.getParameter("password");
		String pass2 = request.getParameter("password2");
		String name = request.getParameter("name");
		String country = request.getParameter("country");
		String city = request.getParameter("city");
		String icq = request.getParameter("icq");
		String email = request.getParameter("email");
		String url = request.getParameter("url");
		String extra = request.getParameter("extra");
		String sign = request.getParameter("sign");
        String visible = request.getParameter("visible");
        
        String params = "";
/*
		String params = "&lang=" + lang+
						"&f_company=" + CMSApplication.URLEncode(company) + 
						"&f_name=" + CMSApplication.URLEncode(name) + "&f_position=" + CMSApplication.URLEncode(position) + 
						"&f_country_id=" + countryId + "&f_city=" + CMSApplication.URLEncode(city) + 
						"&f_address=" + CMSApplication.URLEncode(address) + "&f_phone=" + CMSApplication.URLEncode(phone) + 
						"&f_fax=" + CMSApplication.URLEncode(fax) + "&f_email=" + CMSApplication.URLEncode(email) + 
						"&f_url=" + CMSApplication.URLEncode(url) + "&f_release=" + CMSApplication.URLEncode(release);
*/

		if(pass1 == null || pass2 == null || !pass1.equals(pass2))
		{
			response.sendRedirect(nodePath(pageId) + "?err=1" + params);
			return;
		}
		
		if(pass1.length() > 0)
		    user.setPassword(pass1);

		user.setName(name);
		user.setCountry(country);
		user.setCity(city);
		user.setEmail(email);
		user.setUrl(url);
		user.setIcq(icq);
		user.setDescription(extra);
		user.setForumSign(sign);
		user.setVisible("1".equals(visible));
		
		try
		{
			user.save();
			
			user.unsubscribe();
            
            String dlvNewsId = request.getParameter("subscr_news");
            String dlvTvId = request.getParameter("subscr_tv");
            String showPlaceId = request.getParameter("show_place_id");
            
            if("1".equals(request.getParameter("cookie_gmt")))
                CMSApplication.setCookie(response, "tvschedule.showplace", showPlaceId);
            
            try
            {
                if(dlvNewsId != null && dlvNewsId.length() > 0)
                    user.subscribe(dlvNewsId);
                if(dlvTvId != null && dlvTvId.length() > 0)
                    user.subscribe(dlvTvId, showPlaceId);
            }
            catch(Exception e){}
		}
		catch(DBException e)
		{
			if(e.getOriginal() != null && e.getOriginal().getMessage() != null && e.getOriginal().getMessage().indexOf("USR_EMAIL_AK") >= 0)
				response.sendRedirect(nodePath(pageId) + "?err=email" + params);
			else
				response.sendRedirect(nodePath(pageId) + "?err=save" + params);
			return;
		}
    }
	else if("send_pass".equals(action))
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
				body += "Ваш логин: ";
				body += rs.getString("m_login") + "<BR>";
				body += "Ваш пароль: ";
				body += rs.getString("m_password") + "<BR>";
			}
		}
		catch(Exception e){}
		
		if(body.length() == 0)
		{
			response.sendRedirect(nodePath(pageId) + "?error=email");
			return;
		}
		
		Mailer letter = new Mailer();
		letter.setRecipient(email);
		letter.setSender( senderEmail);
		letter.setSubject("НТВ-Мир: пароль пользователя.");
		letter.setBody(body);
		try
		{
			letter.send();
			response.sendRedirect(nodePath(pageId) + "?ok=1");
			return;
		}
		catch(Exception e)
		{
			response.sendRedirect(nodePath(pageId) + "?error=3");
			return;
		}
	}
    
    response.sendRedirect(nodePath(pageId));
    return;
%>