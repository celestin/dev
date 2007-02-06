<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
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
 * CAM  21-Sep-2006  10028 : Changed Breadth and Width to Width and Depth.
 * CAM  21-Sep-2006  10029 : Changed HTML Page Title to include Product Name.
 * CAM  02-Oct-2006  10038 : Make Prices editable.
 * CAM  06-Oct-2006  10017 : Add (m) after Width and Depth.
 * CAM  14-Nov-2006  10012 : Added Call/Email me about this product.
 * CAM  06-Feb-2007  10082 : Added Variation Images.
 * CAM  06-Feb-2007  10082 : Fixed JS Error onclick.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$utab = NULL;          if (!empty($_GET['tab'])) $utab = $_GET['tab'];
$uproduct = NULL;      if (!empty($_GET['product'])) $uproduct = $_GET['product'];
$uphoto = NULL;        if (!empty($_GET['photo'])) $uphoto = $_GET['photo'];
$uvariation = NULL;    if (!empty($_GET['variation'])) $uvariation = $_GET['variation'];

function output_price_row($rowhtm, $pivots, $pricepriv, $priceprivid, $roptions, $priceprivro, $priceprivroid) {
  global $loggedin;

  foreach ($pivots as $pp) {
    $rowhtm .= "<td align=right>";

    if (empty($pricepriv[$pp])) {
      $rowhtm .= "-";
    } else {
      if ($loggedin) {
        $rowhtm .= "<a href=\"price.edit.php?price_id=" . $priceprivid[$pp] . "\">";
      }

      $rowhtm .= Util::getHtmlPrice($pricepriv[$pp]);

      if ($loggedin) {
        $rowhtm .= "</a>";
      }
    }

    $rowhtm .= "</td>";
  }

  foreach ($roptions as $ro) {
    $rowhtm .= "<td align=right>";

    if (empty($priceprivro[$ro])) {
      $rowhtm .= "-";
    } else {
      if ($loggedin) {
        $rowhtm .= "<a href=\"price.edit.php?price_id=" . $priceprivroid[$ro] . "\">";
      }

      $rowhtm .= Util::getHtmlPrice($priceprivro[$ro]);

      if ($loggedin) {
        $rowhtm .= "</a>";
      }
    }

    $rowhtm .= "</td>";
  }

  echo "$rowhtm</tr>\n";
}

