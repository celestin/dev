<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TC Munro
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id: Main.php 349 2006-12-21 21:59:47Z craig $
 *
 * Who  When         Why
 * CAM  29-Jan-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "T.C. Munro";
$cfg['Site']['URL']   = "http://www.tcmunro.co.uk";                 // no trailing slash
$cfg['Site']['Email'] = "craig@southesk.com";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "local") !== FALSE) {
  $cfg['Site']['Dir'] = "c:/appserv/www/tcmunro/";
} else {
  $cfg['Site']['Dir'] = "/home/virtual/tcmunro.co.uk/var/www/html/";  // trailing slash
}

/*
$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "westcoastexpress";
$cfg['Site']['Db']['Password'] = "bob50";
$cfg['Site']['Db']['Database'] = "westcoastexpress_net_-_site";
*/

include_once $toroot . 'WEB-INF/inc.php';

function mdate($datein) {
  return date("Y-m-d", strtotime($datein));
}

function f_mand($value) {
  global $retry;
  echo (!empty($retry) && empty($value)) ? "fldmand" : "fld";
}

function endsWith($str, $sub) {
   return (substr($str, strlen($str) - strlen($sub)) === $sub);
}

session_start();
error_reporting(E_ALL);

?>
