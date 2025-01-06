<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

<%
	String wysiwygName = "";
	int wysiwygWidth = -1;
	int wysiwygHeight = -1;
	String wysiwygValue = "";
%>

<STYLE>
.wysiwyg_button {
	border-left: 1 solid #D4D0C8;
	border-right : 1 solid #D4D0C8;
	border-top : 1 solid #D4D0C8;
	border-bottom : 1 solid #D4D0C8;
}
.wysiwyg_buttonOver {
	border-left: 1 solid #ffffff;
	border-right : 1 solid #808080;
	border-top : 1 solid #ffffff;
	border-bottom : 1 solid #808080;
}
.wysiwyg_buttonDown {
	border-left: 1 solid #808080;
	border-right : 1 solid #ffffff;
	border-top : 1 solid #808080;
	border-bottom : 1 solid #ffffff;
}
</STYLE>

<SCRIPT LANGUAGE="javascript">
var wysiwygSrcFlag		= new Array();
var wysiwygFocusFlag	= new Array();

im1		= '/admin/img/editor/cut.gif';
im1_n	= '/admin/img/editor/cut_na.gif';

im2		= '/admin/img/editor/copy.gif';
im2_n	= '/admin/img/editor/copy_na.gif';

im3		= '/admin/img/editor/paste.gif';
im3_n	= '/admin/img/editor/paste_na.gif';

im4		= '/admin/img/editor/b.gif';
im4_n	= '/admin/img/editor/b_na.gif';

im5		= '/admin/img/editor/i.gif';
im5_n	= '/admin/img/editor/i_na.gif';

im6		= '/admin/img/editor/u.gif';
im6_n	= '/admin/img/editor/u_na.gif';

im7		= '/admin/img/editor/order.gif';
im7_n	= '/admin/img/editor/order_na.gif';

im8		= '/admin/img/editor/unorder.gif';
im8_n	= '/admin/img/editor/unorder_na.gif';

im9		= '/admin/img/editor/link_g.gif';
im9_n	= '/admin/img/editor/link_g_na.gif';

im10	= '/admin/img/editor/link.gif';
im10_n	= '/admin/img/editor/link_na.gif';

im11	= '/admin/img/editor/unlink.gif';
im11_n	= '/admin/img/editor/unlink_na.gif';

im12	= '/admin/img/editor/image.gif';
im12_n	= '/admin/img/editor/image_na.gif';

im13	= '/admin/img/editor/src.gif';
im13_n	= '/admin/img/editor/src_na.gif';


function wysiwygFocus(name){
	wysiwygFocusFlag[name] = 1;
	wysiwygUndisabled(name, 1,13);
}

function wysiwygBlur(name){
	wysiwygFocusFlag[name] = 0;
	wysiwygDisabled(name, 1,13);
}

function wysiwygUndisabled(name, num1, num2) {
	if(wysiwygSrcFlag[name] == 0)
	{
		for(i = num1; i <= num2; i++)
		{
			var bname = (name + '_but_' + i);
			if(document.all[bname] != null)
			{
				document.all[bname].disabled = false;
				document.all[bname].style.cursor = "hand";			
				if(document.all[bname].src != null)
				{	  
					document.all[bname].src = eval('im' + i);
				}
			}
		}
	}
	else
	{
		document.all[name + '_but_13'].disabled = false;
		document.all[name + '_but_13'].style.cursor = "hand";				
		if(document.all[name + '_but_13'].src != null)
		{	  
			document.all[name + '_but_13'].src = eval('im13');
		}	
	}
}


function wysiwygDisabled(name, num1, num2) {
	for(i = num1; i <= num2; i++)
	{
		var bname = (name + '_but_' + i);
		if(document.all[bname] != null)
		{
			document.all[bname].disabled = true;
			document.all[bname].style.cursor = "default";	  
			if(document.all[bname].src != null)
			{	  
				document.all[bname].src = eval('im' + i + '_n');
			}	  
		}
	}
}



// изменение кнопки
function wysiwygOver(name){
	if(!name.disabled){
		name.className = "wysiwyg_buttonOver";
	}
}

// изменение кнопки
function wysiwygOut(name){
	if(!name.disabled){
		name.className = "wysiwyg_button";
	}
}

// изменение кнопки
function wysiwygDown(name){
	if(!name.disabled){
		name.className = "wysiwyg_buttonDown";
	}
}



// выполняет команду редактирования (cut, copy, paste, bold, italic...)
function wysiwygExec(name, command)
{
	if((wysiwygSrcFlag[name] == 0 || command == "cut" || command == "copy" || command == "paste")  &&
		eval(name + "_wysiwyg_id").isContentEditable && 
		wysiwygFocusFlag[name]==1)
	{
		document.execCommand(command, true);
	}
}


function wysiwygWin(name, fileName) {
	
	if(wysiwygSrcFlag[name] == 0  && wysiwygFocusFlag[name] ==1){
		termsImg=window.open(fileName,'TmWindowImg','scrollbars=yes,width=658,height=477, location=no,toolbar=no,directories=no,status=no,menubar=no,resizable=no,screenX=180,screenY=166'); //,top=266,left=180');
	}
}


function doEditLink()
{
	var f = document.forms.main;	

	f.article_mode.value = '3';
	f.article_submode.value = '302';
	
	editLinkWin=window.open('','editLinkWin','scrollbars=no,width=507,height=600,location=no,toolbar=no,directories=no,status=no,menubar=no,resizable=no,screenX=180,screenY=66,top=66,left=180');
	
	f.target = 'editLinkWin';
	
	f.submit();

	f.target = '';
}

function imageSelected(file, w, h, alt, align)
{
	var str = file + '" border=0 width="' + w + '" height="' + h + '" alt="' + alt + '"';
	document.execCommand("InsertImage", false, str);
}

function linkSelected(file)
{
	document.execCommand("CreateLink", false, file);
}


function createLocalLink(name)
{
	if(document.selection.type == "None")
	{
		alert("Не выделен текст ссылки");
	}
	else
	{
		wysiwygWin(name, "/admin/inc/editor/select_link.jsp");
	}
}


// переключение режима редактирования  текст / html
function wysiwygSrc(name) {
	
	if (eval(name + "_wysiwyg_id").isContentEditable)
	{
		if(wysiwygSrcFlag[name] == 0)
		{
			document.all[name + '_wysiwyg_id'].innerText = document.all[name + "_wysiwyg_id"].innerHTML;
			wysiwygSrcFlag[name] = 1;
			wysiwygDisabled(name, 4, 12);
		}
		else
		{
			document.all[name + '_wysiwyg_id'].innerHTML = document.all[name + '_wysiwyg_id'].innerText;
			wysiwygSrcFlag[name] = 0;
			wysiwygUndisabled(name, 4, 12);
		}
	}
}


function wysiwygPrepareParams(formName)
{
	var f = document.forms[formName];
	for(var i in wysiwygSrcFlag)
	{
		if (wysiwygSrcFlag[i] == 0)
		{
			f[i].value = document.all[i + '_wysiwyg_id'].innerHTML;
		}
		else
		{
			f[i].value = document.all[i + '_wysiwyg_id'].innerText;
		}	
	}
}

function textareaFocus(name)
{
    texareaFocus(name);
}

function texareaFocus(name)
{
    document.all[name + '_wysiwyg_id'].focus();
}
</script>
