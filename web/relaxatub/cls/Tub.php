<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Hot Tub wrapper class
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  24-Sep-2006  10020 : Display colours and wood finishes of tubs.
 * CAM  24-Sep-2006  10030 : Ensure Tub IDs are uppercase.
 * CAM  22-Mar-2008  10258 : Added no_people and dimen attributes.
 * CAM  12-Apr-2008  10241 : Use new short fields.
 * * * * * * * * * * * * * * * * * * * * * * * */

class Tub extends Tuple {

  // ----- Instance Variables --------------------------------------------- //

  /**
  * Seats no. of people.
  * @private
  * @type String
  */
  var $no_people = NULL;
  /**
  * External Dimensions.
  * @private
  * @type String
  */
  var $dimen = NULL;
  /**
  * Inside Colour.
  * @private
  * @type String
  */
  var $colour = NULL;
  /**
  * Wood Colour.
  * @private
  * @type String
  */
  var $wood = NULL;
  /**
  * Series to which the Tub belongs.
  * @private
  * @type String
  */
  var $series = NULL;
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
  /**
  * Customer Quote 1.
  * @private
  * @type String
  */
  var $quote1 = NULL;
  /**
  * Name of Customer responsible for Quote 1.
  * @private
  * @type String
  */
  var $cust1 = NULL;
  /**
  * Customer Quote 1.
  * @private
  * @type String
  */
  var $quote2 = NULL;
  /**
  * Name of Customer responsible for Quote 1.
  * @private
  * @type String
  */
  var $cust2 = NULL;

  // ----- Constructors --------------------------------------------------- //

  /**
  * Construct a new Tuple.
  *
  * @param String The Tub ID.
  *
  * @public
  * @returns
  */
  function Tub($tub, $series='') {

    if (!empty($series)) {
      $this->id = strtoupper($tub);
      $this->series = $series;
    } else {
      $sql = "SELECT * FROM tub WHERE tub='" .$tub . "'";
      $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

      if ($row = mysql_fetch_array($res)) {
        foreach($row AS $key => $val) {
          $$key = stripslashes($val);
        }

        $this->id = strtoupper($tub);
        $this->series = $series;

        $this->no_people = $no_people;
        $this->dimen = $dimen;
        $this->colour = $colour;
        $this->wood = $wood;
        $this->capacity = $capacity;
        $this->dry_weight = $dry_weight;
        $this->fill_weight = $fill_weight;
        $this->pumps = $short_pumps;
        $this->shield = $shield;
        $this->safety = $safety;
        $this->ports = $short_ports;
        $this->custom = $short_custom;
        $this->filter = $filter;
        $this->auto = $auto;
        $this->light = $light;
        $this->protect = $protect;

        $this->quote1 = $quote1;
        $this->cust1 = $cust1;
        $this->quote2 = $quote2;
        $this->cust2 = $cust2;
      }
    }
  }

  // ----- Public Methods ------------------------------------------------- //

  /**
  * Return the image filename for this Tub.
  *
  * @param String File type
  *
  * @public
  * @returns String
  */
  function imgFile($folder) {
    $ftype = ".jpg";

    if ($folder == "t") {
      $ftype = ".gif";
    }

    return "img/tub/" . $folder . "/" . strtolower($this->id) . $ftype;
  }

  /**
  * Format a Quote/Customer neatly
  *
  * @param String Quotation
  * @param String Customer name
  *
  * @public
  * @returns String
  */
  function getQuote($quote, $cust) {
    return "<table border=0>" .
             "<tr>".
               "<td><span class=bigquot>&quot;</span>".
               "$quote".
               "<span class=bigquot>&quot;</span></td>".
             "</tr>".
             "<tr><td colspan=2 class=custquot>$cust</td><td>&nbsp;</td></tr>".
           "</table>";
  }

  /**
  * Is there a Quote 1 for this Tub?
  *
  * @public
  * @returns boolean
  */
  function hasQuote1() {
    return (!empty($this->quote1));
  }

  /**
  * Get a neatly formatted Quote/Customer.
  *
  * @public
  * @returns String
  */
  function getQuote1() {
    if (!empty($this->quote1)) {
      return $this->getQuote($this->quote1, $this->cust1);
    }

    return "&nbsp;";
  }

  /**
  * Is there a Quote 1 for this Tub?
  *
  * @public
  * @returns boolean
  */
  function hasQuote2() {
    return (!empty($this->quote2));
  }

  /**
  * Get a neatly formatted Quote/Customer.
  *
  * @public
  * @returns String
  */
  function getQuote2() {
    if (!empty($this->quote2)) {
      return $this->getQuote($this->quote2, $this->cust2);
    }

    return "&nbsp;";
  }
}
?>