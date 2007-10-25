<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Aug-2007  File created.
 * CAM  15-Oct-2007  10187 : Pass Book reference to SqlFactory.
 * CAM  25-Oct-2007  10187 : Added Verse Start to search.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once('functions.php');

$keywords = $_SESSION['search_keywords'];
$author   = $_SESSION['search_author'];
$bookid   = $_SESSION['search_bookid'];
$chapter  = $_SESSION['search_chapter'];
$vstart   = $_SESSION['search_vstart'];

$sqlFactory = new SqlFactory("mse_text", "t.author, t.vol, t.page, t.para, t.inits, t.text", "t.author, t.vol, t.page");

$showBibleRef = false;

if (!empty($keywords)) {
  $sqlFactory->setSearchText($keywords);
}

if ((count($author)>0) && (empty($author['ALL']))) {
  $sqlFactory->setAuthors($author);
}

if (!empty($bookid) && !empty($chapter)) {
  $sqlFactory->setBookRef($bookid, $chapter, $vstart);

  if (empty($keywords)) $showBibleRef = true;
}

$sql = $sqlFactory->getSql();
//echo "<pre>$sql</pre>";
?>
<table border=0 cellpadding=3 cellspacing=0 width="100%">
  <tr>
    <th class="rh" width="50">Servant<br>Vol</th>
    <th class="rh" width="40">Page</th>
    <th class="rh" width="50">Inits</th>
    <th class="rh">Text</th>
  </tr>
<?
if ($sqlFactory->isSearch()) {
  $ssql = mysql_query($sqlFactory->getSql()) or die(mysql_error());
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
  <td class="rd"><? echo highlight_text($text, $inits, $keywords, $ref, $bookname); ?></td>
</tr></form><?
  }
}
?>
</table>