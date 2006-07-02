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
include('top.php');
include_once('functions.php');

$stext = NULL;        if (!empty($_GET['text'])) $stext = $_GET['text'];
$sql_text = str_replace(" ", "%", $stext);

$uauthor = NULL;      if (!empty($_GET['author'])) $uauthor = $_GET['author'];
$uvol = NULL;         if (!empty($_GET['vol'])) $uvol = $_GET['vol'];
$upage = NULL;        if (!empty($_GET['page'])) $upage = $_GET['page'];
$upara = NULL;        if (!empty($_GET['prgh'])) $upara = $_GET['prgh'];

$ubookid = NULL;      if (!empty($_GET['bookid'])) $ubookid = $_GET['bookid'];
$uchapter = NULL;     if (!empty($_GET['chapter'])) $uchapter = $_GET['chapter'];
$uvstart = NULL;      if (!empty($_GET['vstart'])) $uvstart = $_GET['vstart'];

$section = NULL;      if (!empty($_GET['section'])) $section = $_GET['section'];
$raut = NULL;         if (!empty($_GET['raut'])) $raut = $_GET['raut'];
$rvol = NULL;         if (!empty($_GET['rvol'])) $rvol = $_GET['rvol'];
$rpag = NULL;         if (!empty($_GET['rpag'])) $rpag = $_GET['rpag'];
$rpar = NULL;         if (!empty($_GET['rpar'])) $rpar = $_GET['rpar'];


if ($ubookid != NULL) {
  $sql = "SELECT b.bookname, b.singlechap ".
         "FROM mse_bible_book b ".
         "WHERE b.bookid = $ubookid";
//echo "<pre>$sql</pre>";
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  }

  $singlechap = ($singlechap == 1);
  if ($singlechap) $uchapter = 1;
}

?>

<table border=0 cellpadding=4 cellspacing=0>

<tr><td class=bardesc valign=top>Text<br>Search</td>
<td>
  <form method=get name="action_form" action="index.php">
  <table border=1 cellpadding=2 cellspacing=0>
  <tr><td width="300"><input type=hidden name=author id=author size=4 value="<? echo $uauthor;?>"><input
  type=hidden name=vol id=vol size=4 value="<? echo $uvol;?>"><input
  type=hidden name=bookid id=bookid size=4 value="<? echo $ubookid;?>"><input
  type=hidden name=chapter id=chapter size=4 value="<? echo $uchapter;?>"><input
  type=hidden name=vstart id=vstart size=4 value="<? echo $uvstart;?>"><?
  if (!empty($stext)) {
    echo $stext;
    ?><input size=30 type=hidden name=text id=text value="<? echo $stext;?>"></td><td><input
    type=button value="Clear" onclick="resetForm();"><?
  } else {
    ?><input size=30 type=text name=text id=text value=""></td><td><input
    type=submit value="Search"><?
  }
  ?></td></tr>
  </table></form>
</td>
</tr>


<tr><td class=bardesc valign=top>Author<br>Filter</td>
<td>
  <table border=1 cellpadding=2 cellspacing=0>
  <tr><td>
  <a href="index.php?level=1<? echo f_url(false,false,true,true,true); ?>">All</a>&nbsp;
  <?
  $sql = "SELECT DISTINCT author ".
         "FROM mse_volume ".
         "WHERE added IS NOT NULL ".
         "ORDER BY 1";
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  ?>
  <a href="index.php?level=2&author=<? echo $author . f_url(false,false,true,true,true); ?>"><? echo $author; ?></a>&nbsp;
  <?
  }
  if (!empty($uauthor)) {
  ?>
  </td></tr>
  <tr><td>
  <?
    if (!empty($stext)) {
      $sql = "SELECT DISTINCT v.vol ".
             "FROM mse_volume v, mse_text t ".
             "WHERE v.author='$uauthor' ".
             "AND t.author = v.author ".
             "AND t.vol = v.vol ".
             "AND t.text LIKE '%$sql_text%' ";
    } else {
      $sql = "SELECT DISTINCT vol ".
             "FROM mse_volume ".
             "WHERE author='$uauthor' ";
    }

    $sql .= "AND added IS NOT NULL ".
            "ORDER BY 1";
    $ssql = mysql_query($sql);
    while ($row = mysql_fetch_array($ssql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
  ?>
  <a href="index.php?level=3&vol=<? echo $vol . f_url(true,false,true,true,true); ?>"><? echo $vol; ?></a>&nbsp;
  <?
    }
  }
  ?>
  </td></tr>
  </table>
</td>
</tr>

<?
  if (empty($stext)) {
?>
<tr><td class=bardesc valign=top>Scripture<br>Filter</td>
<td>
  <table border=1 cellpadding=2 cellspacing=0>
<?
    if (empty($ubookid)) {
      f_show_books();
    } else if (empty($uchapter)) {
      f_show_chapters();
    } else {
      f_show_verses();
    }
  ?>
  </td></tr></table>
</td>
</tr>
  <?

    if (!empty($ubookid) && !empty($uchapter)) {
?>
<tr><td class=bardesc valign=top>Scripture<br>Results</td>
<td>
<?
      f_show_scripture_table();
  ?>
</td>
</tr>
  <?
    }
  } else if (empty($section)) {
?>
<tr><td class=bardesc valign=top>Search<br>Results</td>
<td>
<?
    f_show_table();
?>
</td>
</tr>
<?
  } else {
?>
<tr><td class=bardesc valign=top>Single<br>Entry</td>
<td>
<?
    f_show_single_section();
?>
</td>
</tr>
<?
  }
?>
<tr height=40>
  <td class=bardesc>&nbsp;</td>
  <td class="cpyrght" valign=bottom><b>V1.00</b> Search designed and maintained by <a href="http://www.southesk.com/">Southesk.com</a></td>
</tr>
<tr height=10>
  <td class=bardesc>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
