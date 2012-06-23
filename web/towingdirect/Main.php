<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Jan-2012  11077 : Changed site name.
 * CAM  18-Feb-2012  11090 : Corrected details.
 * CAM  07-Jun-2012  11126 : Remove errors with deprecated PHP session functions.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Carried Safely";
$cfg['Site']['URL']   = "http://www.carriedsafely.co.uk";                 // no trailing slash
$cfg['Site']['Email'] = "bob@carriedsafely.co.uk";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "artificer") !== FALSE) {
  $cfg['Site']['URL']   = "http://artificer/towingdirect";                 // no trailing slash
  $cfg['Site']['Dir'] = "c:/appserv/www/towingdirect/";
  $cfg['Site']['Email'] = "craig@frontburner.co.uk";
} else {
  $cfg['Site']['Dir'] = "/var/www/vhosts/towingdirect.co.uk/httpdocs/";  // trailing slash
}

$cfg['Site']['Db']['Hostname'] = "127.0.0.1";
$cfg['Site']['Db']['Username'] = "client128239";
$cfg['Site']['Db']['Password'] = "loud1tel";
$cfg['Site']['Db']['Database'] = "client128239_site";

include_once './WEB-INF/inc.php';
include_once 'db.php';

function storeFlash($flash) {
  $_SESSION['flash'] = $flash;
}

function showFlash() {
  if (isset($_SESSION['flash'])) {
    $flash = $_SESSION['flash'];
    if (!empty($flash)) Msg::error($flash);
    unset($_SESSION['flash']);
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
