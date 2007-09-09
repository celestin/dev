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

$title = "Servant Filter";
$tab = "author";
$tabs = true;
include 'tpl/top.php';

$author_filter = $_SESSION['search_author'];  if (!empty($_POST['author_filter'])) $author_filter = $_POST['author_filter'];
$_SESSION['search_author'] = $author_filter;

?>
<form action="servant.php" method="post">
<table border=0 cellpadding=10>
<tr><td align=left colspan=2>
<?
  $q = "Select one or more Servants";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname() . ",";
  }
  $q .= " and click Search:";

  Msg::statement($q);

  $checked = "";
  if (!empty($author_filter['ALL'])) $checked = "CHECKED";

?></td></tr>
<tr>
  <td width="100%"><input type="checkbox" <? echo $checked; ?> name="author_filter[ALL]" value="ALL">All&nbsp;<?

$sql = "SELECT author, name FROM mse_author ORDER BY author";

$ssql = mysql_query($sql);
while ($row = mysql_fetch_array($ssql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $checked = "";
  if (!empty($author_filter[$author]) && empty($author_filter['ALL'])) {
    $checked = "CHECKED";
  }

?>
<input type="checkbox" <? echo $checked; ?> name="author_filter[<? echo $author; ?>]" value="<? echo $author; ?>"><? echo $name; ?>&nbsp;
<?
}

  ?></td>
  <td width="100%"><? echo ActionUtil::submitButton("Search"); ?></td>
</tr>
</table>
</form>
<?
include 'tpl/results.php';
include 'tpl/bot.php';
?>