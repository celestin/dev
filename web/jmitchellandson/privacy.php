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
 * CAM  29-May-2010  10670 : Call table_header.
 * CAM  22-Oct-2010  10791 : Added Google Analytics.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_PRIVACY);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_PRIVACY));
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

<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
<!-- header //-->
<?php require(DIR_WS_INCLUDES . 'header.php'); ?>
<!-- header_eof //-->

<!-- body //-->
<?php require(DIR_WS_INCLUDES . 'table_header.php'); ?>
  <tr>
    <td width="<?php echo BOX_WIDTH; ?>" valign="top"><table border="0" width="<?php echo BOX_WIDTH; ?>" cellspacing="0" cellpadding="2">
<!-- left_navigation //-->
<?php require(DIR_WS_INCLUDES . 'column_left.php'); ?>
<!-- left_navigation_eof //-->
    </table></td>
<!-- body_text //-->
    <td width="100%" valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="0">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
<!--
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
            <td class="pageHeading" align="right"><?php echo tep_image(DIR_WS_IMAGES . 'table_background_specials.gif', HEADING_TITLE, HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
          </tr>
        </table></td>
-->
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
          <tr>
            <td class="main">

              <div id="legal">

                <p>J.Mitchell &amp; Son is committed to preserving the privacy of all
                visitors to our website at www.jmitchellandson.co.uk.  Please read the
                following privacy policy to understand how we use and protect the
                information that you provide to us.</p>

                <p>We are registered with the Information Comissioner's Office (ICO).  Our
                Registration Number is: Z8386063.   For more information, visit the <a
                href="http://www.ico.gov.uk/for_the_public.aspx" target="_blank">ICO
                website</a>.

                For the purposes of the Data protection Act 1998, the Data Controller is
                J.Mitchell &amp; Son of 20 High Street, Brechin, Angus, United Kingdom, DD9 6ER. </p>

                <p>By registering or placing an order on this website, you consent to
                the collection, use and transfer of your information under the terms of
                this policy.</p>

                <h2>INFORMATION THAT WE COLLECT FROM YOU</h2>
                <p>When you visit, register or order products or services on
                www.jmitchellandson.co.uk you may be asked to provide certain
                information about yourself including your name, contact details and
                credit or debit card information. </p>

                <p>We may also collect information about your usage of our website as
                well as information about you from messages you post to the website and
                e-mails or letters you send to us.</p>

                <p>To maintain customer service standards and to assist staff training,
                we may record and monitor incoming calls.</p>

                <h2>USE OF YOUR INFORMATION</h2>
                <p>Your information will enable us to provide you with access to all
                parts of our website and to supply the goods, services or information
                you have requested.  It will enable you to participate in interactive
                features of our service, when you choose to do so. It will also enable
                us to bill you and to contact you where necessary concerning your
                orders.  We will also use and analyse the information we collect so that
                 we can administer, support, improve and develop our business.</p>

                <p>In particular, we may use your information to contact you for your
                views on our services and to notify you occasionally about important
                changes or developments to the website or our services.  Further, where
                you have consented, we might also use your information to let you know
                by email about other products and services which we offer which may be
                of interest to you.  If you change your mind about being contacted in
                the future, please let us know.</p>


                <h2>DISCLOSURE OF YOUR INFORMATION</h2>
                <p>The information you provide to us may be accessed by or given to
                third parties some of whom may be located outside the European Economic
                Area who act for us for the purposes set out in this policy or for other
                 purposes approved by you.  Those parties process information, fulfil
                and deliver orders, process credit card payments and provide support
                services on our behalf.  We may also pass aggregate information on the
                usage of our website to third parties but this will not include
                information that can be used to identify you.</p>

                <p>Where you have consented when providing us with your details, we may
                also allow  other companies in our group, to contact you occasionally
                about products and services which may be of interest to you.  They may
                contact you by e-mail.  If you change your mind about being contacted by
                 these companies in the future, please let us know at
                sales@jmitchellandson.co.uk.</p>

                <p>You agree that we may disclose your identity and contact details to
                (1) any third party who claims to us that any material posted or
                uploaded by you to our site constitutes a violation of their
                intellectual property rights or their rights of privacy, and (2) to
                other companies and organisations for the purposes of fraud protection
                and credit risk reduction.</p>
                <p>Finally, if our business enters into a joint venture with or is sold
                to or merged with another business entity, your information may be
                disclosed to our new business partners or owners.</p>
                <p>Countries outside the European Economic Area do not always have
                strong data protection laws.  However, we will always take steps to
                ensure, so far as reasonably possible, that your information is used by
                third parties in accordance with this policy.
                Unfortunately, the transmission of information via the internet is not
                completely secure. Although we will do our best to protect your personal
                 data, we cannot guarantee the security of your data transmitted to our
                site; any transmission is at your own risk.</p>
                <p>Unless required to do so by law, we will not otherwise share, sell or
                 distribute any of the information you provide to us without your
                consent.</p>


                <h2>COOKIES</h2>
                <p>Cookies are small amounts of information which we may store on your
                computer.</p>

                <p>We do not use cookies on our website.</p>



                <h2>SECURITY AND DATA RETENTION</h2>
                <p>We employ security measures to protect, so far as reasonably
                possible, your information from access by unauthorised persons and
                against unlawful processing, accidental loss, destruction and damage.
                We will retain your information for a reasonable period or as long as
                the law requires or permits.</p><p>


                </p><h2>ACCESSING AND UPDATING</h2>

                <p>You are entitled to see the personal information held about you and
                you may ask us to make any necessary changes to ensure that it is
                accurate and kept up to date.  If you wish to do this, please contact us
                 at sales@jmitchellandson.co.uk.  We are entitled by law to charge a
                fee of £10 to meet our costs in providing you with details of the
                information we hold about you.</p>

                <h2>CHANGES TO OUR PRIVACY POLICY</h2>
                <p>Any changes to our privacy policy in the future will be posted to the
                 website and, where appropriate, through e-mail notification.<br>
                This Privacy Policy was created on 12/04/2010.

                <h2>CONTACT</h2>
                <p>All comments, queries and requests relating to our use of your
                information are welcomed and should be addressed to
                <a href="mailto:sales@jmitchellandson.co.uk?Subject=Website%20Enquiry">sales@jmitchellandson.co.uk</a>.</p>

              </div>

            </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="1" cellpadding="2" class="infoBox">
          <tr class="infoBoxContents">
            <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
              <tr>
                <td width="10"><?php echo tep_draw_separator('pixel_trans.gif', '10', '1'); ?></td>
                <td align="right"><?php echo '<a href="' . tep_href_link(FILENAME_DEFAULT) . '">' . tep_image_button('button_continue.gif', IMAGE_BUTTON_CONTINUE) . '</a>'; ?></td>
                <td width="10"><?php echo tep_draw_separator('pixel_trans.gif', '10', '1'); ?></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
<!-- body_text_eof //-->
    <td width="<?php echo BOX_WIDTH; ?>" valign="top"><table border="0" width="<?php echo BOX_WIDTH; ?>" cellspacing="0" cellpadding="2">
<!-- right_navigation //-->
<?php require(DIR_WS_INCLUDES . 'column_right.php'); ?>
<!-- right_navigation_eof //-->
    </table></td>
  </tr>
</table>
<!-- body_eof //-->

<!-- footer //-->
<?php require(DIR_WS_INCLUDES . 'footer.php'); ?>
<!-- footer_eof //-->
<br>
</body>
</html>
<?php require(DIR_WS_INCLUDES . 'application_bottom.php'); ?>
