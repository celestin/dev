<?php
        </table>
        </form>
<?php
          // *** BEGIN GOOGLE CHECKOUT ***
          if (defined('MODULE_PAYMENT_GOOGLECHECKOUT_STATUS') && MODULE_PAYMENT_GOOGLECHECKOUT_STATUS == 'True') {
            include_once('googlecheckout/gcheckout.php');
          }
          // *** END GOOGLE CHECKOUT ***
?>         
        <form></td>
      </tr>
<?php
    $initialize_checkout_methods = $payment_modules->checkout_initialization_method();
      </tr>
<?php