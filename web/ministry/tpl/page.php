<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Results panes
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Aug-2007  File created.
 * CAM  24-Nov-2007  10210 : Indicate in the Preview Pane where a new page occurs in the physical volume.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once('functions.php');

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

if (!empty($preview_author)) {
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
        $newtext .= trim(substr($row[1], $prevchar, $charpos[$i])) . "&nbsp;<span title=\"This paragraph continues on physical Page $pageNo in the printed volume.\" class=\"contNewPage\">$pageNo</span>&nbsp;";
        $prevchar = $charpos[$i];
      }

      $newtext .= trim(substr($row[1], $prevchar));
    }

    $newtext = str_replace("@", "", $newtext);  // TODO include scripture links and highlight search words

    if (empty($row[0])) $row[0] = "<img src=\"img/f.gif\" border=0 width=0 height=0>";

    echo "<tr><td valign=top><b>" . $row[0] . "</b></td><td>" . $newtext . "</td></tr>";
  }

?></table><?

} else {
  echo "&nbsp;";
}

?>
