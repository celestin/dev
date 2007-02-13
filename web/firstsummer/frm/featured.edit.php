<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Featured Product Form
 *
 * $Id: news.edit.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  13-Feb-2007  10079 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<form action="<? echo $form_action; ?>" method="post" name="" id="">
  <table border="0" align="left" cellpadding="0" cellspacing="8">
    <tr>
      <td class="<? echo (!empty($retry) && empty($product_id)) ? "fldmand" : "fld" ?>">Product ID</td>
      <td><select name="product_id" type="text" id="product_id"><?

  $ssql = "SELECT c.category, r.range, p.product, p.id product_id ".
          "FROM categories c, prodranges r, products p ".
          "WHERE r.category_id = c.id ".
          "AND p.prodrange_id = r.id ".
          "ORDER BY c.disporder, r.disporder, p.disporder";
  $sql = mysql_query($ssql) or die (mysql_error());
  while ($row = mysql_fetch_array($sql)) {
    $html = "<option value=\"$row[3]\"";
    if ($row[3] == $product_id) $html .= " SELECTED";
    $html .= ">$row[0] - $row[1] - $row[2]</option>";

    echo "$html\n";
  }

    ?></select></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($product)) ? "fldmand" : "fld" ?>">Product Name</td>
      <td><input name="product" type="text" id="product" size=30
      <? echo 'value="'. $product . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($description)) ? "fldmand" : "fld" ?>">Description</td>
      <td><textarea name="description" type="text" id="description" rows=4 cols=30><? echo $description;?></textarea>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($feature)) ? "fldmand" : "fld" ?>">What&#039;s on offer?</td>
      <td><textarea name="feature" type="text" id="feature" rows=4 cols=30><? echo $feature;?></textarea>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($price)) ? "fldmand" : "fld" ?>">Feature Price</td>
      <td><input name="price" type="text" id="price" size=8 <? echo 'value="'. $price . '">';?></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
        <input name="retry" type="hidden" id="retry" value="1">
        <input name="feature_id" type="hidden" id="feature_id" value="<? echo $feature_id; ?>">
        <input class="button" type="submit" value="<? echo $form_button; ?>">
      </td>
    </tr>
  </table>
</form>
