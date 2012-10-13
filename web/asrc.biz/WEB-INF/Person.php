<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  20-Mar-2004  File created.
 * CAM  19-Jan-2006  9 : Added Blockbooker flag.
 * CAM  22-Jun-2007  10132 : Added 'Unknown User' if problem with SQL query.
 * CAM  22-Jun-2007  10130 : Added getClass.
 * CAM  23-Oct-2007  10182 : Added getBookingsDescription.
 * CAM  15-Nov-2007  10156 : Added User Privs - C01:Coach and E01:EventEditor.
 * CAM  13-Oct-2012  11135 : Removed erroring use of get_class.
 * * * * * * * * * * * * * * * * * * * * * * * */

/**
* A Person - ID, First and Last names.
*
* @author Craig McKay
* @version 2004
* @public
*/
class Person extends Tuple {

  // ----- Instance Variables --------------------------------------------- //

  /**
  * Person's first name.
  * @private
  * @type String
  */
  var $firstname = NULL;

  /**
  * Person's last name.
  * @private
  * @type String
  */
  var $lastname = NULL;

  /**
  * Person's email.
  * @private
  * @type String
  */
  var $email = NULL;

  /**
  * Person's Date of Birth.
  * @private
  * @type String
  */
  var $dob = NULL;

  /**
  * Is this Person an Administrator?
  * @private
  * @type boolean
  */
  var $admin = NULL;

  /**
  * Membership Type
  * @private
  * @type Tuple
  */
  var $membertype = NULL;

  /**
  * Block Booker flag
  * @private
  * @type boolean
  */
  var $blockbooker = FALSE;

  /**
  * Coach flag
  * @private
  * @type boolean
  */
  var $coach = FALSE;

  /**
  * Event Editor flag
  * @private
  * @type boolean
  */
  var $eventeditor = FALSE;

  // ----- Properties ----------------------------------------------------- //

  /**
  * Set the ID.
  *
  * @public
  * @returns Object
  */
  function setFirstname($firstname) {
    $this->firstname = $firstname;
  }

  /**
  * Return the ID.
  *
  * @public
  * @returns
  */
  function getFirstname() {
    if ($this->blockbooker) return "$this->firstname $this->lastname";
    return $this->firstname;
  }


  /**
  * Set the Description.
  *
  * @public
  * @returns
  */
  function setLastname($lastname) {
    $this->lastname = $lastname;
  }

  /**
  * Return the ID.
  *
  * @public
  * @returns String
  */
  function getLastname() {
    return $this->lastname;
  }


  /**
  * Set the Email.
  *
  * @public
  * @returns
  */
  function setEmail($email) {
    $this->email = $email;
  }

  /**
  * Return the Email.
  *
  * @public
  * @returns String
  */
  function getEmail() {
    return $this->email;
  }


  /**
  * Set the Admin flag.
  *
  * @public
  * @returns
  */
  function setAdmin($admin) {
    $this->admin = $admin;
  }

  /**
  * Return the Admin flag.
  *
  * @public
  * @returns String
  */
  function isAdmin() {
    return $this->admin;
  }

  /**
  * Set the Membership Type.
  *
  * @public
  * @returns
  */
  function setMembershipType($membertype) {
    $this->membertype = $membertype;
  }

  /**
  * Return the Membership Type.
  *
  * @public
  * @returns Tuple
  */
  function getMembershipType() {
    return $this->membertype;
  }

  // ----- Permissions --------------------------------------------------- //

  /**
  * Return the Block Booker flag.
  *
  * @public
  * @returns boolean
  */
  function isBlockBooker() {
    return $this->blockbooker;
  }

  /**
  * Return the Coach flag.
  *
  * @public
  * @returns boolean
  */
  function isCoach() {
    return $this->coach;
  }

  /**
  * Return the Event Editor flag.
  *
  * @public
  * @returns boolean
  */
  function isEventEditor() {
    return $this->eventeditor;
  }


  // ----- Constructors --------------------------------------------------- //

  /**
  * Construct a new Person.
  *
  * @param Object The ID.
  * @param String The Description.
  *
  * @public
  * @returns
  */
  function Person($id='', $firstname='', $lastname='', $email='', $dob='', $admin=false, $membertype='', $blockbooker=FALSE, $privs='') {
    $this->id = $id;
    $this->desc = $firstname . " " . $lastname;
    $this->firstname = $firstname;
    $this->lastname = $lastname;
    $this->email = $email;
    $this->dob = $dob;
    $this->admin = $admin;
    $this->membertype = $membertype;
    $this->blockbooker = $blockbooker;

    $this->coach = (strpos(strtoupper($privs), "C01") !== FALSE);
    $this->eventeditor = (strpos(strtoupper($privs), "E01") !== FALSE);
  }

  function getPerson($memberid) {
    $per = mysql_query("SELECT m.*, mt.type_name ".
                       "FROM member m, member_type mt ".
                       "WHERE m.member_type = mt.member_type ".
                       "AND m.memberid='$memberid'");
    if ($row = mysql_fetch_array($per)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $mt = new Tuple($member_type, $type_name);

      $bb = FALSE;
      if ($block_booker == 1) $bb = TRUE;

      return new Person($memberid,$first_name,$last_name,$email_address,$dob,$admin,$mt,$bb,$privs);
    }

    return new Person($memberid, "Unknown", "User", "", "", 0, "Z", 0);
  }

  function toHtmlString($showID=false) {
    $rval = parent::toHtmlString($showID);

    $mt = $this->getMembershipType();

    $rval = $this->membertype->getDesc() . " member " . $rval;

    return $rval;
  }

  function getBookingsDescription() {
    $bookDesc = "";
    if (!$this->admin) {
      $bookDesc = "my ";
    }
    return $bookDesc . "bookings";
  }

  function getClass() {
    $mtype = "";

    if (gettype($this->membertype) == "object") {
      $mtype = $this->membertype->getID();
    } else {
      $mtype = $this->membertype;
    }

    $rval = "member_type_" . strtolower($mtype);

    return $rval;
  }
}
?>