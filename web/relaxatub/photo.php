<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Photo Gallery
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  06-Oct-2006  10053 : Changed sort order of photos.
 * CAM  14-Feb-2008  10243 : Highlight link associated with current page.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once 'main.php';

  $_photo = '';
  $_tub = '';

  $param = 'photo';
  if (!empty($HTTP_POST_VARS[$param]) || !empty($HTTP_GET_VARS[$param])) {
    $_photo = (!empty($HTTP_POST_VARS[$param])) ? $HTTP_POST_VARS[$param] : $HTTP_GET_VARS[$param];
  }

  $pageId = "pagephoto";
  $pageTitle = "Photo Album";
  include "tpl/top.php";

  $html = "";
  $sql = "SELECT * FROM photo ORDER BY photo DESC";
  $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b><br>' . mysql_error() . '</pre>');
  $phcount=0;
  $phmax=6;

  while ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
    $thisPhoto = new Photo($photo, $location, $tub);

    $phcount++;
    if ($phcount > $phmax) {
      $html .= "</tr><tr>";
      $phcount = 1;
    }

    if ($photo == $_photo || empty($_photo)) {
      $_photo = $photo;
      $currPhoto = $thisPhoto;
      $cls = '"phsel"';
    } else {
      $cls = '"phbox"';
    }

    $html .= "<td><a href=\"photo.php?photo=$photo\"><img height=60 border=0 class=$cls src=\"" . $thisPhoto->imgFile("t") . "\"></a></td>\n";
  }

  if ($phcount < $phmax) {
    $html .= "<td colspan=" . ($phmax - $phcount) . ">&nbsp;</td>";
  }
?>

<table align=left valign=top border=0 cellpadding=0 cellspacing=0 width="100%"><tr>

  <td align=center><table border=0 cellpadding=5>
    <tr><td align=center><img height="330" class="phbox" src="<? print $currPhoto->imgFile("f"); ?>"></td></tr>
    <tr><td class="tubname"><? print $currPhoto->location; ?></td></tr>
  </table></td>

  </tr><tr>

  <td valign=top align=center class="phnav"><table border=0 cellpadding=4 cellspacing=0>
    <tr>
<?
  echo $html;
?>
  </tr></table></td>

</tr></table>

<?
  include "tpl/bot.php";
?>