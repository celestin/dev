<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Database connection
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  06-Feb-2006  10: Added created_by.
 * * * * * * * * * * * * * * * * * * * * * * * */

//SET PASSWORD FOR 'asrc'@'localhost' = OLD_PASSWORD('fred71');

$dbhost = 'mysql6.streamline.net';
if ((strtolower($_SERVER['SERVER_NAME']) == "localhost") || (strtolower($_SERVER['SERVER_NAME']) == "510m-0087")) {
  $dbhost = 'localhost';
}

$dbusername = 'asrc';$dbpasswd = 'fred71';
$database_name = 'asrc';

$connection = mysql_pconnect("$dbhost","$dbusername","$dbpasswd", MYSQL_CLIENT_INTERACTIVE) or die ("Couldn't connect to server.");
$db = mysql_select_db("$database_name", $connection) or die("Couldn't select database.");
?>