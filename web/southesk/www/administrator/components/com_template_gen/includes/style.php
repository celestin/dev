<?php


if ($left_width ){
$leftcolumwidth = $left_width;
}
else{
$leftcolumwidth = '150px';
}
if ($right_width){
$rightcolumwidth = $right_width;
}
else{
$rightcolumwidth = '150px';
}
if (!$left_bg){
$left_bg = 'FFFFFF';
}
if (!$right_bg){
$right_bg = 'FFFFFF';
}
if (!$body_bg){
$body_bg = 'FFFFFF';
}

 function makecss(){
			global $style;
			$css_style = '';
				foreach ($style as $key => $value) {
					if ($key == 'div'){
						$css_style .= "div, td, p {";
					}
					elseif ($key == 'a'){
						$css_style .= " a ,a:active, a:link {";
					}
					else{
					$css_style .= "$key {\n";
					}
					foreach ($value as $v2 => $v3) {
						if ($v3 != 'normal'){
					  		if ($v3 != 'left'){
					  			if ($v3 != 'default'){
					  				if (!empty($v3)){
					  					if ($v2 == 'color' || $v2 == 'background-color' ){
					   						$css_style .= "$v2:  #$v3; \n ";
					  					}
					 					else{
               								$css_style .= "$v2:  $v3; \n ";
			 							}
			   						}
			   					}
			   				}
			   			}
					}
					$css_style .=  "}\n";
				}
return $css_style;
}
$the_rest = makecss();





//Comment

/* Style Sheet input */
$layout ="
body { 
	margin:0;
	padding:0;
	border : 0; 
	background-color : #$body_bg;\n";
if ($body_bg_image){
$layout .= "background-image : url(../images/$body_bg_image);\n";
if ($body_bg_repeat){
$layout .= "background-repeat : $body_bg_repeat;\n";
}
}
$layout .="
}
#wrapper { min-width: 400px;
 border: 1px solid #$body_bg; margin: 0 -1px;
 width: ";
if ($page_width == 'fullpage'){
$layout .=  '100%';
}
else{
$layout .= $page_w ;
}
$layout .="\n}
#outer {
	border-left-width: $leftcolumwidth; 
	border-left-color: #$left_bg;  ";
if ( $column == 'three_col' ) {
$layout .= "
	border-right-width: $rightcolumwidth; 
	border-right-color: #$right_bg; ";
}
if ($outer_bg_image){
$layout .= "
	background-image : url(../images/$outer_bg_image);\n";
if ($outer_bg_repeat){
$layout .= "background-repeat : $outer_bg_repeat;\n";
}
}
if ($main_bg){
$layout .= "background-color: #$main_bg; ";
}
$layout .= "}
#leftcol {
	width: $leftcolumwidth;            
	margin-left: -$leftcolumwidth;     
}";
if ( $column == 'three_col' ) {
$layout .= "#rightcol {
	width: $rightcolumwidth;              
	margin-right: -$rightcolumwidth;     
}
#rightcol { margin-left: 1px; 
float: left; position: relative; z-index: 11;}";
}
$layout .= "\n #outer { width: auto; border-left-style: solid; border-right-style: solid; }
#inner { margin: 0; width: 100%; }
#header, #footer { width: 100%; position: relative; z-index: 13; }
.clear { clear: both; }
/* Mozilla code */
#outer > #inner { border-bottom: 1px solid transparent; }
#leftcol { float: left; position: relative; z-index: 10;
margin-right: 1px; }
#center { margin: 0 -3px 0 -2px; 
float: left; width: 100%; position: relative; z-index: 12;}
.content {padding: 5px 5px 5px 5px;
width : 90%; \n}";


$footerstyle = "#footer{  
 height: $footer_height; \n";
if ($footer_bg){
$footerstyle .= " background-color: #$footer_bg; \n";
}
if ($footer_bg_image){
$footerstyle.= "background-image : url(../images/$footer_bg_image);\n";
if ($footer_bg_repeat){
$footerstyle .= "background-repeat : $footer_bg_repeat;\n";
}
}
$footerstyle .= "}\n";


$headerstyle = "#header{  
 height: $header_height;\n";
if ($header_bg){
$headerstyle .= " background-color: #$header_bg ; \n";
}
if ($header_bg_image){
$headerstyle.= "background-image : url(../images/$header_bg_image);\n";
if ($header_bg_repeat){
$headerstyle .= "background-repeat : $header_bg_repeat;\n";
}
}
$headerstyle .= "}\n";






/* end CSS tabless style */

/* Styles not generated with style function */

$moduletable = "table.moduletable { \n";
$moduletable .= " margin: 0px 0px 0px 0px;\n";
if ( !empty( $moduletable_width ) ) {
$moduletable .= "width: $moduletable_width ;\n";
}
$moduletable .= "}\n";

$hrstyle = "hr {
	";
	if ($hr_bg){
$hrstyle .= "color: #$hr_bg;
background-color: #$hr_bg;";
}
$hrstyle .= "height: $hr_height;
	width: $hr_width;
}
hr.separator {
	";
	if ($hrs_bg){
$hrstyle .= "color: #$hrs_bg;
background-color: #$hrs_bg;";
}
$hrstyle .= "
    height: $hrs_height;
	width: $hrs_width ;
    }";

$pnav = $style['a.pnav'];
$pnav_style =".pnav { \n ";
foreach ($pnav as $sel => $prop){
if ($prop){
if ($sel == 'color' || $sel == 'background-color' ){
					   $pnav_style .= "$sel:  #$prop; \n ";
					  }
					  else{
               $pnav_style .= "$sel:  $prop; \n ";
			 }
}
}
$pnav_style .="} \n ";


/* End Styles not generated with style function */



$stylesheet = $layout . "\n";
if ($header) {
$stylesheet .= $headerstyle . "\n";
}
if ($footer) {
$stylesheet .= $footerstyle . "\n";
}
$stylesheet .= $moduletable. "\n";
$stylesheet .= $hrstyle. "\n";
$stylesheet .= $pnav_style. "\n";
$stylesheet .= $the_rest;


$fp = fopen("$new_template/css/template_css.css","w");
fwrite($fp,$stylesheet);
fclose($fp);
?>

