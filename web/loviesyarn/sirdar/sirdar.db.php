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

include '../includes/configure.php';

$connection = mysql_pconnect(DB_SERVER,
                             DB_SERVER_USERNAME,
                             DB_SERVER_PASSWORD)
              or die ("Couldn't connect to server.");

$db = mysql_select_db(DB_DATABASE, $connection)
      or die("Couldn't select database.");
?>
