<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TC Munro
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EmailMsg - Sends an Email
 *
 * $Id: EmailMsg.php 80 2006-05-11 00:05:34Z craig $
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

/**
* EmailMsg information.
*
* @author Craig McKay
* @version 2005
* @public
*/
class EmailMsg {

  var $personname;
  var $personaddress1;
  var $personaddress2;
  var $personaddress3;
  var $personpostcode;
  var $personphone;
  var $personfax;
  var $personemail;
  var $bro_robinsons;
  var $bro_dovetail;
  var $bro_simplicity;
  var $bro_ffawt;
  var $bro_elite;
  var $bro_malvern;
  var $bro_alton;
  var $bro_robcomm;
  var $bro_roblrg;
  var $bro_summerhouses;
  var $bro_playhouses;
  var $bro_sheds;
  var $chk_sitevisit;
  var $chk_aluminium;
  var $chk_timber;
  var $chk_leanto;
  var $chk_accessories;
  var $build_size;
  var $build_accessories;

  /**
  * Originator Member
  * @private
  * @type Person
  */
  var $memPerson;

  function EmailMsg($personname, $personaddress1, $personaddress2, $personaddress3,
                    $personpostcode, $personphone, $personfax, $personemail,
                    $bro_robinsons, $bro_dovetail, $bro_simplicity, $bro_ffawt, $bro_elite, $bro_malvern,
                    $bro_alton, $bro_robcomm, $bro_roblrg, $bro_summerhouses, $bro_playhouses, $bro_sheds,
                    $chk_sitevisit, $chk_aluminium, $chk_timber, $chk_leanto, $chk_accessories, $build_size, $build_accessories) {

    $this->personname =           $personname;
    $this->personaddress1 =       $personaddress1;
    $this->personaddress2 =       $personaddress2;
    $this->personaddress3 =       $personaddress3;
    $this->personpostcode =       $personpostcode;
    $this->personphone =          $personphone;
    $this->personfax =            $personfax;
    $this->personemail =          $personemail;
    $this->bro_robinsons =        $bro_robinsons;
    $this->bro_dovetail =         $bro_dovetail;
    $this->bro_simplicity =       $bro_simplicity;
    $this->bro_ffawt =            $bro_ffawt;
    $this->bro_elite =            $bro_elite;
    $this->bro_malvern =          $bro_malvern;
    $this->bro_alton =            $bro_alton;
    $this->bro_robcomm =          $bro_robcomm;
    $this->bro_roblrg =           $bro_roblrg;
    $this->bro_summerhouses =     $bro_summerhouses;
    $this->bro_playhouses =       $bro_playhouses;
    $this->bro_sheds =            $bro_sheds;
    $this->chk_sitevisit =        $chk_sitevisit;
    $this->chk_aluminium =        $chk_aluminium;
    $this->chk_timber =           $chk_timber;
    $this->chk_leanto =           $chk_leanto;
    $this->chk_accessories =      $chk_accessories;
    $this->build_size =           $build_size;
    $this->build_accessories =    $build_accessories;
  }

  function getHeaders($cc='') {
    global $cfg;

    $cr = "\r\n";
    $headers = "From: " . $cfg['Site']['Name'] . "<" . $cfg['Site']['Email'] . ">$cr";
    if (!empty($cc)) $headers .= "Cc: $cc$cr";
    $headers .= "Bcc: craig@frontburner.co.uk$cr";
    $headers .= "MIME-Version: 1.0$cr";
    $headers .= "X-Priority: 1$cr";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1$cr";
    return $headers;
  }

  function getHTMLStart($subject) {
    global $cfg;

    $cr = "\r\n";
    return "<html><head>".
          "<link href=" . $cfg['Site']['URL'] . "/main.css rel=stylesheet type=text/css>".
          "</head><body>".
          "<table cellspacing=0 cellpadding=0 border=0 width=\"100%\">".
            "<tr><td valign=center align=center><table cellspacing=5 cellpadding=0 border=0>".
              "<tr>".
                "<td colspan=2 align=center><b>$subject</b></td>$cr$cr".
              "</tr><tr>".
                "<td><table width=\"100%\" border=0 cellpadding=2>";
  }

  function getHTMLEnd() {
    $cr = "\r\n";
    return "</table></td>".
        "</tr></table>".
      "</td></tr>".
    "</table>$cr".
    "</body></html>$cr";
  }

