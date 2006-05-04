<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Main page setup
 * Copyright (c) 2004-2005 Southesk.com
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  19-May-2005  Added Javascript.
 * * * * * * * * * * * * * * * * * * * * * * * */

/* ---------- Application Paths ---------- */
// Set php.MVC library root directory
$appServerRootDir = 'C:/WWW/cvsworking/phpmvc'; // no trailing slash

// Set the application path
$moduleRootDir = 'C:/WWW/cvsworking/phpmvc';  // no trailing slash
/* ---------- Application Paths ---------- */

// Setup the application specific ActionDispatcher (RequestDispatcher)
$actionDispatcher = 'ActionDispatcher';

// Set the OS Type [Optional] [UNIX|WINDOWS|MAC] if we have
// trouble detecting the server OS type. Eg: path errors.
$osType = '';

// Relative path to the phpmvc configuration files
$configPath = './WEB-INF'; // no trailing slash

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