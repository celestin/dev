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

$connection = mysql_pconnect("$dbhost","$dbusername","$dbpasswd")  or die ("Couldn't connect to server.");
$db = mysql_select_db("$database_name", $connection)  or die("Couldn't select database.");


?>
    <table>
<?
$sql = mysql_query("SELECT author, vol, localfile ".
                   "FROM mse_volume "/*.
                   "WHERE author = 'CAC' ".
                   "AND vol = 20"*/);

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

?>
    <tr>
    <td><? echo $author; ?></td>
    <td><? echo $vol; ?></td>
    <td><? echo $localfile; ?></td>
<?

    $fp = fopen($localfile, "r") or die("OPEN");
    $rows=0;
    $titles = "";
    $voltitle = "";
    while (!feof($fp)) {
      $buffer = fgets($fp, 4096);

      // Parse Scriptures
      // Parse Article Names

      if (substr($buffer, 0, 2) == "{#") {
        $voltitle .= str_replace("}", "", str_replace("{#", "", $buffer));
      }

/*
      $upper = $lower = $html = 0;
      for ($i=0;$i<strlen($buffer);$i++) {
        $c = ord(substr($buffer, $i, 1));
        if ($c >= 65 && $c <= 90) $upper++;
        if ($c >= 97 && $c <= 122) $lower++;
        if ($c == 60 || $c == 62) $html++;
      }

      if ((($upper + $lower) > 0) && ($html == 0)) {
        if (($upper / ($upper + $lower)) > 0.7) $titles .= $buffer . "<br>";
      }

      $rows++;
*/
    }
    fclose($fp) or die("CLOSE");

    if (!empty($voltitle)) {
      $sql2 = mysql_query("UPDATE mse_volume ".
                          "SET title = '$voltitle' ".
                          "WHERE author = '$author' ".
                          "AND vol = $vol");
    }

?>
    <td><? echo $titles; ?></td>
<?

  }


?>

</table>