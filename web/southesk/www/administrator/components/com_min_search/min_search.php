<?php
/**
* @version $Id$
* @package Mambo_4.5.1
* @copyright (C) 2000 - 2004 Miro International Pty Ltd
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* Mambo is Free Software
*/

/** ensure this file is being included by a parent file */
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );

// load the html drawing class
$mainframe->setPageTitle(_CONTACT_TITLE);

if ( !isset( $op ) ) {
  $op = '';
}

//Load Vars
$con_id = intval( mosGetParam( $_REQUEST ,'con_id', 0 ) );
$min_search_id = intval( mosGetParam( $_REQUEST ,'min_search_id', 0 ) );
$catid = intval( mosGetParam( $_REQUEST ,'catid', 0 ) );

switch( $task ) {
  default:
    min_searchpage( $option, $min_search_id );
    break;
}

switch( $op ) {
  case 'sendmail':
    sendmail( $con_id, $option );
    break;
}


function min_searchpage( $option, $min_search_id ) {
  global $mainframe, $database, $my, $Itemid;

  //HTML_min_search::viewmin_search( $min_search, $params, $count, $list );
}

?>
