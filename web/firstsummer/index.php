<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  08-Apr-2006  Added newsitems.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Home";
include 'tpl/top.php';
?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr><td width="35%" valign=top class="eyecatch"><p>1st Summerhouses is dedicated to selling quality log buildings.
Whether it's a Log Cabin to live in, a BBQ Hut or an extra room in the back garden we have lots of buildings to suit.
We also custom build Log Cabins to customer specifications.</p>
<p>Our products are sourced from only the best manufacturers, and from ordering to completion we will keep you informed every step of the way.</p>
</td>
<td width="65%" valign=top style="padding-left:5px"><table border=0 cellpadding=4 cellspacing=0>
<tr><td align=left><img style="padding-right:8px" src="img/title/news.gif" width="49" height="15" alt="News"></td></tr>

<?

$ssql = "SELECT newsitem, news_text, ".
        "DATE_FORMAT(news_date,'%d %b %Y') news_date_fmt, news_img ".
        "FROM newsitems ".
        "ORDER BY news_date DESC ".
        "LIMIT 2 ";
$sql = mysql_query($ssql) or die (mysql_error());
$counter=0;

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  $style = "";
  if ($counter++ > 0) {
    $style = "style=\"padding-top:20px\"";
  }
?>
<tr>
<?
  if (empty($news_img)) {
    $sql2 = mysql_query("SELECT id,imgfile FROM photos ORDER BY rand() LIMIT 1");
    if ($row2 = mysql_fetch_array($sql2)) {
      foreach($row2 AS $key2 => $val) {
        $$key2 = stripslashes($val);
      }
      $news_img = "g/t/$imgfile";
    }
  }
?>
<td <? echo $style; ?>><b><? echo $news_date_fmt; ?></b>&nbsp;-&nbsp;<b><? echo $newsitem; ?></b></td></tr>
<td><? echo $news_text; ?></td></tr>
<?
}
?>
</td></tr>
<tr><td <? echo $style; ?> align="center">More in the <a href="news.php">News Archive</a>.</td></tr>
</table></td></tr>
<tr>
  <td colspan=2 align=right><img style="padding-top:5px;padding-right:8px" src="img/title/featured.gif" width="172" height="15" alt="Featured Products"></td>
</tr><tr>
  <td colspan=2 align=center><table border=0 cellpadding=0 cellspacing=8 width="100%">
    <tr>
<?
  $ssql = "SELECT f.product_id,f.product,f.description,f.price,f.feature,h.imgfile ".
          "FROM featuredproducts f, photos h ".
          "WHERE f.product_id = h.product_id ".
          "AND h.default_flag = 1 ".
          "ORDER BY f.id DESC ".
          "LIMIT 4 ";
  $sql = mysql_query($ssql) or die (mysql_error());
  $counter=1;

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
    if ($counter++ == 3) {
?>
  </tr><tr>
<?
    }
?>
<td width="50%" class="feature" valign=top><table border=0 cellpadding=0 cellspacing=4 width="100%">
  <tr><td width="100" rowspan=3 class="price" valign=top><a href="product.php?product=<? echo $product_id; ?>"><img border=2 src="img/g/t/<? echo $imgfile; ?>"></a>
    <br><? echo Util::getHtmlPrice($price); ?></td>
    <td class="leftspace" valign=top><a href="product.php?product=<? echo $product_id; ?>"><? echo $product; ?></a></td>
  </tr>
  <tr><td class="leftspace"><? echo $description; ?></td></tr>
  <tr><td class="leftspace" valign=bottom><? echo $feature; ?></td></tr>
</table></td>
<?
  }
?>
    </tr>
  </table></td>
</tr>
<tr valign=bottom><td colspan=3 align=center>
<?
include 'tpl/cards.php';
?>
</td></tr></table>
<?
include 'tpl/bot.php';
?>