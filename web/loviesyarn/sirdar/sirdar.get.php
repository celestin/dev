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
 * CAM  23-Nov-2010  10823  Added Sirdar leaflets
 * CAM  28-Jul-2011  10998  Include Leaflets and Shades and use all images from Sirdar website.
 * * * * * * * * * * * * * * * * * * * * * * * */

include 'sirdar.db.php';


function output_table()
{
  global $row1, $row2, $row3, $row4;

  if (!empty($row1)) echo "<tr><td><table border=1><tr>$row1</tr><tr>$row2</tr><tr>$row3</tr><tr>$row4</tr></table></td></tr>";

  $row1 = "";
  $row2 = "";
  $row3 = "";
  $row4 = "";

}

function output_bar($status, $value) {

  //echo '<td>$value</td><td><img src="../images/f.png" height="20" width="' . ($value * 5) . '"></td>';
  echo '<img src="../images/status/' . strtolower($status) . '.png" height="20" width="' . ($value * 5) . '">';

}

function add_status_button($yarn_code, $subtype, $sub_code, $status_code, $current_status, $status_label) {
  $groupname = "group_" . $yarn_code;
  if (!empty($sub_code)) $groupname .= "_" . strtolower($subtype) . "_" . $sub_code;
  $id = $groupname . "_status_" . strtolower($status_code);

  return
    "<input type=\"radio\" name=\"$groupname\" " . (($status_code == $current_status) ? "CHECKED " : "") .
    "value=\"$status_code\" id=\"$id\" onClick=\"saveStatus('$yarn_code','$subtype','$sub_code','$status_code');\"><label for=\"$id\">$status_label</label><br />";
}

function ajax_status_table($yarn_code, $sub_code, $status, $subtype) {
  return
    "<div>".
      add_status_button($yarn_code, $subtype, $sub_code, 'NEW', $status, 'Not defined').
      add_status_button($yarn_code, $subtype, $sub_code, 'INC', $status, 'Included').
      add_status_button($yarn_code, $subtype, $sub_code, 'EXC', $status, 'Excluded').
  "</div>";
}

function background_colour($status) {
	if ($status == "NEW") return "background-color: orange";
}

?>
<html>
<head><title>iknit Sirdar wool selection</title>
<script type="text/javascript">
  function clearStatusBar() {
    document.getElementById("statusBar").innerHTML="";
  }

  function saveStatus(yarnCode, subType, subCode, statusValue)
  {
    if (window.XMLHttpRequest)
    {
      xmlhttp=new XMLHttpRequest();
    }
    else
    {
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
        document.getElementById("statusBar").innerHTML="<span id='saved'>" + xmlhttp.responseText + "</span>";
        setTimeout("clearStatusBar()", 1000);
      }
    }
    document.getElementById("statusBar").innerHTML="<span id='saving'>Saving...</span>";
    xmlhttp.open("GET","sirdar.save.php?yarn_code="+yarnCode+"&sub_type="+subType+"&sub_code="+subCode+"&status="+statusValue,true);
    xmlhttp.send();
  }
</script>
</head>
<body>

<style TYPE="text/css">
<!--
  h1, h2, h3, p, td, th, li {
    font-family: Arial;
  }

  th {
    background-color: #fff17b;
    font-weight: bold;
  }

  ul {
    margin: 0;
    padding: 0px 0px 20px 0px;
    list-style-type: none;
  }

  ul li { display: inline; }

  li {
    padding-right: 15px;
    font-size: 10pt;
    font-weight: bold;
  }

  #statusBar {
  }

  #saving {
    background-color: #ff9600;
    padding: 4px;
  }

  #saved {
    background-color: #cce82e;
    padding: 4px;
  }

  }
