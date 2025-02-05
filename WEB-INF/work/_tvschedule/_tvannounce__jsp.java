/*
 * JSP generated by Resin 2.0.5 (built Thu Jan 10 21:43:38 PST 2002)
 */

package _tvschedule;
import javax.servlet.*;
import javax.servlet.jsp.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tengry.ntvmir.tvschedule.*;
import tengry.cms.*;
import tengry.cms.db.*;
import tengry.cms.core.*;
import tengry.cms.user.*;
import tengry.cms.mailer.*;

public class _tvannounce__jsp extends com.caucho.jsp.JavaPage{
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

  
    private static final String [] MONTHS = new String[] {
        "������", "�������", "�����", "������", "���", "����",
        "����", "������", "��������", "�������", "������", "�������"
    };
    private static final String [] DAYS = new String[] {
        "--", "�����������", "�����������", "�������", "�����", "�������", "�������", "�������"
    };
    public String toString(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return  "" + cal.get(Calendar.DATE) + " " + MONTHS[cal.get(Calendar.MONTH)] + 
                    ", <b>" + DAYS[cal.get(Calendar.DAY_OF_WEEK)] + "</b>";
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
      pageContext.write(_jsp_string0, 0, _jsp_string0.length);
      
    String announceId = request.getParameter("announce_id");
    Tvannounce announce = null;
    
try{

	if(previewInfo == null)
	{
	    announce = new Tvannounce();
        announce.load(announceId);
    }
	else
	{
		announce = (Tvannounce)previewInfo.get("article");
	}
	
    
    ShowPlace showPlace = null;
    int gmtShift = 0;
    
    String spId = CMSApplication.getCookie(request, "tvschedule.showplace");
    if(spId != null && spId.length() > 0)
    {
        try{
            showPlace = ShowPlace.getShowPlace(langCode, spId);
        }catch(Exception e)
        {
            showPlace = null;
        }
    }
    
    if(showPlace == null)
    {
        showPlace = ShowPlace.getDefaultShowPlace(langCode);
    }
    
    if(showPlace != null)
        gmtShift = showPlace.getTimeZone().getGmtShift();

      pageContext.write(_jsp_string1, 0, _jsp_string1.length);
      pageContext.write(_jsp_string1, 0, _jsp_string1.length);
      
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
      out.print((des));
      pageContext.write(_jsp_string12, 0, _jsp_string12.length);
      out.print((des));
      pageContext.write(_jsp_string13, 0, _jsp_string13.length);
      out.print((des));
      pageContext.write(_jsp_string14, 0, _jsp_string14.length);
      out.print((des));
      pageContext.write(_jsp_string15, 0, _jsp_string15.length);
      out.print((des));
      pageContext.write(_jsp_string16, 0, _jsp_string16.length);
      out.print((toString(announce.getTvDate(langCode))));
      pageContext.write(_jsp_string17, 0, _jsp_string17.length);
      out.print((announce.getId()));
      pageContext.write(_jsp_string18, 0, _jsp_string18.length);
      out.print((des));
      pageContext.write(_jsp_string19, 0, _jsp_string19.length);
      out.print((des));
      pageContext.write(_jsp_string20, 0, _jsp_string20.length);
      out.print((announce.getImg()));
      pageContext.write(_jsp_string21, 0, _jsp_string21.length);
      out.print((des));
      pageContext.write(_jsp_string22, 0, _jsp_string22.length);
      out.print((announce.getTime(gmtShift)));
      pageContext.write(_jsp_string23, 0, _jsp_string23.length);
      out.print((CMSApplication.toHTML(announce.getName())));
      pageContext.write(_jsp_string24, 0, _jsp_string24.length);
      out.print((announce.getText()));
      pageContext.write(_jsp_string25, 0, _jsp_string25.length);
      out.print((des));
      pageContext.write(_jsp_string26, 0, _jsp_string26.length);
      out.print((langCode));
      pageContext.write(_jsp_string27, 0, _jsp_string27.length);
      out.print((des));
      pageContext.write(_jsp_string28, 0, _jsp_string28.length);
        }catch(Exception e){} 
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
    _caucho_line_map = new com.caucho.java.LineMap("_tvannounce__jsp.java", "/usr/local/apache/htdocs/ntvmir/tvschedule/tvannounce.jsp");
    _caucho_line_map.add("/tvschedule/tvannounce.jsp", 1, 1);
    _caucho_line_map.add("/inc/init_global.jsp", 1, 1);
    _caucho_line_map.add(44, 20);
    _caucho_line_map.add("/usr/local/apache/htdocs/ntvmir/tvschedule/tvannounce.jsp", 48, 33);
    _caucho_line_map.add("/tvschedule/tvannounce.jsp", 1, 64);
    _caucho_line_map.add("/inc/init_global.jsp", 1, 69);
    _caucho_line_map.add("/usr/local/apache/htdocs/ntvmir/tvschedule/tvannounce.jsp", 7, 113);
    _caucho_line_map.add(8, 115);
    _caucho_line_map.add(65, 156);
    _caucho_line_map.add("/inc/path_init.jsp", 1, 156);
    _caucho_line_map.add("/usr/local/apache/htdocs/ntvmir/tvschedule/tvannounce.jsp", 70, 186);
    _caucho_line_map.add(84, 201);
    _caucho_line_map.add(84, 203);
    _caucho_line_map.add(85, 205);
    _caucho_line_map.add(92, 214);
    _caucho_line_map.add(92, 216);
    _caucho_line_map.add(99, 218);
    _caucho_line_map.add(101, 222);
    _caucho_line_map.add(102, 224);
    _caucho_line_map.add(111, 226);
    _caucho_line_map.add(111, 228);
    _caucho_line_map.add(114, 230);
    _caucho_line_map.add(114, 232);
    _caucho_line_map.add(123, 234);
    _caucho_line_map.add(123, 236);
    _caucho_line_map.add(132, 238);
    _caucho_line_map.add(133, 240);
    _caucho_line_map.add(139, 242);
    _caucho_line_map.add(152, 244);
    _caucho_line_map.add(159, 246);
    _caucho_line_map.add(160, 248);
    _caucho_line_map.add(160, 250);
    com.caucho.vfs.Depend depend;
    depend = new com.caucho.vfs.Depend(mergePath.lookup("file:/usr/local/apache/htdocs/ntvmir/inc/init_global.jsp"), 1043852040000L, 1646L);
    _caucho_depends.add(depend);
    depend = new com.caucho.vfs.Depend(mergePath.lookup("file:/usr/local/apache/htdocs/ntvmir/inc/path_init.jsp"), 1043334172000L, 857L);
    _caucho_depends.add(depend);
    depend = new com.caucho.vfs.Depend(mergePath.lookup("file:/usr/local/apache/htdocs/ntvmir/tvschedule/tvannounce.jsp"), 1046707243000L, 5727L);
    _caucho_depends.add(depend);
  }

