<?php

header("Content-type: text/xml\n");
//header("Content-type: text/html\n");
header("Content-Transfer-Encoding: ascii");

echo "<?xml version=\"1.0\"?>\n";
echo "<rss version=\"2.0\">\n";
echo "<channel>\n";

$make = "ANY";          if (!empty($_GET['make'])) $make = $_GET['make'];
$model = "ANY";         if (!empty($_GET['model'])) $model = $_GET['model'];
$miles = "40";          if (!empty($_GET['miles'])) $miles = $_GET['miles'];
$postcode = "dd9+6aw";  if (!empty($_GET['postcode'])) $postcode = $_GET['postcode'];
$maxpr = NULL;          if (!empty($_GET['maxpr'])) $maxpr = $_GET['maxpr'];
$variant = NULL;        if (!empty($_GET['variant'])) $variant = $_GET['variant'];
$keywords = NULL;       if (!empty($_GET['keywords'])) $keywords = $_GET['keywords'];

if ($model == "ANY") $maxpr = "50000";

$postcode = str_replace(" ", "+", $postcode);

echo "<title>AutoTrader $make $model</title>";
echo '<description>RSS Feed Copyright 2005-2006 Frontburner, author Craig McKay (craig@frontburner.co.uk) Auto Trader UK - New Cars, Used Cars for sale online, Car Loans, Car Insurance &amp; Car Prices</description>';
echo '<link>http://www.autotrader.co.uk</link>';


$url = "http://atsearch.autotrader.co.uk/WWW/cars_search.asp?modelexact=1&".
       "lid=search_used_cars_full&make=$make&model=$model&".
       "variant=$variant&keywords=$keywords&min_pr=75&max_pr=$maxpr&mileage=&".
       "agerange=&postcode=$postcode&miles=$miles&max_records=50&".
       "source=0&sort=3&ukcarsearch_full=SEARCH";

$fp = fopen($url, "r") or die("OPEN");

$echoon = false;
$buffer = "";
$entire = "";

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

        echo "<item>\n";
        echo "<title>$lines[0] - $lines[2] ($lines[3] miles)</title>\n";
        echo "<description>$lines[1] ($type/$photos)</description>\n";
        echo "</item>\n";
      }
    }
  }
}

?>

</channel>
</rss>
