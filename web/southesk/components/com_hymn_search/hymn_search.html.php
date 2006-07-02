<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Southesk.com
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Hymn Search Controller
 *
 * $Id: blockbooking.php 37 2006-05-04 22:21:18Z craig $
 *
 * Who  When         Why
 * CAM  02-Jul-2006  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

/** ensure this file is being included by a parent file */
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );


/**
* @package Mambo_4.5.1
*/
class HTML_hymn_search {

  function viewhymn_search( &$hymn_search, &$params, $count, &$list ) {
    //print_r( $hymn_search );
    global $mosConfig_live_site;
    global $mainframe, $Itemid;
    $template = $mainframe->getTemplate();
    $sitename = $mainframe->getCfg( 'sitename' );
    $hide_js = mosGetParam($_REQUEST,'hide_js', 0 );
    ?>
    <script language="JavaScript" type="text/javascript">
    <!--
    function validate(){
      if ( ( document.emailForm.text.value == "" ) || ( document.emailForm.email.value.search("@") == -1 ) || ( document.emailForm.email.value.search("[.*]" ) == -1 ) ) {
        alert( "<?php echo _CONTACT_FORM_NC; ?>" );
      } else {
      document.emailForm.action = "<?php echo sefRelToAbs("index.php?option=com_hymn_search&Itemid=$Itemid"); ?>"
      document.emailForm.submit();
      }
    }
    //-->
    </script>
    <script type="text/javascript">
    <!--
    function ViewCrossReference( selSelectObject ){
      var links = new Array();
      <?php
      $n = count( $list );
      for ($i = 0; $i < $n; $i++) {
         echo "\nlinks[".$list[$i]->value."]='"
          . sefRelToAbs( 'index.php?option=com_hymn_search&task=view&hymn_search_id='. $list[$i]->value .'&Itemid='. $Itemid )
          . "';";
      }
      ?>

      var sel = selSelectObject.options[selSelectObject.selectedIndex].value
      if (sel != "") {
        location.href = links[sel];
      }
    }
    //-->
    </script>
    <?php
    // For the pop window opened for print preview
    if ( $params->get( 'popup' ) ) {
      ?>
      <title><?php echo $sitename ." :: ". $hymn_search->name; ?></title>
      <link rel="stylesheet" href="<?php echo $mosConfig_live_site ."/templates/". $template ."/css/template_css.css";?>" type="text/css" />
      <?php
    }
    ?>
    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="contentpane<?php echo $params->get( 'pageclass_sfx' ); ?>">
    <?php
    // displays Page Title
    HTML_hymn_search::_writePageTitle( $params );
  }


  /**
  * Writes Page Title
  */
  function _writePageTitle( &$params ) {
    if ( $params->get( 'page_title' )  && !$params->get( 'popup' ) ) {
      ?>
      <tr>
        <td class="componentheading<?php echo $params->get( 'pageclass_sfx' ); ?>" colspan="2">
        <?php echo $params->get( 'header' ); ?>
        </td>
      </tr>
      <?php
    }
  }


  /**
  * Writes Email form
  */
  function _writeEmailForm( &$hymn_search, &$params, $sitename ) {
    if ( $hymn_search->email_to && !$params->get( 'popup' ) && $params->get( 'email_form' ) ) {
      ?>
      <?
    } else {
      echo '&nbsp;';
    }
  }


  function nohymn_search( &$params ) {
    ?>
    <br /><br />
    <?php echo _CONTACT_NONE;?>
    <br /><br />
    <?php
    // displays back button
    mosHTML::BackButton ( $params );
  }
}
?>
