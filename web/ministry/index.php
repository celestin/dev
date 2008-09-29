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
 * CAM  25-Oct-2007  10187 : Added Verse Start to search.
 * CAM  08-Nov-2007  10200 : Added results_pageno.
 * CAM  18-Nov-2007  10205 : Added search_previous.
 * CAM  04-Jun-2008  10268 : Added Latest Volumes.
 * CAM  29-Sep-2008  10302 : Added root.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Home";

include $root.'tpl/top.php';

$_SESSION['search_keywords'] = "";
$_SESSION['search_author'] = array('ALL'=>'ALL');

$_SESSION['search_bookid'] = "";
$_SESSION['search_chapter'] = "";
$_SESSION['search_vstart'] = "";

$_SESSION['search_previous'] = "";

$_SESSION['preview_author'] = "";
$_SESSION['preview_vol'] = "";
$_SESSION['preview_page'] = "";

$_SESSION['results_pageno'] = "";

include $root.'tpl/newsearch.php';
include $root.'tpl/latestvols.php';
include $root.'tpl/bot.php';
?>