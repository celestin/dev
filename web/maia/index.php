<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Home Page Context
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/maia/index.php $
 * 
 * 2     3/02/06 20:42 Craig
 *
 * 1     3/02/06 1:52 Craig
 * 1000
 *
 * Who  When         Why
 * CAM  02-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Home";
include 'tpl/top.php';
  if (!empty($msource)) {
    include("tpl/$msource");
  } else if (!empty($mtext)) {
    echo $mtext;
  }
include 'tpl/bot.php';
?>