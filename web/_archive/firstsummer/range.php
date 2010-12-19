<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Range page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  14-Apr-2006  Show all products in the range rather than a random image.
 * CAM  02-Oct-2006  10046 : Moved HTML to a function in group.php to allow it to be called from category.php.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
if (!isset($urange)) {
  $urange = NULL;             if (!empty($_GET['range'])) $urange = $_GET['range'];
}

get_range($urange);

include 'tpl/bot.php';
?>