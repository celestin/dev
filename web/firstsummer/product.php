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
 * CAM  14-Apr-2006  Added Plans functionality.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$utab = NULL;          if (!empty($_GET['tab'])) $utab = $_GET['tab'];
$uproduct = NULL;      if (!empty($_GET['product'])) $uproduct = $_GET['product'];
$uphoto = NULL;        if (!empty($_GET['photo'])) $uphoto = $_GET['photo'];

if (empty($utab)) $utab = 1;
$productname = NULL;

$sql = mysql_query("SELECT p.id product_id, p.product, p.brochure, p.prodrange_id urange, r.category_id ucategory ".
                   "FROM products p, prodranges r  ".
                   "WHERE p.prodrange_id = r.id ".
                   "AND p.id = '$uproduct'");

if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  $productname = $product;
}

$title = "Product";
include 'tpl/top.php';

$sql = mysql_query("SELECT id,imgfile FROM photos WHERE product_id='$uproduct' ORDER BY rand() LIMIT 1 ");
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
        $html .= "<td class=\"ti\"><a class=\"itemnav$cls\" href=\"product.php?product=$uproduct&tab=$utab&photo=$id\"><img width=100 height=100 src=\"img/g/t/$imgfile\"></a><!--<br>delete from photos where imgfile='$imgfile'--></td>\n";
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
?>
  </table></td>
</tr>
<tr>
  <td colspan=3><table border=1 cellpadding=4 cellspacing=0>
    <tr>
      <th>Product</th>
      <th>Breadth</th>
      <th>Width</th>
      <th>Wood</th>
    </tr>
<?
  $sql = mysql_query("SELECT IFNULL(v.variation, p.product) variation,".
                      "v.vbreadth,v.vlength,c.pivot,c.price ".
                      "FROM prodprices c, prodvariations v, products p ".
                      "WHERE c.prodvariation_id = v.id ".
                      "AND c.product_id = p.id ".
                      "AND c.product_id = $uproduct ".
                      "ORDER BY v.disporder");
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key2 => $val) {
      $$key2 = stripslashes($val);
    }
?>
  <tr>
    <td><? echo $variation; ?></td>
    <td align=right><? echo number_format($vbreadth, 2); ?></td>
    <td align=right><? echo number_format($vlength, 2); ?></td>
    <td align=right>&pound;<? echo number_format($price, 2, '.', ','); ?></td>
  </tr>
<?
  }

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
