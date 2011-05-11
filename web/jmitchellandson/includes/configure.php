<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * J.Mitchell & Son (jmitchellandson.co.uk)
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
 * CAM  05-Feb-2011  10937 : Added config for SMITH laptop.
 * * * * * * * * * * * * * * * * * * * * * * * */

  if ((strpos(strtolower($_SERVER['SERVER_NAME']), "emperor") !== FALSE) ||
      (strpos(strtolower($_SERVER['SERVER_NAME']), "artificer") !== FALSE)) {
    define('HTTP_SERVER', 'http://' . strtolower($_SERVER['SERVER_NAME']) . '/jmitchellandson');
    define('DIR_FS_CATALOG', 'c:/appserv/www/jmitchellandson/');
    define('DIR_WS_CATALOG', '../');
  } else {
    define('HTTP_SERVER', 'http://www.jmitchellandson.co.uk');
    define('DIR_FS_CATALOG', '/home/jmitch/public_html/');
    define('DIR_WS_CATALOG', '/');
  }

  define('HTTPS_SERVER', HTTP_SERVER);
  define('HTTP_CATALOG_SERVER', HTTP_SERVER);
  define('HTTPS_CATALOG_SERVER', HTTP_SERVER);
  define('DIR_FS_ADMIN', DIR_FS_CATALOG . 'nosila/');

  define('ENABLE_SSL', false);
  define('HTTP_COOKIE_DOMAIN', 'www.jmitchellandson.co.uk');
  define('HTTPS_COOKIE_DOMAIN', HTTP_COOKIE_DOMAIN);
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
  define('DB_SERVER_USERNAME', 'jmitchellandson');
  define('DB_SERVER_PASSWORD', 'john77');
  define('DB_DATABASE', 'jmitchellandson_site');
  define('USE_PCONNECT', 'false');
  define('STORE_SESSIONS', 'mysql');
?>