<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Page Preview Pane
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Aug-2007  File created.
 * CAM  24-Nov-2007  10210 : Indicate in the Preview Pane where a new page occurs in the physical volume.
 * CAM  29-Dec-2007  10211 : Call the highlight function with SqlFactory.
 * CAM  02-Jan-2008  10206 : Added Page Controls.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once('functions.php');

$volPages = 0;

function count_vol_pages($author, $vol) {
  global $volPages;

  if ($volPages == 0) {
    $sql = "SELECT MAX(page) vol_pages  ".
           "FROM mse_text ".
           "WHERE author='$author' ".
           "AND vol=$vol ";

    $ssql = mysql_query($sql);
    if ($row = mysql_fetch_array($ssql)) {
      $volPages = $row[0];
    }
  }

  return $volPages;
}

function store_session_var($varname) {
  $rval = "";

  if (!empty($_SESSION[$varname])) {
    $rval = $_SESSION[$varname];
  }

  if (!empty($_POST[$varname])) {
    $rval = $_POST[$varname];
    $_SESSION[$varname] = $rval;
  }

  return $rval;
}

$preview_author = store_session_var('preview_author');
$preview_vol    = store_session_var('preview_vol');
$preview_page   = store_session_var('preview_page');

$pagechanged  = isset($_POST["pagechanged"]) ? TRUE : FALSE;
$gotopage     = isset($_POST["gotopage"]) ? $_POST["gotopage"] : "";

if ($pagechanged && !empty($gotopage)) {
  $preview_page = ($gotopage * 1);
}

$keywords = $_SESSION['search_keywords'];
$author   = $_SESSION['search_author'];
$bookid   = $_SESSION['search_bookid'];
$chapter  = $_SESSION['search_chapter'];
$vstart   = $_SESSION['search_vstart'];

$sqlFactory = new SqlFactory();
if (!empty($keywords)) {
  $sqlFactory->setSearchText($keywords);
}
if ((count($author)>0) && (empty($author['ALL']))) {
  $sqlFactory->setAuthors($author);
}
if (!empty($bookid) && !empty($chapter)) {
  $sqlFactory->setBookRef($bookid, $chapter, $vstart);
}


if (!empty($preview_author)) {
  count_vol_pages($preview_author, $preview_vol);

  echo "<p align=center><b>$preview_author</b> Volume <b>$preview_vol</b> Page <b>$preview_page</b></p>";

?><table border=0 cellpadding=0 cellspacing=4><?

  $sql = "SELECT inits, text, page, newpages ".
         "FROM mse_text ".
         "WHERE author='$preview_author' ".
         "AND vol=$preview_vol ".
         "AND page=$preview_page ".
         "ORDER BY para";

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {

    $newtext = $row[1];

    if (!empty($row[3])) {
      $charpos = explode(",", $row[3]);
      $newtext = "";
      $prevchar = 0;

      for($i = 0; $i < count($charpos); $i++) {
        $pageNo = ($row[2] + $i + 1);
        $newtext .= trim(substr($row[1], $prevchar, ($charpos[$i] - $prevchar))) . "&nbsp;<span title=\"This paragraph continues on physical Page $pageNo in the printed volume.\" class=\"contNewPage\">$pageNo</span>&nbsp;";
        $prevchar = $charpos[$i];
      }

      $newtext .= trim(substr($row[1], $prevchar));
    }

    $newtext = f_highlight_text($newtext, $sqlFactory);

    if (empty($row[0])) $row[0] = "<img src=\"img/f.gif\" border=0 width=0 height=0>";

    echo "<tr><td valign=top><b>" . $row[0] . "</b></td><td>" . $newtext . "</td></tr>";
  }

?></table><div align="center" style="padding-top:10px;">
  <form method="POST" id="pageSelector" name="pageSelector">
    <input type=hidden id="pagechanged" name="pagechanged" value="1">
    <table border=0 cellpadding=5 cellspacing=0><tr>
      <td><img width="16" height="16" class="imagebutton" title="Goto first page" src="img/page_first.png" onclick="ChangePageNo(pageSelector, gotopage, 1);"></td>
      <td><img width="16" height="16" class="imagebutton" title="Goto previous page" src="img/page_prev.png" onclick="ChangePageNo(pageSelector, gotopage, <? echo max(1, ($preview_page-1)); ?>);"></td>
      <td><input class="volpage" id="gotopage" name="gotopage" size=4 value="<? echo $preview_page; ?>" onKeyUp="ValidationPageNo(this);" onChange="ValidationPageNo(this, <? echo $volPages; ?>);" onclick="this.className='volpageedit';" onBlur="this.className='volpage';"></td>
      <td><img width="16" height="16" class="imagebutton" title="Goto next page" src="img/page_next.png" onclick="ChangePageNo(pageSelector, gotopage, <? echo min($volPages, ($preview_page+1)); ?>);"></td>
      <td><img width="16" height="16" class="imagebutton" title="Goto last page (<? echo $volPages; ?>)" src="img/page_last.png" onclick="ChangePageNo(pageSelector, gotopage, <? echo $volPages; ?>);"></td>
    </td></table>
  </form>
</div><?

} else {
  echo "&nbsp;";
}

?>
