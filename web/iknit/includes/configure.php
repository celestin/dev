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
 * CAM  10-Jan-2011  10928 : Better config options for development environments.
 * * * * * * * * * * * * * * * * * * * * * * * */

  if (strpos(strtolower($_SERVER['SERVER_NAME']), "www.iknit.biz") !== FALSE) {
    define('HTTP_SERVER', 'http://www.iknit.biz');
    define('HTTPS_SERVER', 'http://www.iknit.biz');
    define('DIR_FS_CATALOG', '/var/www/html/');
  } else {
    $url = 'http://localhost';
    if ($_SERVER['SERVER_PORT'] != 80) $url .= ':' . $_SERVER['SERVER_PORT'];
    $url .= '/iknit';

    define('HTTP_SERVER', $url);
    define('HTTPS_SERVER', $url);
    define('DIR_FS_CATALOG', 'c:/appserv/www/iknit/');
  }

  define('ENABLE_SSL', false);
  define('HTTP_COOKIE_DOMAIN', 'www.iknit.biz');
  define('HTTPS_COOKIE_DOMAIN', 'www.iknit.biz');
  define('HTTP_COOKIE_PATH', '/');
  define('HTTPS_COOKIE_PATH', '/');
  define('DIR_WS_HTTP_CATALOG', '/');
  define('DIR_WS_HTTPS_CATALOG', '/');
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

  define('DB_SERVER', '127.0.0.1');
  define('DB_SERVER_USERNAME', 'iknitbiz');
  define('DB_SERVER_PASSWORD', 'bill81');
  define('DB_DATABASE', 'iknit_biz_site');
  define('USE_PCONNECT', 'false');
  define('STORE_SESSIONS', 'mysql');
?>