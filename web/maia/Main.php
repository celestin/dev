<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Main page setup
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/maia/Main.php $
 * 
 * 2     3/02/06 20:42 Craig
 *
 * 1     3/02/06 1:52 Craig
 * 1000
 *
 * Who  When         Why
 * CAM  02-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Maia Systems";
$cfg['Site']['URL']   = "http://maia-systems.com";                 // no trailing slash
$cfg['Site']['Email'] = "Jon.Gill@maia-systems.com";
$cfg['Site']['Dir']   = "/home/virtual/site215/fst/var/www/cc/";  // trailing slash

if (strtolower($_SERVER['SERVER_NAME']) == "knox.southesk.local") {
  $cfg['Site']['Db']['Hostname'] = "localhost";
} else {
  $cfg['Site']['Db']['Hostname'] = "205.178.146.17";
}
$cfg['Site']['Db']['Username'] = "maiasystems";
$cfg['Site']['Db']['Password'] = "sulzer27&";
$cfg['Site']['Db']['Database'] = "maiasystems_com";

include_once './WEB-INF/inc.php';
include_once 'db.php';

function mdate($datein) {
  return date("Y-m-d", strtotime($datein));
}

function fldmand($value) {
  global $retry;
  echo (!empty($retry) && empty($value)) ? "fldmand" : "fld";
}

function f_is_admin() {
  global $member, $loggedin;

  if ($loggedin) {
    if ($member->isAdmin()) {
      return true;
    }
  }

  return false;
}


function f_admin($section) {
  global $source;

  $rval = $section;
  if (f_is_admin() && empty($source)) {
    $rval .= "&editsection=$section";
  }

  return $rval;
}

function f_url($editsection='') {
  global $section1, $section2, $section3;

  $rval = "dummy=1";
  if (!empty($section1)) $rval .= "&section1=$section1";
  if (!empty($section2)) $rval .= "&section2=$section2";
  if (!empty($section3)) $rval .= "&section3=$section3";
  if (!empty($editsection)) $rval .= "&editsection=$editsection";

  return $rval;
}

function f_class($tsection) {
  global $section1, $section2, $section3;

  $sel = "class=\"sel\"";

  if (!empty($section3)) {
    if ($tsection == $section3) { echo $sel; return; }
  } else if (!empty($section2)) {
    if ($tsection == $section2) { echo $sel; return; }
  } else if (!empty($section1)) {
    if ($tsection == $section1) { echo $sel; return; }
  }
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