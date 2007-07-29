<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * New Search Wizard
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Scripture Search";
include 'tpl/top.php';
include_once('functions.php');
?>

<table border=0 cellpadding=10>
<tr><td align=left colspan=2>
<?
  $q = "Firstly";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname() . ",";
  }

  $q .= " select your Book:";

  Msg::statement($q);

?></td></tr>

</table>

<?
/**** START ****/
?>

  <table border=1 cellpadding=2 cellspacing=0>
<?
    if (empty($ubookid)) {
      f_show_books();
    } else if (empty($uchapter)) {
      f_show_chapters();
    } else {
      f_show_verses();
    }
  ?>
  </td></tr></table>
</td>
</tr>
  <?

    if (!empty($ubookid) && !empty($uchapter)) {
      f_show_scripture_table();
}
  ?>


<?
/**** END ****/
?>






<?
include 'tpl/bot.php';
?>