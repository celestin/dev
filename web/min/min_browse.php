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

$ubookid = NULL;      if (!empty($_GET['bookid'])) $ubookid = $_GET['bookid'];
$uchapter = NULL;     if (!empty($_GET['chapter'])) $uchapter = $_GET['chapter'];
$uvstart = NULL;      if (!empty($_GET['vstart'])) $uvstart = $_GET['vstart'];

?>
    <table border=1>
<?

if ($ubookid != NULL) {
  $sql = "SELECT b.bookname, b.singlechap ".
         "FROM mse_bible_book b ".
         "WHERE b.bookid = $ubookid";

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  }

  if ($singlechap == 1) $uchapter = 1;
}

if (empty($ubookid)) {
  $prevtest = "";

  $sql = "SELECT DISTINCT b.testament, r.bookid, b.bookname ".
         "FROM mse_bible_ref r, mse_bible_book b ".
         "WHERE r.bookid = b.bookid ".
         "ORDER BY 1 DESC,2";
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($testament <> $prevtest) {
      if ($prevtest <> "") {
?>
  </td></tr>
<?
      }
?>
  <tr><td><b><? echo $testament; ?></b></td><td>
<?
      $prevtest = $testament;
    }

?>
    <a href="min_browse.php?bookid=<? echo $bookid; ?>"><? echo $bookname; ?></a>&nbsp;
<?
  }
} else if (empty($uchapter)) {
  $sql = "SELECT DISTINCT chapter ".
         "FROM mse_bible_ref ".
         "WHERE bookid = $ubookid ".
         "ORDER BY chapter";
?>
  <tr><td><a href="min_browse.php">Books</a>&nbsp;|&nbsp;<? echo "$bookname"; ?></td></tr><tr><td>Chapters
<?

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
    <a href="min_browse.php?bookid=<? echo $ubookid; ?>&chapter=<? echo $chapter; ?>"><? echo $chapter; ?></a>&nbsp;
<?
  }
} else /*if (empty($uvstart))*/ {
  $sql = "SELECT DISTINCT vstart ".
         "FROM mse_bible_ref ".
         "WHERE bookid = $ubookid ".
         "AND chapter = $uchapter ".
         "ORDER BY vstart";
?>
    <tr><td><a href="min_browse.php">Books</a>&nbsp;|
    <a href="min_browse.php?bookid=<? echo $ubookid; ?>"><? echo "$bookname"; ?></a>&nbsp;|
    Chapter <? echo $uchapter; ?></td></tr><tr><td>Verses
<?
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
    <a href="min_browse.php?bookid=<? echo $ubookid; ?>&chapter=<? echo $uchapter; ?>&vstart=<? echo $vstart; ?>"><? echo ($vstart==0) ? "All" : $vstart; ?></a>&nbsp;
<?
  }
/*} else {
?>
    <tr><td><a href="min_browse.php">Books</a>&nbsp;|
    <a href="min_browse.php?bookid=<? echo $ubookid; ?>"><? echo "$bookname"; ?></a>&nbsp;|
    <a href="min_browse.php?bookid=<? echo $ubookid; ?>&chapter=<? echo $uchapter; ?>"><? echo "Chapter $uchapter"; ?></a>&nbsp;|
    Verse <? echo $uvstart; ?>
<?*/
}
?>
</td></tr></table>
<?

if (!empty($ubookid) && !empty($uchapter)) {
?>
<br>
<table border=1>
<tr>
  <th>Verses</th>
  <th>Servant</th>
  <th>Vol.</th>
  <th>Page</th>
  <th>Para</th>
  <th>Text</th>
</tr>
<?
  $maxrows = 200;

  $sql = "SELECT r.ref, r.vstart, r.vend, t.author, t.vol, t.page, t.para, t.text, b.bookname ".
         "FROM mse_bible_ref r, mse_text t, mse_bible_book b ".
         "WHERE r.author = t.author ".
         "AND r.vol = t.vol ".
         "AND r.page = t.page ".
         "AND r.para = t.para ".
         "AND r.bookid = b.bookid ".
         "AND r.bookid = $ubookid ";

  if ($singlechap != 1) $sql .= "AND r.chapter = $uchapter ";

  if (!empty($uvstart)) {
    $sql .= "AND r.vstart = $uvstart ";
  } else {
    $maxrows = 20;
  }

  $sql .= "ORDER BY chapter, vstart, t.author, t.vol, t.page, t.para";
//echo "<pre>$sql</pre>";
  $currrow=0;

  $ssql = mysql_query($sql);
  while (($row = mysql_fetch_array($ssql)) && ($currrow++ < $maxrows)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $verses = "&nbsp;";
    if ($vstart > 0) $verses = $vstart;
    if ($vend == ($vstart+1)) {
      $verses .= ", $vend";
    } else if ($vend > 0) {
      $verses .= " - $vend";
    }

    $atpos = -1;
    $nextpos = $prevpos = 0;
    for ($curr = 0; $curr < $ref; $curr++) {
      $prevpos = $atpos;
      $atpos = strpos($text, "@", $atpos+1);
    }
    if (($nextpos = strpos($text, "@", $atpos+1)) === FALSE) {
      $nextpos = strlen($text);
    }

    $backpoint = max(0, max($prevpos+1, $atpos-60));
    $backtrail = $atpos-$backpoint;
    $headtrail = min(60, ($nextpos-$atpos)-1);

    $booklen = strlen($bookname);
    $backs = substr($text, $backpoint, ($atpos-$backpoint));
    $heads = substr($text, $atpos+$booklen+1, $headtrail-$booklen);


    $text = trim("$backs<b>$bookname</b>$heads");

    $midp = strlen($text)*0.254;
    if (($backpoint > 0) && (($atpos = strpos($text, " ")) !== FALSE) && $atpos < $midp) {
      $text = trim(substr($text, $atpos+1, strlen($text)));
    }

    $midp = strlen($text)*0.75;
    if ((substr($text, strlen($text)-1, 1) !== ".") &&
        (($atpos = strrpos($text, " ")) !== FALSE) &&
        ($atpos > $midp)) {
      $text = trim(substr($text, 0, $atpos));
    }
?>
<tr><td><?echo $verses;?></td><td><?echo $author;?></td><td><b><?echo $vol;?></b></td><td><?echo $page;?></td><td><?echo $para;?></td><td><?echo $text;?></td></tr>
<?
  }
?>
</table>
<?

}

?>
