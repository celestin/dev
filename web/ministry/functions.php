<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Functions
 * Copyright (c) 2006 Southesk.com
 *
 * $Log: /web/cc/db.php $
 *
 * Who  When         Why
 * CAM  15-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

function f_neat_truncate($text, $backpoint) {
  $rval = $text;

  $midp = strlen($rval)*0.254;
  if (($backpoint > 0) && (($atpos = strpos($rval, " ")) !== FALSE) && $atpos < $midp) {
    $rval = trim(substr($rval, $atpos+1, strlen($rval)));
  }

  $midp = strlen($rval)*0.75;
  if ((substr($rval, strlen($rval)-1, 1) !== ".") &&
      (($atpos = strrpos($rval, " ")) !== FALSE) &&
      ($atpos > $midp)) {
    $rval = trim(substr($rval, 0, $atpos));
  }

  return $rval;
}

function f_url($a,$v,$b,$c,$s) {
  global $stext, $uauthor, $uvol, $upage, $upara,
         $ubookid, $uchapter, $uvstart, $bookname, $singlechap;

  $rval = "";

  if (!empty($stext))           $rval .= "&text=$stext";
  if ($a && !empty($uauthor))   $rval .= "&author=$uauthor";
  if ($v && !empty($uvol))      $rval .= "&vol=$uvol";
  if ($b && !empty($ubookid))   $rval .= "&bookid=$ubookid";
  if ($c && !empty($uchapter))  $rval .= "&chapter=$uchapter";

  return $rval;
}

function remove_inits($text, $inits) {
  if (substr($text, 0, strlen($inits)) == $inits) {
    $text = trim(substr($text, strlen($inits), strlen($text)));
  }
  return $text;
}

function highlight_text($text, $inits, $stext, $ref='') {
  $bold = true;

  $text = remove_inits($text, $inits);
  $text = remove_inits($text, 'Ques.');
  $text = remove_inits($text, 'Rem.');
  $text = str_replace('@', '', $text);

  if (!empty($stext)) {
    if (($atpos = strpos(strtolower($text), strtolower($stext))) === FALSE) {
      $atpos = 0;
      $bold = false;
    }
    $backpoint = max(0, $atpos-60);
    $backtrail = $atpos-$backpoint;
    $headtrail = 60;

    $booklen = strlen($stext);
    $backs = substr($text, $backpoint, $backtrail);
    $heads = substr($text, $atpos+$booklen, $headtrail-$booklen);
    $rtext = substr($text, $atpos, $booklen);

    $hi_text = $backs;
    if ($bold) {
      $hi_text .= "<b>$rtext</b>";
    } else {
      $hi_text .= "$rtext";
    }
    $hi_text .= $heads;
    $hi_text = trim($hi_text);

    return f_neat_truncate($hi_text, $backpoint);

  } else if (!empty($ref)) {
    $atpos = -1;
    $nextpos = $prevpos = 0;
    for ($curr = 0; $curr < $ref; $curr++) {
      $prevpos = $atpos;
      $atpos = strpos($text, "@", $atpos+1);
    }
    if (($nextpos = strpos($text, "@", $atpos+1)) === FALSE) {
      $nextpos = strlen($text);
    }

    $backpoint = max(0, max($prevpos+1, $atpos-60));
    $backtrail = $atpos-$backpoint;
    $headtrail = min(60, ($nextpos-$atpos)-1);

    $booklen = strlen($bookname);
    $backs = substr($text, $backpoint, ($atpos-$backpoint));
    $heads = substr($text, $atpos+$booklen+1, $headtrail-$booklen);

    $text = trim("$backs<b>$bookname</b>$heads");

    return f_neat_truncate($text, $backpoint);
  }
}

function f_url_ref($a,$v,$pg,$pa) {
  return "&raut=$a&rvol=$v&rpag=$pg&rpar=$pa";
}

function f_show_books() {
  global $stext, $uauthor, $uvol, $ubookid, $uchapter, $uvstart, $bookname, $singlechap;
  $prevtest = "";

  $sql = "SELECT DISTINCT b.testament, r.bookid, b.bookname ".
         "FROM mse_bible_ref r, mse_bible_book b ".
         "WHERE r.bookid = b.bookid ";

  if (!empty($uauthor)) {
    $sql .= "AND r.author = '$uauthor' ";
  }
  if (!empty($uvol)) {
    $sql .= "AND r.vol = $uvol ";
  }
  $sql .= "ORDER BY 1 DESC,2";

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($testament <> $prevtest) {
      if ($prevtest <> "") {
?>
</td></tr>
<?
      }
?>
<tr><td><b><? echo $testament; ?></b></td><td>
<?
      $prevtest = $testament;
    }
?>
<a href="scripture.php?level=4&bookid=<? echo $bookid . f_url(true,true,false,false,false); ?>"><? echo str_replace(" ", "&nbsp;", $bookname); ?></a>&nbsp;
<?
  }
}

