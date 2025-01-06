<%--- ОПРОС ---%>
<%
boolean votePrinted = false;
try{
if(node != null && node.getVoteId() != null)
{
    String userIP = request.getRemoteAddr();
    Vote vote = new Vote();
    vote.load(node.getVoteId());
    Enumeration enum = VoteItem.getVoteItems(vote.getId());
       
    if(!vote.isVotedIP(userIP))
    {
        String voteType = (vote.getSelectorType() == Vote.SELECTOR_RADIO ? "radio" : "checkbox");
%>
<form action="/vote/xt_vote.jsp" method="post">
<input type="hidden" name="id" value="<%=pageId%>">
<input type="hidden" name="vote_id" value="<%=vote.getId()%>">
<tr valign="top">
<td bgcolor="#80AFE0" style="background-image:url(<%=des%>/lft-vt-bg.gif);background-repeat:repeat-x;"><img src="<%=des%>/lft-tn-tr.gif" width="10" height="10" border="0" align="right" hspace="0">
<img src="<%=des%>/ttl-vote.gif" width="37" height="7" border="0" hspace="10" vspace="11"><br>
<div style="margin:0px 30px 0px 10px;" class="defFont">
<b class="bluTtl"><%=CMSApplication.toHTML(vote.getQuestion())%></b><br>
</div>
<%  
        int i = 0;
        while(enum.hasMoreElements())
        {
            VoteItem item = (VoteItem)enum.nextElement();
            i++;
%>
<div style="margin:<%= i==1 ? 6 : 0%>px 30px 0px 6px;" class="defFont">
<input type="<%=voteType%>" name="vote_item_id" value="<%=item.getId()%>" id="vi_<%=i%>" NAME="qwestion"><LABEL for="vi_<%=i%>"><%=CMSApplication.toHTML(item.getItem())%></LABEL>
</div>
<%      } %>
<div  style="text-align:right;"><input type="Image" src="<%=des%>/btn-vote.gif" width="78" height="18" border="0" hspace="10"></div>
</form>
</td>
</tr>
<%





    }
    else
    {






%>
<tr valign="top">
<td height="180" bgcolor="#80AFE0" style="background-image:url(<%=des%>/lft-vt-bg.gif);background-repeat:repeat-x;"><img src="<%=des%>/lft-tn-tr.gif" width="10" height="10" border="0" align="right" hspace="0">
<img src="<%=des%>/ttl-vote.gif" width="37" height="7" border="0" hspace="10" vspace="11"><br>

<!---- ОПРОС РЕЗУЛЬТАТЫ----->

<div style="margin:0px 30px 10px 10px;" class="defFont">
<b class="bluTtl"><%=CMSApplication.toHTML(vote.getQuestion())%></b><br>
</div>
<img src="<%=des%>/t-poll-rslt.gif" width="71" height="24" alt="" border="0" hspace="10"><br>



<div style="margin:0px 10px 0px 10px;" class="smallFont">
<SPAN class="bluTtl">Проголосовало - <B><%=vote.getQuantity()%></B> человек</SPAN>
</div>
	

			
<div style="width:100%; padding:12px 0px 0px 10px;">
		<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" background="">
<%
        java.text.DecimalFormat df = new java.text.DecimalFormat( "##0.0" );

	    while(enum.hasMoreElements())
	    {
	    	VoteItem item = (VoteItem) enum.nextElement();
	    	int l1 = 0;
	    	double pct = 0;
	    	if(vote.getQuantity() > 0 )
	    	{
	    		l1 = (item.getQuantity() * 100) / vote.getQuantity();
	    		pct = ((double)item.getQuantity() * 100.0) / ((double)vote.getQuantity());
	    	}
%>
		<TR VALIGN="bottom"><TD COLSPAN="3" WIDTH="100%" height="20"><SPAN CLASS="XsmallFont" STYLE="color:#FFFFFF"><%=CMSApplication.toHTML(item.getItem())%>  (<%=item.getQuantity()%>)</SPAN></TD></TR>
		<TR VALIGN="bottom">
		<TD height="14" WIDTH="90%">
		<!---- графический индикатор процента голосов   ----->
				<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="0" BGCOLOR="#CCCCCC" WIDTH="95%" background=""><TR><TD><TABLE BORDER="0" CELLPADDING="1" CELLSPACING="0" BGCOLOR="#4F76A9" WIDTH="100%" background=""><TR><TD>
				<!--меняем проценты ячеек таблицы что бы в сумме было 100%--><TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%" background=""><TR><TD WIDTH="<%=l1%>%" HEIGHT="4" BGCOLOR="#8cda9c"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD><TD WIDTH="<%=100-l1%>%"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></TD></TR></TABLE>
				</TD></TR></TABLE></TD></TR></TABLE><DIV STYLE="margin:1px 0px 0px 0px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="1"></DIV>
			<!----//графический индикатор процента голосов  ----->
		</TD>
		<TD align="right" class="bluTtl"><B CLASS="XsmallFont"><%=df.format(pct)%>%</B></TD>
		<td><div style="width:10px;"><SPACER TYPE="block" HEIGHT="1" WIDTH="10"></div></td>
		</TR>
<%      } %>
		</TABLE>
</div>
<BR>
		<!----//ОПРОС РЕЗУЛЬТАТЫ----->
</td>
</tr>
<%
    }
    votePrinted = true;
}
}catch(Exception e){}
%>
<%--- //ОПРОС ---%>