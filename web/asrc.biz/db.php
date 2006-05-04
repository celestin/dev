<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Database connection
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Id: calc.c 148 2002-07-28 21:30:43Z sally $
 *
 * 2     6/02/06 22:37 Craig
 * 10
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  06-Feb-2006  10: Added created_by.
 * * * * * * * * * * * * * * * * * * * * * * * */

$dbhost = 'mysql6.streamline.net';

if (strtolower($_SERVER['SERVER_NAME']) == "localhost") {
  $dbhost = 'localhost';
}

$dbusername = 'asrc';$dbpasswd = 'fred71';
$database_name = 'asrc';

$connection = mysql_pconnect("$dbhost","$dbusername","$dbpasswd", MYSQL_CLIENT_INTERACTIVE) or die ("Couldn't connect to server.");
$db = mysql_select_db("$database_name", $connection) or die("Couldn't select database.");
?>