function f_show_chapters() {
  global $stext, $uauthor, $uvol, $ubookid, $uchapter, $uvstart, $bookname, $singlechap;
  $sql = "SELECT DISTINCT chapter ".
         "FROM mse_bible_ref ".
         "WHERE bookid = $ubookid ";
  if (!empty($uauthor)) {
    $sql .= "AND author = '$uauthor' ";
  }
  if (!empty($uvol)) {
    $sql .= "AND vol = $uvol ";
  }
  $sql .= "ORDER BY chapter";
?>
<tr><td><a href="index.php?level=5">Books</a>&nbsp;|&nbsp;<? echo "$bookname"; ?></td></tr><tr><td>Chapters
<?

  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
<a href="index.php?level=6&chapter=<? echo $chapter . f_url(true,true,true,false,false); ?>"><? echo $chapter; ?></a>&nbsp;
<?
  }
}

function f_show_verses() {
  global $stext, $uauthor, $uvol, $ubookid, $uchapter, $uvstart, $bookname, $singlechap;

  $sql = "SELECT DISTINCT vstart ".
         "FROM mse_bible_ref ".
         "WHERE bookid = $ubookid ";

  if (!$singlechap) {
    $sql .= "AND chapter = $uchapter ";
  }

  if (!empty($uauthor)) {
    $sql .= "AND author = '$uauthor' ";
  }
  if (!empty($uvol)) {
    $sql .= "AND vol = $uvol ";
  }

  $sql .= "ORDER BY vstart";

  //echo "<pre>$sql</pre>";
?>
<tr><td><a href="index.php?level=7<? echo f_url(true,true,false,false,false); ?>">Books</a>&nbsp;|
<a href="index.php?level=8&bookid=<? echo $ubookid . f_url(true,true,false,false,false); ?>"><? echo "$bookname"; ?></a>&nbsp;|
Chapter <? echo $uchapter; ?></td></tr><tr><td>Verses
<?
  $ssql = mysql_query($sql);
  while ($row = mysql_fetch_array($ssql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
<a href="index.php?level=9&vstart=<? echo $vstart . f_url(true,true,true,true,false); ?>"><? echo ($vstart==0) ? "All" : $vstart; ?></a>&nbsp;
<?
  }
}

function f_show_scripture_table() {
  global $stext, $uauthor, $uvol, $ubookid, $uchapter, $uvstart, $bookname, $singlechap;
?>
<table border=1 cellpadding=2 cellspacing=0>
<tr>
  <th>Verses</th>
  <th>Servant</th>
  <th>Vol.</th>
  <th>Page</th>
  <th>Para</th>
  <th>Text</th>
</tr>
<?
  $maxrows = 200;

  $sql = "SELECT r.ref, r.vstart, r.vend, t.author, t.vol, t.page, t.para, t.text, b.bookname ".
         "FROM mse_bible_ref r, mse_text t, mse_bible_book b ".
         "WHERE r.author = t.author ".
         "AND r.vol = t.vol ".
         "AND r.page = t.page ".
         "AND r.para = t.para ".
         "AND r.bookid = b.bookid ".
         "AND r.bookid = $ubookid ";

  if ($singlechap != 1) $sql .= "AND r.chapter = $uchapter ";

  if (!empty($uauthor)) {
    $sql .= "AND r.author = '$uauthor' ";
  }
  if (!empty($uvol)) {
    $sql .= "AND r.vol = $uvol ";
  }

  if (!empty($uvstart)) {
    $sql .= "AND r.vstart = $uvstart ";
  } else {
    $maxrows = 20;
  }

  $sql .= "ORDER BY chapter, vstart, t.author, t.vol, t.page, t.para";
//echo "<pre>$sql</pre>";
  $currrow=0;

  $ssql = mysql_query($sql);
  while (($row = mysql_fetch_array($ssql)) && ($currrow++ < $maxrows)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $verses = "&nbsp;";
    if ($vstart > 0) $verses = $vstart;
    if ($vend == ($vstart+1)) {
      $verses .= ", $vend";
    } else if ($vend > 0) {
      $verses .= " - $vend";
    }

    $atpos = -1;
    $nextpos = $prevpos = 0;
    for ($curr = 0; $curr < $ref; $curr++) {
      $prevpos = $atpos;
      $atpos = strpos($text, "@", $atpos+1);
    }
    if (($nextpos = strpos($text, "@", $atpos+1)) === FALSE) {
      $nextpos = strlen($text);
    }

    $backpoint = max(0, max($prevpos+1, $atpos-60));
    $backtrail = $atpos-$backpoint;
    $headtrail = min(60, ($nextpos-$atpos)-1);

    $booklen = strlen($bookname);
    $backs = substr($text, $backpoint, ($atpos-$backpoint));
    $heads = substr($text, $atpos+$booklen+1, $headtrail-$booklen);

    $text = trim("$backs<b>$bookname</b>$heads");

    $text = f_neat_truncate($text, $backpoint);

?>
<tr><td><?echo $verses;?></td><td><?echo $author;?></td><td><b><?echo $vol;?></b></td><td><a href="vol.php?<?echo "author=$author&vol=$vol&page=$page";?>"><?echo $page;?></a></td><td><?echo $para;?></td><td class="dt"><?echo $text;?></td></tr>
<?
  }
?>
</table>
<?
}

function f_show_table() {
  global $stext, $sql_text, $uauthor, $uvol, $ubookid, $uchapter, $uvstart, $bookname, $singlechap;
?>
<table border=1 cellpadding=2 cellspacing=0>
<tr>
  <th>Servant</th>
  <th>Vol.</th>
  <th>Page</th>
  <th>Para</th>
  <th>More</th>
  <th>Text</th>
</tr>
<?
  $maxrows = 200;

  $sql = "SELECT author, vol, page, para, text ".
         "FROM mse_text t ".
         "WHERE text LIKE '%$sql_text%' ";

  if (!empty($uauthor)) {
    $sql .= "AND author = '$uauthor' ";
  }
  if (!empty($uvol)) {
    $sql .= "AND vol = $uvol ";
  }

  $sql .= "ORDER BY author, vol, page, para";
//echo "<pre>$sql</pre>";
  $currrow=0;

  $ssql = mysql_query($sql);
  while (($row = mysql_fetch_array($ssql)) && ($currrow++ < $maxrows)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if (($atpos = strpos(strtolower($text), strtolower($stext))) === FALSE) {
      $atpos = 0;
    }
    $jim = "<b>$atpos</b>";

    $backpoint = max(0, $atpos-60);
    $backtrail = $atpos-$backpoint;
    $headtrail = 60;

    $booklen = strlen($stext);
    $backs = substr($text, $backpoint, $backtrail);
    $heads = substr($text, $atpos+$booklen, $headtrail-$booklen);
    $rtext = substr($text, $atpos, $booklen);

    $hi_text = trim("$backs<b>$rtext</b>$heads");
    $hi_text = f_neat_truncate($hi_text, $backpoint);
    //$hi_text = trim($atpos+$booklen." : $jim : $backs<b>$stext</b>$heads<br>".$text);

?>
<tr><td><?echo $author;?></td><td><b><?echo $vol;?></b></td><td><?echo $page;?></td><td><?echo $para;?></td>
<td align=center><a href="index.php?level=10&section=1<? echo f_url(true,true,true,true,true) . f_url_ref($author, $vol, $page, $para); ?>"><img
  alt="Paragraph" border=0 src="pa.png"></a>&nbsp;<a href="index.php?level=10&section=1<? echo f_url(true,true,true,true,true); ?>"><img
  alt="Whole Page" border=0 src="pg.png"></a></td>
<td class="dt"><?echo $hi_text;?></td></tr>
<?
  }
?>
</table>
<?
}


function f_show_single_section() {
  global $stext, $sql_text, $uauthor, $uvol, $ubookid, $uchapter, $uvstart, $bookname, $singlechap,
         $raut, $rvol, $rpag, $rpar;
?>
<table border=1 cellpadding=2 cellspacing=0>
<?
  $maxrows = 200;

  $sql = "SELECT author, vol, page, para, text ".
         "FROM mse_text t ".
         "WHERE author = '$raut' ".
         "AND vol = $rvol ";

  if (!empty($rpag)) {
    $sql .= "AND page = $rpag ";
  }
  if (!empty($rpar)) {
    $sql .= "AND para = $rpar ";
  }

  $sql .= "ORDER BY author, vol, page, para";
echo "<pre>$sql</pre>";
  $currrow=0;

  $ssql = mysql_query($sql);
  while (($row = mysql_fetch_array($ssql)) && ($currrow++ < $maxrows)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if (($atpos = strpos(strtolower($text), strtolower($stext))) === FALSE) {
      $atpos = 0;
    }
    $jim = "<b>$atpos</b>";

    $hi_text = $text;
?>

<tr>
  <td>Servant</td><td><?echo $author;?></td>
<tr></tr>
  <td>Vol.</td><td><b><?echo $vol;?></b></td>
<tr></tr>
  <td>Page</td><td><?echo $page;?></td>
<tr></tr>
  <td>Para</td><td><?echo $para;?></td>
<tr></tr>
  <td>More</td><td align=center><a href="index.php?level=11&section=1<? echo f_url(true,true,true,true,true); ?>"><img
  alt="Paragraph" border=0 src="pa.png"></a>&nbsp;<a href="index.php?level=11&section=1<? echo f_url(true,true,true,true,true); ?>"><img
  alt="Whole Page" border=0 src="pg.png"></a></td>
<tr></tr>
  <td>Text</td><td><?echo $hi_text;?></td>
</tr>

<?
  }
?>
</table>
<?
}
