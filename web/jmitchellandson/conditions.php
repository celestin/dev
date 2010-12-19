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

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_CONDITIONS);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_CONDITIONS));
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
        <td class="main">

          <div id="legal">
            <p>Welcome to the <strong>J.Mitchell &amp; Son</strong> website terms
            and conditions for use. These Terms and Conditions apply to the use of
            this website at <strong>www.jmitchellandson.co.uk</strong>. By accessing
             the website <strong>www.jmitchellandson.co.uk</strong> and/or placing
            an order, you agree to be bound by these terms and conditions.</p><p>

            </p><p>Using this website indicates that you accept these terms
            regardless of whether or not you choose to register with us or order
            from us.  If you do not accept these terms, do not use this website.</p>
            <p>The <strong>www.jmitchellandson.co.uk</strong> website is operated by John Laing trading as J. Mitchell & Son.

            <p>Our VAT registration number is 265 8023 54.</p>
            <p>Our contact details are as follows:<br>
            Trading address:  20 High Street,<br>
                  Brechin,<br>

                  Angus,<br>
                  United Kingdom,<br>
                  DD9 6ER.<br>
            General email:    <a href="mailto:sales@jmitchellandson.co.uk?Subject=Website%20Enquiry">sales@jmitchellandson.co.uk</a><br>
            Telephone number: 01356 624015<br>
            Fax number    01356 624015</p>

            <h2>1. INTRODUCTION</h2>
            <p>1.1  You will be able to access most areas of this Website without
            registering your details with us. Certain areas of this Website are only
             open to you if you register.</p>

            <p>1.2 We may revise these terms and conditions at any time by updating
            this posting. You should check this Website from time to time to review
            the then current terms and conditions, because they are binding on you.
            Certain provisions of these terms and conditions may be superseded by
            expressly designated legal notices or terms located on particular pages
            of this Website. If you do not wish to accept any new terms and
            conditions after we have given notice, you should not continue to use
            this Website.</p>

            <p>1.3 If you have any concerns about material on our site, please contact
            us by email at <a href="mailto:sales@jmitchellandson.co.uk?Subject=Website%20Enquiry">sales@jmitchellandson.co.uk</a>.</p>

            <h2>2. ORDERING FROM US</h2>
            <p>2.1  You are deemed to place an order with us by ordering via our
            online checkout process. As part of our checkout process you will be
            given the opportunity to check your order and to correct any errors. We
            will send you an order acknowledgement, detailing the products you have
            ordered.</p>

            <p>2.2 Our acceptance of an order takes place when we despatch the order.
            We will send you a despatch confirmation by email. When we despatch the
            order the purchase contract will be made ,  unless we have notified you
            that we do not accept your order or you have cancelled your order.</p>

            <p>2.3 We may refuse to accept an order:
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(a) where goods, services or information
            ordered by you are not available;

            <br>&nbsp;&nbsp;&nbsp;&nbsp;(b) where we cannot obtain authorisation for
             your payment;
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(c) if there has been a pricing or product
            description error; or
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(d) if you do not meet any eligibility
            criteria set out in our terms and conditions.
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(e) if we do not deliver to your area;
            <br><br>
            Where we do not accept your order but have processed your payment, we
            will re-credit your account with any amount deducted by us from your
            debit or credit card as soon as possible, but in any event within 30
            days of your order. We will not be obliged to pay any additional amount
            as compensation for disappointment.</p>

            <h2>3. PRICING</h2>
            <p>3.1  All prices include VAT (where applicable) at the current rates.
            We reserve the right to express the price exclusive of VAT, but we shall
            show VAT separately and include it in the total price.</p>
            <p>3.2 Where we charge separately for packing, carriage and insurance
            and other relevant charges, the appropriate rates are set out in our
            specified pricing structure shown elsewhere on this Website.</p>

            <h2>4. DELIVERY</h2>
            <p>4.1  We will deliver goods ordered by you as soon as possible to the
            address you give us for delivery, but in any event within 5 days of your
             order.</p>

            <p>4.2 If the goods we deliver are not what you ordered or are damaged
            or defective or the delivery is of an incorrect quantity, we shall have
            no liability to you unless you notify us in writing, at our contact
            address, of the problem within 10 working days of the delivery of the
            goods in question.</p>
            <p>4.3 If you do not receive goods ordered by you within 5 days of the
            date on which you ordered them, we shall have no liability to you unless
             you notify us in writing at our contact address of the problem within
            10 days of our maximum delivery period of 5 from the date on which you
            ordered the goods.</p>

            <h2>5. LIABILITY</h2>
            <p>5.1 If the goods we deliver are not what you ordered or are damaged
            or defective or the delivery is of an incorrect quantity, we shall have
            no liability to you unless you notify us in writing at our contact
            address of the problem within 10 working days of the delivery of the
            goods in question.</p>
            <p>5.2 If you do not receive goods ordered by you within 5 days of the
            date on which you ordered them, we shall have no liability to you unless
             you notify us in writing at our contact address of the problem within
            10 days of our maximum delivery period of 5 from the date on which you
            ordered the goods.</p>
            <p>5.3 If you notify a problem to us under this condition, our only
            obligation will be, at your option:
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(a) to make good any shortage or
            non-delivery;
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(b) to replace or repair any goods that are
            damaged or defective; or
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(c) to refund to you the amount paid by you
            for the goods in question in whatever way we choose.</p>
            <p>5.4 Save as precluded by law, we will not be liable to you for any
            indirect or consequential loss, damage or expenses (including loss of
            profits, business or goodwill) howsoever arising out of any problem you
            notify to us under this condition and we shall have no liability to pay
            any money to you by way of compensation other than to refund to you the
            amount paid by you for the goods in question under clause 5.3(c) above.</p>
            <p>5.5 You must observe and comply with all applicable regulations and
            legislation, including obtaining all necessary customs, import or other
            permits to purchase goods from our site. The importation or exportation
            of certain of our goods to you may be prohibited by certain national
            laws. We make no representation and accept no liability in respect of
            the export or import of the goods you purchase.</p>
            <p>5.6 Notwithstanding the foregoing, nothing in these terms and
            conditions is intended to limit any rights you might have as a consumer
            under applicable local law or other statutory rights that may not be
            excluded nor in any way to exclude or limit our liability to you for any
             death or personal injury resulting from our negligence.</p>

            <h2>6. CANCELLATION OF CONTRACTS FOR GOODS AND RETURNS POLICY &#8211; FOR
            CONSUMERS ONLY </h2>
            <p>6.1 This section applies to consumers only (and not to businesses or
            other organisations) who order goods</p>
            <p>6.2 If you wish to cancel your order:
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(a) you can notify us by email to
            sales@jmitchell&amp;son.co.uk before we have dispatched the goods to
            you; or
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(b) where goods have already been dispatched
             to you, by returning goods to us in accordance with clause 4.2 above.</p>
            <p>6.3 You can return goods you have ordered from us for any reason at
            any time within 7 days of receipt for a full refund or exchange. The
            costs of returning goods to us shall be borne by you.
            <br>6.4 Upon receipt of the goods we will give you a full refund of the
            amount paid or an exchange credit as required, less (if for any reason
            the these costs have not been paid by you) the costs of delivery to us.
            <br>6.5 The rights to return the goods to us as referred to in clause
            6.3 will not apply in the following circumstances: -
              <br>     * in the event that the product has been used
              <br>     * to any products that we have made or customised specifically for you

            <br>The provisions of this clause 6.5 do not affect your statutory
            rights. </p>

            <h2>7. LICENCE</h2>
            <p>7.1  You are permitted to print and download extracts from this
            Website for your own use on the following basis:
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(a) no documents or related graphics on this
             Website are modified in any way;
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(b) no graphics on this Website are used
            separately from accompanying text; and
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(c)any of our copyright and trade mark
            notices and this permission notice appear in all copies.</p>

            <p>7.2 Unless otherwise stated, the copyright and other intellectual
            property rights in all material on this Website (including without
            limitation photographs and graphical images) are owned by us or our
            licensors. For the purposes of these terms and conditions, any use of
            extracts from this Website other than in accordance with clause 5.1
            above for any purpose is prohibited. If you breach any of the terms in
            these terms and conditions, your permission to use this Website
            automatically terminates and you must immediately destroy any downloaded
             or printed extracts from this Website.</p>

            <p>7.3 Subject to clause 7.1, no part of this Website may be reproduced
             or stored in any other website or included in any public or private
            electronic retrieval system or service without our prior written
            permission.</p>

            <p>7.4 Any rights not expressly granted in these terms are reserved.</p>

            <h2>8. SERVICE ACCESS</h2>
            <p>8.1  While we endeavour to ensure that this Website is normally
            available 24 hours a day, we will not be liable if for any reason this
            Website is unavailable at any time or for any period.
            <br>8.2 Access to this Website may be suspended temporarily and without
            notice in the case of system failure, maintenance or repair or for
            reasons beyond our control.  </p>

            <h2>9. VISITOR MATERIAL AND CONDUCT</h2>
            <p>9.1  Other than personally identifiable information, which is covered
            under the <a href="privacy.php">Privacy Policy</a>, any material you transmit
            or post to this Website will be considered non-confidential and
            non-proprietary. We will have no obligations with respect to such
            material. We and our nominees will be free to copy, disclose,
            distribute, incorporate and otherwise use such material and all data,
            images, sounds, text and other things embodied therein for any and all
            commercial or non-commercial purposes.</p>

            <p>9.2 You are prohibited from posting or transmitting to or from this
            Website any material:
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(a) that is threatening, defamatory,
            obscene, indecent, seditious, offensive, pornographic, abusive, liable
            to incite racial hatred, discriminatory, menacing, scandalous,
            inflammatory, blasphemous, in breach of confidence, in breach of privacy
             or which may cause annoyance or inconvenience;
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(b) for which you have not obtained all
            necessary licences and/or approvals;
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(c) which constitutes or encourages conduct
            that would be considered a criminal offence, give rise to civil
            liability, or otherwise be contrary to the law of or infringe the rights
             of any third party, in the UK or any other country in the world; or
            <br>&nbsp;&nbsp;&nbsp;&nbsp;(d) which is technically harmful (including,
             without limitation, computer viruses, logic bombs, Trojan horses,
            worms, harmful components, corrupted data or other malicious software or
             harmful data).</p>

            <p>9.3 You may not misuse the Website (including, without limitation,
            by hacking, impersonating any person or entity or falsely misrepresent
            your affiliation with a person or entity, &#8216;stalk&#8217; or harass another or
            collect or store personal data about other users ).</p>

            <p>9.4 We will fully co-operate with any law enforcement authorities or
             court order requesting or directing us to disclose the identity or
            locate anyone posting any material in breach of clauses 9.2 or 9.3.</p>

            <p>9.5 It is your responsibility to determine that your input into our
            site, including use of any chat room areas of our site, including your
            choice of your user name, conforms to the above conditions. Remember
            that the site and your content may be accessed by children.</p>

            <p>9.6 If you notice any content which breaches these conditions,
            please notify us by email to sales@jmitchellandson.co.uk.</p>

            <h2>10. LINKS TO AND FROM OTHER WEBSITES</h2>
            <p>10.1 Links to third party websites on this Website are provided
            solely for your convenience. If you use these links, you leave this
            Website. We have not reviewed all of these third party websites and do
            not control and are not responsible for these websites or their content
            or availability. We therefore do not endorse or make any representations
             about them, or any material found there, or any results that may be
            obtained from using them. If you decide to access any of the third party
             websites linked to this Website, you do so entirely at your own risk.</p>

            <p>10.2  You may not create any links to this Website.

            <p>10.3  You shall fully indemnify us for any loss or damage we or any
            of our group companies may suffer or incur as a result of your breach of
             clause 10.2.</p>

            <h2>11. REGISTRATION</h2>
            <p>11.1 To register with www.jmitchellandson.co.uk you must be over 18
            years of age.</p>

            <p>11.2 Each registration is for a single user only, whether or not
            acting on behalf of a company or other organisation. We do not permit
            you to share your user name and password with any other person nor with
            multiple users on a network.</p>

            <p>11.3 Responsibility for the security of any passwords issued rests
            with you and if you know or suspect that someone else knows your
            password, you should contact us immediately.</p>

            <p>11.4 We may suspend or cancel your registration immediately at our
            reasonable discretion or if you breach any of your obligations under
            these terms and conditions.</p>

            <h2>12. DISCLAIMER</h2>

            <p>12.1 While we endeavour to ensure that the information on this
            Website is correct, we do not warrant the accuracy and completeness of
            the material on this Website. We may make changes to the material on
            this Website, or to the products and prices described in it, at any time
             without notice. The material on this Website may be out of date, and we
             make no commitment to update such material.</p>

            <p>12.2 The material on this Website is provided &#8220;as is&#8221; without any
            conditions, warranties or other terms of any kind. Accordingly, to the
            maximum extent permitted by law, we provide you with this Website on the
             basis that we exclude all representations, warranties, conditions and
            other terms (including, without limitation, the conditions implied by
            law of satisfactory quality, fitness for purpose and the use of
            reasonable care and skill) which but for these terms and conditions
            might have effect in relation to this Website.  </p>

            <h2>13. LIABILITY</h2>
            <p>13.1 We, any other party (whether or not involved in creating,
            producing, maintaining or delivering this Website), and any of our group
             companies and the officers, directors, employees, shareholders or
            agents of any of them, exclude all liability and responsibility for any
            amount or kind of loss or damage that may result to you or a third party
             (including without limitation, any direct, indirect, punitive or
            consequential loss or damages, or any loss of income, profits, goodwill,
             data, contracts, use of money, or loss or damages arising from or
            connected in any way to business interruption, and whether in tort
            (including without limitation negligence), contract or otherwise) in
            connection with this Website in any way or in connection with the use,
            inability to use or the results of use of this Website, any websites
            linked to this Website or the material on such websites, including but
            not limited to loss or damage due to viruses that may infect your
            computer equipment, software, data or other property on account of your
            access to, use of, or browsing this Website or your downloading of any
            material from this Website or any websites linked to this Website.</p>

            <p>13.2 Nothing in these terms and conditions shall exclude or limit
            our liability for (i) death or personal injury caused by negligence (as
            such term is defined by the Unfair Contract Terms Act 1977); (ii) fraud;
             (iii) misrepresentation as to a fundamental matter; or (iv) any
            liability which cannot be excluded or limited under applicable law.</p>

            <p>13.3 If your use of material on this Website results in the need for
             servicing, repair or correction of equipment, software or data, you
            assume all costs thereof.</p>

            <p>13.4 You agree, on behalf of yourself and your business entity or
            organisation, jointly and severally to indemnify us fully, defend and
            hold us, and our officers, directors, employees and agents, harmless
            from and against all claims, liability, damages, losses, costs
            (including reasonable legal fees) arising out of any breach of the terms
             and conditions by you, or your use of this Website, or the use by any
            other person using your registration details.</p>

            <h2>14. GOVERNING LAW AND JURISDICTION</h2>

            <p>14.1 These terms and conditions shall be governed by and construed in
             accordance with Scottish law. Disputes arising in connection with these
            terms and conditions shall be subject to the exclusive jurisdiction of
            the Scottish courts where the claim is brought by you, save where you
            have legal rights to bring any claim in respect of such a dispute in any
             other jurisdiction. We nevertheless retain the right to bring
            proceedings against you for any threatened or actual breach of these
            terms and conditions in your country of residence, registration or
            business or any other relevant country.</p>

            <p>14.2 We do not warrant that materials, services or information for
            sale on the Website are appropriate or available for use outside the
            United Kingdom. It is prohibited to access the Website from territories
            where its contents are illegal or unlawful. If you access this Website
            from locations outside the United Kingdom, you do so at your own risk
            and you are responsible for compliance with local laws.</p>

            <h2>15. MISCELLANEOUS</h2>
            <p>15.1 You may not assign, sub-license or otherwise transfer any of
            your rights under these terms and conditions</p>

            <p>15.2 If any provision of these terms and conditions is found by any
            court of competent jurisdiction to be invalid, the invalidity of that
            provision will not affect the validity of the remaining provisions which
             shall continue to have full force and effect.</p>

            <p>15.4 No person other than the parties to these terms and conditions
            are intended to benefit from them pursuant to the Contracts (Rights of
            Third Parties) Act 1999.</p>
          </div>

        </td>
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
