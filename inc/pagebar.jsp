<%!
	void printPagebar(int pageNumber, int pageSize, int count, String href, JspWriter out) 
		throws java.io.IOException
	{
		out.print("<b>На страницу:</b> ");

		int pages = 1 + (count - 1)/pageSize;
		for(int i = 1; i <= pages; i++)
		{
			if(i > 1)
				out.print(", ");
				
		    if(i == 4 && pageNumber > 6)
		    {
		        out.print("...");
	            i = pageNumber-2;
		        continue;
		    }
            if(i == pageNumber + 2 && pages-pageNumber > 5)
            {
		        out.print("...");
	            i = pages-2;
	            continue;
	        }
		    
			if(i != pageNumber)
				out.print("<a href=\"" + href + "&page_number=" + i + "\">" + i + "</a>");
			else
				out.print("" + i);
		}
		if(pageNumber < pages)
		    out.print(" <a href=\"\">След</a>.");
	}
%>