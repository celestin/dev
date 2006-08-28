<?php
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );
// needed to seperate the ISO number from the language file constant _ISO
$iso = split( '=', _ISO );
// xml prolog
echo '<?xml version="1.0" encoding="'. $iso[1] .'"?' .'>';
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<?php
if ( $my->id ) {
  initEditor();
}
?>
<meta http-equiv="Content-Type" content="text/html; <?php echo _ISO; ?>" />
<?php mosShowHead(); ?>
<link rel="shortcut icon" href="<?php echo $mosConfig_live_site;?>/images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="<?php echo $mosConfig_live_site; ?>/templates/southesk1/css/template_css.css" />
</head>
<body>

<table width="800" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="eeeeee">
<tr>
  <td width="6" bgcolor="#FFFFFF">
  <img src="<?php echo $mosConfig_live_site; ?>/templates/southesk1/images/pixel.png" width="1" height="1" alt="spacer" />
  </td>
  <td valign="top" class="greybg">
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td bgcolor="#FFFFFF">
      <img src="<?php echo $mosConfig_live_site; ?>/templates/southesk1/images/pixel.png" width="1" height="6" alt="spacer" /></td>
      <td width="180" height="6" valign="bottom" bgcolor="#FFFFFF">
      <img src="<?php echo $mosConfig_live_site; ?>/templates/southesk1/images/search_01.png" width="180" height="3" alt="search" /></td>
    </tr>
    <tr>
      <td rowspan=2 align="left" valign="top">
      <img src="<?php echo $mosConfig_live_site; ?>/templates/southesk1/images/image_03.png" width="598" height="28" alt="Southesk.com" />
      </td>
      <td height="17" valign="top" class="greybg">
      <img src="<?php echo $mosConfig_live_site; ?>/templates/southesk1/images/search_02.png" width="180" height="17" alt="Search" />
      </td>
    </tr>
    <tr>
      <td valign="top">
      <?php mosLoadModules ( 'user4', -1 ); ?>
      </td>
    </tr>
    </table>
    <!-- This is the vertical menu. Change the links as needed or delete the script from this line if you dont use it-->
<!--
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td>
      <?php mosLoadModules ( 'user3', -1 ); ?>
      </td>
    </tr>
    </table>
-->
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="125" valign="top" bgcolor="#eeeeee">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <?php mosLoadModules ( 'left' ); ?>
          </td>
        </tr>
        <tr>
        <td align=center>
        <!-- Start of Flickr Badge -->
        <a href="http://www.flickr.com/photos/mcmoose/"><img src="http://flagrantdisregard.com/flickr/profilewidget/recent.vert/ffffff/d70042/97149645@N00.jpg" border="0" alt="Craig McKay&#039;s photos" title="Craig McKay&#039;s photos" /></a>
        <!-- End of Flickr Badge -->
        </td>
        </tr>
        </table>
      </td>

      <td rowspan=2 width="6" bgcolor="#FFFFFF">&nbsp;</td>
      <td valign="top">
      <br />
        <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td class="pathway">
          <?php mosPathWay(); ?>
          </td>
        </tr>
        </table>
      <br />
        <table width="98%" border="0" align="center" cellpadding="4" cellspacing="0">
        <tr>
          <td class="mainpage">
          <?php mosMainBody(); ?>
          </td>
        </tr>
        </table>
      </td>
      <td class="mainpage-bkg">
      <img src="<?php echo $mosConfig_live_site;?>/templates/southesk1/images/pixel.png" width="1" height="1" alt="spacer"/>
      </td>
    </tr>
    <tr>
      <td style="padding-right:5px;">
      <?php mosLoadModules ( 'right' ); ?>
      </td>
    </tr>
    </table>
  </td>
  <td width="6" bgcolor="#FFFFFF">
  <img src="<?php echo $mosConfig_live_site; ?>/templates/southesk1/images/pixel.png" width="1" height="1" alt="spacer"/>
  </td>
</tr>
</table>
<?php mosLoadModules( 'debug', -1 );?>
</body>
</html>
