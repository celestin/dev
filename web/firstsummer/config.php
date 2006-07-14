<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main page setup
 *
 * $Id: Main.php 84 2006-05-11 18:55:49Z craig $
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "1st Summerhouses";
$cfg['Site']['URL']   = "http://www.1stsummerhouses.com";                 // no trailing slash
$cfg['Site']['Email'] = "sales@1stsummerhouses.com";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "local") !== FALSE) {
  $cfg['Site']['Db']['Hostname'] = "c:/appserv/www/";
} else {
  $cfg['Site']['Dir']   = "/home/virtual/site215/fst/var/www/cc/";  // trailing slash
}

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "firstsummer";
$cfg['Site']['Db']['Password'] = "john21";
$cfg['Site']['Db']['Database'] = "1stsummerhouses_com_-_site";

?>
