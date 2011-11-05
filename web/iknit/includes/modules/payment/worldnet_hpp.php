<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * iKnit (iknit.biz)
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
 * CAM  29-Oct-2011  11021 : Fix date bug.
 * CAM  05-Nov-2011  11057 : Added Customer email to notification.
 * * * * * * * * * * * * * * * * * * * * * * * */

class worldnet_hpp
{
  var $code, $title, $description, $enabled;
  var $oid;

  function worldnet_hpp()
  {
    global $order;

    $this->code        = 'worldnet_hpp';
    $this->title       = MODULE_PAYMENT_WORLDNETHPP_TEXT_TITLE;
    $this->description = MODULE_PAYMENT_WORLDNETHPP_TEXT_DESCRIPTION;
    $this->sort_order  = MODULE_PAYMENT_WORLDNETHPP_SORT_ORDER;
    $this->enabled     = ((MODULE_PAYMENT_WORLDNETHPP_STATUS == 'True') ? true : false);
    $this->pci         = true;

    if( (int)MODULE_PAYMENT_WORLDNETHPP_ORDER_STATUS_ID > 0 )
    {
      $this->order_status = MODULE_PAYMENT_WORLDNETHPP_ORDER_STATUS_ID;
    }

    if(is_object($order))
      $this->update_status();

    $this->form_action_url = (MODULE_PAYMENT_WORLDNETHPP_TEST_MODE == "Yes" ? "https://testpayments.worldnettps.com/merchant/paymentpage" : "https://payments.worldnettps.com/merchant/paymentpage");
  }

  // class methods
  function update_status()
  {
    global $order;

    if( ($this->enabled == true) && ((int)MODULE_PAYMENT_WORLDNETHPP_ZONE > 0) )
    {
      $check_flag = false;
      $check_query = tep_db_query("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_WORLDNETHPP_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");
      while ($check = tep_db_fetch_array($check_query))
      {
        if ($check['zone_id'] < 1)
        {
          $check_flag = true;
          break;
        }
        elseif ($check['zone_id'] == $order->billing['zone_id'])
        {
          $check_flag = true;
          break;
        }
      }

      if($check_flag == false)
      {
        $this->enabled = false;
      }
    }
  }

  function javascript_validation()
  {
    return false;
  }

  function selection()
  {
    return array( 'id'     => $this->code,
                  'module' => $this->title );
  }

  function pre_confirmation_check()
  {
    return false;
  }

  function confirmation()
  {
    return false;
  }

  function process_button()
  {
    global $osC_Session, $order, $currencies,$currency;

    if ($currency == MODULE_PAYMENT_WORLDNETHPP_CURRENCY_2)
    {
      $my_currency = MODULE_PAYMENT_WORLDNETHPP_CURRENCY_2;
      $terminalid  = MODULE_PAYMENT_WORLDNETHPP_ID_2;
    	$secret      = MODULE_PAYMENT_WORLDNETHPP_SECRET_2;
    }
    else
    {
      $my_currency = MODULE_PAYMENT_WORLDNETHPP_CURRENCY;
      $terminalid  = MODULE_PAYMENT_WORLDNETHPP_ID;
    	$secret      = MODULE_PAYMENT_WORLDNETHPP_SECRET;
    }

    mt_srand((double)microtime()*1000000);

    $datetime = strftime("%d-%m-%Y:%H:%M:%S").":".mt_rand(1, 999);
    $orderid = strftime("%H%M%S"). mt_rand(100000, 999999);
	  $email = $order->customer['email_address'];
    $curr = $my_currency;

    $amount = number_format($order->info['total'] * $currencies->get_value($my_currency), $currencies->get_decimal_places($my_currency), '.', '');
    $receiptPageURL = tep_href_link(FILENAME_CHECKOUT_PROCESS, '', 'SSL');
    $hash      = md5($terminalid . $orderid . $amount . $datetime . $receiptPageURL . $secret);

    $n=sizeof($order->products);
    $orderString = 'Product Count: ' . $n . '<br /><br />';
    for ($i=0; $i<$n; $i++) {
        $orderString .= 'Product ID: ' . tep_get_prid($order->products[$i]['id']) . '<br />Model: ' . $order->products[$i]['model'] . '<br />Name: ' . $order->products[$i]['name'] . '<br />Quantity: ' . $order->products[$i]['qty'] . '<br />Price: ' . $order->products[$i]['final_price'] . '<br /><br />';
    }


    $process_button_string = tep_draw_hidden_field('TERMINALID',          $terminalid) .
                             tep_draw_hidden_field('osCsid',              session_id()) .
                             tep_draw_hidden_field('ORDERID',             $orderid) .
                             tep_draw_hidden_field('AMOUNT',              $amount) .
                             tep_draw_hidden_field('CURRENCY',            $curr) .
                             tep_draw_hidden_field('DATETIME',            $datetime) .
                             tep_draw_hidden_field('HASH',                $hash).
                             tep_draw_hidden_field('RECEIPTPAGEURL',      $receiptPageURL).
                             (MODULE_PAYMENT_WORLDNETHPP_SEND_EMAIL == "Yes" ? tep_draw_hidden_field('EMAIL', $email) : "").
                             tep_draw_hidden_field('CUSTOMERNAME',        urldecode($order->billing['firstname']) . ' ' . urldecode($order->billing['lastname'])).
                             (strlen($order->billing['company']) > 0 ? tep_draw_hidden_field('CUSTOMERCOMPANY', urldecode($order->billing['company'])) : "").
                             tep_draw_hidden_field('CUSTOMERADDRESS',     $order->billing['street_address'] . ', ' . $order->billing['city'] . ', ' . $order->billing['state'] . ', ' . $order->billing['postcode'] . ', ' . $order->billing['country']['title']).
                             tep_draw_hidden_field('CUSTOMERPHONENUMBER', $order->customer['telephone']).
                             tep_draw_hidden_field('CUSTOMEREMAIL',       '<a href="mailto:' . $email . '">' . $email . '</a>').
                             tep_draw_hidden_field('ORDERDETAILS',        $orderString);

    return $process_button_string;
  }

