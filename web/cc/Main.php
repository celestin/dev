<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Main page setup
 * Copyright (c) 2005 Southesk.com
 *
 * $Log: /web/cc/Main.php $
 *
 * 4     11/02/06 22:13 Craig
 *
 * 3     29/12/05 15:24 Craig
 * Remove trailing slash
 *
 * 2     28/12/05 15:56 Craig
 *
 * 1     28/12/05 15:43 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * CAM  11-Feb-2006  Path details to include check for local server.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Christian Corner";
$cfg['Site']['URL']   = "http://cc.southesk.com";                 // no trailing slash
$cfg['Site']['Email'] = "craig@southesk.com";
$cfg['Site']['Dir']   = "/var/www/cc/";  // trailing slash

if (strpos(strtolower($_SERVER['SERVER_NAME']), "local") !== FALSE) {
  $cfg['Site']['Db']['Hostname'] = "c:/appserv/www/";
} else {
  $cfg['Site']['Dir']   = "/var/www/cc/";  // trailing slash
}

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "southesk";
$cfg['Site']['Db']['Password'] = "psalm45";
$cfg['Site']['Db']['Database'] = "southesk_com_-_list";

include_once './WEB-INF/inc.php';
include_once 'db.php';

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

<script language="Javascript">
  function getObjRef(p_ref) {
    return document.all ? document.all[p_ref] : document.getElementById(p_ref);
  }
</script>