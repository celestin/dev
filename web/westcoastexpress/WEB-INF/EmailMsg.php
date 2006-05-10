<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EmailMsg - Sends an Email
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

/**
* EmailMsg information.
*
* @author Craig McKay
* @version 2005
* @public
*/
class EmailMsg {

  var $boattype;
  var $boatlength;
  var $boatweight;
  var $boatkeel;
  var $boatloc;
  var $boatdest;
  var $earlydate;
  var $estval;
  var $owntrailer;
  var $comments;
  var $contactemail;
  var $contactname;
  var $contacttel;

  /**
  * Originator Member
  * @private
  * @type Person
  */
  var $memPerson;

  function EmailMsg($boattype, $boatlength, $boatweight, $boatkeel,
                    $boatloc, $boatdest, $earlydate, $estval, $owntrailer, $comments,
                    $contactemail, $contactname, $contacttel) {
  $this->boattype =      $boattype;
  $this->boatlength =    $boatlength;
  $this->boatweight =    $boatweight;
  $this->boatkeel =      $boatkeel;
  $this->boatloc =       $boatloc;
  $this->boatdest =      $boatdest;
  $this->earlydate =     $earlydate;
  $this->estval =        $estval;
  $this->owntrailer =    $owntrailer;
  $this->comments =      $comments;
  $this->contactemail =  $contactemail;
  $this->contactname =   $contactname;
  $this->contacttel =    $contacttel;

  }

  function getHeaders($cc='') {
    global $cfg;

    $cr = "\r\n";
    $headers = "From: " . $cfg['Site']['Name'] . "<" . $cfg['Site']['Email'] . ">$cr";
    if (!empty($cc)) $headers .= "Cc: $cc$cr";
    $headers .= "MIME-Version: 1.0$cr";
    $headers .= "X-Priority: 1$cr";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1$cr";
    return $headers;
  }

  function getHTMLStart($subject) {
    global $cfg;

    $cr = "\r\n";
    return "<html><head>".
          "<link href=" . $cfg['Site']['Name'] . "/wce.css rel=stylesheet type=text/css>".
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
    $cc = $this->contactemail;
    $subject = "Request for Quotation";
    $cr = "\r\n";

    $message = $this->getHTMLStart($subject) .
      "<tr><td class=fld>Type of Boat</td><td>" . $this->boattype . "</td></tr>$cr$cr".
      "<tr><td class=fld>Length of boat</td><td>" . $this->boatlength . "</td></tr>$cr$cr".
      "<tr><td class=fld>Weight of boat</td><td>" . $this->boatweight . "</td></tr>$cr$cr".
      "<tr><td class=fld>Type of Keel</td><td>" . $this->boatkeel . "</td></tr>$cr$cr".
      "<tr><td class=fld>Location (present position)</td><td>" . $this->boatloc . "</td></tr>$cr$cr".
      "<tr><td class=fld>Destination</td><td>" . $this->boatdest . "</td></tr>$cr$cr".
      "<tr><td class=fld>Ealiest preferred date</td><td>" . $this->earlydate . "</td></tr>$cr$cr".
      "<tr><td class=fld>Estimated value</td><td>" . $this->estval . "</td></tr>$cr$cr".
      "<tr><td class=fld>Own trailer?</td><td>" . $this->owntrailer . "</td></tr>$cr$cr".
      "<tr><td class=fld>Additional comments</td><td>" . $this->comments . "</td></tr>$cr$cr".
      "<tr><td class=fld>Email Address</td><td>" . $this->contactemail . "</td></tr>$cr$cr".
      "<tr><td class=fld>Contact Name</td><td>" . $this->contactname . "</td></tr>$cr$cr".
      "<tr><td class=fld>Contact Tel</td><td>" . $this->contacttel . "</td></tr>$cr$cr".
      $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders($cc));
  }
}
?>