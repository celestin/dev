<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Database login
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

$dbhost = 'localhost';
$dbusername = 'relaxatub';$dbpasswd = 'hazel44';
$database_name = 'relaxatub_com_-_prod';

$connection = mysql_pconnect("$dbhost","$dbusername","$dbpasswd")
  or die ("Couldn't connect to server.");

$db = mysql_select_db("$database_name", $connection)
  or die("Couldn't select database.");
?>