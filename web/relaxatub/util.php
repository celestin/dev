<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Utilities
 *
 * $Id: activate.php 84 2006-05-11 18:55:49Z craig $
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

function getTub($tub,$series) {
  if (!empty($tub)) return $tub;

  $sql = "SELECT tub FROM tub ".
         "WHERE disabled=0 ";
  if (!empty($series)) {
    $sql .= "AND series = $series ";
  }
  $sql .= "ORDER BY tub";

  $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

  if ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
    return $tub;
  }

  return '';
}

function getSeries($tub) {
  $sql = "SELECT s.series,s.seriesName FROM tub t, series s WHERE t.series = s.series AND t.tub = '$tub'";
  $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');
  if ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
    return new Tuple($series, $seriesName);
  }
  return new Tuple();
}
?>