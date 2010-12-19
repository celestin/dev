<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * iKnit (iknit.biz)
 *
 * osCommerce, Open Source E-Commerce Solutions
 * http://www.oscommerce.com
 * Copyright (c) 2007 osCommerce
 * Released under the GNU General Public License
 *
 * Customised by Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Apr-2010  10639 : Added Product Extra Fields (http://www.oscommerce.com/community/contributions,2202)
 * * * * * * * * * * * * * * * * * * * * * * * */

define('HEADING_TITLE', 'Product Extra Fields');
define('SUBHEADING_TITLE', 'Add a new field');

define('TABLE_HEADING_FIELDS', 'Field Name');
define('TABLE_HEADING_ORDER', 'Sort Order');
define('TABLE_HEADING_LANGUAGE', 'Language');
define('TABLE_HEADING_STATUS', 'Status');
define('TABLE_HEADING_CATEGORY', 'Category');
define('TABLE_HEADING_ACTION', 'Action');

define('IMAGE_ADD_FIELD', 'Add new field');
define('IMAGE_UPDATE_FIELDS', 'Update fields');
define('IMAGE_REMOVE_FIELDS', 'Remove selected fields');

define ('TEXT_ALL_LANGUAGES', 'All');

define ('TEXT_CATEGORIES_INFO', '
When adding or updating extra fields, put the desired categories id in the Category field, followed by a ",".
The trailing ',' is important, you need to add it after each category id even if you only write one category! If
you want to have a field that will be used for all products, write "all" and nothing else. If you have subcate-
gories, you can also put parent categories id here, the field will show up in all subcategories as well.');

define ('TABLE_HEADING_GOOGLE_ONLY', 'Google only');
define ('ENTRY_GOOGLE_ONLY_YES', 'Yes');
define ('ENTRY_GOOGLE_ONLY_NO', 'No');
?>