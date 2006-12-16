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
include('min_scr.php');

function f_inits($text) {
  $halt=false;
  $inits=false;
  $dotcount=0;

  $txt = $text;
  if (substr($txt, 0, 1) == ".") $txt = substr($txt, 1, strlen($txt)-1);    // Remove lines that begin with a period

  for ($i=0; $i<strlen($txt)&&!$halt&&($i<11); $i++) {
    $c = ord(strtoupper(substr($txt, $i, 1)));
    if ($c == 46) {
      $dotcount++;

    } else if ($c == 32) {
      $halt = true;

      if ($dotcount > 1) {
        $inits = true;
      }

    } else if (($c >= 65 && $c <= 90) || ($c == 39)) {
      // continue
    } else {
      $halt = true;
      $inits = false;
    }
  }

  if ($inits && ($i>0)) {
    $txt = trim(substr($txt, 0, $i));
    if ($txt <> "..") return $txt;
  }

  return "";
}


?>
    <table border=0>
<?

$fileinfo = TRUE;

$bb = array();
$sql = mysql_query("SELECT bookid,bookname,singlechap ".
                   "FROM mse_bible_book ".
                   "ORDER BY bookname");

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  $bb[$bookid] = new BibleBook($bookid,$bookname,$singlechap);
  //echo "[".$bb[$bookid]->bookname . " ".$bb[$bookid]->singlechap."]<br>";
}
$bbcount = count($bb);

$sql = mysql_query("SELECT v.author, v.vol, v.localfile ".
                   "FROM mse_volume v, mse_volume_current c ".
                   "WHERE v.author = c.author AND v.vol = c.vol");

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if ($fileinfo) {
?>
    <tr>
    <td><? echo $author; ?></td>
    <td><? echo $vol; ?></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><? echo $localfile; ?></td>
<?
  }

    $sqld = mysql_query("DELETE FROM mse_text WHERE author = '$author' and vol = $vol");
    $sqld = mysql_query("DELETE FROM mse_bible_ref WHERE author = '$author' and vol = $vol");

    $fp = fopen($localfile, "r") or die("OPEN");
    $rows = $pageno = $para = 0;
    $titles = "";
    while (!feof($fp)) {
      $rows++;
      $buffer = fgets($fp, 4096);

      if ((substr($buffer, 0, 1) === "{") && (substr($buffer, 0, 2) !== "{#")) {
        //$pageno = str_replace("}", "", str_replace("{", "", $buffer));

        if (($cb = strpos($buffer, "}")) !== FALSE) {
          $pageno = substr($buffer, 1, $cb-1);
        }

        $para = 0;
      } else if (substr($buffer, 0, 2) === "{#") {
        // Volume title - do nothing
      } else {
        $para++;

        $inits = f_inits($buffer);

        if (empty($inits)) {
          $inits = "NULL";
        } else {
          $inits = "'". str_replace("'", "\'", $inits) ."'";
        }

        //echo "$inits ";

        $sqli = mysql_query("INSERT INTO mse_text (".
                              "author, vol, page, para, localrow, inits, text".
                            ") VALUES (".
                              "'$author', $vol, $pageno, $para, $rows, $inits, '". str_replace("'", "\'", $buffer) ."'".
                           ")") or die(mysql_error());
      }

      // Parse Scriptures
      if (strpos($buffer, "@") !== FALSE) {
        $a = explode("@", $buffer);
        $ac = count($a);

        for ($ai = 1; $ai < $ac; $ai++) {
          $bref = new BibleRef($a[$ai]);

          if ($bref->refvalid) {
            //echo "<tr><td><b>Valid ref</b>$bref->chapter :: $bref->vstart :: $bref->vend</td><td colspan=3>$a[$ai]</td></tr>";
            $sqli_s = "INSERT INTO mse_bible_ref (".
                        "author, vol, page, para, ref, ".
                        "bookid, chapter, vstart, vend".
                      ") VALUES (".
                        "'$author', $vol, $pageno, $para, $ai, ".
                        "$bref->bookid, $bref->chapter, $bref->vstart, $bref->vend".
                      ")";
            $sqli = mysql_query($sqli_s) or die ("<pre>$bref->cv\n$localfile\n$rows\n" . mysql_error() . "\n\n$sqli_s</pre>");
          } else {
            echo "<tr><td>$author</td><td>$vol</td><td>$pageno</td><td>$rows</td><td>".$bref->f_errcode()."</td><td>". substr($a[$ai],0,40)."</td></tr>";
          }

        }
      }
    }
    fclose($fp) or die("CLOSE");

    if ($fileinfo) {
?>
    <td><? echo $rows; ?></td>
<?
    }

  }


?>

</table>