-->
</style>
<?

  $style_name = "";  if (!empty($_GET['style_name'])) $style_name = $_GET['style_name'];
  $ply_name = "";  if (!empty($_GET['ply_name'])) $ply_name = $_GET['ply_name'];
  $yarn_name = "";  if (!empty($_GET['yarn_name'])) $yarn_name = $_GET['yarn_name'];

  if (empty($style_name))
  {
    ?><ul><li>Top</li></ul>
      <table border="1" cellpadding=10 cellspacing=0>
      <tr>
        <th>Style</th>
        <th>Progress</th>
        <th>Not defined</th>
        <th>Included</th>
        <th>Excluded</th>
      </tr><?
    $ssql =
      "SELECT style_name, ".
        "SUM(if(yarn_status='NEW', 1, 0)) new_yarn, ".
        "SUM(if(yarn_status='INC', 1, 0)) inc_yarn, ".
        "SUM(if(yarn_status='EXC', 1, 0)) exc_yarn ".
      "FROM sirdar_yarn ".
      "GROUP BY style_name";
    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      echo '<tr><td><a href="?style_name=' . urlencode($row['style_name']) . '">' . $row['style_name'] . '</a></td>';
      echo '<td>';
      output_bar('NEW', $row['new_yarn']);
      output_bar('INC', $row['inc_yarn']);
      output_bar('EXC', $row['exc_yarn']);
      echo '</td>';
      echo '<td align="right">' . $row['new_yarn'] . '</td>';
      echo '<td align="right">' . $row['inc_yarn'] . '</td>';
      echo '<td align="right">' . $row['exc_yarn'] . '</td>';
      echo '</tr>';

    }
    ?></table><?
  }
  else if (empty($ply_name))
  {
    ?><ul><li><a href="?">Top</a></li><li><? echo $style_name; ?></li></ul>
      <table border="1" cellpadding=10 cellspacing=0>
      <tr>
        <th>Ply</th>
        <th>Progress</th>
        <th>Not defined</th>
        <th>Included</th>
        <th>Excluded</th>
      </tr><?
    $ssql =
      "SELECT ply_name, ".
        "SUM(if(yarn_status='NEW', 1, 0)) new_yarn, ".
        "SUM(if(yarn_status='INC', 1, 0)) inc_yarn, ".
        "SUM(if(yarn_status='EXC', 1, 0)) exc_yarn ".
      "FROM sirdar_yarn ".
      "WHERE style_name='" . $style_name . "' ".
      "GROUP BY ply_name ";
    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      echo '<tr><td><a href="?style_name=' . urlencode($style_name) . '&ply_name=' . urlencode($row['ply_name']) . '">' . $row['ply_name'] . '</a></td>';
      echo '<td>';
      output_bar('NEW', $row['new_yarn']);
      output_bar('INC', $row['inc_yarn']);
      output_bar('EXC', $row['exc_yarn']);
      echo '</td>';
      echo '<td align="right">' . $row['new_yarn'] . '</td>';
      echo '<td align="right">' . $row['inc_yarn'] . '</td>';
      echo '<td align="right">' . $row['exc_yarn'] . '</td>';
      echo '</tr>';
    }
    ?></table><?
  }
  else if (empty($yarn_name))
  {
    ?><ul><li><a href="?">Top</a></li><li><a href="?style_name=<? echo urlencode($style_name); ?>"><? echo $style_name; ?></a></li><li><? echo $ply_name; ?></li></ul>
      <table border="1" cellpadding=10 cellspacing=0>
      <tr>
        <th colspan="2">Yarn</th>
        <th>Leaflet Progress</th>
        <th>Not defined</th>
        <th>Included</th>
        <th>Excluded</th>
      </tr><?
    $ssql =
      "SELECT yarn_name, MIN(yarn_status) yarn_status, ".
        "SUM(if(leaflet_status='NEW', 1, 0)) new_yarn, ".
        "SUM(if(leaflet_status='INC', 1, 0)) inc_yarn, ".
        "SUM(if(leaflet_status='EXC', 1, 0)) exc_yarn ".
      "FROM sirdar_yarn y, sirdar_yarn_leaflet s ".
      "WHERE s.yarn_code = y.yarn_code ".
      "AND style_name='" . $style_name . "' ".
      "AND ply_name='" . $ply_name . "' ".
      "GROUP BY yarn_name ";


    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      echo '<tr>';
      echo '<td>';
      output_bar($row['yarn_status'], 4);
      echo '</td>';

      echo '<td><a href="?style_name=' . urlencode($style_name) . '&ply_name=' . urlencode($ply_name) . '&yarn_name=' . urlencode($row['yarn_name']) . '">' . $row['yarn_name'] . '</a></td>';
      echo '<td>';
      output_bar('NEW', $row['new_yarn']);
      output_bar('INC', $row['inc_yarn']);
      output_bar('EXC', $row['exc_yarn']);
      echo '</td>';
      echo '<td align="right">' . $row['new_yarn'] . '</td>';
      echo '<td align="right">' . $row['inc_yarn'] . '</td>';
      echo '<td align="right">' . $row['exc_yarn'] . '</td>';
      echo '</tr>';


      echo '</tr>';
    }
    ?></table><?
  }
  else
  {

    ?><ul><li><a href="?">Top</a></li>
        <li><a href="?style_name=<? echo urlencode($style_name); ?>"><? echo $style_name; ?></a></li>
        <li><a href="?style_name=<? echo urlencode($style_name); ?>&ply_name=<? echo urlencode($ply_name);?>"><? echo $ply_name; ?></a></li>
        <li><? echo $yarn_name; ?></li>
      </ul><?

    $row1 = "";
    $row2 = "";
    $row3 = "";
    $row4 = "";
    $counter = 0;
    $prev_yarn_name="";

    $ssql = "SELECT y.style_name, y.yarn_status, y.ply_name, y.yarn_name, y.yarn_code, y.yarn_image, l.leaflet_code, l.leaflet_status, l.leaflet_image ".
            "FROM sirdar_yarn y, sirdar_yarn_leaflet l ".
            "WHERE y.yarn_code = l.yarn_code ".
            "AND y.style_name='" . $style_name . "' ".
            "AND y.ply_name='" . $ply_name . "' ".
            "AND y.yarn_name='" . $yarn_name . "' ".
            "ORDER BY y.style_name, y.ply_name, y.yarn_name, l.leaflet_code ";
    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      if ($prev_yarn_name != $yarn_name)
      {
        ?>
        <div>
        <table border=0 cellpadding=5 cellspacing=0>
          <tr>
            <td><table border=0  cellpadding=5 cellspacing=0>
              <tr>
                <td><img height="200" src="http://www.sirdar.co.uk/images/products/yarns/<? echo $yarn_image;?>"></td>
                <td><? echo ajax_status_table($yarn_code, '', $yarn_status, 'None'); ?></td>
                <td><div id="statusBar"></div></td>
              </tr>
            </table></td
          </tr>
        <?

        $prev_yarn_name = $yarn_name;
      }

      if (($counter % 8) == 0) {
        output_table();
      }

      $row1 .= "<td style=\"font-size:10pt;font-weight:bold;text-align:center;" . background_colour($leaflet_status) . "\">$leaflet_code</td>";
      $row3 .= "<td style=\"font-size:8pt;\">" . ajax_status_table($yarn_code, $leaflet_code, $leaflet_status, 'Leaflet') . "</td>";
      $row4 .= "<td><img height=\"140\" src=\"http://www.sirdar.co.uk/images/products/yarns_relateddesigns/$leaflet_image\"></td>\n";

      $counter++;

    }

    output_table();
    ?></div><?

    if (1==1)
    {
    $counter = 0;

    $ssql = "SELECT y.style_name, y.yarn_status, y.ply_name, y.yarn_name, y.yarn_code, y.yarn_image, s.shade_code, s.shade_status, s.shade_name, s.shade_image ".
            "FROM sirdar_yarn y, sirdar_yarn_shade s ".
            "WHERE y.yarn_code = s.yarn_code ".
            "AND y.style_name='" . $style_name . "' ".
            "AND y.ply_name='" . $ply_name . "' ".
            "AND y.yarn_name='" . $yarn_name . "' ".
            "ORDER BY y.style_name, y.ply_name, y.yarn_name, s.shade_name ";
    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      if ($prev_yarn_name != $yarn_name)
      {
        ?>
        <div>
        <table border=0 cellpadding=5 cellspacing=0>
          <tr>
            <td><table border=0  cellpadding=5 cellspacing=0>
              <tr>
                <td><img height="200" src="http://www.sirdar.co.uk/images/products/yarns/<? echo $yarn_image;?>"></td>
                <td><? echo ajax_status_table($yarn_code, '', $yarn_status, 'Yarn'); ?></td>
                <td><div id="statusBar"></div></td>
              </tr>
            </table></td
          </tr>
        <?

        $prev_yarn_name = $yarn_name;
      }

      if (($counter % 12) == 0) {
        output_table();
      }

      $row1 .= "<td style=\"font-size:8pt;" . background_colour($shade_status) . "\">$shade_name</td>";
      $row2 .= "<td style=\"font-size:9pt;\">$shade_code</td>";
      $row3 .= "<td style=\"font-size:8pt;\">" . ajax_status_table($yarn_code, $shade_code, $shade_status, 'Shade') . "</td>";
      $row4 .= "<td height=\"65\" ><img height=\"60\" src=\"http://www.sirdar.co.uk/images/products/shades/$shade_image\"></td>\n";

      $counter++;

    }

    output_table();
    ?></div><?
    }
  }
?>
</body>
</html>