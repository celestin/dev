<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Database Connectivity
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/maia/db.php $
 * 
 * 1     3/02/06 1:52 Craig
 * 1000
 *
 * Who  When         Why
 * CAM  02-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

global $cfg;

$connection = mysql_pconnect($cfg['Site']['Db']['Hostname'],
                             $cfg['Site']['Db']['Username'],
                             $cfg['Site']['Db']['Password'])
              or die ("Couldn't connect to server.");

$db = mysql_select_db($cfg['Site']['Db']['Database'], $connection)
      or die("Couldn't select database.");
?>