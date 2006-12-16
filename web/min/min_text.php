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
$database_name = 'southesk_com_-_hymn';

ini_set("max_execution_time", "100");

$connection = mysql_pconnect("$dbhost","$dbusername","$dbpasswd")  or die ("Couldn't connect to server.");
$db = mysql_select_db("$database_name", $connection)  or die("Couldn't select database.");

  $sql = "SELECT DISTINCT author, vol, page ".
         "FROM mse_text ";

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $sql2 = "SELECT MAX(page) artpage ".
            "FROM mse_article ".
            "WHERE author = '$author' ".
            "AND vol = $vol ".
            "AND page <= $page ";

    $ssql2 = mysql_query($sql2);
    while ($row2 = mysql_fetch_array($ssql2)) {
      foreach($row2 AS $key2 => $val2) {
        $$key2 = stripslashes($val2);
      }

      mysql_query("UPDATE mse_text SET article_page = $artpage ".
                  "WHERE author = '$author' ".
                  "AND vol = $vol ".
                  "AND page = $page ");
    }
  }


?>
