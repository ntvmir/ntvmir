<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ include file="/inc/init_global.jsp"%>
<%
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
%>
<%@ include file="/inc/path_init.jsp"%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign="top" class="XsmallFont">
<%
    if(pagePath.size() > 1)
    {
%>
<div style="margin-top:8px">
<%  
        for(int i = 0; i < pagePath.size(); i++)
        {
            WebTreeNode treeNode = (WebTreeNode)pagePath.elementAt(i);
            if(i+1 == pagePath.size())
                out.println(CMSApplication.toHTML(treeNode.getName()));
            else
            {
%>  
<a href="<%=nodePath(treeNode)%>"><%=CMSApplication.toHTML(treeNode.getName())%></a> /
<%
            }
        }
%>
</div>
<%  } %>
</td>
<!--заголовок страницы--><td align="right"><img src="<%=des%>/<%=sectionImg%>/ttl.gif" height="47" alt="<%=sectionName%>" border="0"></td>
</tr>
</table>
</NOINDEX>
<div style="text-align: justify;" class="defFont">
<%=frameContent%>
</div>
<NOINDEX>
<%
	if(frameCount > 1)
	{
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:3px;">
	<tr>
	<td align="right" width="100%">
<%		if(num != 1){ %>
	<a href="<%=nodePath(pageId)%>?num=<%=num-1%><%=previewParam%>"><img src="<%=des%>/btn-arr-blu-prew.gif" width="18" height="18" border="0" hspace="5" alt="Предыдущая"></a>
<%  } %>
	<img src="<%=des%>/dvder.gif" width="9" height="9" border="0" vspace="4">
<%		if(num < frameCount){ %>
	<a href="<%=nodePath(pageId)%>?num=<%=num+1%><%=previewParam%>"><img src="<%=des%>/btn-arr-blu.gif" width="18" height="18" border="0" hspace="5" alt="Следующая"></a>
<%  } %>
    </td>
	<td><div style="width:11;"><SPACER TYPE="block" HEIGHT="1" WIDTH="11"></div></td>
	</tr>
</table>

<%------------------------------

		<TABLE WIDTH="480" BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="margin-top:7;">
	
		<!--separator BOTTOM -->
		<TR><TD HEIGHT="1" BGCOLOR="#DDE6F0" COLSPAN="2"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD></TR>
		<TR><TD HEIGHT="7" COLSPAN="2"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD></TR>		
		<TR>
<%		if(num > 1){ %>
		<TD><SPAN CLASS="smallFont"><A HREF="/page.jsp?id=<%=pageId%>&num=1<%=previewParam%>">в начало</A></SPAN></TD>
<%		}else{ %>
		<TD></TD>
<%		} %>
		<TD ALIGN="right"><SPAN CLASS="smallFont">


<%		if(num == 1){ %>

<%		}else{ %>
		<A HREF="/page.jsp?id=<%=pageId%>&num=<%=num-1%><%=previewParam%>">предыдущая</A>
<%		} %>
		<IMG SRC="<%=des%>/main/v_dotz.gif" WIDTH="1" HEIGHT="16" ALT="" BORDER="0" VSPACE="0" HSPACE="3">
<%		if(num < frameCount){ %>
		<A HREF="/page.jsp?id=<%=pageId%>&num=<%=num+1%><%=previewParam%>">следующая</A>
<%		} %>
        </SPAN>
		</TD>
		</TR>
		</TABLE>
----------------------------%>
<%
	}
}
catch(Exception e)
{
	out.println("<!-- " + e + " -->");
	out.println("<B>Ошибка при загрузке страницы.<B>");
}
%>












