<%@ page import="java.util.*"%>
<%@page import="tengry.cms.db.*"%>
<%@page import="tengry.cms.*"%>
<%@page import="tengry.cms.core.*"%>
<%@page import="java.sql.*"%>

<%
	String m_query = request .getParameter("query");
	if(m_query != null)
	{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Vector res = null;
		try
		{
			conn = CMSApplication.getApplication().getConnection();
			stmt = conn.prepareStatement(m_query);
			rs = stmt.executeQuery();
			ResultSetMetaData m_meta_data = rs.getMetaData();
			out.println("<TABLE BORDER=\"1\" CELLPADDING=\"5\">");
			out.println("<TR>");
			out.println("<TH>getColumnName</TH>");
			out.println("<TH>getColumnClassName</TH>");
			out.println("<TH>getColumnLabel</TH>");
			out.println("<TH>getColumnType</TH>");
			out.println("<TH>getColumnTypeName</TH>");
			out.println("</TR>");
			for(int i = 1; i <= m_meta_data.getColumnCount(); i++)
			{
				out.println("<TR>");
				out.println("<TD>" + m_meta_data.getColumnName(i) + "</TD>");
				out.println("<TD>" + m_meta_data.getColumnClassName(i) + "</TD>");
				out.println("<TD>" + m_meta_data.getColumnLabel(i) + "</TD>");
				out.println("<TD>" + m_meta_data.getColumnType(i) + "</TD>");
				out.println("<TD>" + m_meta_data.getColumnTypeName(i) + "</TD>");
				out.println("</TR>");
			}
			out.println("</TABLE>");
		}
		catch(SQLException e)
		{
			throw e;
		}
		finally
		{
			try{ if(rs != null){ rs.close(); rs = null; }}catch(Exception e){}
			try{ if(stmt != null){ stmt.close(); stmt = null; }}catch(Exception e){}
			try{
				if(conn != null)
				{
					conn.close();
				}
				conn = null;
			}catch(Exception e)
			{
				throw new CantCloseConnectionException("Can't close connection after executing query '" + m_query + "'", e);
			}
		}
		
		try{
			DBStatement st = new DBStatement("SELECT * FROM " + (new Design()).getEntityName() + " WHERE m_selected=?");
			st.setBoolean(1, true);
			Vector v = st.executeQuery(new Design());
			if(v.size() == 0)
				throw new DBException("Selected design not found");
			out.println(((Design)v.firstElement()).getName());

		}catch(Exception e)
		{
			out.println(e);
		}			

	}
%>


<FORM ACTION="tst.jsp">
<INPUT name="query" size="100" VALUE="<%=m_query != null ? m_query : ""%>">
<input type="submit">
</FORM>
