<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Oct-2007  10195 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Email Queue";
include_once 'Main.php';
include 'tpl/top.php';
$alternate=true;
$prev_time="";

?>

<table cellspacing=0 cellpadding=0 width="100%" border=0>
<tr><td valign=top><table border=1 cellspacing=0 cellpadding=2>
<tr>
  <th>Type</th>
  <th>Item</th>
  <th>Count</th>
</tr>
<?
  $ssql = "SELECT q.item_id,".
                 "MAX(q.item_type) item_type,".
                 "MAX(e.event_title) event_title,".
                 "COUNT(q.memberid) row_count ".
          "FROM queue q ".
          "LEFT OUTER JOIN event e ON e.id = q.item_id ".
          "GROUP BY item_id ";

  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $rowclass="bc";
    $alternate = (!$alternate);
    if ($alternate) {
      $rowclass="alt";
    }
    ?>
    <tr>
      <td  class=$rowclass><? echo $item_type; ?></td>
      <td  class=$rowclass><? echo $event_title; ?></td>
      <td  class=$rowclass><? echo $row_count; ?></td>
    </tr>
    <?
  }
?>
</table></td></tr>
</table></td></tr>


<?
include 'tpl/bot.php';
?>