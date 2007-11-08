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
 * CAM  08-Nov-2007  10200 : Added Results Pagination.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once('functions.php');

$keywords = $_SESSION['search_keywords'];
$author   = $_SESSION['search_author'];
$bookid   = $_SESSION['search_bookid'];
$chapter  = $_SESSION['search_chapter'];
$vstart   = $_SESSION['search_vstart'];

$pageNo = $_SESSION['results_pageno'];  if (isset($_POST['results_pageno'])) $pageNo = $_POST['results_pageno'];

if ($pageNo == "0") $pageNo = 1; $_SESSION['results_pageno'] = $pageNo;

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

if ($sqlFactory->isSearch()) {
  $rowCount = 0;
  $ssql = mysql_query($sqlFactory->getSql(true)) or die(mysql_error());
  if ($row = mysql_fetch_array($ssql)) {
    $rowCount = $row[0];
  }

  $maxRows = 10;

  if ($rowCount > $maxRows) {
    $sqlFactory->setLimit($maxRows, $pageNo);
  ?>
  <table align=center border=0 cellpadding=4 cellspacing=0><tr><td class="pageannot">Pages</td>
  <?
    $j = 0;
    $maxPages = 7;
    $eitherSide = 2;
    $lastPageToShow = round($rowCount / $maxRows)- ($eitherSide - 1);  // a page back from the end - i.e. show the last two in a long list

    if ($pageNo == 1) $eitherSide = 5;

    $resultsPage = "";

    $middleStart = $pageNo-$eitherSide;
    $middleEnd = $pageNo+$eitherSide;
    if ($pageNo < $maxPages) {
      $middleStart = 0;
      $middleEnd = $maxPages;
    }

    for ($i = 0; $i < $rowCount; $i += $maxRows) {
      $j++;

      if (($j <= 2) || (($j >= ($middleStart)) && ($j <= ($middleEnd))) || ($j >= $lastPageToShow)) {
        // Display up to the max pages, or the last few pages

        if ($j == $pageNo) {
          $resultsPage = "<td class=\"pagesel\">$j</td>";
        } else {
          $resultsPage = "<td><input type=hidden name=results_pageno value=\"$j\">".
             ActionUtil::submitButton($j, "pagebutton", "pagebuttonhover")."</td>";
        }

        ?><form method="post"><? echo "$resultsPage"; ?></form><?

      } else if (($j == ($middleStart-1)) || ($j == ($middleEnd+1))) {
        // In between just show an ellipsis
        ?><td>...</td><?

      }
    }
?>
<td class="pageannot"><? echo "(" . number_format($rowCount) . " results)"; ?></td></tr></table>
<?
  }
}
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