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

  $sql = "SELECT inits, text ".
         "FROM mse_text ".
         "WHERE author='$preview_author' ".
         "AND vol=$preview_vol ".
         "AND page=$preview_page ".
         "ORDER BY para";

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {

    $row[1] = remove_inits($row[1], $row[0]);
    $row[1] = remove_inits($row[1], 'Ques.'); // TODO Do something
    $row[1] = remove_inits($row[1], 'Rem.');  // more clever with these two
    $row[1] = str_replace("@", "", $row[1]);  // TODO include scripture links and highlight search words

    if (empty($row[0])) $row[0] = "<img src=\"img/f.gif\" border=0 width=0 height=0>";

    echo "<tr><td valign=top><b>" . $row[0] . "</b></td><td>" . $row[1] . "</td></tr>";
  }

?></table><?

} else {
  echo "&nbsp;";
}

?>
