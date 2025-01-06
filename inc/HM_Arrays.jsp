<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.Enumeration"%>

<%@ page import="tengry.cms.*"%>
<%@ page import="tengry.cms.core.*"%>
<%@ page import="tengry.northgas.*"%>
<% String sectionCode=SectionCode.ROOT; %>
<%  response.setHeader("Pragma","no-cache"); %>
<%
	char R = CMSApplication.LANG_RUS;
	char E = CMSApplication.LANG_ENG;
	String sLang = request.getParameter("lang");
	char lang = R;
	if(("" + E).equals(sLang))
		lang = E;
	String des = CMSApplication.getApplication().getCurrentDesignPath();
%>
<%!
	private void printArrays(char lang, WebTreeNode node, String arrName, JspWriter out) throws IOException
	{
		Vector nodes = node.getVisibleChilds();
		if(nodes.size() == 0)
			return;
		out.println(arrName + " = [");
		out.println("[],");
		for(int i = 0; i < nodes.size(); i++)
		{
			WebTreeNode child = (WebTreeNode)nodes.elementAt(i);
			Vector subChilds = child.getVisibleChilds();
			String name = "";
			if(lang == CMSApplication.LANG_ENG)
				name = child.getNameEng();
			else
				name = child.getNameRus();
			if(subChilds.size() > 0)
				out.print("[\"<B>" + name + "</B>\", \"/page.jsp?id=" + child.getId() + "&lang=" + lang + "\", 1, 0, 1]");
			else
				out.print("[\"" + name + "\", \"/page.jsp?id=" + child.getId() + "&lang=" + lang + "\", 1, 0, 0]");
			if(i+1 < nodes.size())
				out.print(",");
			out.println("");
		}
		out.println("]\n");
		
		for(int i = 0; i < nodes.size(); i++)
		{
			WebTreeNode child = (WebTreeNode)nodes.elementAt(i);
			printArrays(lang, child, arrName + "_" + (i+1), out);
		}
	}
%>
function getReal(xy,el){
    if((HM_IE)||(HM_DOM)){
       Pos=(xy=="x")?el.offsetLeft:el.offsetTop;
       if ((HM_IE)&&(!HM_Mac)&&(el.tagName)&&
           (el.tagName.toUpperCase()=="TABLE")&&
           (el.border)&&(el.border>0)) Pos++;
       tmpEl=el.offsetParent;
       while(tmpEl!=null){
          Pos+=(xy=="x")?tmpEl.offsetLeft:tmpEl.offsetTop;
          if ((HM_IE)&&(!HM_Mac)&&(tmpEl.tagName)&&
              (tmpEl.tagName.toUpperCase()=="TABLE")&&
              (tmpEl.border)&&(tmpEl.border>0)) Pos++;
          tmpEl=tmpEl.offsetParent;
       }
    }else{
       Pos=(xy=="x")?el.x:el.y;
    }
    if (HM_IE&&HM_Mac) {
       MacOffset=(xy=="x")?(document.body.currentStyle.marginLeft) :
                           (document.body.currentStyle.marginTop);
       if(MacOffset.indexOf('%')!=-1){
          MacSize=(xy=="x")?parseInt(document.body.offsetWidth) :
                            parseInt(document.body.offsetHeight);
          MacOffset=(parseInt(MacOffset)/100)*MacSize;
       }else{
          MacOffset=parseInt(MacOffset)
       }
       Pos+=MacOffset;
    }
    return Pos;
}

function findXY(elementid,xory) {
    var thePlacer = HM_DOM ? document.getElementById(elementid) :
                    HM_IE ? document.all(elementid) : document.images[elementid];
    retVal=getReal(xory,thePlacer);
    return retVal;
}



HM_Array1 = [
[
120,                          // menu_width
<%=lang==E ? 185 : 185%>, 							// left_position
HM_topPoz,                            // top_position
"",                         // font_color
"",                      // mouseover_font_color
"",                      // background_color
"",                       // mouseover_background_color
"",                        // border_color
"",                       // separator_color
0,                             // top_is_permanent
1,                             // top_is_horizontal
0,                             // tree_is_horizontal
1,                             // position_under
1,                             // top_more_images_visible
1,                             // tree_more_images_visible
"null",                        // evaluate_upon_tree_show
"null",                        // evaluate_upon_tree_hide
,                              // right_to_left
0,                             // display_on_click
true,                          // top_is_variable_width
false],                        // tree_is_variable_width

["","",1,0,1]
]

<%
{
	WebTreeNode node = CMSApplication.getApplication().getSectionNode(SectionCode.COMPANY);
	printArrays(lang, node, "HM_Array1_1", out) ;
}
%>

//---------------------------------------------------------------------------------------------

