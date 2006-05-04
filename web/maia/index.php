<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Website
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
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