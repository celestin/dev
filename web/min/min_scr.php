<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Database Connectivity
 * Copyright (c) 2005 Southesk.com
 *
 * $Log: /web/cc/db.php $
 *
 * 1     28/12/05 15:43 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

class BibleBook {
  var $bookid;
  var $bookname;
  var $namelen;
  var $singlechap;

  function BibleBook($bookid, $bookname, $singlechap) {
    $this->bookid = $bookid;
    $this->bookname = $bookname;
    $this->namelen = strlen($bookname);

    if ($singlechap == "1") {
      $this->singlechap = TRUE;
    } else {
      $this->singlechap = FALSE;
    }
  }

  function f_matchstart($start) {
    return (strncasecmp($start, $this->bookname, $this->namelen) == 0);
  }
}

class BibleRef {
  var $bookid;
  var $chapter;
  var $vstart;
  var $vend;
  var $cv;
  var $refvalid;
  var $errcode;

  function BibleRef($scripture) {
    $this->bookid = 0;
    $this->chapter = 0;
    $this->vstart = 0;
    $this->vend = 0;
    $this->refvalid = FALSE;

    $this->f_parse_scripture($scripture);
  }

  function f_chop_non_numbers($text) {
    for ($i=strlen($text)-1; $i>=0; $i--) {
      $ouc = ord(substr($text, $i, 1));
      if ($ouc >= 48 && $ouc <= 57) {
        //echo "{found $ouc $text ".substr($text, 0, $i+1)."}<br>";
        return substr($text, 0, $i+1);
      }
    }

    return "";
  }

  function f_parse_scripture($scripture) {
    global $bb, $bbcount;

    $start = $scripture;

    $rem = "";
    for ($j=1; $j<=$bbcount; $j++) {
      if ($bb[$j]->f_matchstart($start)) {
      //if (substr($start, 0, strlen($bb[$j])) === $bb[$j]) {
        $this->bookid = $j;
        $rem = trim(substr($start, $bb[$j]->namelen, 100));

        if (substr($rem, 0, 1) == ".") {
          $rem = trim(substr($rem, 1, 100));
        }
        if (($ap = strpos($rem, ".")) !== FALSE) {
          $rem = substr($rem, 0, $ap);
        }
        if (($ap = strpos($rem, ")")) !== FALSE) {
          $rem = substr($rem, 0, $ap);
        }
        if (($ap = strpos($rem, "(")) !== FALSE) {
          $rem = substr($rem, 0, $ap);
        }
        if (($ap = strpos($rem, "\"")) !== FALSE) {
          $rem = substr($rem, 0, $ap);
        }
        if (($ap = strpos($rem, ";")) !== FALSE) {
          $rem = substr($rem, 0, $ap);
        }

        break;
      }
    }

    $colon = $match = FALSE;
    if (!empty($rem)) {
      //echo $bb[$j]." - $rem<br>";
      $klen=strlen($rem);
      for ($k=0; $k<$klen; $k++) {
        $c = substr($rem, $k, 1);
        $ouc = ord(strtoupper($c));

        if ($c === ":") {
          if ($colon) {
            $match = TRUE;
            break;
          }
          $colon = TRUE;
        } else if ($ouc >= 65 && $ouc <= 97) {
          $match = TRUE;
          break;
        }
      }

      if ($match) {
        $cv = trim(substr($rem, 0, $k));
      } else {
        $cv = trim($rem);
      }

      if ($cv === "") {
        $this->refvalid = TRUE;
        return;
      }

      $cv = $this->f_chop_non_numbers($cv);

      if ($cv === "") {
        $this->refvalid = TRUE;
        return;
      }

      $this->cv = $cv;

      if ($bb[$j]->singlechap) {
        // No chapter reference - look straight at the verses
        if (($chp = strpos($cv, "-")) !== FALSE) {

          $this->vstart = trim(substr($cv, 0, $chp));
          $this->vend   = trim(substr($cv, $chp+1, strlen($cv)));

        } else if (($chp = strpos($cv, ",")) !== FALSE) {

          $this->vstart = trim(substr($cv, 0, $chp));
          $this->vend   = trim(substr($cv, $chp+1, strlen($cv)));

        } else {
          $this->vstart = $cv;
        }

        if (!is_numeric($this->vstart) || !is_numeric($this->vend)) {
          // Non-numerics
          $this->errcode = 'S';
          $this->refvalid = FALSE;
          return;
        }

        $this->refvalid = TRUE;
        return;
      }

      if (($chp = strpos($cv, ":")) !== FALSE) {
        $this->chapter = trim(substr($cv, 0, $chp));
        if (strpos($this->chapter, "-") !== FALSE) {
          // Range before colon is invalid
          $this->errcode = 'L';
          $this->refvalid = FALSE;
          return;
        }
        $vs = trim(substr($cv, $chp+1, strlen($cv)));

        if (($chp = strpos($vs, "-")) !== FALSE) {

          $this->vstart = trim(substr($vs, 0, $chp));
          $this->vend   = trim(substr($vs, $chp+1, strlen($vs)));

        } else if (($chp = strpos($vs, ",")) !== FALSE) {

          $this->vstart = trim(substr($vs, 0, $chp));
          $this->vend   = trim(substr($vs, $chp+1, strlen($vs)));

        } else {
          $this->vstart = $vs;
        }

      } else {
        if (($chp = strpos($cv, "-")) !== FALSE) {
          // Chapter range is invalid
          $this->errcode = 'C';
          $this->refvalid = FALSE;
          return;
        }

        $this->chapter = $this->f_chop_non_numbers(trim($cv));
      }

      if (!is_numeric($this->chapter) || !is_numeric($this->vstart) || !is_numeric($this->vend)) {
        // Non-numerics
        $this->errcode = 'N';
        $this->refvalid = FALSE;
        return;
      }

      $this->refvalid = TRUE;
    }
  }

  function f_errcode() {
    if (empty($this->errcode)) {
      return 'E';
    }

    return $this->errcode;
  }
}