if (empty($utab)) $utab = 1;
$productname = NULL;
$htmlname = NULL;
$rand_img = "";
$variation_img = "";
$variation_text = "";

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
if (!empty($productname)) $title .= " - $productname";
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
$sql = mysql_query("SELECT count(*) example_count FROM prodvariations WHERE product_id='$uproduct' AND imgfile IS NOT NULL");
$example_count=0;
if ($row = mysql_fetch_array($sql)) {
  $example_count = $row[0];
}
if ($example_count > 0) {
  $ssql = "SELECT imgfile, variation FROM prodvariations ".
          "WHERE product_id='$uproduct' ".
          "AND imgfile IS NOT NULL ";
  if (!empty($uvariation)) {
    $ssql .= "AND id='$uvariation' ";
  }
  $ssql .= "ORDER BY disporder LIMIT 1";
  $sql = mysql_query($ssql);
  if ($row = mysql_fetch_array($sql)) {
    $variation_img = $row[0];
    $variation_text = $row[1];
  }
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
    if ($tab_id == 2 && (empty($rand_img) || !empty($variation_img))) $show_tab = false;
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
<div id="cmTable" name="methelp" style="display:none;position:relative;">
  <form action="contactme.php" method="post">
  <table class="cmBox" border=0 cellspacing=0 cellpadding=4 width="100%">
    <tr onclick="contact_popupClose();">
      <td class="cmTitle" width="100%" id="cmTitle">Call me now about the <? echo $productname ?></td>
      <td class="cmTitle" width="10" align=right><img width="10" height="10" src="img/ico/small/close_off.gif" onClick="contact_popupClose();return false;" onMouseOver="this.src='img/ico/small/close_on.gif';" onMouseOut="this.src='img/ico/small/close_off.gif';"></td>
    </tr>
    <tr>
      <td colspan=2><table border=0 cellspacing=0 cellpadding=4>
        <tr>
          <td rowspan=5 width=60 valign=top><img width=48 height=48 id="cmIcon" src="img/ico/large/phone_me.png"></td>
          <td id="cmProduct">Product</td><td><input size=24 value="<? echo $productname ?>" readonly name="contactProd" id="contactProd"></td>
        </tr><tr>
          <td id="cmName" width=80>Name</td><td><input size=30 name="contactName" id="contactName"></td>
        </tr><tr>
          <td id="cmTxt1">Txt1</td><td><input size=40 name="contactTxt1" id="contactTxt1"></td>
        </tr><tr>
          <td id="cmComments" valign=top>Comments</td><td><textarea rows=6 cols=40 name="contactComments" id="contactComments"></textarea></td>
        </tr><tr>
          <td>&nbsp;</td><td><input type=submit value="Call me now!" id="cmButton"><input type="hidden" value="" name="contactType" id="contactType"></td>
        </tr>
      </table></td>
    </tr>
  </table>
  </form>
  <br>
</div>

<table border=0 width="100%">
<tr>
<?
      if (!empty($variation_img)) {
?>
      <td valign=top class=fldlbl width="250"><img height=250 width=250 src="img/v/m/<? echo $variation_img; ?>"><br><? echo $variation_text; ?></td>
<?
      } else if (!empty($rand_img)) {
?>
      <td valign=top width="250"><img height=200 src="img/g/m/<? echo $rand_img; ?>"></td>
<?
      } else {
?>
      <td valign=top width="250"><img height=200 src="img/g/m/_blank.jpg"></td>
<?
      }
?>
  <td valign=top align=right><table border=0 cellpadding=4 cellspacing=1 width="300">
    <tr><td colspan=2 class="download">MORE INFORMATION</td></tr>
<?
      if (!empty($brochure)) {
?>
    <tr>
      <td width=32><a target="_blank" href="upl/<? echo $brochure; ?>"><img border=0 width=32 height=32 src="img/ico/small/pdf.png"></a></td>
      <td><a target="_blank" href="upl/<? echo $brochure; ?>">Download Product Brochure</a></td>
    </tr>
<?
      }

?>
    <tr>
      <td align=center><a href="javascript:void();" onclick="contact_callme();return false;"><img border=0 width=32 height=32 src="img/ico/small/phone_me.png"></a></td>
      <td><a href="javascript:void();" onclick="contact_callme();return false;">Call me now about <?echo $productname; ?></a></td>
    </tr>
    <tr>
      <td align=center><a href="javascript:void();" onclick="contact_emailme();return false;"><img border=0 width=32 height=32 src="img/ico/small/email_me.png"></a></td>
      <td><a href="javascript:void();" onclick="contact_emailme();return false;">Email me now about <?echo $productname; ?></a></td>
    </tr>
<?
  if ($example_count>0) {
?>
    <tr><td colspan=2 class="download"><? echo strtoupper($productname); ?> EXAMPLES</td></tr>
<?

    $sql = mysql_query("SELECT id variation_id, imgfile, variation ".
                       "FROM prodvariations ".
                       "WHERE product_id = $uproduct ".
                       "AND imgfile IS NOT NULL");
    while ($row = mysql_fetch_array($sql)) {
?>
  <tr>
    <td><a href="product.php?product=<? echo $uproduct; ?>&variation=<? echo $row[0]; ?>"><img border=0 width=40 height=40 src="img/v/t/<? echo $row[1]; ?>"></a></td>
    <td><a href="product.php?product=<? echo $uproduct; ?>&variation=<? echo $row[0]; ?>"><? echo $row[2]; ?></a></td>
  </tr>
<?
    }
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
      <th<? if ($ropivots) echo " rowspan=2";?>>Width (m)</th>
      <th<? if ($ropivots) echo " rowspan=2";?>>Depth (m)</th>
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
  $priceprivid = array();
  $priceprivroid = array();
  $sql = mysql_query("SELECT v.id varid, IFNULL(v.variation, p.product) variation,".
                      "v.vbreadth,v.vlength,c.pivot,c.price,c.rangeoption_id, c.id price_id ".
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
        output_price_row($rowhtm, $pivots, $pricepriv, $priceprivid, $roptions, $priceprivro, $priceprivroid);
      }

      $rowhtm = "<tr><td>$variation</td>".
                  "<td align=right>". number_format($vbreadth, 2) ."</td>".
                  "<td align=right>". number_format($vlength, 2) ."</td>";
      $pricepriv = array();
      $priceprivro = array();
      $priceprivid = array();
      $priceprivroid = array();
    }

    if (empty($rangeoption_id)) {
      $pricepriv[$pivot] = $price;
      $priceprivid[$pivot] = $price_id;
    } else {
      $priceprivro[$rangeoption_id.":".$pivot] = $price;
      $priceprivroid[$rangeoption_id.":".$pivot] = $price_id;
    }

    $prevvarid = $varid;
  }

  output_price_row($rowhtm, $pivots, $pricepriv, $priceprivid, $roptions, $priceprivro, $priceprivroid);

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
