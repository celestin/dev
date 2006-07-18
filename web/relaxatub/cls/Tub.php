<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Hot Tub wrapper class
 *
 * $Id: activate.php 84 2006-05-11 18:55:49Z craig $
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

class Tub {

  // ----- Instance Variables --------------------------------------------- //

  /**
  * Water Capacity.
  * @private
  * @type String
  */
  var $capacity = NULL;
  /**
  * Dry Weight.
  * @private
  * @type String
  */
  var $dry_weight = NULL;
  /**
  * Filled Weight.
  * @private
  * @type String
  */
  var $fill_weight = NULL;
  /**
  * Massaging Pumps.
  * @private
  * @type String
  */
  var $pumps = NULL;
  /**
  * Heatshield Cover.
  * @private
  * @type String
  */
  var $shield = NULL;
  /**
  * Safety Approval.
  * @private
  * @type String
  */
  var $safety = NULL;
  /**
  * Water Ports System.
  * @private
  * @type String
  */
  var $ports = NULL;
  /**
  * Personal Customised Therapeut.
  * @private
  * @type String
  */
  var $custom = NULL;
  /**
  * Microfilter Filtration.
  * @private
  * @type String
  */
  var $filter = NULL;
  /**
  * Automatic Controls.
  * @private
  * @type String
  */
  var $auto = NULL;
  /**
  * Underwater Lighting.
  * @private
  * @type String
  */
  var $light = NULL;
  /**
  * Customer Protection.
  * @private
  * @type String
  */
  var $protect = NULL;

  // ----- Constructors --------------------------------------------------- //

  /**
  * Construct a new Tuple.
  *
  * @param Object The ID.
  * @param String The Description.
  *
  * @public
  * @returns
  */
  function Tub($tub) {
    $sql = "SELECT * FROM tub WHERE tub='" .$tub . "'";
    $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

    if ($row = mysql_fetch_array($res)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $this->capacity = $capacity;
      $this->dry_weight = $dry_weight;
      $this->fill_weight = $fill_weight;
      $this->pumps = $pumps;
      $this->shield = $shield;
      $this->safety = $safety;
      $this->ports = $ports;
      $this->custom = $custom;
      $this->filter = $filter;
      $this->auto = $auto;
      $this->light = $light;
      $this->protect = $protect;
    }
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
}
?>