
</table></td></tr>

<tr>
  <td align=center class=cpyrght>Copyright &copy; 2006 Dunc Smith. All rights reserved.<br />
  Site designed and maintained by <a href="http://www.frontburner.co.uk/">frontburner.co.uk</a>&nbsp;|&nbsp;<a href="mailto:webmaster@frontburner.co.uk">Webmaster</a></td>
</tr>

</table>


<?

  $ssql = "SELECT DISTINCT s.section, s.secName, s.menu ".
          "FROM section s, category c, piece d ".
          "WHERE s.section = c.section ".
          "AND c.cat = d.cat ".
          "AND s.menu IS NOT NULL ".
          "ORDER BY sortOrder";
  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    print "<div id=\"mnu$menu\" style=\"position:absolute;display:none\"><table class=mnu border=0 width=\"100\">";

    $ssql = "SELECT DISTINCT c.cat, c.catName ".
            "FROM category c, piece d ".
            "WHERE section=$section ".
            "AND c.cat = d.cat ".
            "ORDER BY catName";

    $sql2 = mysql_query($ssql) or die (mysql_error());

    while ($row2 = mysql_fetch_array($sql2)) {
      foreach($row2 AS $key => $val) {
        $$key = stripslashes($val);
      }

      print "<tr><td><a href=\"index.php?cat=$cat\" class=nav>$catName</a></td></tr>";
    }

    print "</table></div>";
  }

?>

</body>
</html>