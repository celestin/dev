<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Return a page from a volume
 * Copyright (c) 2006 Southesk.com
 *
 * $Log: /web/cc/db.php $
 *
 * Who  When         Why
 * CAM  15-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include('db.php');
include('top.php');

$uauthor = NULL;      if (!empty($_GET['author'])) $uauthor = $_GET['author'];
$uvol = NULL;         if (!empty($_GET['vol'])) $uvol = $_GET['vol'];
$upage = NULL;        if (!empty($_GET['page'])) $upage = $_GET['page'];
$upara = NULL;        if (!empty($_GET['prgh'])) $upara = $_GET['prgh'];

?>
<h3><?echo "Servant $uauthor, Vol. $uvol, Page $upage";?></h3>

<table border=0 cellpadding=2 cellspacing=0 width=500>
<tr>
  <th>Para</th>
  <th>Text</th>
</tr>
<?
  $sql = "SELECT para, text ".
         "FROM mse_text ".
         "WHERE author = '$uauthor' ".
         "AND vol = '$uvol' ".
         "AND page = '$upage' ".
         "ORDER BY para ";

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

?>
<tr><td valign=top><?echo $para;?></td><td class="dt"><?echo $text;?></td></tr>
<?
  }
?>
</table>

