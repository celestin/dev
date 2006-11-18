<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * SourceCodeMetrics.com
 * Copyright (c) 2006 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Nov-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Source Code Metrics";
$cfg['Site']['URL']   = "http://www.sourcecodemetrics.com";                 // no trailing slash
$cfg['Site']['Email'] = "laurence.arthur@powersoftware.com";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "local") !== FALSE) {
  $cfg['Site']['Db']['Hostname'] = "c:/appserv/www/";
} else {
  $cfg['Site']['Dir']   = "/home/virtual/site215/fst/var/www/cc/";  // trailing slash
}

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "username";
$cfg['Site']['Db']['Password'] = "password";
$cfg['Site']['Db']['Database'] = "database";

include_once './WEB-INF/inc.php';
//include_once 'db.php';

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