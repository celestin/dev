<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  15-Oct-2007  10187 : Reset the Scripture vars.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Home";

include 'tpl/top.php';

$_SESSION['search_keywords'] = "";
$_SESSION['search_author'] = array('ALL'=>'ALL');

$_SESSION['search_bookid'] = "";
$_SESSION['search_chapter'] = "";

$_SESSION['preview_author'] = "";
$_SESSION['preview_vol'] = "";
$_SESSION['preview_page'] = "";

include 'tpl/newsearch.php';
include 'tpl/bot.php';
?>