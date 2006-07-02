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

/**
* @package Mambo_4.5.1
*/

class mosTemplatePosition extends mosDBTable {
	var $id=null;
	var $position=null;
	var $description=null;

	function mosTemplatePosition() {
	    global $database;
	    $this->mosDBTable( '#__template_positions', 'id', $database );
	}
}

?>
