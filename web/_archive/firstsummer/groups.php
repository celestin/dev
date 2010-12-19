<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Groups - Grouping functions
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Oct-2006  10046 : File created.
 * CAM  10-Oct-2006  10059 : Added get_group.
 * CAM  25-Nov-2006  10012 : Added new Range Text.
 * * * * * * * * * * * * * * * * * * * * * * * */

function get_category($ucategory) {
  $sql = "SELECT c.category category_name, r.range range_name, p.product product_name, h.imgfile rand_img ".
         "FROM photos h, products p, prodranges r, categories c ".
         "WHERE p.id = h.product_id ".
         "AND r.id = p.prodrange_id ".
         "AND c.id = r.category_id ".
         "AND c.id = '$ucategory' ".
         "ORDER BY rand() ".
         "LIMIT 1";

  $sql2 = mysql_query($sql);
  if ($row2 = mysql_fetch_array($sql2)) {
    foreach($row2 AS $key2 => $val) {
      $$key2 = stripslashes($val);
    }
  }

  $title = "$category_name Category";
  include 'tpl/top.php';

  ?>
  <table border=0 cellpadding=0 cellspacing=0 width="100%">
  <tr>
    <td><h3><? echo $category_name; ?></h3></td>
  </tr><tr>
    <td align=center align=top>
      <table border=0 cellspacing=0 cellpadding=0 class=msg1tab><tr><td><div class=msg1>Please select a Range underneath <? echo $category_name; ?> to view specific products.</div></td></tr></table>
    </td>
  </tr><tr>
    <td align=center><img height=376 src="img/g/f/<? echo $rand_img; ?>"></td>
  </tr>
  </table>
  <?
}

function get_group($urange, $message, $ugroup='') {
?>
  <tr>
    <td align=center align=top>
      <table width="100%" border=0 cellspacing=0 cellpadding=0 class=msg2tab><tr><td class=msg2><? echo $message; ?></td>
      </tr><tr><td align=center><table border=0 cellpadding=0 cellspacing=0><tr>
<?
  $ssql = "SELECT p.id product_id, p.product product_name, h.id photo_id,imgfile ".
          "FROM products p, photos h ".
          "WHERE h.product_id = p.id ".
          "AND p.prodrange_id='$urange' ".
          "AND h.default_flag=1 ";

  if (!empty($ugroup)) {
    $ssql .= "AND p.prodgroup_id = '$ugroup' ";
  }
  $ssql .= "ORDER BY p.disporder";

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
    $url = "<a class=\"imgnav\" href=\"product.php?product=$product_id&tab=1\">";
    $html .= "<td class=\"thumb\" width=120 align=center valign=top>$url<img border=0 width=100 height=100 src=\"img/g/t/$imgfile\"><br>$pname</a></td>\n";
  }

  if (fmod($phmax, $phtcount+1) > 0) {
    $html .= "<td colspan=" . fmod($phmax, $phtcount+1) . ">&nbsp;</td>\n";
  }
  echo $html;
?>
          </tr></table>
    </td></tr></table>
  </tr>
<?
}

function get_range($urange) {
  $ssql = "SELECT c.category category_name, r.range range_name, r.long_text ".
          "FROM products p, prodranges r, categories c ".
          "WHERE r.id = p.prodrange_id ".
          "AND c.id = r.category_id ".
          "AND r.id = '$urange' ".
          "ORDER BY rand() ".
          "LIMIT 1";

  $sql = mysql_query($ssql);
  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  }

  $title = "$range_name Range";
  include 'tpl/top.php';

  ?>
  <!--<h3><? echo $category_name; ?> :: <? echo $range_name; ?></h3>-->
  <table border=0 cellpadding=5 cellspacing=0 width="100%">
<?
  if (!empty($long_text)) {
?>
  <tr>
    <td>
      <table width="100%" border=0 cellspacing=0 cellpadding=0 class="eyecatch">
        <tr>
          <td><? echo $long_text; ?></td>
        </tr>
      </table>
    </td>
  </tr>
<?
  }
?>
  <tr>
    <?
      $ssql = "SELECT id prodgroup_id, prodgroup ".
              "FROM prodgroups g ".
              "WHERE g.prodrange_id = '$urange' ".
              "ORDER BY g.disporder ";
      $sql = mysql_query($ssql);
      $groups = false;
      while ($row = mysql_fetch_array($sql)) {
        foreach($row AS $key => $val) {
          $$key = stripslashes($val);
        }
        get_group($urange, "$prodgroup $range_name", $prodgroup_id);
        //echo "<tr><td>&nbsp;</td></tr>";
        $groups = true;
      }

      if (!$groups) {
        get_group($urange, "Please click on an image to view specific $range_name information.");
      }
    ?>
  </table>
  <?

}