  function sendRequest() {
    global $cfg;

    $to = $cfg['Site']['Email'];
    $subject = "Contact Request";
    $cr = "\r\n";

    $message = $this->getHTMLStart($subject) .
      "<tr><td class=fld>Name                        </td><td>" . $this->personname . "</td></tr>$cr$cr".
      "<tr><td class=fld>Address 1                   </td><td>" . $this->personaddress1 . "</td></tr>$cr$cr".
      "<tr><td class=fld>Address 2                   </td><td>" . $this->personaddress2 . "</td></tr>$cr$cr".
      "<tr><td class=fld>Address 3                   </td><td>" . $this->personaddress3 . "</td></tr>$cr$cr".
      "<tr><td class=fld>Postcode                    </td><td>" . $this->personpostcode . "</td></tr>$cr$cr".
      "<tr><td class=fld>Phone                       </td><td>" . $this->personphone . "</td></tr>$cr$cr".
      "<tr><td class=fld>Fax                         </td><td>" . $this->personfax . "</td></tr>$cr$cr".
      "<tr><td class=fld>Email                       </td><td>" . $this->personemail . "</td></tr>$cr$cr";

    if (!empty($this->bro_robinsons))       $message .= "<tr><td colspan=2>I would like a brochure for Robinsons Greenhouses</td></tr>$cr$cr";
    if (!empty($this->bro_dovetail))        $message .= "<tr><td colspan=2>I would like a brochure for Dovetail Greenhouses</td></tr>$cr$cr";
    if (!empty($this->bro_simplicity))      $message .= "<tr><td colspan=2>I would like a brochure for Simplicity Greenhouses</td></tr>$cr$cr";
    if (!empty($this->bro_ffawt))           $message .= "<tr><td colspan=2>I would like a brochure for Fawt Greenhouses</td></tr>$cr$cr";
    if (!empty($this->bro_elite))           $message .= "<tr><td colspan=2>I would like a brochure for Elite Greenhouses</td></tr>$cr$cr";
    if (!empty($this->bro_malvern))         $message .= "<tr><td colspan=2>I would like a brochure for Malvern Greenhouses</td></tr>$cr$cr";
    if (!empty($this->bro_alton))           $message .= "<tr><td colspan=2>I would like a brochure for Alton Greenhouses</td></tr>$cr$cr";
    if (!empty($this->bro_robcomm))         $message .= "<tr><td colspan=2>I would like a brochure for Robinsons Commercial Glasshouses</td></tr>$cr$cr";
    if (!empty($this->bro_roblrg))          $message .= "<tr><td colspan=2>I would like a brochure for Robinsons Large Lean-to and Feature Greenhouses</td></tr>$cr$cr";
    if (!empty($this->bro_summerhouses))    $message .= "<tr><td colspan=2>I would like a brochure for Summerhouses</td></tr>$cr$cr";
    if (!empty($this->bro_playhouses))      $message .= "<tr><td colspan=2>I would like a brochure for Playhouses</td></tr>$cr$cr";
    if (!empty($this->bro_sheds))           $message .= "<tr><td colspan=2>I would like a brochure for Sheds</td></tr>$cr$cr";

    if (!empty($this->chk_sitevisit))       $message .= "<tr><td colspan=2>I would like a FREE, No-obligation Site Vist to discuss my requirements and offer advice.</td></tr>$cr$cr";
    if (!empty($this->chk_aluminium))       $message .= "<tr><td colspan=2>I am interested in Aluminium.</td></tr>$cr$cr";
    if (!empty($this->chk_timber))          $message .= "<tr><td colspan=2>I am interested in Timber.</td></tr>$cr$cr";
    if (!empty($this->chk_leanto))          $message .= "<tr><td colspan=2>I am interested in Lean-to.</td></tr>$cr$cr";
    if (!empty($this->chk_accessories))     $message .= "<tr><td colspan=2>I am interested in the following accessories:</td></tr>$cr$cr".
                                                        "<tr><td colspan=2>" . $this->build_accessories . "</td></tr>$cr$cr";

    $message .= "<tr><td class=fld>Approximate Size            </td><td>" . $this->build_size . "</td></tr>$cr$cr".
    $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders($this->personemail));
  }
}
?>