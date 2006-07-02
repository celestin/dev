<?php
$img_array = $_SESSION['img_array'];
$template_details ='<?xml version="1.0" encoding="iso-8859-1"?>
<mosinstall type="template">
<name>'.$TemplateName.'</name>
<creationDate>'.date("j-m-Y").'</creationDate>
<author>';
if (!empty ($author)){
$template_details .= $author ;
}
$template_details .= '</author>
<copyright>';
if ($copyright == 'CR'){
$template_details .='(C) Copyright 2004 '. $author ;
}
else {
$template_details .= 'This template is released under the '.$copyright ;
}
$template_details .= '</copyright>
<authorEmail>';
if (!empty ($email)){
$template_details .= $email ;
}
$template_details .= '</authorEmail>
<authorUrl>';
if (!empty ($url)){
$template_details .= $url ;
}
$template_details .= '</authorUrl>
<version>'.$version.'</version>
<description>' .$description.'</description>
<files>
<filename>index.php</filename>
<filename>templateDetails.xml</filename>
</files>
';
if ($nu_images >= 1){
$template_details .= '<images>';
	foreach ($img_array as $image){
$template_details .= "<filename>$image</filename>\n";
	}
$template_details .= '</images>';
}
$template_details .= '<css>
<filename>css/template_css.css</filename>
</css>
</mosinstall>';

$fp = fopen("$new_template/templateDetails.xml","w");
fwrite($fp,$template_details);
fclose($fp);
?>