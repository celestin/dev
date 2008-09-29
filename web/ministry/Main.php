<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  12-Nov-2007  10203 : Removed getObjRef as its in form.js.
 * CAM  29-Sep-2008  10302 : Added root.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Good Teaching Search Engine";
$cfg['Site']['URL']   = "http://goodteaching.org"; // no trailing slash
$cfg['Site']['Email'] = "craig@southesk.com";

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "goodteaching";
$cfg['Site']['Db']['Password'] = "psalm45";
$cfg['Site']['Db']['Database'] = "goodteaching_org_min";

if (!empty($db)) {
  $cfg['Site']['Db']['Database'] = $db;
}

if (strpos(strtolower($_SERVER['SERVER_NAME']), "localhost") !== FALSE) {
  $cfg['Site']['URL'] = "http://localhost/ministry";
}

include_once $root.'WEB-INF/inc.php';
include_once $root.'db.php';

function mdate($datein) {
  return date("Y-m-d", strtotime($datein));
}

function fldmand($value) {
  global $retry;
  echo (!empty($retry) && empty($value)) ? "fldmand" : "fld";
}

function fieldFocus() {
  echo " onFocus=\"this.style.backgroundColor='#F0F0F0';\" onBlur=\"this.style.backgroundColor='#fff';\" ";
}

session_start();
error_reporting(E_ALL);

include_once $root.'task.php';

?>