<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Bible Book
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Oct-2007  10187 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

class BibleBook {

  var $bookId = 0;
  var $bookName = "";
  var $singleChap = false;
  
  function BibleBook($bookid) {
    $sql = "SELECT bookname,singlechap FROM mse_bible_book WHERE bookid = '$bookid' ";
    $ssql = mysql_query($sql);
    if ($row = mysql_fetch_array($ssql)) {
      $this->bookId = $bookid;
      $this->bookName = $row[0];
      $this->singleChap = ($row[1] == 1);
    }
  }
  
  function getBookId() {
    return $this->bookId;
  }  
  function getBookName() {
    return $this->bookName;
  }
  function isSingleChap() {
    return $this->singleChap;
  }
}

?>