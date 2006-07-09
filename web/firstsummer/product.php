<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Product Page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  08-Apr-2006  Added more functionality.
 * CAM  14-Apr-2006  Corrected gallery thumbnail link class.
 * CAM  30-May-2006  Added Plans functionality.
 * CAM  08-Jun-2006  Continued development of pricing.
 * CAM  08-Jul-2006  1004 : Completed pricing.
 * CAM  09-Jul-2006  10014 : Show product Dimensions.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$utab = NULL;          if (!empty($_GET['tab'])) $utab = $_GET['tab'];
$uproduct = NULL;      if (!empty($_GET['product'])) $uproduct = $_GET['product'];
$uphoto = NULL;        if (!empty($_GET['photo'])) $uphoto = $_GET['photo'];

function output_price_row($rowhtm, $pivots, $pricepriv, $roptions, $priceprivro) {
  foreach ($pivots as $pp) {
    $rowhtm .= "<td align=right>";

    if (empty($pricepriv[$pp])) {
      $rowhtm .= "-";
    } else {
      $rowhtm .= "&pound;" . number_format($pricepriv[$pp], 2, '.', ',');
    }
    $rowhtm .= "</td>";
  }

  foreach ($roptions as $ro) {
    $rowhtm .= "<td align=right>";

    if (empty($priceprivro[$ro])) {
      $rowhtm .= "-";
    } else {
      $rowhtm .= "&pound;" . number_format($priceprivro[$ro], 2, '.', ',');
    }
    $rowhtm .= "</td>";
  }

  echo "$rowhtm</tr>\n";
}

if (empty($utab)) $utab = 1;
$productname = NULL;
$htmlname = NULL;

$sql = mysql_query("SELECT p.id product_id, p.product, IFNULL(p.htmlname, p.product) htmlname, p.brochure, p.prodrange_id urange, r.category_id ucategory ".
                   "FROM products p, prodranges r  ".
                   "WHERE p.prodrange_id = r.id ".
                   "AND p.id = '$uproduct'");

if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  $productname = $product;
  $htmlname = $htmlname;
}

$title = "Product";
include 'tpl/top.php';

$sql = mysql_query("SELECT id,imgfile FROM photos WHERE product_id='$uproduct' AND default_flag=1 ORDER BY rand() LIMIT 1 ");
if ($row = mysql_fetch_array($sql)) {
  $rand_img = $row[1];
}
$sql = mysql_query("SELECT count(*) plan_count FROM plans WHERE product_id='$uproduct'");
$plan_count=0;
if ($row = mysql_fetch_array($sql)) {
  $plan_count = $row[0];
}

?>
<table border=0 cellpadding=0 cellspacing=0 width="100%" valign=top>
  <tr>
    <td><table border=0 cellpadding=2 cellspacing=0><tr>
<?
  $prev = false;
  $sql = mysql_query("SELECT id tab_id,tab ".
                     "FROM tabs ".
                     "ORDER BY disporder");

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key2 => $val) {
      $$key2 = stripslashes($val);
    }

    $cls = "";
    $hcls = "itemnav";
    if ($tab_id == $utab) {
      $cls = "sel";
      $hcls = "navsel";
    }

    if ($tab_id == 1 && !empty($productname)) {
      $tab = str_replace(" ", "&nbsp;", $productname);
    }

    $show_tab = true;
    if ($tab_id == 2 && empty($rand_img)) $show_tab = false;
    if ($tab_id == 3 && $plan_count<1) $show_tab = false;

    if ($show_tab) {
      if ($prev) {
?>
        <td class="tabspace"><img src="img/f.gif"></td>
<?
      }
?>
      <td class="tab<? echo $cls;?>"><a class="<? echo $hcls;?>" href="product.php?product=<? echo $uproduct;?>&tab=<? echo $tab_id;?>"><? echo $tab;?></a></td>
<?
    }

    $prev = true;
  }
?>
      <td class="tabspace" width="100%"><img src="img/f.gif"></td>
    </tr></table></td>
  </tr>

  <tr>
    <td valign=top class="page">