  private static byte []_jsp_string24;
  private static byte []_jsp_string13;
  private static byte []_jsp_string28;
  private static byte []_jsp_string2;
  private static byte []_jsp_string4;
  private static byte []_jsp_string10;
  private static byte []_jsp_string18;
  private static byte []_jsp_string26;
  private static byte []_jsp_string21;
  private static byte []_jsp_string5;
  private static byte []_jsp_string6;
  private static byte []_jsp_string0;
  private static byte []_jsp_string17;
  private static byte []_jsp_string19;
  private static byte []_jsp_string20;
  private static byte []_jsp_string8;
  private static byte []_jsp_string14;
  private static byte []_jsp_string16;
  private static byte []_jsp_string12;
  private static byte []_jsp_string22;
  private static byte []_jsp_string9;
  private static byte []_jsp_string11;
  private static byte []_jsp_string23;
  private static byte []_jsp_string25;
  private static byte []_jsp_string27;
  private static byte []_jsp_string1;
  private static byte []_jsp_string7;
  private static byte []_jsp_string15;
  private static byte []_jsp_string3;
  static {
    try {
      _jsp_string24 = "</b><br><NOINDEX>\r\n</div>\r\n</a>\r\n</td>\r\n</tr>\r\n<!----//1 ----->\r\n</table>\r\n\r\n</td>\r\n<td></td>\r\n<td>\r\n</NOINDEX>\r\n<div style=\"margin:8px 0px 0px 7px;\" class=\"defFont\">\r\n".getBytes("Cp1251");
      _jsp_string13 = "/blu-ttl-lft.gif\" width=\"16\" height=\"19\" border=\"0\"><img src=\"".getBytes("Cp1251");
      _jsp_string28 = "/tvprogram/btn-prog-lst.gif\" width=\"119\" height=\"18\" alt=\"\" border=\"0\" hspace=\"8\"></a></td></tr>\r\n</table>\r\n".getBytes("Cp1251");
      _jsp_string2 = "\r\n\r\n<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n<tr>\r\n<td width=\"100%\" valign=\"top\" class=\"XsmallFont\">\r\n".getBytes("Cp1251");
      _jsp_string4 = "  \r\n<a href=\"".getBytes("Cp1251");
      _jsp_string10 = "/ttl.gif\" height=\"47\" alt=\"".getBytes("Cp1251");
      _jsp_string18 = "\" target=\"_blank\"><img src=\"".getBytes("Cp1251");
      _jsp_string26 = "/greyln2.gif\"><SPACER TYPE=\"block\" HEIGHT=\"1\" WIDTH=\"1\"></td></tr>		\r\n<tr><td></td><td></td><td><a href=\"/pages/".getBytes("Cp1251");
      _jsp_string21 = "\" width=\"77\" height=\"58\" alt=\"\" border=\"0\"></div></td>\r\n</tr>\r\n<tr>\r\n<td align=\"center\" class=\"smallFont\">\r\n<a class=\"nonUa\">\r\n<div style=\"margin:5px 0px 0px 6px;line-height:130%;\">\r\n<!---- ����� ----->\r\n<table border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"margin-top:4px\">\r\n<tr valign=\"top\">\r\n	<td style=\"background:#FFFFFF url(".getBytes("Cp1251");
      _jsp_string5 = "\">".getBytes("Cp1251");
      _jsp_string6 = "</a> /\r\n".getBytes("Cp1251");
      _jsp_string0 = "\r\n".getBytes("Cp1251");
      _jsp_string17 = "</SPAN>\r\n</div></td>\r\n<td><div style=\"width:7;\"><SPACER TYPE=\"block\" HEIGHT=\"1\" WIDTH=\"7\"></div></td>\r\n<td bgcolor=\"#DDF3E1\" class=\"defFont\" width=\"100%\"><a href=\"/tvschedule/announce_prn.jsp?id=".getBytes("Cp1251");
      _jsp_string19 = "/tvprogram/btn-prnt.gif\" width=\"101\" height=\"10\" alt=\"������ ��� ������\" border=\"0\" align=\"right\" hspace=\"5\" vspace=\"2\"></a></td>\r\n</tr>\r\n\r\n<tr valign=\"top\">\r\n<td align=\"center\">\r\n\r\n<table border=\"0\" width=\"184\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top:8px\">\r\n<!---- 1 ----->\r\n<tr>\r\n<td valign=\"top\" width=\"184\" height=\"87\" background=\"".getBytes("Cp1251");
      _jsp_string20 = "/tvprogram/bg-m-pic.gif\"><div style=\"padding-left:53px;\"><img src=\"".getBytes("Cp1251");
      _jsp_string8 = "\r\n</td>\r\n<!--��������� ��������--><td align=\"right\"><img src=\"".getBytes("Cp1251");
      _jsp_string14 = "/tvprogram/ttl-weekly.gif\" width=\"131\" height=\"19\" alt=\"��������� �� ������\" border=\"0\"></td>\r\n		<td align=\"right\"><img src=\"".getBytes("Cp1251");
      _jsp_string16 = "/tvprogram/ico-cal.gif\" width=\"16\" height=\"12\" alt=\"\" border=\"0\" align=\"absbottom\" hspace=\"3\"><SPAN class=\"grnTtl\">".getBytes("Cp1251");
      _jsp_string12 = "/blu-ttl-bg.gif\" bgcolor=\"#004896\">\r\n	<tr>\r\n		<td nowrap><img src=\"".getBytes("Cp1251");
      _jsp_string22 = "/hm-bg.gif) no-repeat;font-family: Verdana;\" class=\"smallFont\" align=\"center\" height=\"18\"><div style=\"width:36;height:1;\"><SPACER TYPE=\"block\" HEIGHT=\"1\" WIDTH=\"36\"></div>\r\n	<a href=\"\" class=\"nonUa\"><b class=\"bluTtl\">".getBytes("Cp1251");
      _jsp_string9 = "/".getBytes("Cp1251");
      _jsp_string11 = "\" border=\"0\"></td>\r\n</tr>\r\n</table>\r\n\r\n\r\n\r\n<!---- ����������� ��������� �� ������----->\r\n	<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" background=\"".getBytes("Cp1251");
      _jsp_string23 = "</b></a>\r\n	</td>\r\n	<td><div style=\"width:1;\"><SPACER TYPE=\"block\" HEIGHT=\"1\" WIDTH=\"1\"></div></td>\r\n</tr>\r\n</table>\r\n<!----//����� ----->\r\n</NOINDEX><b class=\"bluTtl\">".getBytes("Cp1251");
      _jsp_string25 = "\r\n</div>\r\n<NOINDEX>\r\n</td>\r\n</tr>\r\n\r\n<tr><td height=\"11\" colspan=\"3\"><SPACER TYPE=\"block\" HEIGHT=\"1\" WIDTH=\"1\"></td></tr>		\r\n<!-- divider --><tr><td height=\"11\" colspan=\"3\" background=\"".getBytes("Cp1251");
      _jsp_string27 = "/tvschedule\"><img src=\"".getBytes("Cp1251");
      _jsp_string1 = "\r\n\r\n".getBytes("Cp1251");
      _jsp_string7 = "\r\n</div>\r\n".getBytes("Cp1251");
      _jsp_string15 = "/blu-ttl-rght.gif\" width=\"16\" height=\"19\" border=\"0\"></td>\r\n	</tr>\r\n	</table>\r\n<!----//����������� ��������� �� ������----->\r\n\r\n\r\n<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top:8px;\">\r\n<tr>\r\n<td height=\"20\" bgcolor=\"#DDF3E1\" class=\"defFont\"><div style=\"width:205;\">\r\n&nbsp;<img src=\"".getBytes("Cp1251");
      _jsp_string3 = "\r\n<div style=\"margin-top:8px\">\r\n".getBytes("Cp1251");
    } catch (java.io.UnsupportedEncodingException e) {
      e.printStackTrace();
    }
  }
}
