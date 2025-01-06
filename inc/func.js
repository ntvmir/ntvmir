function trim(str)
{
	var spaceChars = " ";
	var p1 = 0;
	var p2 = str.length - 1;
	
	if(str == null)
		return '';
	
	while(p1<=p2)
	{
		
		if(spaceChars.indexOf(str.charAt(p1)) < 0)
			break;
		p1 ++;
	}
	while(p2 > p1)
	{
		if(spaceChars.indexOf(str.charAt(p2)) < 0)
			break;
		p2 --;
	}
	if(p1 > p2)
		return '';
	
	return str.substring(p1, p2+1);
}

function isTime( dbdate ) {
	var numStr="0123456789";
	var thisChar;
	var month;
	var year;
	var len;
   
	len = dbdate.length;
	if ( len != 8 )
    	return false;
    
	for (var i=0; i<len; i++)
	{
		thisChar=dbdate.substring(i,i+1);
		if (i==2 || i==5)
		{
			if ((thisChar!=":")) //(thisChar!=".") && (thisChar!="/") && 
				return false;
		}
		else
		{
			if ((numStr.indexOf(thisChar,0) == -1))
				return false;
		}
	}

	//проверка корректности часа
	hour=dbdate.substring(0,2);
	if (hour>23 || hour<0)
		return false;     

	//проверка корректности минут
	minute=dbdate.substring(3,5);
	if (minute>59 || minute<0)
		return false;     

	//проверка корректности секунд
	second=dbdate.substring(6,8);
	if (second>59 || second<0)
		return false;     

	return true;
}
function isShortTime( dbdate ) {
	var numStr="0123456789";
	var thisChar;
	var month;
	var year;
	var len;
   
	len = dbdate.length;
	if ( len != 5 )
    	return false;
    
	for (var i=0; i<len; i++)
	{
		thisChar=dbdate.substring(i,i+1);
		if (i==2)
		{
			if ((thisChar!=":")) //(thisChar!=".") && (thisChar!="/") && 
				return false;
		}
		else
		{
			if ((numStr.indexOf(thisChar,0) == -1))
				return false;
		}
	}

	//проверка корректности часа
	hour=dbdate.substring(0,2);
	if (hour>23 || hour<0)
		return false;     

	//проверка корректности минут
	minute=dbdate.substring(3,5);
	if (minute>59 || minute<0)
		return false;     

	return true;
}
function isDateAndShortTimeOrSpace( value )
{
	var thisChar;
	var time;
	var date;
	var len;

	date = value.substring(0,10);
	if ( !isDate(date) )
		return false;

	len = value.length;
	if ( len==10 )
		return true;

	thisChar=value.substring(10,11);
	if ( thisChar!=" " )
		return false;

	time = value.substring(11);
	if ( !isShortTime(time) )
		return false;

	return true;
}

 function isDate(dbdate)
  {
   var numStr="0123456789";
   var thisChar;
   var month;
   var year;
   var len;
    
   len = dbdate.length;
   if (len!=10)
    {
     return false;
    }
   for (var i=0; i<len; i++)
    {
     thisChar=dbdate.substring(i,i+1);
     if (i==2 || i==5)
      {
       if ((thisChar!=".") && (thisChar!="/") && (thisChar!=":"))
        {
         return false;
        }
      }
     else
      {
       if ((numStr.indexOf(thisChar,0) == -1))
        {
         return false;     
        }
      }
    }
			
//проверка корректности месяца
month=dbdate.substring(3,5);
if (month>12)
 {
  return false;     
 }
else
 {

//проверка корректности числа
  if (month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12)
   {
    thisChar=dbdate.substring(0,2);
    if (thisChar>31)
     {
      return false;     
     }
   }
  if (month==4 || month==6 || month==9 || month==11)
   {
    thisChar=dbdate.substring(0,2);
    if (thisChar>30)
     {
      return false;     
     }
   }
  if (month==2)
   {
    year=dbdate.substring(6,len);
    year=year-(Math.round(year/4)*4);
    if (year==0)
     {
      thisChar=dbdate.substring(0,2);
      if (thisChar>29)
       {
        return false;     
       }
     }
    else
     {
      thisChar=dbdate.substring(0,2);
      if (thisChar>28)
       {
        return false;     
      }
       }
     }
   }
  return true;
}

function isNumber( digit )
{
	var numStr="0123456789";
	var thisChar;
	var len;
	
	len = digit.length;
	if( len == 0 )
		return false;
    
	for (var i=0; i<len; i++)
    {
		thisChar=digit.substring(i,i+1);
	    if (thisChar != "." &&
			numStr.indexOf(thisChar,0) == -1)
        {
			return false;
        }
    }

	return true;
}

function isValid(what,chars) {
	//проверяет, что все символы из what принадлежат множеству chars
	//если what пустая - ошибка
	if (what=="") {
		return false;
	}
	bool1=false;
	for (count1=0; (count1<what.length)&&(!bool1);count1++) {
		bool2=false;
		for (count2=0; (count2<chars.length)&&(!bool2);count2++) {
			if (what.charCodeAt(count1)==chars.charCodeAt(count2)) {
				bool2=true;
			}
		}
		if (!bool2) {
			bool1=true;
		}
	}
	return !bool1;
 }

function isEmail(strEmail) 
{
	var letters="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var numbers="0123456789";
	
	var name="";
	var server="";
	var strings  = new Array();

	//Данная функция проверяет строку strEmail на соответствие формату почтового адреса.
	//При этом строка разбивается на составные части:
	//имя_пользователя@сервер

	if (strEmail=="") {
		return (false);
	}
	//разделяем строку на имя пользователя и имя сервера
	strings=strEmail.split("@");
	if (strings.length==1) {
		return false;
	} else if (strings.length==2) {
		name=strings[0];
		server=strings[1];
	} else {
		return false;
	}
	
	//проверка имени на допустимость символов
	if (!isValid(name,letters+numbers+"._-")) {
		return false;
	}
	
	//разделяем имя сервера на составные части
	strings=server.split(".");
	if (strings.length<2) {
		return false;
	}
	//проверяем каждую часть на допустимые символы
	for (i=0;i<strings.length;i++) {
		if (!isValid(strings[i],letters+numbers+"_-")) {
			return false;
		}
	}
	
	return true;
 }
