<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  31-May-2006  Added endsWith and moved getObjRef to ajax.js.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "West Coast Express";
$cfg['Site']['URL']   = "http://www.westcoastexpress.net";                 // no trailing slash
$cfg['Site']['Email'] = "waveney77@yahoo.com";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "local") !== FALSE) {
  $cfg['Site']['Db']['Hostname'] = "c:/appserv/www/";
} else {
  $cfg['Site']['Dir']   = "/home/virtual/site215/fst/var/www/cc/";  // trailing slash
}

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "westcoastexpress";
$cfg['Site']['Db']['Password'] = "bob50";
$cfg['Site']['Db']['Database'] = "westcoastexpress_net_-_site";

include_once './WEB-INF/inc.php';
include_once 'db.php';

function mdate($datein) {
  return date("Y-m-d", strtotime($datein));
}

function fldmand($value) {
  global $retry;
  echo (!empty($retry) && empty($value)) ? "fldmand" : "fld";
}

function endsWith($str, $sub) {
   return (substr($str, strlen($str) - strlen($sub)) === $sub);
}

session_start();
error_reporting(E_ALL);

include_once 'task.php';

?>
