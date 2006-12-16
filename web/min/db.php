<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Database Connectivity
 * Copyright (c) 2005 Southesk.com
 *
 * $Log: /web/cc/db.php $
 *
 * 1     28/12/05 15:43 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$dbhost = 'localhost';
$dbusername = 'southesk';$dbpasswd = 'psalm45';
$database_name = 'southesk_com_-_min';

ini_set("max_execution_time", "100");

$connection = mysql_pconnect("$dbhost","$dbusername","$dbpasswd")  or die ("Couldn't connect to server.");
$db = mysql_select_db("$database_name", $connection)  or die("Couldn't select database.");

?>
