<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * J.Mitchell & Son (jmitchellandson.co.uk)
 *
 * osCommerce, Open Source E-Commerce Solutions
 * http://www.oscommerce.com
 * Copyright (c) 2007 osCommerce
 * Released under the GNU General Public License
 *
 * Customised by Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-May-2010  10677 : Created to show ElementsSilver products.
 * CAM  22-Oct-2010  10791 : Added Google Analytics.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require('includes/application_top.php');
  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_DEFAULT);
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<base href="<?php echo (($request_type == 'SSL') ? HTTPS_SERVER : HTTP_SERVER) . DIR_WS_CATALOG; ?>">
<link rel="stylesheet" type="text/css" href="<?php echo CONFIG_STYLESHEET; ?>">
<link rel="shortcut icon" href="<?php echo CONFIG_FAVICON; ?>" type="image/vnd.microsoft.icon" />
<link rel="icon" href="<?php echo CONFIG_FAVICON; ?>" type="image/vnd.microsoft.icon" />
<?php include(FILENAME_ANALYTICS); ?>
</head>

<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" style="background:none;">
<!-- header //-->
<!-- header_eof //-->

<table border="0" cellspacing="5" cellpadding="0">
<?php
    $sql =
      "SELECT p.groupid, p.products_id,p.products_model,p.products_image,p.dataload_gender ".
      "FROM products p, products_to_categories pc ".
      "WHERE pc.products_id = p.products_id ".
      "AND pc.categories_id in (16,17,18,19) ".
      "ORDER BY p.groupid, p.products_model ";

    $previousgroupid=0;
    $categories_query = tep_db_query($sql);
    $number_of_categories = tep_db_num_rows($categories_query);
    while ($categories = tep_db_fetch_array($categories_query)) {
      if ($categories['groupid'] <> $previousgroupid) {
        ?></tr><tr><td colspan=4 style="border-top:1px solid black;"><img src="images/bg1.jpg" height=0></td></tr><tr><td>Group<br /><? echo $categories['groupid']?></td><?
      }
      ?><td style="text-align:center;"><b><? echo $categories['products_model']?></b><br /><? echo $categories['dataload_gender']?><br /><img height="220" src="images/<? echo $categories['products_image']?>"></td><?

      $previousgroupid = $categories['groupid'];
    }
?>
    </table>

</body>
</html>
<?php require(DIR_WS_INCLUDES . 'application_bottom.php'); ?>
