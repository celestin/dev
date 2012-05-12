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
 * CAM  28-Apr-2010  10639 : Added Product Extra Fields (http://www.oscommerce.com/community/contributions,2202)
 * CAM  10-Jan-2011  10928 : Better config options for development environments.
 * CAM  23-May-2011  10961 : Smarter definition of config vars.
 * CAM  19-Apr-2012  11115 : Renamed to Lovie's Yarn.
 * CAM  12-May-2012  11119 : Local settings.
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

	  define('DB_SERVER_USERNAME', 'loviesya_test');
	  define('DB_SERVER_PASSWORD', 'iknit_test');
	  define('DB_DATABASE', 'loviesya_biz_test');
  } else {
    $url = 'http://artificer';
    if ($_SERVER['SERVER_PORT'] != 80) $url .= ':' . $_SERVER['SERVER_PORT'];
    $url .= '/loviesyarn';

    define('HTTP_SERVER', $url);
    define('HTTPS_SERVER', $url);
    define('DIR_FS_CATALOG', 'c:/appserv/www/loviesya/');

	  define('DB_SERVER_USERNAME', 'iknitbiz');
	  define('DB_SERVER_PASSWORD', 'bill81');
	  define('DB_DATABASE', 'iknit_biz_site');
  }

  define('ENABLE_SSL', false);
  define('HTTP_COOKIE_DOMAIN', 'www.loviesyarn.com');
  define('HTTPS_COOKIE_DOMAIN', HTTP_COOKIE_DOMAIN);
  define('HTTP_COOKIE_PATH', '/');
  define('HTTPS_COOKIE_PATH', HTTP_COOKIE_PATH);
  define('DIR_WS_HTTP_CATALOG', '/');
  define('DIR_WS_HTTPS_CATALOG', DIR_WS_HTTP_CATALOG);
  define('DIR_WS_IMAGES', 'images/');
  define('DIR_WS_ICONS', DIR_WS_IMAGES . 'icons/');
  define('DIR_WS_INCLUDES', 'includes/');
  define('DIR_WS_BOXES', DIR_WS_INCLUDES . 'boxes/');
  define('DIR_WS_FUNCTIONS', DIR_WS_INCLUDES . 'functions/');
  define('DIR_WS_CLASSES', DIR_WS_INCLUDES . 'classes/');
  define('DIR_WS_MODULES', DIR_WS_INCLUDES . 'modules/');
  define('DIR_WS_LANGUAGES', DIR_WS_INCLUDES . 'languages/');

  define('DIR_WS_DOWNLOAD_PUBLIC', 'pub/');
  define('DIR_FS_DOWNLOAD', DIR_FS_CATALOG . 'download/');
  define('DIR_FS_DOWNLOAD_PUBLIC', DIR_FS_CATALOG . 'pub/');
?>