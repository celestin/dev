<?php

global $cfg;
include_once('../../../config.php');

class DATABASE_CONFIG
{
  var $default = array();

  var $test = array('driver' => 'mysql',
              'connect' => 'mysql_connect',
              'host' => 'localhost',
              'login' => 'user',
              'password' => 'password',
              'database' => 'project_name-test',
              'prefix' => '');

  function DATABASE_CONFIG() {
    global $cfg;

    $this->default['driver']    = 'mysql';
    $this->default['connect']   = 'mysql_connect';
    $this->default['host']      = $cfg['Site']['Db']['Hostname'];
    $this->default['login']     = $cfg['Site']['Db']['Username'];
    $this->default['password']  = $cfg['Site']['Db']['Password'];
    $this->default['database']  = $cfg['Site']['Db']['Database'];
    $this->default['prefix']    = '';
  }
}
?>