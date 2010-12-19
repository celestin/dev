<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Price Edit form
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  04-Oct-2006  10038 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

?>

<form action="price.edit.php" method="post">
<table border=0 cellpadding=5 cellspacing=0>

<tr><td><input size=6 style="text-align:right;" name="price" value="<? echo $price; ?>"></td>
    <td><input class="button" type="submit" value="Save Price"></td></tr>

<tr><td>
  <input type="hidden" name="confirm" value="1">
  <input type="hidden" name="price_id" value="<? echo $price_id; ?>">
  <input type="hidden" name="product_id" value="<? echo $product_id; ?>">
</td></tr>

</table>
</form>
