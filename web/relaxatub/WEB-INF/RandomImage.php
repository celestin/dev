<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Get a random image from a directory
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  23-Feb-2008  10235 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

class RandomImage {

  // ----- Instance Variables --------------------------------------------- //
  /**
  * Directory
  * @private
  * @type String
  */
  var $_directory = NULL;
  /**
  * List of Images
  * @private
  * @type Array
  */
  var $_results = NULL;
  
  // ----- Constructors --------------------------------------------------- //

  /**
  * Construct a new RandomImage object.
  *
  * @param String The Directory.
  *
  * @public
  */
  function RandomImage($directory) {
    $this->_directory = $directory;
    if (substr($this->_directory, -1, 1) !== "/") {
      $this->_directory .= "/";  
    }
    
    $this->_results = array();

    $handler = opendir($this->_directory);

    while ($file = readdir($handler)) {
        if(!is_dir($file) && stristr($file,".jpg") !== FALSE)
            $this->_results[] = $file;
    }

    closedir($handler);
  }
  
  function GetRandomImage() {
   return $this->_directory . $this->_results[rand()%count($this->_results)];   
  }
}
?>