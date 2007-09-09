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
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Home";

include 'tpl/top.php';

$_SESSION['search_keywords'] = "";
$_SESSION['search_author'] = array('ALL'=>'ALL');
$_SESSION['preview_author'] = "";
$_SESSION['preview_vol'] = "";
$_SESSION['preview_page'] = "";

include 'tpl/newsearch.php';
include 'tpl/bot.php';
?>