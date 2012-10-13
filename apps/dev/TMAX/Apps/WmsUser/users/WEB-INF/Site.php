<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Site Class
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  09-Sep-2012  11128 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

/**
* A Site - ID, Fullname (Desc) and Shortname.
*
* @author Craig McKay
* @public
*/
class Site extends Tuple {

  // ----- Instance Variables --------------------------------------------- //

  /**
  * Site's first name.
  * @private
  * @type String
  */
  var $shortname = NULL;

  // ----- Properties ----------------------------------------------------- //

  // ----- Constructors --------------------------------------------------- //

  /**
  * Construct a new Site.
  *
  * @param Object The ID.
  * @param String The Description.
  *
  * @public
  * @returns
  */
  function Site($id='', $sitefullname='', $siteshortname='') {
    $this->id = $id;
    $this->desc = $sitefullname;
    $this->shortname = $siteshortname;
  }

  function getSite($siteid) {
    $qry = mysql_query("SELECT site, sitefullname, siteshortname ".
                       "FROM site ".
                       "WHERE site='$siteid'");
    if ($row = mysql_fetch_array($qry)) {

      return new Site($row[0],$row[1],$row[2]);
    }
  }
}
?>