  function before_process()
  {
    global $currency;

    $error = false;

    if ($currency == MODULE_PAYMENT_WORLDNETHPP_CURRENCY_2)
    {
        $terminalid = MODULE_PAYMENT_WORLDNETHPP_ID_2;
    }
    else
    {
        $terminalid = MODULE_PAYMENT_WORLDNETHPP_ID;
    }
    $secret       = MODULE_PAYMENT_WORLDNETHPP_SECRET;

    $orderid      = $_REQUEST['ORDERID']      ;
    $amount       = $_REQUEST['AMOUNT']       ;
    $datetime     = $_REQUEST['DATETIME']     ;

    $result       = $_REQUEST['RESULT']       ;

    $message      = $_REQUEST['MESSAGE']      ;

    $authcode     = $_REQUEST['AUTHCODE']     ;
    $pasref       = $_REQUEST['PASREF']       ;
    $md5hash_post = $_REQUEST['HASH']         ;
    $RESPONSECODE = $_REQUEST['RESPONSECODE'] ;
    $RESPONSETEXT = $_REQUEST['RESPONSETEXT'] ;

    $md5hash_new = md5($terminalid . $orderid . $amount . preg_replace('/(....-..-..T..)(..)(..)/', '\1:\2:\3', $datetime) . $RESPONSECODE . $RESPONSETEXT . $secret);

    //Check to see if hashes match or not
    if ($md5hash_new != $md5hash_post)
    {
      $payment_error_return = 'payment_error=' . $this->code . '&error=' . TEXT_WORLDNETHPP_HASH_ERROR . ': (' . $md5hash_new . ' vs ' . $md5hash_post . ')';
      tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT, $payment_error_return, 'SSL', true, false));
    }

    if($RESPONSECODE != "A")
    {
      $payment_error_return = 'payment_error=' . $this->code . '&error=' . TEXT_WORLDNETHPP_RESPONSE_ERROR . '. Bank Response: ' . $RESPONSETEXT;
      tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT, $payment_error_return, 'SSL', true, false));
    }

    return false;
  }

  function after_process()
  {
    return false;
  }

  function get_error()
  {
    if (PHP_VERSION < 4.1)
    {
      global $_GET;
    }

    $error = array('title' => WORLDNETHPP_ERROR_TITLE,
                   'error' => ((isset($_GET['error'])) ? stripslashes(urldecode($_GET['error'])) : IPAYMENT_ERROR_MESSAGE));

    return $error;
  }

  function output_error()
  {
    return false;
  }

  function check()
  {
    if(!isset($this->_check))
    {
      $check_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_WORLDNETHPP_STATUS'");
      $this->_check = tep_db_num_rows($check_query);
    }
    return $this->_check;
  }

  function install()
  {
    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added)
      VALUES
      (
        'Enable WorldNet TPS Module',
        'MODULE_PAYMENT_WORLDNETHPP_STATUS',
        'True',
        'Do you want to accept WorldNet TPS payments?',
        '6',
        '1',
        'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added)
      VALUES
      (
        'Test Mode?',
        'MODULE_PAYMENT_WORLDNETHPP_TEST_MODE',
        'Yes',
        'Are you in test or live mode?',
        '6',
        '2',
        'tep_cfg_select_option(array(\'Yes\',\'No\'), ', now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added)
      VALUES
      (
        'First Transaction Currency',
        'MODULE_PAYMENT_WORLDNETHPP_CURRENCY',
        'Selected Currency',
        'The first currency to use for credit card transactions',
        '6',

        '3',
        'tep_cfg_select_option(array(\'EUR\',\'GBP\',\'USD\'), ', now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added)
      VALUES
      (
        'First Terminal ID',
        'MODULE_PAYMENT_WORLDNETHPP_ID',
        'TerminalID 1',
        'The Terminal ID provided by WorldNet TPS for the first currency',
        '6',
        '4',
        now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added)
      VALUES
      (
        'First Shared Secret',
        'MODULE_PAYMENT_WORLDNETHPP_SECRET',
        'Secret',
        'The Shared Secret provided by WorldNet TPS for the first currency',
        '6',
        '7',
        now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added)
      VALUES
      (
        'Second Transaction Currency (if applicable)',
        'MODULE_PAYMENT_WORLDNETHPP_CURRENCY_2',
        'Selected Currency',
        'The second currency to use for credit card transactions',
        '6',
        '5',
        'tep_cfg_select_option(array(\'EUR\',\'GBP\',\'USD\'), ', now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added)
      VALUES
      (
        'Second Terminal ID',
        'MODULE_PAYMENT_WORLDNETHPP_ID_2',
        'TerminalID 2',
        'The Terminal ID provided by WorldNet TPS for the second currency',
        '6',
        '6',
        now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added)
      VALUES
      (
        'Second Shared Secret',
        'MODULE_PAYMENT_WORLDNETHPP_SECRET_2',
        'Secret',
        'The Shared Secret provided by WorldNet TPS for the second currency',
        '6',
        '7',
        now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added)
      VALUES
      (
        'Send receipt from WorldNet TPS host?',
        'MODULE_PAYMENT_WORLDNETHPP_SEND_EMAIL',
        'No',
        'The WorldNet TPS host can send it\'s own non-configurable e-mail that only contains transaction information.',
        '6',
        '8',
        'tep_cfg_select_option(array(\'Yes\',\'No\'), ', now())");

tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added)
      VALUES
      (
        'Sort order of display.',
        'MODULE_PAYMENT_WORLDNETHPP_SORT_ORDER',
        '0',
        'Sort order of display. Lowest is displayed first.',
        '6',
        '9',
        now())");

    tep_db_query(
      "INSERT INTO " .
      TABLE_CONFIGURATION .
      " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added)
      VALUES
      (
        'Set Order Status',
        'MODULE_PAYMENT_WORLDNETHPP_ORDER_STATUS_ID',
        '0',
        'Set the status of orders made with this payment module to this value',
        '6',
        '10',
        'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now())");
  }

  function remove()
  {
    tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key like 'MODULE_PAYMENT_WORLDNETHPP%';");
  }

  function keys()
  {
    return array(
      'MODULE_PAYMENT_WORLDNETHPP_STATUS'              ,
      'MODULE_PAYMENT_WORLDNETHPP_TEST_MODE'           ,
      'MODULE_PAYMENT_WORLDNETHPP_CURRENCY'            ,
      'MODULE_PAYMENT_WORLDNETHPP_ID'                  ,
      'MODULE_PAYMENT_WORLDNETHPP_SECRET'              ,
      'MODULE_PAYMENT_WORLDNETHPP_CURRENCY_2'          ,
      'MODULE_PAYMENT_WORLDNETHPP_ID_2'                ,
      'MODULE_PAYMENT_WORLDNETHPP_SECRET_2'            ,
      'MODULE_PAYMENT_WORLDNETHPP_SEND_EMAIL'          ,
      'MODULE_PAYMENT_WORLDNETHPP_ORDER_STATUS_ID'     ,
      'MODULE_PAYMENT_WORLDNETHPP_SORT_ORDER');
  }
}

?>
