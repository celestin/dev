<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Main page setup
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/parkersretreat/Main.php $
 * 
 * 1     23/04/06 21:27 Craig
 *
 * Who  When         Why
 * CAM  11-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Parker&#039;s Retreat";
$cfg['Site']['URL']   = "http://www.parkersretreat.co.uk";                 // no trailing slash
$cfg['Site']['Email'] = "craig@frontburner.co.uk";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "local") !== FALSE) {
  $cfg['Site']['Dir'] = "C:/AppServ/www/parkersretreat/";
} else {
  $cfg['Site']['Dir']   = "/home/virtual/site215/fst/var/www/cc/";  // trailing slash
}

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "parkersretreat";
$cfg['Site']['Db']['Password'] = "alexis44";
$cfg['Site']['Db']['Database'] = "parkersretreat_co_uk_-_site";

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