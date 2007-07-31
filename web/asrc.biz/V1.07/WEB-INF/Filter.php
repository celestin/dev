<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Filter Class
 *
 * $Id: Block.php 41 2006-05-04 22:31:06Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2006  10021 : File added.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'inc.php';

/**
* Filter for User Administration
*
* @author Craig McKay
* @version 2006
* @public
*/
class Filter {

  var $filter_id;
  var $filter_parent;
  var $filter_fname;
  var $filter_lname;
  var $filter_type;

  var $filter;

  function Filter($filter_id, $filter_parent, $filter_fname, $filter_lname, $filter_type) {
    $this->filter_id = $filter_id;
    $this->filter_parent = $filter_parent;
    $this->filter_fname = $filter_fname;
    $this->filter_lname = $filter_lname;
    $this->filter_type = $filter_type;

    $this->filter = "";

    $this->add('memberid', $this->filter_id);
    $this->add('parent', $this->filter_parent);
    $this->add('first_name', $this->filter_fname);
    $this->add('last_name', $this->filter_lname);
    $this->add('member_type', $this->filter_type);
  }

  function isFiltered() {
    if (!empty($this->filter_id)) return true;
    if (!empty($this->filter_parent)) return true;
    if (!empty($this->filter_fname)) return true;
    if (!empty($this->filter_lname)) return true;
    if (!empty($this->filter_type)) return true;
    return false;
  }

  function getFilter() {
    return $this->filter;
  }

  function add($column, $value) {
    if (!empty($value)) {
      if (empty($this->filter)) {
        $this->filter = "WHERE ";
      } else {
        $this->filter .= " AND ";
      }

      $value = trim($value);

      if ($value == "!") {
        $this->filter .= "($column IS NULL OR TRIM($column) = '') ";
      } else {
        if ($column == "member_type") {
          $this->filter .= "$column = '$value' ";
        } else {
          $this->filter .= "$column LIKE '%$value%' ";
        }
      }
    }
  }
}
?>