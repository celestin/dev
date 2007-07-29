<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * WEBSITE_NAME
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Main page setup
 *
 * $Id: /web/cc/Main.php $
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Site Name";
$cfg['Site']['URL']   = "http://site.url.com";                 // no trailing slash
$cfg['Site']['Email'] = "craig@southesk.com";
$cfg['Site']['Dir']   = "/home/virtual/site215/fst/var/www/cc/";  // trailing slash

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