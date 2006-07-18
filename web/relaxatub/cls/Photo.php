<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Photo wrapper class
 *
 * $Id: activate.php 84 2006-05-11 18:55:49Z craig $
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

class Photo extends Tuple {

  // ----- Instance Variables --------------------------------------------- //

  /**
  * Photo Location
  * @private
  * @type String
  */
  var $location = NULL;
  /**
  * Tub ID featured in the Photo
  * @private
  * @type String
  */
  var $tub = NULL;

  // ----- Constructors --------------------------------------------------- //

  /**
  * Construct a new Photo.
  *
  * @param Object The ID.
  * @param String The Description.
  *
  * @public
  * @returns
  */
  function Photo($photo, $location, $tub) {
    $this->id = $photo;
    $this->location = $location;
    $this->tub = $tub;
  }


  // ----- Public Methods ------------------------------------------------- //

  /**
  * Format this Tuple as an HTML String.
  *
  * @param boolean Show ID
  *
  * @public
  * @returns String
  */
  function toHtmlString($showID=false) {
    $rval = "<b>" . $this->desc . "</b>";

    if ($showID) $rval .= " (<b>" . $this->id . "</b>)";

    return $rval;
  }

  /**
  * Return the image filename for this Photo.
  *
  * @param String File type
  *
  * @public
  * @returns String
  */
  function imgFile($folder) {
    return "img/ph/" . $folder . "/" . $this->id;
  }

}
?>