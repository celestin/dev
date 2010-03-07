<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Database connection
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  08-Feb-2007  10097 : Moved parameters to config.php.
 * * * * * * * * * * * * * * * * * * * * * * * */

$connection = mysql_pconnect($cfg['Site']['Db']['Hostname'],$cfg['Site']['Db']['Username'],$cfg['Site']['Db']['Password'], MYSQL_CLIENT_INTERACTIVE) or die ("Couldn't connect to server.");
$db = mysql_select_db($cfg['Site']['Db']['Database'], $connection) or die("Couldn't select database.");
?>
