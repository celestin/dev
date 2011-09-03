<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  19-May-2005  Added Javascript.
 * CAM  08-Feb-2007  10097 : Include config.
 * CAM  25-Jun-2007  10133 : Changed includes to be consistent with other systems.
 * CAM  12-Aug-2007  10157 : Added Flash and Redirect methods.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once dirname(__FILE__).'/config.php';
include_once dirname(__FILE__).'/db.php';
include_once dirname(__FILE__).'/WEB-INF/inc.php';

session_start();
error_reporting(E_ALL);

function storeFlash($flash) {
  $_SESSION['flash'] = $flash;
}

function showFlash() {
  if (session_is_registered('flash')) {
    $flash = $_SESSION['flash'];
    if (!empty($flash)) Msg::statement($flash);
    session_unregister('flash');
  }
}

function redirect($url) {
?>
<script language="javascript">top.location.href="<? echo $url; ?>";</script>
<?
}

include_once 'task.php';

?>