<%@page contentType="text/html; charset=windows-1251"%>
<%@page import="java.util.*"%>
<%!
    private int indexOf(StringBuffer text, String str, int idx)
    {
        if(str == null)
            str = "";
        char [] s = str.toCharArray();
        int i = idx;
        while(i <= text.length() - s.length)
        {
            int j;
            for(j = 0; j < s.length && s[j] == text.charAt(i+j); j++);
            if(j == s.length)
                return i;
        }
        
        return -1;
    }
%>

<%
	String str = request.getParameter("str");
	String text = request.getParameter("text");
	if(str == null) str = "";
	if(text == null) text = "";
	StringBuffer ttt = new StringBuffer(text);
	int idx = -1;
	do
	{
	    idx = indexOf(ttt, str, idx+1);
	    out.println("" + idx + "<br>");
	}while(idx >= 0);
%>
<FORM>
<INPUT name="str" size=80 VALUE="<%=str == null ? "" : str%>"><br>
<textarea name=text><%=text%></textarea><br>
<input type=submit value=go VALUE=""><br>
</form>
