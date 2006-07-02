<?php
// $Id$
/**
* Template Generator admin
* @package Mambo Open Source
* @Copyright (C) 2000 - 2003 Miro International Pty Ltd
* @ All rights reserved
* @ Mambo Open Source is Free Software
* @ Released under GNU/GPL License : http://www.gnu.org/copyleft/gpl.html
* @version $Revision: 1.16 $
**/

// ensure this file is being included by a parent file
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );

// ensure user has access to this function
if (!($acl->acl_check( 'administration', 'edit', 'users', $my->usertype, 'components', 'all' )
		| $acl->acl_check( 'administration', 'edit', 'users', $my->usertype, 'components', 'com_template_gen' ))) {
	mosRedirect( 'index2.php', _NOT_AUTH );
}



$cid = mosGetParam( $_REQUEST, 'cid', array(0) );
if (!is_array( $cid )) {
	$cid = array(0);
}
?>
<script language="JavaScript" type="text/javascript">
function startTemp(){
var newTemp=window.open("components/com_template_gen/index.php","");
newTemp.focus();
}


</script>

<div style="cursor:pointer;" onClick="startTemp();">Click here to<h2>Make New Template</h2></div>
<div id="message" class="message"></div>
<p>To display your own icon on the browser address bar <br/>when visitors view or bookmark your web page make your icon <a href="http://www.chami.com/html-kit/services/favicon/">here</a> <br/>then upload it to your template along with your other image files it will be automatically displayed</p>
