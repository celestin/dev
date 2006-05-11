<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Range page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  14-Apr-2006  Show all products in the range rather than a random image.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
if (!isset($urange)) {
  $urange = NULL;             if (!empty($_GET['range'])) $urange = $_GET['range'];
}

$sql = "SELECT c.category category_name, r.range range_name, p.product product_name, h.imgfile rand_img ".
       "FROM photos h, products p, prodranges r, categories c ".
       "WHERE p.id = h.product_id ".
       "AND r.id = p.prodrange_id ".
       "AND c.id = r.category_id ".
       "AND r.id = '$urange' ".
       "ORDER BY rand() ".
       "LIMIT 1";

$sql2 = mysql_query($sql);
if ($row2 = mysql_fetch_array($sql2)) {
  foreach($row2 AS $key2 => $val) {
    $$key2 = stripslashes($val);
  }
}

$title = "$range_name Range";
include 'tpl/top.php';

?>
<table border=0>
<tr>
  <td><h3><? echo $category_name; ?> :: <? echo $range_name; ?></h3></td>
</tr><tr>
  <td>
        <table border=0 cellpadding=0 cellspacing=0><tr>
  <?
        $ssql = "SELECT p.id product_id, p.product product_name, h.id photo_id,imgfile ".
                "FROM products p, photos h ".
                "WHERE h.product_id = p.id ".
                "AND p.prodrange_id='$urange' ".
                "AND h.default_flag=1 ".
                "ORDER BY p.disporder";

        $sql2 = mysql_query($ssql);
        $phcount=0;
        $phtcount=0;
        $phmax=5;
        $html = "";
        $main_pic = "_blank.jpg";
        while ($row2 = mysql_fetch_array($sql2)) {
          foreach($row2 AS $key2 => $val) {
            $$key2 = stripslashes($val);
          }

          $phcount++;
          $phtcount++;
          if ($phcount > $phmax) {
            $html .= "</tr><tr>";
            $phcount = 1;
          }

          $pname = $product_name;
          if (strlen($pname) > 10) {
            $pname = str_replace(" ", "<br>", $product_name);
          }

          $html .= "<td height=170 width=120 align=center valign=top><a class=\"itemnav\" href=\"product.php?product=$product_id&tab=1\"><img width=100 height=100 src=\"img/g/t/$imgfile\"></a><br>$pname</td>\n";
        }

        if (fmod($phmax, $phtcount+1) > 0) {
          $html .= "<td colspan=" . fmod($phmax, $phtcount+1) . ">&nbsp;</td>\n";
        }
        echo $html;
  ?>
        </tr></table>
  </td>
</tr>
</table>
<?

include 'tpl/bot.php';
?>