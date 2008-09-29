<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Easton's Search
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Sep-2008  10302 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Easton's Bible Dictionary";
$root = "../";
$tabs = false;
$pageName = "pageEaston";
include $root.'tpl/top.php';

$author_filter = $_SESSION['search_author'];  if (!empty($_POST['author_filter'])) $author_filter = $_POST['author_filter'];
$_SESSION['search_author'] = $author_filter;

?>
<h2>Coming soon...</h2>
<?
include $root.'tpl/bot.php';
?>