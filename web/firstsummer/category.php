<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Category page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  02-Oct-2006  10046 : If BBQ Huts, show Range page rather than Category.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

if (!isset($ucategory)) {
  $ucategory = NULL;          if (!empty($_GET['category'])) $ucategory = $_GET['category'];
}

if ($ucategory == '1') {
  get_range('7');
} else {
  get_category($ucategory);
}


include 'tpl/bot.php';
?>