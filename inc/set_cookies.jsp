<%

if("forum".equals(sectionCode))
{
    String forumId = request.getParameter("forum_id");
    String themeId = request.getParameter("theme_id");
    if(forumId != null && themeId == null)
    {
        java.text.SimpleDateFormat forumSdf = new java.text.SimpleDateFormat("dd.MM.yyyy-HH.mm.ss");
        String sDate = forumSdf.format(new Date());
        CMSApplication.setCookie(response, "forum.last_view." + forumId, sDate);
    }
}

if("tvschedule".equals(sectionCode))
{
    String showPlaceId = request.getParameter("show_place_id");
    if(showPlaceId != null)
    {
        CMSApplication.setCookie(response, "tvschedule.showplace", showPlaceId);
    }
}
    
%>