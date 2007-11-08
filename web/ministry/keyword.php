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
 * CAM  15-Oct-2007  10187 : Attempt to send empty using NULL.
 * CAM  08-Nov-2007  10200 : Added results_pageno.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Keyword Search";
$tab = "KEYWORD";
$tabs = true;
include 'tpl/top.php';

$keywords = $_SESSION['search_keywords'];  if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];

if ($keywords == "NULL") {
  $keywords = "";
}

$_SESSION['search_keywords'] = $keywords;


?>
<form action="keyword.php" method="post" name=searchText id=searchText>
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
  <td>
    <input name="keywords" id="keywords" size=50 value="<? echo $keywords; ?>">
    <input type=hidden name="results_pageno" id="results_pageno" value="0">
  </td>
  <td width="100%"><? echo ActionUtil::submitButton("Search", "button", "buttonhover", "submitSearchText();"); ?></td>
</tr>
</table>
</form>

<?
include 'tpl/results.php';
include 'tpl/bot.php';
?>