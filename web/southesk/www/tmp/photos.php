<html>
<head><title>Test</title>
</head>
<body>
<?
$dbhost = 'localhost';
$dbusername = 'southesk';$dbpasswd = 'psalm45';
$database_name = 'southesk_com_-_global';

$connection = mysql_pconnect("$dbhost","$dbusername","$dbpasswd")
  or die ("Couldn't connect to server.");
$db = mysql_select_db("$database_name", $connection)
  or die("Couldn't select database.");

    $ssql = "SELECT pid, aid, filepath, filename, ".
            "date_format(FROM_UNIXTIME(ctime), '%Y-%m-%d') mtime, ".
            "title, caption, ".
            "keywords FROM cpg11d_pictures ";
    $sql = mysql_query($ssql) or die (mysql_error());

    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      echo "$pid,$filepath,$filename,$mtime,$title,$caption,$keywords<br>";
    }

?>
</body>
</html>
