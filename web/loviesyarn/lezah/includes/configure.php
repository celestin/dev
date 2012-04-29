<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Lovie's Yarns (loviesyarn.com)
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
 * CAM  19-Apr-2012  11115 : Renamed to Lovie's Yarn.
 * * * * * * * * * * * * * * * * * * * * * * * */

  define('DB_SERVER', '127.0.0.1');
  define('USE_PCONNECT', 'false');
  define('STORE_SESSIONS', 'mysql');

  if (strpos(strtolower($_SERVER['SERVER_NAME']), "www.loviesyarn.com") !== FALSE) {
    define('HTTP_SERVER', 'http://www.loviesyarn.com');
    define('HTTPS_SERVER', HTTP_SERVER);
    define('DIR_FS_CATALOG', '/home/loviesya/public_html/');

	  define('DB_SERVER_USERNAME', 'iknitbiz');
	  define('DB_SERVER_PASSWORD', 'bill81');
	  define('DB_DATABASE', 'loviesya_biz_site');

  } else if (strpos(strtolower($_SERVER['SERVER_NAME']), "test.loviesyarn.com") !== FALSE) {
    define('HTTP_SERVER', 'http://test.loviesyarn.com');
    define('HTTPS_SERVER', HTTP_SERVER);
    define('DIR_FS_CATALOG', '/home/loviesya/test_html/');
    define('DIR_WS_CATALOG', '/');

	  define('DB_SERVER_USERNAME', 'loviesya_test');
	  define('DB_SERVER_PASSWORD', 'iknit_test');
	  define('DB_DATABASE', 'loviesya_biz_test');

  } else {
    $url = 'http://localhost';
    if ($_SERVER['SERVER_PORT'] != 80) $url .= ':' . $_SERVER['SERVER_PORT'];
    $url .= '/iknit';

    define('HTTP_SERVER', $url);
    define('DIR_FS_CATALOG', 'c:/appserv/www/iknit/');
    define('DIR_WS_CATALOG', '../');

	  define('DB_SERVER_USERNAME', 'iknitbiz');
	  define('DB_SERVER_PASSWORD', 'bill81');
	  define('DB_DATABASE', 'iknit_biz_site');
  }

  define('DIR_FS_ADMIN', DIR_FS_CATALOG . 'lezah/');
  define('HTTPS_SERVER', HTTP_SERVER);

  define('ENABLE_SSL_CATALOG', 'false');
  define('DIR_FS_DOCUMENT_ROOT', DIR_FS_CATALOG);
  define('DIR_WS_ADMIN', '/lezah/');
  define('DIR_WS_IMAGES', 'images/');
  define('DIR_WS_ICONS', DIR_WS_IMAGES . 'icons/');
  define('DIR_WS_CATALOG_IMAGES', DIR_WS_CATALOG . 'images/');
  define('DIR_WS_INCLUDES', 'includes/');
  define('DIR_WS_BOXES', DIR_WS_INCLUDES . 'boxes/');
  define('DIR_WS_FUNCTIONS', DIR_WS_INCLUDES . 'functions/');
  define('DIR_WS_CLASSES', DIR_WS_INCLUDES . 'classes/');
  define('DIR_WS_MODULES', DIR_WS_INCLUDES . 'modules/');
  define('DIR_WS_LANGUAGES', DIR_WS_INCLUDES . 'languages/');
  define('DIR_WS_CATALOG_LANGUAGES', DIR_WS_CATALOG . 'includes/languages/');
  define('DIR_FS_CATALOG_LANGUAGES', DIR_FS_CATALOG . 'includes/languages/');
  define('DIR_FS_CATALOG_IMAGES', DIR_FS_CATALOG . 'images/');
  define('DIR_FS_CATALOG_MODULES', DIR_FS_CATALOG . 'includes/modules/');
  define('DIR_FS_BACKUP', DIR_FS_ADMIN . 'backups/');
?>