<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Configuration Data
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Feb-2007  10097 : File created.
 * CAM  22-Jun-2007  10132 : Corrected Local Server name.
 * CAM  25-Jun-2007  10133 : Added 'Test' boolean.
 * CAM  12-Aug-2007  10157 : Changed Test URL to reflect king machine.
 * CAM  14-Aug-2007  10164 : Reconfigured Database parameters for goblin.xssl.net.
 * CAM  26-Oct-2007  10195 : Added settings for localhost.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Aberdeen Squash Racquets Club";
$cfg['Site']['URL']   = "http://www.asrc.biz";                 // no trailing slash
$cfg['Site']['Email'] = "info@asrc.co.uk";
$cfg['Site']['Test'] = FALSE;

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Database'] = "asrc_biz_-_site";
$cfg['Site']['Db']['Username'] = "asrc";
$cfg['Site']['Db']['Password'] = "fred71";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "artificer") !== FALSE) {
  $cfg['Site']['URL']   = "http://artificer/asrc";

  $cfg['Site']['Test'] = TRUE;
  $cfg['Site']['Email'] = "craig@frontburner.co.uk";

}
?>