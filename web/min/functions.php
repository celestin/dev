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
  $rval = str_replace("@", "", $text);

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
  if ($pg != FALSE)             $rval .= "&page=$pg";
  if ($pa != FALSE)             $rval .= "&prgh=$pa";
  if ($b && !empty($ubookid))   $rval .= "&bookid=$ubookid";
  if ($c && !empty($uchapter))  $rval .= "&chapter=$uchapter";

  return $rval;
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
<a href="index.php?level=4&bookid=<? echo $bookid . f_url(true,true,false,false,false); ?>"><? echo $bookname; ?></a>&nbsp;
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
<tr><td><a href="index.php?level=5<? echo f_url(false,false,false,false,false); ?>">Books</a>&nbsp;|&nbsp;<? echo "$bookname"; ?></td></tr><tr><td>Chapters
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

function f_show_results_table() {
  global $stext, $sql_text, $uauthor, $uvol, $ubookid, $uchapter, $uvstart, $bookname, $singlechap;
?>
<table border=1 cellpadding=2 cellspacing=0 width="650">
<tr>
  <th>Ch:Vs</th>
  <th>Servant</th>
  <th>Vol.</th>
  <th>Page</th>
  <th>Para</th>
  <th>Text</th>
</tr>
<?
  $maxrows = 200;

  if (!empty($ubookid)) {
    $sql = "SELECT r.ref, r.chapter, r.vstart, r.vend, t.author, t.vol, t.page, t.para, t.text, b.bookname \n".
           "FROM mse_text t, mse_bible_ref r, mse_bible_book b \n".
           "WHERE r.author = t.author \n".
           "AND r.vol = t.vol \n".
           "AND r.page = t.page \n".
           "AND r.para = t.para \n".
           "AND r.bookid = b.bookid \n".
           "AND r.bookid = '$ubookid' \n";
  } else {
    $sql = "SELECT NULL ref, NULL chapter, NULL vstart, NULL vend, t.author, t.vol, t.page, t.para, t.text, NULL bookname \n".
           "FROM mse_text t \n".
           "WHERE 1=1 \n";
  }

  if (!empty($uchapter) && ($singlechap != 1)) {
    $sql .= "AND r.chapter = '$uchapter' \n";
  }

  if (!empty($uauthor)) {
    $sql .= "AND r.author = '$uauthor' \n";
  }
  if (!empty($uvol)) {
    $sql .= "AND r.vol = $uvol \n";
  }

  if (!empty($uvstart)) {
    $sql .= "AND r.vstart = $uvstart \n";
  } else {
    $maxrows = 20;
  }

  if (!empty($sql_text)) {
    $sql .= "AND t.text LIKE '%$sql_text%' \n";
  }

  $sql .= "ORDER BY ";
  if (!empty($ubookid)) {
    $sql .= "chapter, vstart, ";
  }
  $sql .= "t.author, t.vol, t.page, t.para\n";

echo "<pre>$sql</pre>";
  $currrow=0;

  $ssql = mysql_query($sql);
  while (($row = mysql_fetch_array($ssql)) && ($currrow++ < $maxrows)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $verses = "&nbsp;";
    if (!empty($chapter))$verses = "<b>$chapter</b>";
    if ($vstart > 0) $verses .= ":$vstart";
    if ($vend == ($vstart+1)) {
      $verses .= ", $vend";
    } else if ($vend > 0) {
      $verses .= " - $vend";
    }

    if (!empty($stext)) {
      if (($atpos = strpos(strtolower($text), strtolower($stext))) === FALSE) {
        $atpos = 0;
      }
      $backpoint = max(0, $atpos-60);
      $backtrail = $atpos-$backpoint;
      $headtrail = 60;

      $booklen = strlen($stext);
      $backs = substr($text, $backpoint, $backtrail);
      $heads = substr($text, $atpos+$booklen, $headtrail-$booklen);
      $rtext = substr($text, $atpos, $booklen);

      $hi_text = trim("$backs<b>$rtext</b>$heads");
      $text = f_neat_truncate($hi_text, $backpoint);

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

      $text = f_neat_truncate($text, $backpoint);
    }

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
<table border=1 cellpadding=2 cellspacing=0 width="650">
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