HM_Array2 = [
[
158,                          // menu_width
<%=lang==E ? 262 : 279%>, 							// left_position
HM_topPoz,                            // top_position
"",                         // font_color
"",                      // mouseover_font_color
"",                      // background_color
"",                       // mouseover_background_color
"",                        // border_color
"",                       // separator_color
0,                             // top_is_permanent
1,                             // top_is_horizontal
0,                             // tree_is_horizontal
1,                             // position_under
1,                             // top_more_images_visible
1,                             // tree_more_images_visible
"null",                        // evaluate_upon_tree_show
"null",                        // evaluate_upon_tree_hide
,                              // right_to_left
0,                             // display_on_click
true,                          // top_is_variable_width
false],                        // tree_is_variable_width

["","",1,0,1]
]

<%
{
	WebTreeNode node = CMSApplication.getApplication().getSectionNode(SectionCode.PRODUCT);
	printArrays(lang, node, "HM_Array2_1", out) ;
}
%>


//---------------------------------------------------------------------------------------------

HM_Array3 = [
[
135,                          // menu_width
<%=lang==E ? 355 : 361%>, 							// left_position
HM_topPoz,                            // top_position
"",                         // font_color
"",                      // mouseover_font_color
"",                      // background_color
"",                       // mouseover_background_color
"",                        // border_color
"",                       // separator_color
0,                             // top_is_permanent
1,                             // top_is_horizontal
0,                             // tree_is_horizontal
1,                             // position_under
1,                             // top_more_images_visible
1,                             // tree_more_images_visible
"null",                        // evaluate_upon_tree_show
"null",                        // evaluate_upon_tree_hide
,                              // right_to_left
0,                             // display_on_click
true,                          // top_is_variable_width
false],                        // tree_is_variable_width

["","",1,0,1]
]


<%
{
	WebTreeNode node = CMSApplication.getApplication().getSectionNode(SectionCode.PROJECT);
	printArrays(lang, node, "HM_Array3_1", out) ;
}
%>


//---------------------------------------------------------------------------------------------

HM_Array4 = [
[
125,                          // menu_width
<%=lang==E ? 425 : 425%>, 							// left_position
HM_topPoz,                            // top_position
"",                         // font_color
"",                      // mouseover_font_color
"",                      // background_color
"",                       // mouseover_background_color
"",                        // border_color
"",                       // separator_color
0,                             // top_is_permanent
1,                             // top_is_horizontal
0,                             // tree_is_horizontal
1,                             // position_under
1,                             // top_more_images_visible
1,                             // tree_more_images_visible
"null",                        // evaluate_upon_tree_show
"null",                        // evaluate_upon_tree_hide
,                              // right_to_left
0,                             // display_on_click
true,                          // top_is_variable_width
false],                        // tree_is_variable_width

["","",1,0,1]
]

<%
{
	WebTreeNode node = CMSApplication.getApplication().getSectionNode(SectionCode.INVESTOR);
	printArrays(lang, node, "HM_Array4_1", out) ;
}
%>

//---------------------------------------------------------------------------------------------


HM_Array5 = [
[
130,                          // menu_width
<%=lang==E ? 522 : 514%>, 							// left_position
HM_topPoz,                            // top_position
"",                         // font_color
"",                      // mouseover_font_color
"",                      // background_color
"",                       // mouseover_background_color
"",                        // border_color
"",                       // separator_color
0,                             // top_is_permanent
1,                             // top_is_horizontal
0,                             // tree_is_horizontal
1,                             // position_under
1,                             // top_more_images_visible
1,                             // tree_more_images_visible
"null",                        // evaluate_upon_tree_show
"null",                        // evaluate_upon_tree_hide
,                              // right_to_left
0,                             // display_on_click
true,                          // top_is_variable_width
false],                        // tree_is_variable_width


["","",1,0,1]
]

<%
{
	WebTreeNode node = CMSApplication.getApplication().getSectionNode(SectionCode.SUPPLIER);
	printArrays(lang, node, "HM_Array5_1", out) ;
}
%>


//---------------------------------------------------------------------------------------------

HM_Array6 = [
[
130,                          // menu_width
<%=lang==E ? 610 : 614%>,				// left_position
HM_topPoz,                            // top_position
"",                         // font_color
"",                      // mouseover_font_color
"",                      // background_color
"",                       // mouseover_background_color
"",                        // border_color
"",                       // separator_color
0,                             // top_is_permanent
1,                             // top_is_horizontal
0,                             // tree_is_horizontal
1,                             // position_under
1,                             // top_more_images_visible
1,                             // tree_more_images_visible
"null",                        // evaluate_upon_tree_show
"null",                        // evaluate_upon_tree_hide
,                              // right_to_left
0,                             // display_on_click
true,                          // top_is_variable_width
false],                        // tree_is_variable_width


["","",1,0,1]
]

<%
{
	WebTreeNode node = CMSApplication.getApplication().getSectionNode(SectionCode.PARTNER);
	printArrays(lang, node, "HM_Array6_1", out) ;
}
%>
