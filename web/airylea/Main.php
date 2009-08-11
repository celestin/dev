<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2006-2009 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * CAM  11-Aug-2009  10467 : Implemented First Found recommendations.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Airylea Motors";
$cfg['Site']['Location'] = "Aberdeen, Scotland, UK";
$cfg['Site']['URL']   = "http://www.airylea.co.uk";                 // no trailing slash
$cfg['Site']['Email'] = "craig@frontburner.co.uk";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "king") !== FALSE) {
  $cfg['Site']['Dir'] = "c:/appserv/www/airylea/";
  $cfg['Site']['Email'] = "craig@frontburner.co.uk";
} else {
  $cfg['Site']['Dir'] = "/var/www/html/";  // trailing slash
}

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "airylea";
$cfg['Site']['Db']['Password'] = "gard77";
$cfg['Site']['Db']['Database'] = "airylea_com_-_site";

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
