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
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once dirname(__FILE__).'/config.php';
include_once './WEB-INF/inc.php';
include_once 'db.php';

session_start();
error_reporting(E_ALL);

include_once 'task.php';

?>

<script language="Javascript">
  function getObjRef(p_ref) {
    return document.all ? document.all[p_ref] : document.getElementById(p_ref);
  }
</script>