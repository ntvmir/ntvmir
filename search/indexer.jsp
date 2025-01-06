<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.db.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.cms.faq.*"%>
<%@ page import="tengry.cms.press.*"%>
<%@ page import="tengry.ntvmir.tvschedule.*"%>
<%  response.setHeader("Pragma","no-cache"); %>
<%!
    private static final int PRESS_NUM = 20;
    private static final int ANNOUNCE_NUM = 15;
    private static final int FAQ_NUM = 3;
    
%>
<HTML>
<BODY>
<noindex><h3>—траница дл€ индексировани€ сайта.</h3></noindex>
<%
    String langCode = CMSApplication.getApplication().getPrimaryLangCode();
    WebTreeNode rootNode = CMSApplication.getApplication().getWebRoot(langCode);
    lll = 1;
    printTree(langCode, rootNode, out);
%>
</BODY>
</HTML>
<%!
    int lll = 1;
    public void printTree(String langCode, WebTreeNode node, JspWriter out) throws Exception
    {
        String typeCode = node.getPageType().getCode();
        if("static".equals(typeCode))
            out.println("<li><a href=\"" + nodePath(node) + "\"><noindex>" + (lll++) + " "  + CMSApplication.toHTML(node.getName()) + "</noindex></a>");
        else
        {
            out.println("<li><noindex>" + CMSApplication.toHTML(node.getName()) + "</noindex>");
            printItems(langCode, node, out);
        }
        Enumeration enum = node.getVisibleChilds().elements();
        boolean firstLoop = true;
        while(enum.hasMoreElements())
        {
            if(firstLoop)
            {
                firstLoop = false;
                out.println("<ul>");
            }
            printTree(langCode, (WebTreeNode)enum.nextElement(), out);
            
        }
        if(!firstLoop)
            out.println("</ul>");
    }
    
    public String nodePath(WebTreeNode node)
    {
        if(node == null)
            return "/pages";
        return nodePath(node.getParent()) + "/" + node.getCode();
    }
    
    public void printItems(String langCode, WebTreeNode node, JspWriter out) throws Exception
    {
        String typeCode = node.getPageType().getCode();

        if("news".equals(typeCode) || "article".equals(typeCode))
        {
            Press press = null;
            if("news".equals(typeCode))
                press = new News(DBObject.LOAD_LIST);
            else
                press = new Article(DBObject.LOAD_LIST);

            Enumeration enum = Press.getPress(PRESS_NUM, press, node.getId(), true);
            boolean firstLoop = true;
            while(enum.hasMoreElements())
            {
                Press p = (Press)enum.nextElement();
                if(firstLoop)
                {
                    firstLoop = false;
                    out.println("<UL>");
                }
                out.println("<LI><A HREF=\"" + nodePath(node) + "?press_id=" + p.getId() + "\"><NOINDEX>" + 
                    (lll++) + " " +
                    CMSApplication.toHTML(p.getCaption()) + "</NOINDEX></A>");
            }
            if(!firstLoop)
                out.println("</UL>");
        }
        else if("tvannounce".equals(typeCode))
        {
            Enumeration enum = Tvannounce.getTvannounces(langCode, null, null, Tvannounce.LOAD_PUB_TRUE, 1, ANNOUNCE_NUM).elements();
            boolean firstLoop = true;
            while(enum.hasMoreElements())
            {
                Tvannounce ann = (Tvannounce)enum.nextElement();
                if(firstLoop)
                {
                    firstLoop = false;
                    out.println("<UL>");
                }
                out.println("<LI><A HREF=\"" + nodePath(node) + "?announce_id=" + ann.getId() + "\"><NOINDEX>" + 
                    (lll++) + " " +
                    CMSApplication.toHTML(ann.getName()) + "</NOINDEX></A>");
            }
            if(!firstLoop)
                out.println("</UL>");
        }
        else if("faq".equals(typeCode))
        {
            Enumeration enum = FaqCategory.getFaqCategoryList(node.getId()).elements();
            boolean firstLoop = true;
            while(enum.hasMoreElements())
            {
                FaqCategory theme = (FaqCategory)enum.nextElement();
                if(firstLoop)
                {
                    firstLoop = false;
                    out.println("<UL>");
                }
                for(int i = 1; i <= FAQ_NUM; i++)
                    out.println("<LI><A HREF=\"" + nodePath(node) + "?theme_id=" + theme.getId() + 
                        "&page_number=" + i + "\"><NOINDEX>" + 
                        (lll++) + " " +
                        CMSApplication.toHTML(theme.getName()) + " (сртаница " + i + ")</NOINDEX></A>");
            }
            if(!firstLoop)
                out.println("</UL>");
        }
    }
%>







