<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * CAM  05-Sep-2012  11128 : Moved getObjRef to top.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Talisman WMS Users";
$cfg['Site']['URL']   = "http://www.talismanwms.com/users";                 // no trailing slash
$cfg['Site']['Email'] = "craig@frontburner.co.uk";
//$cfg['Site']['Dir']   = "/home/virtual/site215/fst/var/www/cc/";  // trailing slash

if (strpos(strtolower($_SERVER['SERVER_NAME']), "artificer") !== FALSE) {
  $cfg['Site']['URL']   = "http://artificer/twms/users";
}

$cfg['Site']['Db']['Hostname'] = "127.0.0.1";
$cfg['Site']['Db']['Username'] = "wms_users";
$cfg['Site']['Db']['Password'] = "TalismanWms411";
$cfg['Site']['Db']['Database'] = "wms_users";

include_once './WEB-INF/inc.php';
include_once 'db.php';

function mdate($datein) {
  return date("Y-m-d", strtotime($datein));
}

function fldmand($value) {
  global $retry;
  echo (!empty($retry) && empty($value)) ? "fldmand" : "fld";
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
