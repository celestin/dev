<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Request Quotation Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-May-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Contact Us";
$toroot = "";
include 'tpl/top.php';

$retry = NULL;                if (!empty($_POST['retry'])) $retry = $_POST['retry'];
$personname = NULL;           if (!empty($_POST['personname'])) $personname = $_POST['personname'];
$personaddress1 = NULL;       if (!empty($_POST['personaddress1'])) $personaddress1 = $_POST['personaddress1'];
$personaddress2 = NULL;       if (!empty($_POST['personaddress2'])) $personaddress2 = $_POST['personaddress2'];
$personaddress3 = NULL;       if (!empty($_POST['personaddress3'])) $personaddress3 = $_POST['personaddress3'];
$personpostcode = NULL;       if (!empty($_POST['personpostcode'])) $personpostcode = $_POST['personpostcode'];
$personphone = NULL;          if (!empty($_POST['personphone'])) $personphone = $_POST['personphone'];
$personfax = NULL;            if (!empty($_POST['personfax'])) $personfax = $_POST['personfax'];
$personemail = NULL;          if (!empty($_POST['personemail'])) $personemail = $_POST['personemail'];

$bro_robinsons = NULL;        if (!empty($_POST['bro_robinsons'])) $bro_robinsons = $_POST['bro_robinsons'];
$bro_dovetail = NULL;         if (!empty($_POST['bro_dovetail'])) $bro_dovetail = $_POST['bro_dovetail'];
$bro_simplicity = NULL;       if (!empty($_POST['bro_simplicity'])) $bro_simplicity = $_POST['bro_simplicity'];
$bro_ffawt = NULL;            if (!empty($_POST['bro_ffawt'])) $bro_ffawt = $_POST['bro_ffawt'];
$bro_elite = NULL;            if (!empty($_POST['bro_elite'])) $bro_elite = $_POST['bro_elite'];
$bro_malvern = NULL;          if (!empty($_POST['bro_malvern'])) $bro_malvern = $_POST['bro_malvern'];
$bro_alton = NULL;            if (!empty($_POST['bro_alton'])) $bro_alton = $_POST['bro_alton'];
$bro_robcomm = NULL;          if (!empty($_POST['bro_robcomm'])) $bro_robcomm = $_POST['bro_robcomm'];
$bro_roblrg = NULL;           if (!empty($_POST['bro_roblrg'])) $bro_roblrg = $_POST['bro_roblrg'];
$bro_summerhouses = NULL;     if (!empty($_POST['bro_summerhouses'])) $bro_summerhouses = $_POST['bro_summerhouses'];
$bro_playhouses = NULL;       if (!empty($_POST['bro_playhouses'])) $bro_playhouses = $_POST['bro_playhouses'];
$bro_sheds = NULL;            if (!empty($_POST['bro_sheds'])) $bro_sheds = $_POST['bro_sheds'];

$chk_sitevisit = NULL;        if (!empty($_POST['chk_sitevisit'])) $chk_sitevisit = $_POST['chk_sitevisit'];
$chk_aluminium = NULL;        if (!empty($_POST['chk_aluminium'])) $chk_aluminium = $_POST['chk_aluminium'];
$chk_timber = NULL;           if (!empty($_POST['chk_timber'])) $chk_timber = $_POST['chk_timber'];
$chk_leanto = NULL;           if (!empty($_POST['chk_leanto'])) $chk_leanto = $_POST['chk_leanto'];
$chk_accessories = NULL;      if (!empty($_POST['chk_accessories'])) $chk_accessories = $_POST['chk_accessories'];
$build_size = NULL;           if (!empty($_POST['build_size'])) $build_size = $_POST['build_size'];
$build_accessories = NULL;    if (!empty($_POST['build_accessories'])) $build_accessories = $_POST['build_accessories'];

if (empty($retry)) {
  include 'frm/contact.request.php';
} else if (empty($personname)) {
  Msg::error("Please tell us your name.");
  include 'frm/contact.request.php';
} else if (empty($personphone)) {
  Msg::error("Please give us your telephone number.");
  include 'frm/contact.request.php';
} else {

  Msg::statement("Thank you - we will contact you as soon as we can.");

  $em = new EmailMsg($personname, $personaddress1, $personaddress2, $personaddress3,
                     $personpostcode, $personphone, $personfax, $personemail,
                     $bro_robinsons, $bro_dovetail, $bro_simplicity, $bro_ffawt, $bro_elite, $bro_malvern,
                     $bro_alton, $bro_robcomm, $bro_roblrg, $bro_summerhouses, $bro_playhouses, $bro_sheds,
                     $chk_sitevisit, $chk_aluminium, $chk_timber, $chk_leanto, $chk_accessories, $build_size, $build_accessories);
  $em->sendRequest();

  echo "<br><br><br><br><br><br>";

}

include 'tpl/bot.php';
?>