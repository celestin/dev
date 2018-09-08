<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * WestCoastExpress Website
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
 * CAM  22-Sep-2011  11029 : Added development url.
 * CAM  09-Nov-2013  11040 : Removed deprecated session_is_registered.
 * CAM  08-Sep-2018  20180908 Switched to Terry.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "West Coast Express";
$cfg['Site']['URL']   = "http://www.westcoastexpress.net";                 // no trailing slash
$cfg['Site']['Email'] = "terrysmith641@hotmail.co.uk";
  $cfg['Site']['Dir'] = "/home/cmckay2/public_html/";  // trailing slash

$cfg['Site']['Db']['Hostname'] = "127.0.0.1";
$cfg['Site']['Db']['Username'] = "cmckay2_user";
$cfg['Site']['Db']['Password'] = "zO)]Fv-9o)Tv@.QM]f";
$cfg['Site']['Db']['Database'] = "westcoastexpress_net_-_site";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "localhost") !== FALSE) {
  $cfg['Site']['URL']   = "http://localhost/fb/westcoastexpress/";                 // no trailing slash
  $cfg['Site']['Dir'] = "C:/Dev/FB/web/westcoastexpress/";
  $cfg['Site']['Email'] = "craig@frontburner.co.uk";

  $cfg['Site']['Db']['Hostname'] = "wizard";
  $cfg['Site']['Db']['Username'] = "westcoastexpress";
  $cfg['Site']['Db']['Password'] = "westcoastexpress";
}

include_once './WEB-INF/inc.php';
include_once 'db.php';

function storeFlash($flash) {
  $_SESSION['flash'] = $flash;
}

function showFlash() {
  if (isset($_SESSION['flash'])) {
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
