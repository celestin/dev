<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Lovie's Yarns (loviesyarn.com)
 *
 * UPDATED 04-12-2009
 * Deprecated $HTTP_POST_VARS replaced with $_POST to enable callback on all platforms/php versions.
 * Javascript dependancy for page redirection replaced with form action otherwise Worldpay removes javascript and leaves
 * visitors stranded.
 *
 * Updated By Pete Batin (petebuzzin in Oscommerce forums)
 * Original Contribution by Harald Ponce de Leon
 *
 * No gaurantees are expressed in anyway, always backup and test before production usage
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
 * CAM  24-Jun-2010  10717 : Updated for RBSWorldpay.
 * CAM  20-Jul-2010  10759 : Redirect unsuccessful payments to FILENAME_CHECKOUT_PAYMENT rather than FILENAME_CHECKOUT_PROCESS.
 * * * * * * * * * * * * * * * * * * * * * * * */

  if (isset($_POST['M_sid']) && !empty($_POST['M_sid'])) {

    chdir('../../../../');
    require ('includes/application_top.php');

    if ($_POST['transStatus'] == 'Y') {
      $pass = false;

      if (isset($_POST['M_hash']) && !empty($_POST['M_hash']) && ($_POST['M_hash'] == md5($_POST['M_sid'] . $_POST['M_cid'] . $_POST['cartId'] . $_POST['M_lang'] . number_format($_POST['amount'], 2) . MODULE_PAYMENT_WORLDPAY_JUNIOR_MD5_PASSWORD))) {
        $pass = true;
      }

      if (isset($_POST['callbackPW']) && ($_POST['callbackPW'] != MODULE_PAYMENT_WORLDPAY_JUNIOR_CALLBACK_PASSWORD)) {
        $pass = false;
      }

      if (tep_not_null(MODULE_PAYMENT_WORLDPAY_JUNIOR_CALLBACK_PASSWORD) && !isset($_POST['callbackPW'])) {
        $pass = false;
      }

      if ($pass == true) {
        include('includes/languages/' . basename($_POST['M_lang']) . '/modules/payment/worldpay_junior.php');

        $order_query = tep_db_query("select orders_status, currency, currency_value from " . TABLE_ORDERS . " where orders_id = '" . (int)$_POST['cartId'] . "' and customers_id = '" . (int)$_POST['M_cid'] . "'");
        if (tep_db_num_rows($order_query) > 0) {
          $order = tep_db_fetch_array($order_query);

          if ($order['orders_status'] == MODULE_PAYMENT_WORLDPAY_JUNIOR_PREPARE_ORDER_STATUS_ID) {
            $order_status_id = (MODULE_PAYMENT_WORLDPAY_JUNIOR_ORDER_STATUS_ID > 0 ? (int)MODULE_PAYMENT_WORLDPAY_JUNIOR_ORDER_STATUS_ID : (int)DEFAULT_ORDERS_STATUS_ID);

            tep_db_query("update " . TABLE_ORDERS . " set orders_status = '" . $order_status_id . "', last_modified = now() where orders_id = '" . (int)$_POST['cartId'] . "'");

            $sql_data_array = array('orders_id' => $_POST['cartId'],
                                    'orders_status_id' => $order_status_id,
                                    'date_added' => 'now()',
                                    'customer_notified' => '0',
                                    'comments' => 'WorldPay: Transaction Verified');

            tep_db_perform(TABLE_ORDERS_STATUS_HISTORY, $sql_data_array);

            if (MODULE_PAYMENT_WORLDPAY_JUNIOR_TESTMODE == 'True') {
              $sql_data_array = array('orders_id' => $_POST['cartId'],
                                      'orders_status_id' => $order_status_id,
                                      'date_added' => 'now()',
                                      'customer_notified' => '0',
                                      'comments' => MODULE_PAYMENT_WORLDPAY_JUNIOR_TEXT_WARNING_DEMO_MODE);

              tep_db_perform(TABLE_ORDERS_STATUS_HISTORY, $sql_data_array);
            }
?>
<style>
.pageHeading {
  font-family: Verdana, Arial, sans-serif;
  font-size: 20px;
  font-weight: bold;
  color: #9a9a9a;
}

.main {
  font-family: Verdana, Arial, sans-serif;
  font-size: 11px;
  line-height: 1.5;
}
</style>

<p class="pageHeading"><?php echo STORE_NAME; ?></p>

<p class="main" align="center"><?php echo MODULE_PAYMENT_WORLDPAY_JUNIOR_TEXT_SUCCESSFUL_TRANSACTION; ?></p>

<meta http-equiv="refresh" content="0; url=<?php echo tep_href_link(FILENAME_CHECKOUT_PROCESS, tep_session_name() . '=' . $_POST['M_sid'] . '&hash=' . $_POST['hash'], 'SSL', false); ?>">

<form action="<?php echo tep_href_link(FILENAME_CHECKOUT_PROCESS, tep_session_name() . '=' . $_POST['M_sid'] . '&hash=' . $_POST['M_hash'], 'SSL', false); ?>" method="post">
  <div align="center">
    <input name="submit" type="submit" value="<?php echo sprintf(MODULE_PAYMENT_WORLDPAY_JUNIOR_TEXT_CONTINUE_BUTTON, addslashes(STORE_NAME)); ?>" />
    </div>
</form>

<p>&nbsp;</p>

<WPDISPLAY ITEM=banner>
<?php
          }
        }
      }
    }else{
    include('includes/languages/' . basename($_POST['M_lang']) . '/modules/payment/worldpay_junior.php');
    ?>
        <style>
.pageHeading {
  font-family: Verdana, Arial, sans-serif;
  font-size: 20px;
  font-weight: bold;
  color: #9a9a9a;
}

.main {
  font-family: Verdana, Arial, sans-serif;
  font-size: 11px;
  line-height: 1.5;
}
</style>

<p align="center" class="pageHeading"><?php echo STORE_NAME; ?></p>

<p class="main" align="center"><?php echo MODULE_PAYMENT_WORLDPAY_JUNIOR_TEXT_UNSUCCESSFUL_TRANSACTION;?></p>

<meta http-equiv="refresh" content="0; url=<?php echo tep_href_link(FILENAME_CHECKOUT_PAYMENT, tep_session_name() . '=' . $_POST['M_sid'] . '&hash=' . $_POST['hash'], 'SSL', false); ?>">

<form action="<?php echo tep_href_link(FILENAME_CHECKOUT_PAYMENT, tep_session_name() . '=' . $_POST['M_sid'] . '&hash=' . $_POST['M_hash'], 'SSL', false); ?>" method="post">
  <div align="center">
    <input name="submit" type="submit" value="<?php echo sprintf(MODULE_PAYMENT_WORLDPAY_JUNIOR_TEXT_CONTINUE_BUTTON, addslashes(STORE_NAME)); ?>" />
    </div>
</form>
<p align="center">&nbsp;</p>

<div align="center">
  <WPDISPLAY ITEM=banner>
  </div>
    <?php
  }
  }
?>