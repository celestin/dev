<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Reworked to use BibleBook.
 * CAM  25-Oct-2007  10187 : Added Verse Start to search.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Scripture Search";
$tab = "scripture";
$tabs = true;
include 'tpl/top.php';
include_once('functions.php');

$bookid = $_SESSION['search_bookid'];    if (!empty($_POST['bookid'])) $bookid = $_POST['bookid'];
$chapter = $_SESSION['search_chapter'];  if (!empty($_POST['chapter'])) $chapter = $_POST['chapter'];
$vstart = $_SESSION['search_vstart'];    if (!empty($_POST['chapter']) && ($_POST['vstart']!="")) $vstart = $_POST['vstart'];

if ($bookid == "NULL") {
  $bookid = "";
  $chapter = "";
  $vstart = 0;
} else if ($chapter == "NULL") {
  $chapter = "";
  $vstart = 0;
}

$_SESSION['search_bookid'] = $bookid;
$_SESSION['search_chapter'] = $chapter;
$_SESSION['search_vstart'] = $vstart;

$entity = "";
$bibleBook = "";

if (empty($bookid)) {
  $entity = "Book";
} else {
  $bibleBook = new BibleBook($bookid);

  if (empty($chapter) && !$bibleBook->isSingleChap()) {
    $entity = "Chapter";
  } else {
    $entity = "Verse(s)";
  }
}
?>
<table border=0 cellpadding=10 cellspacing=0>
<tr><td align=left colspan=2>
<?
  $q = "Select your $entity";

  if ($loggedin) {
    $q .= ", " . $member->getFirstname();
  }

  $q .= ":";

  Msg::statement($q);
?></td></tr><tr><td><?
/**** START ****/
    if (empty($bookid)) {
      f_show_books();
    } else if (empty($chapter) && !$bibleBook->isSingleChap()) {
      f_show_chapters();
    } else {
      f_show_verses();
    }
/**** END ****/
?>
</td></tr>
</table>
<?
include 'tpl/results.php';
include 'tpl/bot.php';
?>