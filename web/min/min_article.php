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

include('db.php');

function f_scripture($item) {
}

//SELECT article,scriptures,page,localrow FROM mse_article WHERE author = 'JT' AND vol = 20

/*
SELECT v.article,v.scriptures,v.page,v.localrow
FROM mse_article v, mse_volume_current c
WHERE v.author = c.author AND v.vol = c.vol
ORDER BY 4
*/

?>
    <table>
<?
$sql = mysql_query("SELECT v.author, v.vol, v.localfile ".
                   "FROM mse_volume v, mse_volume_current c ".
                   "WHERE v.author = c.author AND v.vol = c.vol");

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

?>
    <tr>
    <th>author</th>
    <th>vol</th>
    <th>page</th>
    <th>lineno</th>
    <th>text</th>
    </tr>
<?
    $sqld = mysql_query("DELETE FROM mse_article WHERE author = '$author' and vol = $vol");

    $fp = fopen($localfile, "r") or die("OPEN");
    $rows = $pageno = 0;
    $titles = "";
    while (!feof($fp)) {
      $rows++;
      $buffer = fgets($fp, 4096);

      // Parse Article Names
      $trbuff = trim($buffer);
      if ((substr($trbuff, 0, 1) == "@") && $prevtitle === TRUE) {
        $sql2 = mysql_query("UPDATE mse_article ".
                            "SET scriptures = '$trbuff' ".
                            "WHERE author = '$author' ".
                            "AND vol = '$vol' ".
                            "AND localrow = '".($rows-1)."'");
      }

      if ((substr($buffer, 0, 1) == "{") && (substr($buffer, 0, 2) != "{#")) {
        $pageno = str_replace("}", "", str_replace("{", "", $buffer));
      }

      $upper = $lower = $html = $other = 0;
      for ($i=0;$i<strlen($buffer);$i++) {
        $c = ord(substr($buffer, $i, 1));
        if ($c >= 65 && $c <= 90) {
          $upper++;
        } else if ($c >= 97 && $c <= 122) {
          $lower++;
        } else if ($c == 60 || $c == 62) {
          $html++;
        } else if ($c == 34 || $c == 39 || $c == 32 || $c == 13 || $c == 10 || $c == 58 || $c == 45) {
          // ignore quotes/ws in the 'other' count
        } else if ($c == 46) {
          $other++;
        } else {
//          $other++;
        }
      }

      $prevtitle = FALSE;
      if ((($upper + $lower) > 0) && ($html == 0) && (trim($buffer)<>"PREFATORY NOTE") && (trim($buffer)<>"*NOTE*")) {
        if (($upper / ($upper + $lower + $other)) > 0.7) {
          $sql2 = mysql_query("REPLACE INTO mse_article ( ".
            "author, vol, article, scriptures, localrow, page ".
            ") VALUES (".
            "'$author', '$vol', '". str_replace("'", "\'", $buffer) ."', '', '$rows', '$pageno')");
          $prevtitle = TRUE;

?>
    <tr>
    <td><? echo $author; ?></td>
    <td><? echo $vol; ?></td>
    <td><? echo $pageno; ?></td>
    <td><? echo $rows; ?></td>
    <td><? echo $buffer; ?></td>
    </tr>
<?

        }
      }
    }
    fclose($fp) or die("CLOSE");
  }


?>

</table>
