<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Dunc Smith Glasscraft
 * Copyright (c) 2009 Dunc Smith
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jul-2009  10459 : Added new images and file headers.
 * * * * * * * * * * * * * * * * * * * * * * * */

$dbhost = 'localhost';
$dbusername = 'dsglasscraft';$dbpasswd = 'dunc';

$database_name = 'dsglasscraft_com_-_glass';

$connection = mysql_pconnect("$dbhost","$dbusername","$dbpasswd")
  or die ("Couldn't connect to server.");

$db = mysql_select_db("$database_name", $connection)
  or die("Couldn't select database.");
?>