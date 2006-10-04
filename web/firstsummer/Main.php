<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once dirname(__FILE__).'/config.php';
include_once dirname(__FILE__).'/groups.php';
include_once dirname(__FILE__).'/db.php';
include_once dirname(__FILE__).'/WEB-INF/inc.php';

function mdate($datein) {
  return date("Y-m-d", strtotime($datein));
}

function fldmand($value) {
  global $retry;
  echo (!empty($retry) && empty($value)) ? "fldmand" : "fld";
}

session_start();
error_reporting(E_ALL);

include_once 'task.php';

?>
