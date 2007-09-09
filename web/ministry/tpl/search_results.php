<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Results panes
 *
 * $Id: top.php 486 2007-07-29 21:35:11Z craig $
 *
 * Who  When         Why
 * CAM  19-Aug-2007  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$keywords = $_SESSION['search_keywords'];
$author   = $_SESSION['search_author'];

$sql_text = str_replace(" ", "%", $keywords);

include_once('functions.php');

$sql = "SELECT t.author, t.vol, t.page, t.para, t.inits, t.text ".
       "FROM mse_text t ".
       "WHERE 1=1 ";

$no_search = true;

if (!empty($keywords)) {
  $no_search = false;

  $sql .= "AND t.text LIKE '%$sql_text%' ";
}

if ((count($author)>0) && (empty($author['ALL']))) {
  $asql = "";

  foreach ($author as $currentauthor) {
    if (empty($asql)) {
      $asql = "AND t.author IN (";
    } else {
      $asql .= ",";
    }

    $asql .= "'$currentauthor'";
  }

  $asql .= ") ";
  $sql .= $asql;
}

$sql .= "ORDER BY 1,2,3,4 ";

//echo "<p>$sql</p>";

?>
<table border=0 cellpadding=3 cellspacing=0 width="100%">
  <tr>
    <th class="rh" width="50">Servant<br>Vol</th>
    <th class="rh" width="40">Page</th>
    <th class="rh" width="50">Inits</th>
    <th class="rh">Text</th>
  </tr>
<?

if (!$no_search) {
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if (empty($inits)) $inits = "&nbsp;";

    $preview = "<input type=hidden name=preview_author value=\"$author\">".
               "<input type=hidden name=preview_vol value=\"$vol\">".
               "<input type=hidden name=preview_page value=\"$page\">".
               ActionUtil::submitButton($page, "previewbutton", "previewbuttonhover");

?><form method="post"><tr>
  <td class="rd"><? echo "<b>$author</b> $vol"; ?></td>
  <td class="rd"><? echo "$preview"; ?></td>
  <td class="rd"><? echo "<b>$inits</b>"; ?></td>
  <td class="rd"><? echo highlight_text($text, $inits, $keywords); ?></td>
</tr></form><?
  }
}
?>
</table>