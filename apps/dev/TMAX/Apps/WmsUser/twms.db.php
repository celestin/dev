<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Sirdar - iKnit
 * Copyright (c) 2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Database Connectivity
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2010  10800  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Db']['Hostname'] = "127.0.0.1";
$cfg['Site']['Db']['Username'] = "iknitbiz";
$cfg['Site']['Db']['Password'] = "bill81";
$cfg['Site']['Db']['Database'] = "iknit_biz_site";

$connection = mysql_pconnect($cfg['Site']['Db']['Hostname'],
                             $cfg['Site']['Db']['Username'],
                             $cfg['Site']['Db']['Password'])
              or die ("Couldn't connect to server.");

$db = mysql_select_db($cfg['Site']['Db']['Database'], $connection)
      or die("Couldn't select database.");
?>
