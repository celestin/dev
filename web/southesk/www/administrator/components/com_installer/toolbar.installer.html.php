<?php
/**
* @version $Id$
* @package Mambo_4.5.1
* @copyright (C) 2000 - 2004 Miro International Pty Ltd
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* Mambo is Free Software
* @subpackage Installer
*/

/**
* @package Mambo_4.5.1
*/
class TOOLBAR_installer
{
	function _DEFAULT()	{
		mosMenuBar::startTable();
		mosMenuBar::help( 'sect.installer' );
		mosMenuBar::endTable();
	}

	function _DEFAULT2()	{
		mosMenuBar::startTable();
		mosMenuBar::deleteList();
		mosMenuBar::help( 'sect.installer' );
		mosMenuBar::endTable();
	}

	function _NEW()	{
		mosMenuBar::startTable();
		mosMenuBar::save();
		mosMenuBar::cancel();
		mosMenuBar::endTable();
	}
}
?>