<%!
	void printNavigator(int pageNumber, int pageSize, int count, String href, String width, JspWriter out) 
		throws java.io.IOException
	{
		out.println("<TABLE BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\" WIDTH=\"" + width + "\">");
		out.println("<TR>");
		out.println("<TD WIDTH=\"1%\">&nbsp;</TD>");
		out.println("<TD COLSPAN=\"2\">Всего " + count + "<BR><IMG SRC=\"/admin/inc/bnalk.gif\" WIDTH=\"1\" HEIGHT=\"6\"><BR></TD>");
		out.println("</TR>");
		out.println("<TR>");
		out.println("<TD><IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"6\" HEIGHT=\"1\"><BR></TD>");
		out.println("<TD WIDTH=\"100%\">");
		
		int pages = 1 + (count - 1)/pageSize;
		for(int i = 1; i <= pages; i++)
		{
			if(i > 1)
				out.print(" | ");
			if(i != pageNumber)
				out.println("<A CLASS=\"m\" HREF=\"" + href + "&page_number=" + i + "\">" + i + "</A>");
			else
				out.println("<A CLASS=\"mcur\">" + i + "</A>");
		}
		int last = pageNumber*pageSize;
		if(last > count) 
			last = count;
		out.println("</TD>");
		out.println("<TD WIDTH=\"10%\"><NOBR>с " + (1+ (pageNumber-1)*pageSize) + " по " + last + "</NOBR></TD>");
		out.println("</TR>");
		out.println("<TR><TD COLSPAN=\"3\"><IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"1\" HEIGHT=\"3\"><BR>" +
					"<IMG SRC=\"/admin/img/grey.gif\" WIDTH=\"" + width + "\" HEIGHT=\"1\" ALT=\"\" BORDER=\"0\"><BR>" +
					"<IMG SRC=\"/admin/img/blank.gif\" WIDTH=\"1\" HEIGHT=\"6\"><BR></TD></TR>");
		out.println("</TABLE>");
	}
%>