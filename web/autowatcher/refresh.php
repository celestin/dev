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
         "variant=$variant&keywords=$keywords&min_pr=$min_pr&max_pr=$max_pr&mileage=$mileage&".
         "agerange=$agerange&postcode=$postcode&miles=$miles&max_records=50&".
         "source=$source&sort=3&ukcarsearch_full=SEARCH";
}

if (!$url) {
  Msg::error("Something wrong with your search");
  exit();
}

$fp = fopen($url, "r") or die("OPEN");

$echoon = false;
$buffer = "";
$entire = "";
$photos = "";

function f_detag($entire, $tag) {
  $after = 0;

  while ($p = strpos($entire, "<$tag", $after)) {
    $after = $p+strlen($tag)+1;
    $nextchr = substr($entire, $after, 1);

    if ($nextchr == " " || $nextchr == ">") {
      if ($p2 = strpos($entire, ">", $p)) {
        $beforelen = strlen($entire);
        $entire = substr($entire, 0, $p) . substr($entire, $p2+1, strlen($entire));
        $after -= ($beforelen - strlen($entire));
      } else {
        $beforelen = strlen($entire);
        $entire = substr($entire, 0, $p);
        $after -= ($beforelen - strlen($entire));
      }
    }
  }

  return $entire;
}

function f_full_detag($entire, $tag) {
  while ($p = strpos($entire, "<$tag")) {
    if ($p2 = strpos($entire, ">", $p)) {
      if ($p3 = strpos($entire, "</$tag>", $p2)) {
        $entire = substr($entire, 0, $p) .
        substr($entire, $p2+1, $p3-$p2-1).
        substr($entire, $p3+strlen($tag)+3, strlen($entire));
      } else {
        $entire = substr($entire, 0, $p);
      }
    } else {
      $entire = substr($entire, 0, $p);
    }
  }

  return $entire;
}

while (!feof($fp)) {
   $buffer = fgets($fp, 4096);

   if (strpos($buffer, 'Narrow your search')) {
    $echoon = !$echoon;
   }
   if (strpos($buffer, 'Your search results')) {
    $echoon = true;
   }



   if ($echoon) {
     $entire .= $buffer ;
   }
}
fclose($fp) or die("CLOSE");

if (!strpos($entire, ' Sorry no matches found.')) {

  $p=strpos($entire, 'javascript:more_info');
  $entire = substr($entire, $p+20, strlen($entire));
  $keepgoing=true;
  $i=0;

  while ($keepgoing) {

    $keepgoing=false;

    if ($p2=strpos($entire, '">')) {
      $p5=strlen($entire);

      if ($p3=strpos($entire, 'javascript:more_info', $p2)) {
        $p5=$p3;
        $keepgoing=true;
      } else if ($p3=strpos($entire, '&nbsp;Displaying', $p2)) {
        $p5=$p3;
        $keepgoing=false;
      }

      $thisad = substr($entire, $p2+2, $p5-$p2-2);

      $entire = substr($entire, $p5+20, strlen($entire));

      $p=$p3;

      if (strpos($thisad, "images/common/approved") ||
          strpos($thisad, "dealerlogo.autotrader.co.uk")) {
        continue;
      }

      $thisad = f_detag($thisad, "a");
      $thisad = f_detag($thisad, "b");
      $thisad = f_detag($thisad, "table");
      $thisad = f_detag($thisad, "img");
      $thisad = f_detag($thisad, "font");
      $thisad = f_detag($thisad, "/font");
      $thisad = f_detag($thisad, "tr");
      $thisad = f_detag($thisad, "td");
      $thisad = f_detag($thisad, "/td");
      $thisad = f_detag($thisad, "/tr");
      $thisad = f_detag($thisad, "/table");

      $thisad = f_full_detag($thisad, "script");

      $thisad = str_replace("&nbsp;", " ", $thisad);
      $thisad = str_replace("</b>", "", $thisad);
      $thisad = str_replace("</a>", "<br>", $thisad);

      for ($i=0; $i<10; $i++) {
        $thisad = str_replace(". .", ".", $thisad);
        $thisad = str_replace("..", ".", $thisad);
        $thisad = str_replace(",.", ".", $thisad);
        $thisad = str_replace(" .", ".", $thisad);
      }

      if (strpos($entire, '*multi-photos')) {
        $photos='multiphotos';
        $thisad = str_replace("*multi-photos", "", $thisad);
      }

      $type='trade';

      if (strpos($entire, '(trade)')) {
        $type='trade';
        $thisad = str_replace("(trade)", "", $thisad);
      }

      if (strpos($entire, '(private)')) {
        $type='private';
        $thisad = str_replace("(private)", "", $thisad);
      }

      $lines = explode("<br>", $thisad);

      if (count($lines) == 4) {
        for ($i=0; $i<4; $i++) {
          $lines[$i] = trim($lines[$i]);

          if (substr($lines[$i], strlen($lines[$i])-1, 1) == ',') {
            $lines[$i] = substr($lines[$i], 0, strlen($lines[$i])-1);
          }
        }

        $lines[2] = str_replace("£", "", $lines[2]);
        $lines[3] = str_replace("miles", "", $lines[3]);


        //CARS_popup.asp?id=200541209983417&channel=CARS&&adcategory=CARS

        echo "<b>$lines[0] - $lines[2] ($lines[3] miles)</b>\n";
        echo "<p>$lines[1] ($type/$photos)</p>\n";
      }
    }
  }
}

include 'tpl/bot.php';
?>
