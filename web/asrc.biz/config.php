<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Configuration Data
 *
 * $Id: config.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  08-Feb-2007  10097 : File created.
 * CAM  22-Jun-2007  10132 : Corrected Local Server name.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Aberdeen Squash Racquets Club";
$cfg['Site']['URL']   = "http://www.asrc.biz";                 // no trailing slash
$cfg['Site']['Email'] = "info@asrc.co.uk";

$cfg['Site']['Db']['Hostname'] = "mysql6.streamline.net";
$cfg['Site']['Db']['Database'] = "asrc";
$cfg['Site']['Db']['Username'] = "asrc";
$cfg['Site']['Db']['Password'] = "fred71";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "king") !== FALSE) {
  $cfg['Site']['Db']['Hostname'] = 'localhost';
  $cfg['Site']['URL']   = "http://localhost/asrc";
} else if (strpos(strtolower($_SERVER['SERVER_NAME']), "southesk") !== FALSE) {
  $cfg['Site']['Db']['Hostname'] = 'localhost';
  $cfg['Site']['URL']   = "http://asrc.southesk.com";
  $cfg['Site']['Db']['Database'] = "southesk_com_-_asrc";
  $cfg['Site']['Db']['Username'] = "southesk";
  $cfg['Site']['Db']['Password'] = "psalm45";
}

?>
