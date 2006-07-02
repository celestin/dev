<?php
/**
* @version $Id: toolbar.menumanager.html.php,v 1.6 2004/09/19 18:17:37 akede Exp $
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
class TOOLBAR_menumanager {
	/**
	* Draws the menu for the Menu Manager
	*/
	function _DEFAULT() {
		mosMenuBar::startTable();
		mosMenuBar::addNew();
		mosMenuBar::editList();
		mosMenuBar::custom( 'copyconfirm', 'copy.png', 'copy_f2.png', '&nbsp;Copy', true );
		mosMenuBar::custom( 'deleteconfirm', 'delete.png', 'delete_f2.png', '&nbsp;Delete', true );
		mosMenuBar::spacer();
		mosMenuBar::help( 'sect.menus.manager' );
		mosMenuBar::endTable();
	}

	/**
	* Draws the menu to delete a menu
	*/
	function _DELETE() {
		mosMenuBar::startTable();
		mosMenuBar::cancel( );
		mosMenuBar::spacer();
		mosMenuBar::spacer();
		mosMenuBar::endTable();
	}

	/**
	* Draws the menu to create a New menu
	*/
	function _NEWMENU()	{
		mosMenuBar::startTable();
		mosMenuBar::custom( 'savemenu', 'save.png', 'save_f2.png', '&nbsp;Save', false );
		mosMenuBar::cancel();
		mosMenuBar::spacer();
		mosMenuBar::spacer();
		mosMenuBar::endTable();
	}

	/**
	* Draws the menu to create a New menu
	*/
	function _COPYMENU()	{
		mosMenuBar::startTable();
		mosMenuBar::custom( 'copymenu', 'copy.png', 'copy_f2.png', '&nbsp;Copy', false );
		mosMenuBar::cancel();
		mosMenuBar::spacer();
		mosMenuBar::spacer();
		mosMenuBar::endTable();
	}

}
?>