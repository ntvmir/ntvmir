<%!
    private static final String [] TVS_MONTHS = new String[] {
        "Января", "Февраля", "Марта", "Апреля", "Мая", "Июня",
        "Июля", "Авгуса", "Сентября", "Октября", "Ноября", "Декабря"
    };
    private static final String [] TVS_DAYS = new String[] {
        "--", "Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"
    };
    public String TVS_toString(Date date)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return  "" + cal.get(Calendar.DATE) + " " + TVS_MONTHS[cal.get(Calendar.MONTH)] + 
                    ", <b>" + TVS_DAYS[cal.get(Calendar.DAY_OF_WEEK)] + "</b>";
    }
%>
<%
{
    String  sDate   = request.getParameter("date");
    Date    date    = null;
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd.MM.yyyy");

    try{
        date = sdf.parse(sDate);
    } catch(Exception e) {
        date = sdf.parse(sdf.format(new Date()));
    }
    
    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    int nnn = 1;
    switch(cal.get(Calendar.DAY_OF_WEEK))
    {
        case Calendar.MONDAY:       nnn = 1; break;        case Calendar.TUESDAY:      nnn = 2; break;        case Calendar.WEDNESDAY:    nnn = 3; break;
        case Calendar.THURSDAY:     nnn = 4; break;        case Calendar.FRIDAY:       nnn = 5; break;        case Calendar.SATURDAY:     nnn = 6; break;
        case Calendar.SUNDAY:       nnn = 7; break;
    }
    cal.add(Calendar.DATE, -nnn);
    
    for(int i = 0; i < 7; i++)
    {
        cal.add(Calendar.DATE, 1);
        if(i > 0)
        {    
%>
<div><img src="<%=des%>/2lev/lft-ln.gif" width="169" height="1" alt="" border="0" vspace="6"></div>
<%      }
        if(nnn == i+1)
        {
%>
<div class="Lnav"><a class="cur"><%=TVS_toString(cal.getTime())%></a></div>
<%      }
        else
        {
%>
<div class="Lnav"><a href="/pages/<%=langCode%>/tvschedule?date=<%=sdf.format(cal.getTime())%>"><%=TVS_toString(cal.getTime())%></a></div>
<%      }
    }
}
%>