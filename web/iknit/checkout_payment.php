<?php
  // *** BEGIN GOOGLE CHECKOUT ***
  // Skips Google Checkout as a payment option on the payments page since that option
  // is provided in the checkout page.
  $selection = $payment_modules->selection();
  for ($i = 0, $n = sizeof($selection); $i < $n; $i++) {
    if ($selection[$i]['id'] == 'googlecheckout') {
      array_splice($selection, $i, 1);
      break;
    }
  }
  // *** END GOOGLE CHECKOUT ***

  if (sizeof($selection) > 1) {