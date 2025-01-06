<%!
    
    public void printTree(boolean firstCall, String des, String id, Vector nodes, 
                            String pre, String post, JspWriter out) throws IOException
    {
        if(nodes == null || nodes.size() == 0)
            return;
        pre += "<div class=\"Lnav\">";
        post += "</div>";
        Enumeration enum = nodes.elements();
        while(enum.hasMoreElements())
        {
            WebTreeNode node = (WebTreeNode)enum.nextElement();
            if(firstCall)
                firstCall = false;
            else
                out.println(
                    "<div><img src=\"" + des + "/2lev/lft-ln.gif\" width=\"169\" height=\"1\" alt=\"\" border=\"0\" vspace=\"6\"></div>");

            if(id.equals(node.getId()))
                out.print(pre + "<a class=\"cur\"><b>");
            else
                out.print(pre + "<a href=\"" + nodePath(node) + "\"><b>");
            out.print(CMSApplication.toHTML(node.getName()));
            out.println("</b></a>" + post);
            printTree(false, des, id, node.getVisibleChilds(), pre, post, out);
        }
    
    }
%>
<%
    if(node != null)
    {
        WebTreeNode ttt = node;
        while(ttt.getParent() != null && ttt.getParent().getParent() != null)
            ttt = ttt.getParent();
        
        printTree(true, des, pageId, ttt.getVisibleChilds(), "", "", out);
    }
%>