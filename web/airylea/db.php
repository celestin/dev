<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Database Connectivity
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

global $cfg;

$connection = mysql_pconnect($cfg['Site']['Db']['Hostname'],
                             $cfg['Site']['Db']['Username'],
                             $cfg['Site']['Db']['Password'])
              or die ("Couldn't connect to server.");

$db = mysql_select_db($cfg['Site']['Db']['Database'], $connection)
      or die("Couldn't select database.");
?>