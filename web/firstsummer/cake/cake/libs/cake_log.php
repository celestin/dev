<?php
/* SVN FILE: $Id: cake_log.php 2951 2006-05-25 22:12:33Z phpnut $ */
/**
 * Logging.
 *
 * Log messages to text files.
 *
 * PHP versions 4 and 5
 *
 * CakePHP :  Rapid Development Framework <http://www.cakephp.org/>
 * Copyright (c)	2006, Cake Software Foundation, Inc.
 *								1785 E. Sahara Avenue, Suite 490-204
 *								Las Vegas, Nevada 89104
 *
 * Licensed under The MIT License
 * Redistributions of files must retain the above copyright notice.
 *
 * @filesource
 * @copyright		Copyright (c) 2006, Cake Software Foundation, Inc.
 * @link				http://www.cakefoundation.org/projects/info/cakephp CakePHP Project
 * @package			cake
 * @subpackage		cake.cake.libs
 * @since			CakePHP v 0.2.9
 * @version			$Revision: 2951 $
 * @modifiedby		$LastChangedBy: phpnut $
 * @lastmodified	$Date: 2006-05-25 17:12:33 -0500 (Thu, 25 May 2006) $
 * @license			http://www.opensource.org/licenses/mit-license.php The MIT License
 */
/**
 * Included libraries.
 *
 */
	if (!class_exists('File')) {
		 uses('file');
	}
/**
 * Logs messages to text files
 *
 * @package		cake
 * @subpackage	cake.cake.libs
 */
class CakeLog{
/**
 * Writes given message to a log file in the logs directory.
 *
 * @param string $type Type of log, becomes part of the log's filename
 * @param string $msg  Message to log
 * @return boolean Success
 */
	function write($type, $msg) {
		$filename=LOGS . $type . '.log';
		$output=date('y-m-d H:i:s') . ' ' . ucfirst($type) . ': ' . $msg . "\n";
		$log=new File($filename);
		return $log->append($output);
	}
}
?>