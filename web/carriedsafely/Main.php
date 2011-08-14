<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  31-May-2006  Added endsWith and moved getObjRef to ajax.js.
 * CAM  21-Dec-2006  10068 : Specify correct paths.
 * CAM  26-Mar-2007  Fixed bug with server paths.
 * CAM  11-Aug-2007  10149 : Added Flash and redirect methods.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "West Coast Express";
$cfg['Site']['URL']   = "http://www.westcoastexpress.net";                 // no trailing slash
$cfg['Site']['Email'] = "waveney77@yahoo.com";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "king") !== FALSE) {
  $cfg['Site']['Dir'] = "c:/appserv/www/westcoastexpress/";
  $cfg['Site']['Email'] = "craig@frontburner.co.uk";
} else {
  $cfg['Site']['Dir'] = "/var/www/html/";  // trailing slash
}

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "westcoastexpress";
$cfg['Site']['Db']['Password'] = "bob50";
$cfg['Site']['Db']['Database'] = "westcoastexpress_net_-_site";

include_once './WEB-INF/inc.php';
include_once 'db.php';

function storeFlash($flash) {
  $_SESSION['flash'] = $flash;
}

function showFlash() {
  if (session_is_registered('flash')) {
    $flash = $_SESSION['flash'];
    if (!empty($flash)) Msg::error($flash);
    session_unregister('flash');
  }
}

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

function redirect($url) {
?>
<script language="javascript">top.location.href="<? echo $url; ?>";</script>
<?
}

session_start();
error_reporting(E_ALL);

include_once 'task.php';

?>
