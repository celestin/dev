<?php
extract ($_POST);
if (!get_magic_quotes_gpc()) {
    $footertext = addslashes($_POST['footertext']);
} 
$top = "<?php defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' ); ?>\n";
$top .= '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' . "\n";
$top .= '<html xmlns="http://www.w3.org/1999/xhtml">' . "\n";
$top .= '<head>' . "\n";
$top .= '<title><?php echo $mosConfig_sitename; ?></title>' . "\n";
$top .= '<meta http-equiv="Content-Type" content="text/html; <?php echo _ISO; ?>" />' . "\n";
$top .= '<?php include ("includes/metadata.php"); ?>' . "\n";
$top .= '<link href="<?php echo $mosConfig_live_site;?>/templates/' . $TemplateName . '/css/template_css.css" rel="stylesheet" type="text/css" />' . "\n";
$top .= '<link rel="shortcut icon" href="<?php echo $mosConfig_live_site;?>/templates/' . $TemplateName . '/images/favicon.ico" />' . "\n";
$top .= '<?php if($my->gid >= "1"){ ?>' . "\n";
$top .= '<?php include ("editor/editor.php"); ?>' . "\n";
$top .= '<?php initEditor(); ?>' . "\n";
$top .= '<?php } ?>' . "\n";
$top .= '</head>' . "\n";

$headerdiv = "<div id=\"header\" >\n";
if ($sitename == 'show' ) {
$headerdiv .= '<div id="title"><?php echo $mosConfig_sitename; ?></div>' . "\n";
}
$headerdiv .= "</div>\n";

$datediv = '<div class="date"><?php echo (strftime (_DATE_FORMAT_LC)); ?></div>';

$pathwaydiv = '<div class="pathway"><?php include "pathway.php";?></div>';

$searchdiv = '<form action="<?php echo sefRelToAbs("index.php"); ?>" method="post">';
$searchdiv .= '<input type="text" name="searchword" size="17" value="<?php echo _SEARCH_BOX; ?>"  class="inputbox" onblur="if(this.value==\'\') this.value=\'<?php echo _SEARCH_BOX; ?>\';" onfocus="if(this.value==\'<?php echo _SEARCH_BOX; ?>\') this.value=\'\';" />';
$searchdiv .= '<br /> <input type="submit" name="option" class="button" value="GO" />';
$searchdiv .= '<input type="hidden" name="option" value="search" /> ';
$searchdiv .= '</form>';

$body = '<body>';
if ( $page_width == 'pagecenter') {
$body.= '<div align="center">';
}
$body .='
<div id="wrapper">';
if ( $date == 'top')
{ 
$body .= $datediv ;
}
if ( $path == 'top')
{ 
$body .= $pathwaydiv ;
}
if ($header){
$body .= $headerdiv;
}
if ( $date == 'left')
{ 
$body .= $datediv ;
}
if ( $path == 'left')
{ 
$body .= $pathwaydiv ;
}
$body .= '
<div id="outer">
<div id="inner">
 <div id="leftcol"><div class="content">';
if ( $search == 'left')
{ 
$body .= $searchdiv ;
}
$body .= '<?php if (mosCountModules( "left" )) {  mosLoadModules ( "left" ); ?><?php } ?></div></div>
 <div id="center"><div class="content"><?php if (mosCountModules( "top" )) {  mosLoadModules ( "top" ); ?><?php } ?><?php include_once("mainbody.php"); ?></div></div>';
 if ( $column == 'three_col' ) {
$body .= ' <div id="rightcol"><div class="content">';
if ( $search == 'right')
{ 
$body .= $searchdiv ;
}
$body .= '<?php  if (mosCountModules( "right" )) { mosLoadModules ( "right" ); } ?></div></div>';
}
$body .= '
  <div class="clear"></div> 
</div>
</div>';
 if ( $footer ) {
$body .= ' 
 <div id="footer">'.stripslashes($footertext).'</div>';
}
$body .= '
</div>';
if ( $page_width == 'pagecenter') {
$body .= '</div>';
}
$body .= '</body>
</html>';

$index = $top;
$index .= $body;


$fp = fopen("$new_template/index.php","w");
fwrite($fp,$index);
fclose($fp);
?>
