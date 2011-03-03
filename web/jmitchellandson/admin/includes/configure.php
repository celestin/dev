<?php
  if (strpos(strtolower($_SERVER['SERVER_NAME']), "emperor") !== FALSE) {
    define('HTTP_SERVER', 'http://emperor/jmitchellandson');
    define('HTTPS_SERVER', 'http://emperor/jmitchellandson');
    define('HTTP_CATALOG_SERVER', 'http://emperor/jmitchellandson');
    define('HTTPS_CATALOG_SERVER', 'http://emperor/jmitchellandson');
    define('DIR_FS_CATALOG', 'c:/appserv/www/jmitchellandson/');
    define('DIR_FS_ADMIN', 'c:/appserv/www/jmitchellandson/admin/');
    define('DIR_WS_CATALOG', '../');
  } else {
    define('HTTP_SERVER', 'http://www.jmitchellandson.co.uk');
    define('HTTPS_SERVER', 'http://www.jmitchellandson.co.uk');
    define('HTTP_CATALOG_SERVER', 'http://www.jmitchellandson.co.uk');
    define('HTTPS_CATALOG_SERVER', 'http://www.jmitchellandson.co.uk');
    define('DIR_FS_CATALOG', '/home/jmitch/public_html/');
    define('DIR_FS_ADMIN', '/home/jmitch/public_html/admin/');
    define('DIR_WS_CATALOG', '/');
  }

  define('ENABLE_SSL_CATALOG', 'false');
  define('DIR_FS_DOCUMENT_ROOT', '/home/jmitch/public_html/');
  define('DIR_WS_ADMIN', '/admin/');
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

  define('DB_SERVER', '127.0.0.1');
  define('DB_SERVER_USERNAME', 'jmitchellandson');
  define('DB_SERVER_PASSWORD', 'john77');
  define('DB_DATABASE', 'jmitchellandson_site');
  define('USE_PCONNECT', 'false');
  define('STORE_SESSIONS', 'mysql');
?>