<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Configuration Data
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  07-Mar-2010  10588 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "Relaxatub (Aberdeen, Scotland, UK)";
$cfg['Site']['URL']   = "http://www.relaxatub.com";                 // no trailing slash
$cfg['Site']['Email'] = "customer.service@relaxatub.com";
$cfg['Site']['Test'] = FALSE;

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Database'] = "relaxatub_com_-_prod";
$cfg['Site']['Db']['Username'] = "relaxatub";
$cfg['Site']['Db']['Password'] = "hazel44";

if (strpos(strtolower($_SERVER['SERVER_NAME']), "king") !== FALSE) {
  $cfg['Site']['URL']   = "http://king/relaxatub";
  $cfg['Site']['Test'] = TRUE;
  $cfg['Site']['Email'] = "craig@frontburner.co.uk";
}

?>
