<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Sirdar - iKnit
 * Copyright (c) 2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Drill-down through Sirdar products
 *
 * $Id$
 *
 * Who  When         #      Why
 * CAM  28-Oct-2010  10800  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include 'sirdar.db.php';


?>
<html>
<head><title>iknit Sirdar leafets</title>
</head>
<body>
<?
    $ssql = "SELECT leaflet_sirdar_image ".
            "FROM sirdar_yarn_leaflet ".
            "ORDER BY yarn_code, leaflet_code ";
    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
?>
  <img src="<? echo $leaflet_sirdar_image; ?>">
<?
  }
?>
</body>
</html>