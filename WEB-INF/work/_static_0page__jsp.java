/*
 * JSP generated by Resin 2.0.5 (built Thu Jan 10 21:43:38 PST 2002)
 */

import javax.servlet.*;
import javax.servlet.jsp.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tengry.cms.*;
import tengry.cms.core.*;
import tengry.cms.db.*;
import tengry.cms.user.*;
import tengry.cms.mailer.*;

public class _static_0page__jsp extends com.caucho.jsp.JavaPage{
  private boolean _caucho_isDead;
  
public String nodePath(WebTreeNode node)
{
    if(node == null)
        return "/pages";
    return nodePath(node.getParent()) + "/" + node.getCode();
}

public String nodePath(String nodeId)
{
    return nodePath(CMSApplication.getApplication().lookup(nodeId));
}

  
  public void
  _jspService(javax.servlet.http.HttpServletRequest request,
              javax.servlet.http.HttpServletResponse response)
    throws java.io.IOException, javax.servlet.ServletException
  {
    com.caucho.jsp.QPageContext pageContext = (com.caucho.jsp.QPageContext) com.caucho.jsp.QJspFactory.create().getPageContext(this, request, response, null, true, 8192, true);
    javax.servlet.jsp.JspWriter out = (javax.servlet.jsp.JspWriter) pageContext.getOut();
    javax.servlet.ServletConfig config = getServletConfig();
    javax.servlet.Servlet page = this;
    javax.servlet.http.HttpSession session = pageContext.getSession();
    javax.servlet.ServletContext application = pageContext.getServletContext();
    response.setContentType("text/html; charset=windows-1251");
    request.setCharacterEncoding("CP1251");
    try {
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      
	String      langCode        = null;
	String      pageId          = null;
	String      des             = null;
    User        user            = null;

    langCode = request.getParameter("lang_code");
    if(langCode == null || langCode.trim().length() == 0)
        langCode = CMSApplication.getApplication().getPrimaryLangCode();

	des = CMSApplication.getApplication().getCurrentDesignPath() + "/" + langCode;

	pageId = request.getParameter("id");
	if("".equals(pageId))
		pageId = null;
		
    user = (User)session.getAttribute("ntvmir.user");
    if(user == null)
    {
        String usrid = CMSApplication.getCookie(request, "user.id");
        if(usrid != null && usrid.length() > 0)
        {
            try
            {
                user = User.quickAuthorize(usrid);
            }catch(Exception e){}
        }
    }

	boolean     adminPreview    = false;
	Hashtable   previewInfo     = null;
	adminPreview = (session.getValue("admin.user") != null && "1".equals(request.getParameter("preview")));
	
	previewInfo = (Hashtable)session.getAttribute("admin.previewinfo");
	if(!adminPreview)
		previewInfo = null;

      pageContext.write(_jsp_string1, 0, _jsp_string1.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      
response.setHeader("Pragma","no-cache");
int num = 1;
try{ num = Integer.parseInt(request.getParameter("num")); }catch(Exception e){}

String previewParam = (adminPreview ? "&preview=1" : "");
try
{
	int frameCount = 0;
	String frameContent = "";
	if(previewInfo == null)
	{
		frameCount = StaticPage.getStaticPageCount(pageId);
		if(num > frameCount)
			num = frameCount;
		StaticPage frame = StaticPage.getStaticPage(pageId, num);
		if(frame != null)
			frameContent = frame.getContent();
	}
	else
	{
		Vector frames = (Vector)previewInfo.get("frames");
		if(frames != null)
		{
			frameCount = frames.size();
			frameContent = (String)frames.elementAt(num-1);
		}
	}

      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      
	Vector pagePath = new Vector();
	String sectionImg = "company";
	String sectionName = "� ��������";
	if(pageId != null)
	{
	    WebTreeNode treeNode = CMSApplication.getApplication().lookup(pageId);
	    while(treeNode != null && treeNode.getParent() != null)
	    {
	        pagePath.insertElementAt(treeNode, 0);
	        sectionImg = treeNode.getCode();
	        sectionName = treeNode.getName();
	        treeNode = treeNode.getParent();
	    }
	}
	if(adminPreview && previewInfo != null)
	{
	    sectionImg = (String)previewInfo.get("section");
	    if(sectionImg == null)
	        sectionImg = "about";
	    
	}
	if("about".equals(sectionImg))
	    sectionImg = "company";
	else if("tvschedule".equals(sectionImg))
	    sectionImg = "tvprogram";
	else if("auth".equals(sectionImg))
	    sectionImg = "authorization";

      pageContext.write(_jsp_string2, 0, _jsp_string2.length);
      
    if(pagePath.size() > 1)
    {

      pageContext.write(_jsp_string3, 0, _jsp_string3.length);
        
        for(int i = 0; i < pagePath.size(); i++)
        {
            WebTreeNode treeNode = (WebTreeNode)pagePath.elementAt(i);
            if(i+1 == pagePath.size())
                out.println(CMSApplication.toHTML(treeNode.getName()));
            else
            {

      pageContext.write(_jsp_string4, 0, _jsp_string4.length);
      out.print((nodePath(treeNode)));
      pageContext.write(_jsp_string5, 0, _jsp_string5.length);
      out.print((CMSApplication.toHTML(treeNode.getName())));
      pageContext.write(_jsp_string6, 0, _jsp_string6.length);
      
            }
        }

      pageContext.write(_jsp_string7, 0, _jsp_string7.length);
        } 
      pageContext.write(_jsp_string8, 0, _jsp_string8.length);
      out.print((des));
      pageContext.write(_jsp_string9, 0, _jsp_string9.length);
      out.print((sectionImg));
      pageContext.write(_jsp_string10, 0, _jsp_string10.length);
      out.print((sectionName));
      pageContext.write(_jsp_string11, 0, _jsp_string11.length);
      out.print((frameContent));
      pageContext.write(_jsp_string12, 0, _jsp_string12.length);
      
	if(frameCount > 1)
	{

      pageContext.write(_jsp_string13, 0, _jsp_string13.length);
      		if(num != 1){ 
      pageContext.write(_jsp_string14, 0, _jsp_string14.length);
      out.print((nodePath(pageId)));
      pageContext.write(_jsp_string15, 0, _jsp_string15.length);
      out.print((num-1));
      out.print((previewParam));
      pageContext.write(_jsp_string16, 0, _jsp_string16.length);
      out.print((des));
      pageContext.write(_jsp_string17, 0, _jsp_string17.length);
        } 
      pageContext.write(_jsp_string18, 0, _jsp_string18.length);
      out.print((des));
      pageContext.write(_jsp_string19, 0, _jsp_string19.length);
      		if(num < frameCount){ 
      pageContext.write(_jsp_string14, 0, _jsp_string14.length);
      out.print((nodePath(pageId)));
      pageContext.write(_jsp_string15, 0, _jsp_string15.length);
      out.print((num+1));
      out.print((previewParam));
      pageContext.write(_jsp_string16, 0, _jsp_string16.length);
      out.print((des));
      pageContext.write(_jsp_string20, 0, _jsp_string20.length);
        } 
      pageContext.write(_jsp_string21, 0, _jsp_string21.length);
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      
	}
}
catch(Exception e)
{
	out.println("<!-- " + e + " -->");
	out.println("<B>������ ��� �������� ��������.<B>");
}

      pageContext.write(_jsp_string22, 0, _jsp_string22.length);
    } catch (java.lang.Throwable _jsp_e) {
      pageContext.handlePageException(_jsp_e);
    } finally {
      JspFactory.getDefaultFactory().releasePageContext(pageContext);
    }
  }

  private com.caucho.java.LineMap _caucho_line_map;
  private java.util.ArrayList _caucho_depends = new java.util.ArrayList();

  public boolean _caucho_isModified()
  {
    if (_caucho_isDead)
      return true;
    if (com.caucho.util.CauchoSystem.getVersionId() != 2058990002)
      return true;
    for (int i = _caucho_depends.size() - 1; i >= 0; i--) {
      com.caucho.vfs.Depend depend;
      depend = (com.caucho.vfs.Depend) _caucho_depends.get(i);
      if (depend.isModified())
        return true;
    }
    return false;
  }

  public long _caucho_lastModified()
  {
    return 0;
  }

  public com.caucho.java.LineMap _caucho_getLineMap()
  {
    return _caucho_line_map;
  }

  public void destroy()
  {
      _caucho_isDead = true;
      super.destroy();
  }

  public void init(com.caucho.java.LineMap lineMap,
                   com.caucho.vfs.Path appDir)
    throws javax.servlet.ServletException
  {
    com.caucho.vfs.Path resinHome = com.caucho.util.CauchoSystem.getResinHome();
    com.caucho.vfs.MergePath mergePath = new com.caucho.vfs.MergePath();
    mergePath.addMergePath(appDir);
    mergePath.addMergePath(resinHome);
    mergePath.addClassPath(getClass().getClassLoader());
    _caucho_line_map = new com.caucho.java.LineMap("_static_0page__jsp.java", "/usr/local/apache/htdocs/ntvmir/static_page.jsp");
    _caucho_line_map.add("/static_page.jsp", 1, 1);
    _caucho_line_map.add("/inc/init_global.jsp", 1, 1);
    _caucho_line_map.add(44, 18);
    _caucho_line_map.add("/static_page.jsp", 1, 46);
    _caucho_line_map.add("/inc/init_global.jsp", 1, 52);
    _caucho_line_map.add("/usr/local/apache/htdocs/ntvmir/static_page.jsp", 8, 96);
    _caucho_line_map.add(37, 126);
    _caucho_line_map.add("/inc/path_init.jsp", 1, 126);
    _caucho_line_map.add("/usr/local/apache/htdocs/ntvmir/static_page.jsp", 42, 156);
    _caucho_line_map.add(56, 171);
    _caucho_line_map.add(56, 173);
    _caucho_line_map.add(57, 175);
    _caucho_line_map.add(64, 184);
    _caucho_line_map.add(64, 186);
    _caucho_line_map.add(69, 188);
    _caucho_line_map.add(72, 190);
    _caucho_line_map.add(80, 195);
    _caucho_line_map.add(81, 197);
    _caucho_line_map.add(81, 199);
    _caucho_line_map.add(81, 200);
    _caucho_line_map.add(81, 202);
    _caucho_line_map.add(82, 204);
    _caucho_line_map.add(83, 206);
    _caucho_line_map.add(84, 208);
    _caucho_line_map.add(85, 210);
    _caucho_line_map.add(85, 212);
    _caucho_line_map.add(85, 213);
    _caucho_line_map.add(85, 215);
    _caucho_line_map.add(86, 217);
    _caucho_line_map.add(122, 220);
    com.caucho.vfs.Depend depend;
    depend = new com.caucho.vfs.Depend(mergePath.lookup("file:/usr/local/apache/htdocs/ntvmir/inc/init_global.jsp"), 1043852040000L, 1646L);
    _caucho_depends.add(depend);
    depend = new com.caucho.vfs.Depend(mergePath.lookup("file:/usr/local/apache/htdocs/ntvmir/inc/path_init.jsp"), 1043334172000L, 857L);
    _caucho_depends.add(depend);
    depend = new com.caucho.vfs.Depend(mergePath.lookup("file:/usr/local/apache/htdocs/ntvmir/static_page.jsp"), 1046858578000L, 3853L);
    _caucho_depends.add(depend);
  }

  private static byte []_jsp_string2;
  private static byte []_jsp_string4;
  private static byte []_jsp_string10;
  private static byte []_jsp_string13;
  private static byte []_jsp_string5;
  private static byte []_jsp_string6;
  private static byte []_jsp_string0;
  private static byte []_jsp_string18;
  private static byte []_jsp_string20;
  private static byte []_jsp_string8;
  private static byte []_jsp_string17;
  private static byte []_jsp_string12;
  private static byte []_jsp_string16;
  private static byte []_jsp_string9;
  private static byte []_jsp_string15;
  private static byte []_jsp_string19;
  private static byte []_jsp_string21;
  private static byte []_jsp_string22;
  private static byte []_jsp_string1;
  private static byte []_jsp_string11;
  private static byte []_jsp_string7;
  private static byte []_jsp_string3;
  private static byte []_jsp_string14;
  static {
    try {
      _jsp_string2 = "\r\n\r\n<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n<tr>\r\n<td width=\"100%\" valign=\"top\" class=\"XsmallFont\">\r\n".getBytes("Cp1251");
      _jsp_string4 = "  \r\n<a href=\"".getBytes("Cp1251");
      _jsp_string10 = "/ttl.gif\" height=\"47\" alt=\"".getBytes("Cp1251");
      _jsp_string13 = "\r\n\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"margin-top:3px;\">\r\n	<tr>\r\n	<td align=\"right\" width=\"100%\">\r\n".getBytes("Cp1251");
      _jsp_string5 = "\">".getBytes("Cp1251");
      _jsp_string6 = "</a> /\r\n".getBytes("Cp1251");
      _jsp_string0 = "\r\n".getBytes("Cp1251");
      _jsp_string18 = "\r\n	<img src=\"".getBytes("Cp1251");
      _jsp_string20 = "/btn-arr-blu.gif\" width=\"18\" height=\"18\" border=\"0\" hspace=\"5\" alt=\"���������\"></a>\r\n".getBytes("Cp1251");
      _jsp_string8 = "\r\n</td>\r\n<!--��������� ��������--><td align=\"right\"><img src=\"".getBytes("Cp1251");
      _jsp_string17 = "/btn-arr-blu-prew.gif\" width=\"18\" height=\"18\" border=\"0\" hspace=\"5\" alt=\"����������\"></a>\r\n".getBytes("Cp1251");
      _jsp_string12 = "\r\n</div>\r\n<NOINDEX>\r\n".getBytes("Cp1251");
      _jsp_string16 = "\"><img src=\"".getBytes("Cp1251");
      _jsp_string9 = "/".getBytes("Cp1251");
      _jsp_string15 = "?num=".getBytes("Cp1251");
      _jsp_string19 = "/dvder.gif\" width=\"9\" height=\"9\" border=\"0\" vspace=\"4\">\r\n".getBytes("Cp1251");
      _jsp_string21 = "\r\n    </td>\r\n	<td><div style=\"width:11;\"><SPACER TYPE=\"block\" HEIGHT=\"1\" WIDTH=\"11\"></div></td>\r\n	</tr>\r\n</table>\r\n\r\n".getBytes("Cp1251");
      _jsp_string22 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n".getBytes("Cp1251");
      _jsp_string1 = "\r\n\r\n".getBytes("Cp1251");
      _jsp_string11 = "\" border=\"0\"></td>\r\n</tr>\r\n</table>\r\n</NOINDEX>\r\n<div style=\"text-align: justify;\" class=\"defFont\">\r\n".getBytes("Cp1251");
      _jsp_string7 = "\r\n</div>\r\n".getBytes("Cp1251");
      _jsp_string3 = "\r\n<div style=\"margin-top:8px\">\r\n".getBytes("Cp1251");
      _jsp_string14 = "\r\n	<a href=\"".getBytes("Cp1251");
    } catch (java.io.UnsupportedEncodingException e) {
      e.printStackTrace();
    }
  }
}
