<%
tengry.cms.core.Admin currentAdmin = (tengry.cms.core.Admin)session.getValue( "admin.user" );
int pageAccessCode = 0;
if( currentAdmin == null )
{
	response.sendRedirect( "/admin/login.jsp" );
	return;
}
else pageAccessCode = currentAdmin.getAccessCode(pageId);

if( ! tengry.cms.core.Admin.isR(pageAccessCode) && ! "admin.index".equals(pageId))
{
	response .sendRedirect( "/admin/index.jsp?err=" + tengry.cms.CMSApplication.PAGE_ERROR_ACCESS_DENIED );
	return;
}
%>
