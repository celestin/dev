<?php
/**
* @version $Id$
* @package Mambo_4.5.1
* @copyright (C) 2000 - 2004 Miro International Pty Ltd
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* Mambo is Free Software
*/

/**
* @package Mambo_4.5.1
*/
class TOOLBAR_content {
	function _NEW() {
		mosMenuBar::startTable();
		mosMenuBar::preview( 'contentwindow', true );
		mosMenuBar::media_manager();
		mosMenuBar::save();
		mosMenuBar::cancel();
		mosMenuBar::help( 'sect.content.edit' );
		mosMenuBar::endTable();
	}

	function _EDIT() {
		mosMenuBar::startTable();
		mosMenuBar::preview( 'contentwindow', true );
		mosMenuBar::media_manager();
		mosMenuBar::save();
		mosMenuBar::cancel();
		mosMenuBar::help( 'sect.content.edit' );
		mosMenuBar::endTable();
	}

	function _ARCHIVE() {
		mosMenuBar::startTable();
		mosMenuBar::unarchiveList();
		mosMenuBar::custom( 'remove', 'delete.png', 'delete_f2.png', '&nbsp;Trash', false );
		mosMenuBar::endTable();
	}

	function _MOVE() {
		mosMenuBar::startTable();
		mosMenuBar::custom( 'movesectsave', 'save.png', 'save_f2.png', '&nbsp;Save', false );
		mosMenuBar::cancel();
		mosMenuBar::help( 'sect.content.move' );
		mosMenuBar::endTable();
	}

	function _COPY() {
		mosMenuBar::startTable();
		mosMenuBar::custom( 'copysave', 'save.png', 'save_f2.png', '&nbsp;Save', false );
		mosMenuBar::cancel();
		mosMenuBar::help( 'sect.content.move' );
		mosMenuBar::endTable();
	}

	function _DEFAULT() {
		mosMenuBar::startTable();
		mosMenuBar::addNew();
		mosMenuBar::editList( 'editA' );
		mosMenuBar::publishList();
		mosMenuBar::unpublishList();
		mosMenuBar::custom( 'movesect', 'move.png', 'move_f2.png', '&nbsp;Move' );
		mosMenuBar::custom( 'copy', 'copy.png', 'copy_f2.png', '&nbsp;Copy' );
		mosMenuBar::archiveList();
		mosMenuBar::trash();
		mosMenuBar::help( 'sect.content' );
		mosMenuBar::endTable();
	}
}
?>