<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>

<%
/*
	String wysiwygName;
	String wysiwygWidth;
	String wysiwygHeight;
	String wysiwygValue;
*/
%>

<script language="javascript">
	wysiwygSrcFlag['<%=wysiwygName%>'] = 0;
	wysiwygFocusFlag['<%=wysiwygName%>'] = 0;
</script>

<input type="hidden" name="<%=wysiwygName%>" value="">

<table cellpadding="0" cellspacing="0" border="0" width=<%=wysiwygWidth%> class="wysiwyg_buttonOver">
<tr><td valign="top" height="24" bgcolor="#D4D0C8">
<img src="/img/admin/general/pixels/t_pixel.gif" width="1" height="1" alt="" border="0"><br><!--
--><img src="/admin/img/editor/line1.gif" width="7" height="22" alt="" border="0"><!--
--><a href="#text"><img src="/admin/img/editor/cut_na.gif" width="21" height="20" alt="Вырезать" 
			border="0" disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "cut")' 
			unselectable = "on" 
			class="wysiwyg_button"
			onmouseover="wysiwygOver(this)"
			onmouseout="wysiwygOut(this)"
			onmousedown="wysiwygDown(this)"
			onmouseup="wysiwygOver(this)"
			id="<%=wysiwygName%>_but_1"></a><!--
--><a href="#text"><img src="/admin/img/editor/copy_na.gif" width="21" height="20" alt="Копировать"
			border="0" disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "copy")' 
			unselectable = "on"
			class="wysiwyg_button"
			onmouseover="wysiwygOver(this)"
			onmouseout="wysiwygOut(this)"
			onmousedown="wysiwygDown(this)"
			onmouseup="wysiwygOver(this)"
			id="<%=wysiwygName%>_but_2"></a><!--
--><a href="#text"><img src="/admin/img/editor/paste_na.gif" width="21" height="20" alt="Вставить"
			border="0" disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "paste")'
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_3"></a><!--
--><img src="/admin/img/editor/line2.gif" width="6" height="22" alt="" border="0"><!--
--><a href="#text"><img src="/admin/img/editor/b_na.gif" width="21" height="20" alt="Полужирный"
			border="0" disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "bold")' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_4"></a><!--
--><a href="#text"><img src="/admin/img/editor/i_na.gif" width="21" height="20" alt="Курсив" 
			border="0" disabled  
			onclick='wysiwygExec("<%=wysiwygName%>", "italic")'
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_5"></a><!--
--><a href="#text"><img src="/admin/img/editor/u_na.gif" width="21" height="20" alt="Подчеркнутый" 
			border="0" disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "Underline")' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_6"></a><!--
--><img src="/admin/img/editor/line2.gif" width="6" height="22" alt="" border="0"><!--
--><a href="#text"><img src="/admin/img/editor/order_na.gif" width="21" height="20" alt="" 
			border="0" disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "InsertOrderedList")' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_7"></a><!--
--><a href="#text"><img src="/admin/img/editor/unorder_na.gif" width="21" height="20" alt="" 
			border="0" 
			disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "InsertUnorderedList")' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_8"></a><!--
--><img src="/admin/img/editor/line2.gif" width="6" height="22" alt="" border="0"><!--
--><a href="#text"><img src="/admin/img/editor/link_g_na.gif" width="21" height="20" alt="" 
			border="0" disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "CreateLink")' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_9"></a><!--
--><a href="#text"><img src="/admin/img/editor/link_na.gif" width="22" height="21" alt="" 
			border="0" disabled  
			ooonclick='wysiwygWin("<%=wysiwygName%>", "/admin/inc/editor/select_link.jsp");this.className = "wysiwyg_button"' 
			onclick='createLocalLink("<%=wysiwygName%>");this.className = "wysiwyg_button"' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_10"></a><!--
--><a href="#text"><img src="/admin/img/editor/unlink_na.gif" width="21" height="20" alt="" 
			border="0"  disabled 
			onclick='wysiwygExec("<%=wysiwygName%>", "UnLink")' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_11"></a><!--
--><img src="/admin/img/editor/line2.gif" width="6" height="22" alt="" border="0"><!--
--><a href="#text"><img src="/admin/img/editor/image_na.gif" width="21" height="20" alt="" 
			border="0"  disabled 
			onclick='wysiwygWin("<%=wysiwygName%>", "/admin/inc/editor/select_image.jsp");this.className = "wysiwyg_button"' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_12"></a><!--
--><img src="/admin/img/editor/line2.gif" width="6" height="22" alt="" border="0"><!--
--><a href="#text"><img src="/admin/img/editor/src_na.gif" width="22" height="21" alt=""
			border="0" disabled 
			onclick='wysiwygSrc("<%=wysiwygName%>")' 
			unselectable = "on" 
			class="wysiwyg_button" 
			onmouseover="wysiwygOver(this)" 
			onmouseout="wysiwygOut(this)" 
			onmousedown="wysiwygDown(this)" 
			onmouseup="wysiwygOver(this)" 
			id="<%=wysiwygName%>_but_13"></a><br><!--
--><img src="/img/admin/general/pixels/t_pixel.gif" width="1" height="1" alt="" border="0"><br><!--
--></td>
</tr>
</table>

<img src="/img/admin/general/pixels/t_pixel.gif" width="1" height="2" alt="" border="0"><br>


<DIV id='<%=wysiwygName%>_wysiwyg_id' CONTENTEDITABLE ALIGN=left 
  STYLE="height:<%=wysiwygHeight%>;  width:<%=wysiwygWidth%>; padding:3;border:solid 1px #808080;  overflow=auto;"
  onfocus="wysiwygFocus('<%=wysiwygName%>');"
  onblur="wysiwygBlur('<%=wysiwygName%>');"
  class="main">
<%=wysiwygValue%>
</DIV>