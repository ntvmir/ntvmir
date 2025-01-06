<%!
	public boolean isPagePrivate(String id) throws DBException
	{
		Group g1 = CMSApplication.getApplication().getGroupByName("default");
		Group g2 = CMSApplication.getApplication().getGroupByName("private");
		if(g1 != null && g2 != null)
		{
			return !Group.isR(g1.getAccessCode(id)) && 
					Group.isR(g2.getAccessCode(id));
		}
		else return false;
	}
%>