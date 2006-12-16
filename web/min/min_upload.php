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

function f_sqlstring($item) {
  $x = str_replace("'", "\'", $item);
  $x = str_replace(chr(13).chr(10), "", $x);
  return $x;
}

?>
    <table>
<?

$uf = fopen("C:/AppServ/www/min/upload.sql", 'wb');

$sql = mysql_query("SELECT author, vol, localfile ".
                   "FROM mse_volume ".
                   "WHERE complete = 1 ".
                   "AND author = 'JBS' ".
                   "AND uploaded = 0 ".
                   "ORDER BY author,vol");

if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  echo "UPDATE mse_volume SET uploaded=1 WHERE author = '$author' AND vol = $vol;<br>";

  fwrite($uf, "UPDATE mse_volume SET added=now() WHERE author = '$author' AND vol = $vol;\n\n");
  fwrite($uf, "DELETE FROM mse_article WHERE author = '$author' AND vol = $vol;\n");
  fwrite($uf, "DELETE FROM mse_text WHERE author = '$author' AND vol = $vol;\n");
  fwrite($uf, "DELETE FROM mse_bible_ref WHERE author = '$author' AND vol = $vol;\n\n");

  $sql2 = mysql_query("SELECT page,article,scriptures,localrow ".
                      "FROM mse_article ".
                      "WHERE author = '$author' ".
                      "AND vol = $vol ".
                      "ORDER BY page DESC");

  // Update Article pages and output Inserts for Articles
  while ($row2 = mysql_fetch_array($sql2)) {
    foreach($row2 AS $key2 => $val2) {
      $$key2 = stripslashes($val2);
    }
    $ssql = "UPDATE mse_text ".
            "SET article_page = $page ".
            "WHERE author = '$author' ".
            "AND vol = $vol ".
            "AND localrow >= $localrow ".
            "AND article_page = 0";
    $sql3 = mysql_query($ssql);

    $insertsql = "INSERT INTO mse_article (author,vol,page,article,scriptures) VALUES ".
    "('$author',$vol,$page,'".f_sqlstring($article)."','".f_sqlstring($scriptures)."');\n";

    fwrite($uf, $insertsql);
  }

  // Output Inserts for Text
  $sql2 = mysql_query("SELECT page,para,article_page,text,inits ".
                      "FROM mse_text ".
                      "WHERE author = '$author' ".
                      "AND vol = $vol ".
                      "ORDER BY page,para");

  while ($row2 = mysql_fetch_array($sql2)) {
    foreach($row2 AS $key2 => $val2) {
      $$key2 = stripslashes($val2);
    }

    if (empty($inits)) {
      $inits = "NULL";
    } else {
      $inits = "'".f_sqlstring($inits)."'";
    }

    if (!empty($text)) {
      fwrite($uf, "INSERT INTO mse_text (author,vol,page,para,article_page,inits,text) VALUES ".
      "('$author',$vol,$page,$para,$article_page,$inits,'".f_sqlstring($text)."');\n");
    }
  }

  // Output Inserts for Text
  $sql2 = mysql_query("SELECT page,para,ref,bookid,chapter,vstart,vend ".
                      "FROM mse_bible_ref ".
                      "WHERE author = '$author' ".
                      "AND vol = $vol ".
                      "ORDER BY page,para,ref");

  while ($row2 = mysql_fetch_array($sql2)) {
    foreach($row2 AS $key2 => $val2) {
      $$key2 = stripslashes($val2);
    }

    fwrite($uf, "INSERT INTO mse_bible_ref (author,vol,page,para,ref,bookid,chapter,vstart,vend) VALUES ".
    "('$author',$vol,$page,$para,$ref,$bookid,$chapter,$vstart,$vend);\n");
  }
}

fclose($uf);

?>

