<?php
/* SVN FILE: $Id: dbo_generic.php 2951 2006-05-25 22:12:33Z phpnut $ */

/**
 * Generic layer for DBO.
 *
 * Long description for file
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
 * @subpackage		cake.cake.libs.model.dbo
 * @since			CakePHP v 0.2.9
 * @version			$Revision: 2951 $
 * @modifiedby		$LastChangedBy: phpnut $
 * @lastmodified	$Date: 2006-05-25 17:12:33 -0500 (Thu, 25 May 2006) $
 * @license			http://www.opensource.org/licenses/mit-license.php The MIT License
 */
/**
 * Include DBO.
 */
uses('model' . DS . 'datasources' . DS . 'dbo_source');
/**
 * Abstract DBO class file.
 *
 * All implementations override this class.
 *
 * @package		cake
 * @subpackage	cake.cake.libs.model.dbo
 */
class DBO_generic extends DboSource{

/**
 * Abstract method defined in subclasses.
 *
 */
	 function connect($config) {
	 }

/**
 * Abstract method defined in subclasses.
 *
 */
	 function disconnect() {
	 }

/**
 * Abstract method defined in subclasses.
 *
 */
	 function execute($sql) {
	 }

/**
 * Abstract method defined in subclasses.
 *
 *
 */
	 function fetchRow() {
	 }

/**
 * Abstract method defined in subclasses.
 *
 *
 */
	 function tablesList() {
	 }

/**
 * Abstract method defined in subclasses.
 *
 */
	 function fields($tableName) {
	 }

/**
	 * Abstract method defined in subclasses.
 *
 */
	 function name($name) {
	 }

/**
	 * Abstract method defined in subclasses.
 *
 */
	 function value($data) {
	 }

/**
 * Abstract method defined in subclasses.
 *
 */
	 function lastError() {
	 }

/**
 * Abstract method defined in subclasses.
 *
 */
	 function lastAffected() {
	 }

/**
 * Abstract method defined in subclasses.
 *
 */
	 function lastNumRows() {
	 }

/**
 * Abstract method defined in subclasses.
 *
 */
	 function lastInsertId() {
	 }

/**
 * Abstract method defined in subclasses.
 *
 */
	 function selectLimit($limit, $offset = null) {
	 }
}
?>