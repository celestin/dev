<table border=0>

<?

  $ssql = "SELECT url, title, linkdesc ".
          "FROM link ".
          "ORDER BY title";
  $sql = mysql_query($ssql) or die (mysql_error() . " " . $ssql);
  $i=0;

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
  <tr><td><a href="<? echo $url; ?>"><? echo $title; ?></a></td></tr>
  <tr><td><? echo $linkdesc; ?></td></tr>
<?
  }
?>
</table>