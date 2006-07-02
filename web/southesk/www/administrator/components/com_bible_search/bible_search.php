<?php
/**
* @version $Id: bible_search.php,v 1.34 2004/09/25 18:43:54 saka Exp $
* @package Mambo_4.5.1
* @copyright (C) 2000 - 2004 Miro International Pty Ltd
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* Mambo is Free Software
*/

/** ensure this file is being included by a parent file */
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );

// load the html drawing class
require_once( $mainframe->getPath( 'html' ) );
require_once( $mainframe->getPath( 'class' ) );
$mainframe->setPageTitle( _CONTACT_TITLE );

if ( !isset( $op ) ) {
	$op = '';
}

//Load Vars
$con_id = intval( mosGetParam( $_REQUEST ,'con_id', 0 ) );
$bible_search_id = intval( mosGetParam( $_REQUEST ,'bible_search_id', 0 ) );
$catid = intval( mosGetParam( $_REQUEST ,'catid', 0 ) );

switch( $task ) {
	default:
		bible_searchpage( $option, $bible_search_id );
		break;
}

switch( $op ) {
	case 'sendmail':
		sendmail( $con_id, $option );
		break;
}


function bible_searchpage( $option, $bible_search_id ) {
	global $mainframe, $database, $my, $Itemid;

	HTML_bible_search::viewbible_search( $bible_search, $params, $count, $list );
}

?>
