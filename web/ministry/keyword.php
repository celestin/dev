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

$title = "Keyword Search";
include 'tpl/top.php';

$keywords = NULL;     if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];


?>
<form action="keyword.php" method="post">
<table border=0 cellpadding=10>
<tr><td align=left colspan=2>
<?
  $q = "Type one or more keywords";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname() . ",";
  }
  $q .= " and click Search:";

  Msg::statement($q);

?></td></tr>
<tr>
  <td><input name="keywords" id="keywords" size=50 value="<? echo $keywords; ?>"></td>
  <td width="100%"><? echo ActionUtil::submitButton("Search"); ?></td>
</tr>
</table>
</form>
<?
include 'tpl/bot.php';
?>