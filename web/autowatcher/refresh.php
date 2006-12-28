<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Login to the system (including first-time)
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  30-Sep-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Refresh Search";
include_once 'Main.php';
include 'tpl/top.php';

function page_with_results($url, $page) {
  $url .= "&page=$page";
  $fp = fopen($url, "r") or die("OPEN");
  $entire = "";

  while (!feof($fp)) {
     $buffer = fgets($fp, 4096);
     $entire .= $buffer ;
  }
  fclose($fp) or die("CLOSE");

  return (strpos($entire, 'javascript:more_info')>0);
}

function id_exists($id) {
  global $member, $search;

  $ssql = "SELECT count(*) FROM autosearchresults ".
          "WHERE atid = '$id' ".
          "AND memberid = '" . $member->getID() ."' ".
          "AND asid = '$search' ";

  $sql = mysql_query($ssql);
  while ($row = mysql_fetch_array($sql)) {
    return ($row[0] == 1);
  }
}

function retrieve_page($url, $page) {
  global $member, $search;

  $url .= "&page=$page";

  $reccount=0;

  $fp = fopen($url, "r") or die("OPEN");

  $echoon = false;
  $buffer = "";
  $entire = "";
  $photos = "";

  while (!feof($fp)) {
     $buffer = fgets($fp, 4096);
     $entire .= $buffer ;
  }
  fclose($fp) or die("CLOSE");

  $p4=0;
  $id="";
  $textBegin = "title=\"View full advert details\">";
  $typeBegin = "<span class=\"senaryFontColour\">";

  $p=strpos($entire, 'javascript:more_info');
  if ($p>0) {
    $entire = substr($entire, $p+21, strlen($entire));
    $keepgoing=true;
    $i=0;
  } else {
    $keepgoing=false;
  }

  while ($keepgoing) {

    $reccount++;
    $keepgoing=false;

    if ($p2=strpos($entire, 'bottomMargin5')) {
      $p4 = strpos($entire, '</strong>', $p2);  // end of bottomMargin5 - distance from user
      $p5=strlen($entire);

      if ($p3=strpos($entire, 'javascript:more_info', $p2)) {
        $p5=$p3;
        $keepgoing=true;
      }

      $thisad = substr($entire, 0, $p4-$p3+1);
      $entire = substr($entire, $p5+21, strlen($entire));

      $p=$p3;

      $c1 = strpos($thisad, ',');  // comma - end of id
      $id=substr($thisad, 0, $c1);

      if (id_exists($id)) {
        continue;
      }

      $c2 = strpos($thisad, 'asAdTextContainer', $c1);          // find the start of the HEADER div
      $c3 = strpos($thisad, $textBegin, $c2);                   // hone in on the text of HEADER

      $c4 = strpos($thisad, $typeBegin, $c3);                   // find the end of HEADER and beginning of TYPE
      $c5 = strpos($thisad, "</span>", $c4);                    // find the end of TYPE

      $itemheader = trim(substr($thisad, $c3+strlen($textBegin), ($c4-strlen($textBegin))-$c3));
      $itemtype   = trim(substr($thisad, $c4+strlen($typeBegin), ($c5-strlen($typeBegin))-$c4));

      $c6 = strpos($thisad, 'asAdListContainer', $c5);          // find the beginning of ATTRIBUTES
      $c7 = strpos($thisad, '<ul>', $c6);                       // hone in on the start ATTRIBUTES
      $c8 = strpos($thisad, '</ul>', $c7);                      // find the end of ATTRIBUTES

      $itemattributes = trim(substr($thisad, $c7, ($c8-$c7+5)));

      // Next remove the unordered list tags
      $itemattributes = str_replace("<ul>", "", $itemattributes);
      $itemattributes = str_replace("<\ul>", "", $itemattributes);
      $itemattributes = trim($itemattributes);
      // Now separate the attributes
      $itemattr = explode("<li>", $itemattributes);
      $ia = "";
      foreach ($itemattr as $xx) {
        if (!empty($xx)) $ia .= "<u>$xx</u>&nbsp;";
      }


      $c9 = strpos($thisad, 'asAdContentContainer', $c8);       // find the start of ITEMTEXT
      $c10 = strpos($thisad, '<p>', $c9);                       // hone in on the start ITEMTEXT
      $c11 = strpos($thisad, '</p>', $c10);                     // find the end of ITEMTEXT
      $itemtext = trim(substr($thisad, $c10+3, ($c11-$c10)-7));

      $c12 = strpos($thisad, 'asAdvertRight2', $c11);           // find the start of ITEMPRICE
      $c13 = strpos($thisad, '<strong>', $c12);                 // hone in on the start ITEMPRICE
      $c13+=8;
      $c14 = strpos($thisad, '</strong>', $c13);                // find the end of ITEMPRICE
      $itemprice = trim(substr($thisad, $c13, ($c14-$c13)));

      $c15 = strpos($thisad, 'bottomMargin5', $c14);           // find the start of ITEMDISTANCE
      $c16 = strpos($thisad, '<strong>', $c15);                 // hone in on the start ITEMDISTANCE
      $c16+=8;
      $c17 = strpos($thisad, '</strong>', $c16);                // find the end of ITEMDISTANCE
      $itemdistance = trim(substr($thisad, $c16, ($c17-$c16)));

      //echo "<p>$id<br>$itemheader<br><b>$itemtype</b>$ia<br>&quot;$itemtext&quot;<br>$itemprice<br>$itemdistance</p>\n";

      $itemtext = str_replace("'", "\'", $itemtext);

      $ssql = "INSERT INTO autosearchresults (".
                "atid,memberid,asid,".
                "itemheader,itemtype,itemattributes,itemtext,itemprice,itemdistance".
              ") VALUES (".
                "'$id','" . $member->getID() ."','$search',".
                "'$itemheader','$itemtype','$ia','$itemtext','$itemprice','$itemdistance'".
              ")";
      echo "<p>$ssql</p>";
      $sql = mysql_query($ssql);
    }
  }

  return $reccount;
}

$search = NULL; if (!empty($_GET['search'])) $search = $_GET['search'];

$sql = "SELECT make, model, variant, keywords, min_pr, max_pr, mileage, agerange, postcode, miles, source ".
       "FROM autosearch WHERE memberid = '". $member->getId() . "' AND id = '$search'";
$res = mysql_query($sql) or die (mysql_error());


$url = NULL;

if ($row = mysql_fetch_array($res)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  $postcode = str_replace(" ", "+", $postcode);
  $variant = str_replace(" ", "+", $variant);
  $keywords = str_replace(" ", "+", $keywords);

  $url = "http://atsearch.autotrader.co.uk/WWW/cars_search.asp?modelexact=1&".
         "lid=search_used_cars_full&make=$make&model=$model&".
         "trim=$variant&keywords=$keywords&min_pr=$min_pr&max_pr=$max_pr&mileage=$mileage&".
         "agerange=$agerange&postcode=$postcode&miles=$miles&".
         "source=$source&sort=3&ukcarsearch_full=SEARCH";
}

if (!$url) {
  Msg::error("Something wrong with your search");
  exit();
}

/*
$pageno=0;
while (page_with_results($url, $pageno)) {
  $pageno++;
  echo "<h3>$pageno</h3>";
}
exit();
*/

$pageno=0;
$cars = retrieve_page($url, $pageno);
while ($cars>0) {
  $pageno++;
  echo "<h3>$pageno : cars found $cars</h3>";
  $cars = retrieve_page($url, $pageno);
}

include 'tpl/bot.php';
?>