<?
    if ($utab == 2) {
?>
      <table border=0 cellpadding=0 cellspacing=0>
<?
      $sql = mysql_query("SELECT id,imgfile ".
                          "FROM photos ".
                          "WHERE product_id='$uproduct' ".
                          "ORDER BY disporder");
      $phcount=0;
      $phtcount=0;
      $phmax=5;
      $html = "";
      $main_pic = "_blank.jpg";
      while ($row = mysql_fetch_array($sql)) {
        foreach($row AS $key2 => $val) {
          $$key2 = stripslashes($val);
        }

        $cls = "";
        $selected = false;
        if (($uphoto == $id) || ((empty($uphoto) && $phcount == 0))) {
          $main_pic = "$imgfile";
          $selected = true;
          $cls = "sel";
        }

        $phcount++;
        $phtcount++;
        if ($phcount > $phmax) {
          $html .= "</tr><tr>";
          $phcount = 1;
        }
        $html .= "<td class=\"ti\"><a class=\"imgnav$cls\" href=\"product.php?product=$uproduct&tab=$utab&photo=$id\"><img width=100 height=100 src=\"img/g/t/$imgfile\"></a><!--<br>delete from photos where imgfile='$imgfile'--></td>\n";
      }

      if ($phcount < $phmax) {
        $html .= "<td colspan=" . ($phmax - $phcount) . ">&nbsp;</td>";
      }

      if ($phtcount < 2) {
        $html = "<td class=\"ti\">&nbsp;</td>";
      }
?>
      <tr><td><img src="img/g/f/<? echo $main_pic; ?>"></td></tr><tr><td align=left><table border=0 cellpadding=0 cellspacing=0><tr>
<?
      echo $html;
?>
      </tr></table></td></tr></table>
<?
    } else if ($utab == 3) {
?>
<table align=center border=0 cellpadding=10 cellspacing=0>
<?
      $sql = mysql_query("SELECT id,imgfile ".
                          "FROM plans ".
                          "WHERE product_id='$uproduct' ".
                          "ORDER BY disporder");

      while ($row = mysql_fetch_array($sql)) {
?>
  <tr><td><img src="img/p/<? echo $row[1]; ?>"></td></tr>
<?
      }
?>
</table>
<?
    } else {
?>
<table border=0 width="100%">
<tr>
<?
      if (!empty($rand_img)) {
?>
      <td><img height=200 src="img/g/m/<? echo $rand_img; ?>"></td>
<?
      } else {
?>
      <td><img height=200 src="img/g/m/_blank.jpg"></td>
<?
      }
?>
  <td class="shorttxt"><!--very brief text goes here. very brief text goes here. very brief text goes here--></td>
  <td width=120 valign=top><table border=0 cellpadding=4 cellspacing=0 width="100%">
    <tr><td colspan=2 class="download">DOWNLOAD</td></tr>
<?
      if (!empty($brochure)) {
?>
    <tr>
      <td><a target="_blank" href="upl/<? echo $brochure; ?>"><img border=0 src="img/pdf2.png"></a></td>
      <td><a target="_blank" href="upl/<? echo $brochure; ?>">Brochure</a></td>
    </tr>
<?
      }

  $ropivots = false;
  $sql = mysql_query("SELECT IFNULL(COUNT(*),0) pivot_count ".
                     "FROM prodprices c, rangeoptions o ".
                     "WHERE c.rangeoption_id = o.id ".
                     "AND c.product_id = $uproduct ".
                     "and c.rangeoption_id IS NOT NULL ".
                     "AND c.pivot IS NOT NULL");
  if ($row = mysql_fetch_array($sql)) {
    $ropivots = ($row[0] > 0);
  }
?>
  </table></td>
</tr>

<!-- Dimensions -->
<tr>
  <td colspan=3><table border=0 cellpadding=0 cellspacing=0>
<?
  $dimtypes = array();
  $sql = mysql_query("SELECT distinct(d.dim_type) dim_type ".
                     "FROM proddimensions pd, dimensions d ".
                     "WHERE pd.dimension_id = d.id ".
                     "AND pd.product_id = $uproduct");
  while ($row = mysql_fetch_array($sql)) {
    $dimtypes[count($dimtypes)+1] = $row[0];
  }

  $htmlnameoutput = false;
  foreach($dimtypes AS $dt) {

    if ($dt == 1) {
      echo "<tr><td colspan=2><h4>$htmlname</h4></td></tr>\n";
      $htmlnameoutput = true;

    } else if ($dt == 2) {
      echo "<tr><td colspan=2><h4>";
      if (!$htmlnameoutput) {
        echo "$htmlname&nbsp;";
        $htmlnameoutput = true;
      }

      echo "Included Extras</h4></td></tr>\n";

    } else if ($dt == 3) {
      echo "<tr><td colspan=2><h4>";
      if (!$htmlnameoutput) {
        echo "$htmlname&nbsp;";
        $htmlnameoutput = true;
      }
      echo "Optional Extras</h4></td></tr>\n";
    }

    $sql = mysql_query("SELECT d.dimension, pd.textvalue, pd.numvalue ".
                       "FROM proddimensions pd, dimensions d ".
                       "WHERE pd.dimension_id = d.id ".
                       "AND pd.product_id = $uproduct ".
                       "AND d.dim_type = $dt ".
                       "ORDER BY d.disp_order");
    while ($row = mysql_fetch_array($sql)) {
      if ($dt == 1) {
        echo "<tr><td class=fldlbl width=160>$row[0]</td><td>$row[1]</td></tr>";
      } else {
        if (empty($row[1])) {
        echo "<tr><td colspan=2>$row[0]</td></tr>";
        } else {
        echo "<tr><td colspan=2>$row[1]</td></tr>";
        }
      }
    }

    echo "<tr><td colspan=2><br></td></tr>";
  }

?>
  </table></td>
</tr>

<!-- Prices -->
<tr>
  <td colspan=3><table border=1 cellpadding=4 cellspacing=0>
    <tr>
      <th<? if ($ropivots) echo " rowspan=2";?>>Product</th>
      <th<? if ($ropivots) echo " rowspan=2";?>>Breadth</th>
      <th<? if ($ropivots) echo " rowspan=2";?>>Width</th>
<?
  $pivots = array();
  $roptions = array();
  $sql = mysql_query("SELECT DISTINCT pivot, CONCAT(pivot, 'mm') pivotmm ".
                     "FROM prodprices ".
                     "WHERE product_id = '$uproduct' ".
                     "AND pivot IS NOT NULL ".
                     "ORDER BY pivot");
  while ($row = mysql_fetch_array($sql)) {
    $pivots[$row[0]] = $row[0];

    echo "<th";
    if ($ropivots) echo " rowspan=2";
    echo ">";
    if ($row[1] == "0mm") {
      echo "Price";
    } else {
      echo $row[1];
    }
    echo "</th>\n";
  }

  $prev_ropt = "";
  $pivotrow = "";
  $sql = mysql_query("SELECT DISTINCT o.id,o.rangeoption,c.pivot ".
                     "FROM prodprices c, rangeoptions o ".
                     "WHERE c.rangeoption_id = o.id ".
                     "AND c.product_id = '$uproduct' ".
                     "ORDER BY o.disporder");
  while ($row = mysql_fetch_array($sql)) {
    $roptions[$row[0].":".$row[2]] = $row[0].":".$row[2];

    if ($row[0] != $prev_ropt) {
      echo "<th";
      if (empty($row[2]) && $ropivots) {
        echo " rowspan=2";
      } else if (!empty($row[2])) {
        echo " colspan=2";
      }
      echo ">$row[1]</th>";
    }

    if (!empty($row[2])) {
      $pivotrow .= "<th>$row[2]mm</th>";
    }

    $prev_ropt = $row[0];
  }
?>
    </tr>
<?
  if (!empty($pivotrow)) {
    echo "<tr>$pivotrow</tr>";
  }

  $prevvarid = -1;
  $rowhtm = "";
  $pricepriv = array();
  $priceprivro = array();
  $sql = mysql_query("SELECT v.id varid, IFNULL(v.variation, p.product) variation,".
                      "v.vbreadth,v.vlength,c.pivot,c.price,c.rangeoption_id ".
                      "FROM prodprices c, prodvariations v, products p ".
                      "WHERE c.prodvariation_id = v.id ".
                      "AND c.product_id = p.id ".
                      "AND c.product_id = '$uproduct' ".
                      "ORDER BY v.disporder,v.vbreadth,v.vlength");
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key2 => $val) {
      $$key2 = stripslashes($val);
    }
    if ($varid != $prevvarid) {
      if (!empty($rowhtm)) {
        output_price_row($rowhtm, $pivots, $pricepriv, $roptions, $priceprivro);
      }

      $rowhtm = "<tr><td>$variation</td>".
                  "<td align=right>". number_format($vbreadth, 2) ."</td>".
                  "<td align=right>". number_format($vlength, 2) ."</td>";
      $pricepriv = array();
      $priceprivro = array();
    }

    if (empty($rangeoption_id)) {
      $pricepriv[$pivot] = $price;
    } else {
      $priceprivro[$rangeoption_id.":".$pivot] = $price;
    }

    $prevvarid = $varid;
  }

  output_price_row($rowhtm, $pivots, $pricepriv, $roptions, $priceprivro);

?>
  </table></td>
</tr>
</table>

<?
    }
?>
    </td>
  </tr>
</table>
<?
include 'tpl/bot.php';
?>
