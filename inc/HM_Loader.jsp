<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.northgas.*"%>
<% String sectionCode=SectionCode.ROOT; %>
<%
	char R = CMSApplication.LANG_RUS;
	char E = CMSApplication.LANG_ENG;
	String sLang = request.getParameter("lang");
	char lang = R;
	if(("" + E).equals(sLang))
		lang = E;
	String des = CMSApplication.getApplication().getCurrentDesignPath();
	des += (lang == E ? "/eng" : "/rus");
%>
/*HM_Loader.js
* by Peter Belesis. v4.2.3 020402
* Copyright (c) 2002 Peter Belesis. All Rights Reserved.
*/

HM_DOM = (document.getElementById) ? true : false;
HM_NS4 = (document.layers) ? true : false;
HM_IE = (document.all) ? true : false;
HM_IE4 = HM_IE && !HM_DOM;
HM_Mac = (navigator.appVersion.indexOf("Mac") != -1);
HM_IE4M = HM_IE4 && HM_Mac;
HM_Opera = (navigator.userAgent.indexOf("Opera")!=-1);
HM_Konqueror = (navigator.userAgent.indexOf("Konqueror")!=-1);

HM_IsMenu = !HM_Opera && !HM_IE4M && (HM_DOM || HM_NS4 || HM_IE4 || HM_Konqueror);

HM_BrowserString = HM_NS4 ? "NS4" : HM_DOM ? "DOM" : "IE4";

if(window.event + "" == "undefined") event = null;
function HM_f_PopUp(){return false};
function HM_f_PopDown(){return false};
popUp = HM_f_PopUp;
popDown = HM_f_PopDown;

HM_GL_MenuWidth          = 150;
HM_topPoz = 85;
HM_GL_FontFamily         = "Tahoma";
HM_GL_FontSize           = (HM_NS4)?7:6.4;
HM_GL_FontBold           = false;
HM_GL_FontItalic         = false;
HM_GL_FontColor          = "#0A347A";
HM_GL_FontColorOver      = "#FFFFFF";
HM_GL_BGColor            = "#FFFFFF";
HM_GL_BGColorOver        = "#6291B9";
HM_GL_ItemPadding        = 6;

HM_GL_BorderWidth        = 1;
HM_GL_BorderColor        = "#094C8B";
HM_GL_BorderStyle        = "solid";
HM_GL_SeparatorSize      = 1;
HM_GL_SeparatorColor     = "#B4D0EC";
HM_GL_ImageSrc           = "<%=des%>/tn/tri.gif";
HM_GL_ImageSrcLeft       = "";
HM_GL_ImageSrcOver       = "<%=des%>/tn/tri_on.gif";
HM_GL_ImageSrcLeftOver   = "";

HM_GL_ImageSize          = 9;
HM_GL_ImageHorizSpace    = 4;
HM_GL_ImageVertSpace     = 4;

HM_GL_KeepHilite         = true;
HM_GL_ClickStart         = false;
HM_GL_ClickKill          = 0;
HM_GL_ChildOverlap       = 8;
HM_GL_ChildOffset        = 3;
HM_GL_ChildPerCentOver   = null;
HM_GL_TopSecondsVisible  = .1;
HM_GL_ChildSecondsVisible = .1;
HM_GL_StatusDisplayBuild = 0;
HM_GL_StatusDisplayLink  = 1;
HM_GL_UponDisplay        = null;
HM_GL_UponHide           = null;

HM_GL_RightToLeft        = false;
HM_GL_CreateTopOnly      = 0;
HM_GL_ShowLinkCursor     = true;

HM_GL_ScrollEnabled      = false;
HM_GL_ScrollBarHeight    = null;
HM_GL_ScrollBarColor     = null;
HM_GL_ScrollImgSrcTop    = null;
HM_GL_ScrollImgSrcBot    = null;
HM_GL_ScrollImgWidth     = null;
HM_GL_ScrollImgHeight    = null;

HM_GL_ScrollBothBars     = false;



HM_a_TreesToBuild = [1,2,3,4,5,6];

// the following function is included to illustrate the improved JS expression handling of
// the left_position and top_position parameters introduced in 4.0.9
// and modified in 4.1.3 to account for IE6 standards-compliance mode
// you may delete if you have no use for it

function HM_f_CenterMenu(topmenuid) {
	var MinimumPixelLeft = 0;
	var TheMenu = HM_DOM ? document.getElementById(topmenuid) : window[topmenuid];
	var TheMenuWidth = HM_DOM ? parseInt(TheMenu.style.width) : HM_IE4 ? TheMenu.style.pixelWidth : TheMenu.clip.width;
	var TheWindowWidth = HM_IE ? (HM_DOM ? HM_Canvas.clientWidth : document.body.clientWidth) : window.innerWidth;
	return Math.max(parseInt((TheWindowWidth-TheMenuWidth) / 2),MinimumPixelLeft);
}

if(HM_IsMenu) {
	document.write("<SCR" + "IPT LANGUAGE='JavaScript1.2' SRC='/inc/HM_Arrays.jsp?lang=<%=lang%>' TYPE='text/javascript'><\/SCR" + "IPT>");
	document.write("<SCR" + "IPT LANGUAGE='JavaScript1.2' SRC='/inc/HM_Script"+ HM_BrowserString +".js' TYPE='text/javascript'><\/SCR" + "IPT>");
}


//end