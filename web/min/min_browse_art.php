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

$uonechar = NULL;     if (!empty($_GET['onechar'])) $uonechar = $_GET['onechar'];
$uchapter = NULL;     if (!empty($_GET['chapter'])) $uchapter = $_GET['chapter'];
$uvstart = NULL;      if (!empty($_GET['vstart'])) $uvstart = $_GET['vstart'];

?>
    <table border=1>
<?

if (empty($uonechar)) {
  $sql = "SELECT DISTINCT SUBSTR(article,1,1) onechar ".
         "FROM mse_article ".
         "ORDER BY 1";
?>
  <tr><td>
<?
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

?>
    <a href="min_browse_art.php?onechar=<? echo $onechar; ?>"><? echo $onechar; ?></a>&nbsp;
<?
  }
} else if (empty($uchapter)) {
  $sql = "SELECT article ".
         "FROM mse_article ".
         "WHERE SUBSTR(article,1,1) = '$uonechar' ".
         "ORDER BY 1";
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
    <tr><td><a href="min_browse_art.php?onechar=<? echo $uonechar; ?>"><? echo $article; ?></a></td></tr>
<?
  }
} else if (empty($uvstart)) {
  $sql = "SELECT DISTINCT vstart ".
         "FROM mse_bible_ref ".
         "WHERE bookid = $ubookid ".
         "AND chapter = $uchapter ".
         "ORDER BY vstart";
?>
    <tr><td><a href="min_browse_art.php">Books</a>&nbsp;|
    <a href="min_browse_art.php?bookid=<? echo $ubookid; ?>"><? echo "$bookname"; ?></a>&nbsp;|
    Chapter <? echo $uchapter; ?></td></tr><tr><td>Verses
<?
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
    <a href="min_browse_art.php?bookid=<? echo $ubookid; ?>&chapter=<? echo $uchapter; ?>&vstart=<? echo $vstart; ?>"><? echo ($vstart==0) ? "All" : $vstart; ?></a>&nbsp;
<?
  }
} else {
?>
    <tr><td><a href="min_browse_art.php">Books</a>&nbsp;|
    <a href="min_browse_art.php?bookid=<? echo $ubookid; ?>"><? echo "$bookname"; ?></a>&nbsp;|
    <a href="min_browse_art.php?bookid=<? echo $ubookid; ?>&chapter=<? echo $uchapter; ?>"><? echo "Chapter $uchapter"; ?></a>&nbsp;|
    Verse <? echo $uvstart; ?>
<?
}
?>
</td></tr></table>
<?

if (!empty($ubookid) && !empty($uchapter)) {
?>
<table border=1>
<tr>
  <th>vstart</th>
  <th>vend</th>
  <th>author</th>
  <th>vol</th>
  <th>page</th>
  <th>para</th>
  <th>text</th>
</tr>
<?
  $sql = "SELECT r.vstart, r.vend, t.author, t.vol, t.page, t.para, t.text ".
         "FROM mse_bible_ref r, mse_text t ".
         "WHERE r.author = t.author ".
         "AND r.vol = t.vol ".
         "AND r.page = t.page ".
         "AND r.para = t.para ".
         "AND r.bookid = $ubookid ";

  if ($singlechap != 1) $sql .= "AND r.chapter = $uchapter ";

  if (!empty($uvstart)) $sql .= "AND r.vstart = $uvstart ";

    $sql .= "ORDER BY chapter, vstart, vend";
echo "<pre>$sql</pre>";
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

?>
    <tr>
      <td><?echo $vstart;?></td>
      <td><?echo $vend;?></td>
      <td><?echo $author;?></td>
      <td><?echo $vol;?></td>
      <td><?echo $page;?></td>
      <td><?echo $para;?></td>
      <td><?echo $text;?></td>
    </tr>
<?
  }
?>
</table>
<?

}

?>
