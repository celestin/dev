<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Dunc Smith Glasscraft
 * Copyright (c) 2009 Dunc Smith
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jul-2009  10459 : Added new images and file headers.
 * * * * * * * * * * * * * * * * * * * * * * * */

include "tpl/top.php";

if (!empty($piece)) {
  ?>
  <tr><td class="main">
  <table border=0 width="100%">
    <tr>
      <td align=center><img src="<? print "img/p/l/" . $piece ?>.jpg"</td>
    </tr>
  </table>
  </td></tr>
  <?
} else if (!empty($source)) {
  ?>
  <tr><td class="main">
  <?
  include "ctx/" . $source;
  ?></td></tr><?
}

include "tpl/bot.php";

?>
