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

        <style type="text/css">
        .zg_div {margin:0px 5px 5px 0px; width:117px;}
        .zg_div_inner {border: solid 1px #000000; background-color:#ffffff;  color:#666666; text-align:center; font-family:arial, helvetica; font-size:11px;}
        .zg_div a, .zg_div a:hover, .zg_div a:visited {color:#D20466; background:inherit !important; text-decoration:none !important;}
        </style>
        <script type="text/javascript">
        zg_insert_badge = function() {
        var zg_bg_color = 'ffffff';
        var zgi_url = 'http://www.flickr.com/apps/badge/badge_iframe.gne?zg_bg_color='+zg_bg_color+'&zg_person_id=97149645%40N00';
        document.write('<iframe style="background-color:#'+zg_bg_color+'; border-color:#'+zg_bg_color+'; border:none;" width="113" height="151" frameborder="0" scrolling="no" src="'+zgi_url+'" title="Flickr Badge"></iframe>');
        if (document.getElementById) document.write('<div id="zg_whatlink"><a href="http://www.flickr.com/badge_new.gne"  style="color:#D20466;" onclick="zg_toggleWhat(); return false;">what is this?<\/a><\/div>');
        }
        zg_toggleWhat = function() {
        document.getElementById('zg_whatdiv').style.display = (document.getElementById('zg_whatdiv').style.display != 'none') ? 'none' : 'block';
        document.getElementById('zg_whatlink').style.display = (document.getElementById('zg_whatdiv').style.display != 'none') ? 'none' : 'block';
        return false;
        }
        </script>


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
        <div class="zg_div"><div class="zg_div_inner"><a href="http://www.flickr.com">www.<strong style="color:#3993ff">flick<span style="color:#ff1c92">r</span></strong>.com</a><br>
        <script type="text/javascript">zg_insert_badge();</script>
        <div id="zg_whatdiv">This is a Flickr badge showing public photos from <a href="http://www.flickr.com/photos/97149645@N00">CraigMcKay</a>. Make your own badge <a href="http://www.flickr.com/badge_new.gne">here</a>.</div>
        <script type="text/javascript">if (document.getElementById) document.getElementById('zg_whatdiv').style.display = 'none';</script>
        </div>
        </div>
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
