<?php
/**
* @version $Id: toolbar.menus.html.php,v 1.13 2004/08/28 12:36:59 rcastley Exp $
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
class TOOLBAR_menus {
	/**
	* Draws the menu for a New top menu item
	*/
	function _NEW()	{
		mosMenuBar::startTable();
		mosMenuBar::custom( 'edit', 'next.png', 'next_f2.png', '&nbsp;Next', true );
		mosMenuBar::cancel();
		mosMenuBar::endTable();
	}

	/**
	* Draws the menu to Move Menut Items
	*/
	function _MOVEMENU()	{
		mosMenuBar::startTable();
		mosMenuBar::custom( 'movemenusave', 'move.png', 'move_f2.png', '&nbsp;Move', false );
		mosMenuBar::cancel( 'cancelmovemenu' );
		mosMenuBar::endTable();
	}

	/**
	* Draws the menu to Move Menut Items
	*/
	function _COPYMENU()	{
		mosMenuBar::startTable();
		mosMenuBar::custom( 'copymenusave', 'copy.png', 'copy_f2.png', '&nbsp;Copy', false );
		mosMenuBar::cancel( 'cancelcopymenu' );
		mosMenuBar::endTable();
	}

	/**
	* Draws the menu to edit a menu item
	*/
	function _EDIT() {
		mosMenuBar::startTable();
		mosMenuBar::save();
		mosMenuBar::cancel();
		mosMenuBar::endTable();
	}

	function _DEFAULT() {
		mosMenuBar::startTable();
		mosMenuBar::addNew();
		mosMenuBar::editList();
		mosMenuBar::publishList();
		mosMenuBar::unpublishList();
		mosMenuBar::custom( 'movemenu', 'move.png', 'move_f2.png', '&nbsp;Move', true );
		mosMenuBar::custom( 'copymenu', 'copy.png', 'copy_f2.png', '&nbsp;Copy', true );
		mosMenuBar::trash();
		?>
     	<td>
		<a class="toolbar" href="index2.php?option=com_menumanager" onmouseout="MM_swapImgRestore();"  onmouseover="MM_swapImage('cancel','','images/cancel_f2.png',1);">
		<img src="images/cancel.png" alt="Cancel" border="0" name="cancel" align="middle" />&nbsp;Cancel</a>
		</td>
		<?php
		mosMenuBar::help( 'sect.menus' );
		mosMenuBar::endTable();
	}
}
?>