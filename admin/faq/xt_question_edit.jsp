<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%
	// set the Service name for authorization
	String pageId = FaqCategory.SERVICE_CODE;
%>
<%@ include file="/admin/inc/page_init.jsp"%>
<%
	String id = request.getParameter( "id" );
    String loadType = request.getParameter( "load_type" );

	String mode = "edit";
	
	boolean visible = "1".equals(request .getParameter("visible"));
	String question = request.getParameter("question");
	String user_name = request.getParameter("user_name");
	String user_email = request.getParameter("user_email");
	String answer = request.getParameter("answer");
	String ans_name = request.getParameter("ans_name");

	FaqQuestion faq = new FaqQuestion();
	faq.load(id);
	
	String redirect = "questions.jsp?id=" + faq.getFaqCategoryId() + "&load_type=" + loadType;

if( "edit".equals(mode))
{
	try
	{
		boolean modif = true;
		boolean publ = visible;
		boolean chPubl = (faq.isVisible() != visible);
		
		if(	faq.getUserName().equals(user_name) &&
		    faq.getEmail().equals(user_email) &&
			faq.getQuestion().equals(question) &&
			faq.getAnswer().equals(answer) &&
			faq.getAnswerName().equals(ans_name)) modif= false;

		if( ((modif) && !Admin.isW(pageAccessCode)) ||
			( chPubl && ! Admin.isP( pageAccessCode )) ||
			( modif && publ && !Admin.isP( pageAccessCode )))
		{
			response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_NO_PERMISSIONS );
			return;
		}

        faq.setVisible(visible);
        faq.setUserName(user_name);
        faq.setEmail(user_email);
        faq.setQuestion(question);
        faq.setAnswer(answer);
        faq.setAnswerName(ans_name);
        if(faq.getAnswerDate() == null)
            faq.setAnswerDate(new Date());

		faq.save();
		
		if( modif )
			try{ Journal.newRecord( currentAdmin, faq, pageId, Journal.ACTION_MODIFY, "" ).save(); }catch( Exception e ){}
		if( (publ) && chPubl )
			try{ Journal.newRecord( currentAdmin, faq, pageId, Journal.ACTION_PUBLIC, "" ).save(); }catch( Exception e ){}
		if( !publ && chPubl )
			try{ Journal.newRecord( currentAdmin, faq, pageId, Journal.ACTION_UNPUBL, "" ).save(); }catch( Exception e ){}

		redirect += "&action_done=save";
	}catch(Exception e)
	{
		response.sendRedirect( redirect + "&err=" + CMSApplication.PAGE_ERROR_WHILE_SAVING );
		return;
	}
}

response.sendRedirect( redirect );
%>
