<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TC Munro
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Contact Us context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Oct-2006  File added to svn.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Contact Us";
$toroot = "";
include $toroot ."tpl/top.php";
?>
        <td><!-- InstanceBeginEditable name="Content" -->
          <table width="100%"  border="0" cellpadding="5" cellspacing="8">
            <tr>
              <td valign="top"><img src="images/pic11.jpg" width="100" height="106" align="top"></td>
              <td bgcolor="#CCCCCC"><form name="form1" method="post" action="http://www.tcmunro.co.uk/formmail2/FormMail.pl">
                <table width="472" border="0">
                  <tr>
                    <td width="62"><input name="recipient" type="hidden" value="info@tcmunro.co.uk">
                        <input name="subject" type="hidden" id="subject2" value="Brochure Request">
                        <input name="redirect" type="hidden" id="redirect2" value="http://www.tcmunro.co.uk/"></td>
                    <td width="353" align="center"><span class="szrzbLabel3" id="szrzbLabel5" name="szrzbLabel5"><strong>Contact Us</strong></span></td>
                    <td width="43">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td align="center">For FREE brochure fill in form below:</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span id="szrzbLabel6" name="szrzbLabel6" class="szrzbLabel3">Name</span></td>
                    <td><input name="realname" type="text" id="realname" size="50" maxlength="50"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span id="szrzbLabel8" name="szrzbLabel8" class="szrzbLabel8">Address</span></td>
                    <td><input name="address1" type="text" id="address1" size="50"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><input name="address2" type="text" id="address2" size="50"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><input name="address3" type="text" id="address3" size="50"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span id="szrzbLabel16" name="szrzbLabel16" class="szrzbLabel3">Postcode</span></td>
                    <td><input name="postcode" type="text" id="postcode" size="10"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span id="szrzbLabel11" name="szrzbLabel11" class="szrzbLabel8">Tel. No.</span></td>
                    <td><input name="phone" type="text" id="phone" size="20"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span id="szrzbLabel13" name="szrzbLabel13" class="szrzbLabel8">Fax</span></td>
                    <td><input name="fax" type="text" id="fax" size="20"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span id="szrzbLabel15" name="szrzbLabel15" class="szrzbLabel8">e-mail</span></td>
                    <td><input name="email" type="text" id="email" size="40"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                      <td colspan="2">&nbsp;</td>
                      <td rowspan="21">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2"><strong>I would like a FREE Brochure on the following:</strong></td>
                    </tr>
                  <tr>
                    <td><input name="Robinsons" type="checkbox" id="Robinsons" value="Y"></td>
                    <td>Robinsons Greenhouses</td>
                  </tr>
                  <tr>
                    <td><input name="Dovetail" type="checkbox" id="Dovetail" value="y"></td>
                    <td>Dovetail Greenhouses</td>
                  </tr>
                  <tr>
                    <td><input name="Simplicity" type="checkbox" id="Simplicity" value="Y"></td>
                    <td>Simplicity Greenhouses</td>
                  </tr>
                  <tr>
                    <td><input name="fFawt" type="checkbox" id="fFawt" value="Y"></td>
                    <td>Fawt Greenhouses</td>
                  </tr>
                  <tr>
                    <td><input name="Elite" type="checkbox" id="Elite" value="Y"></td>
                    <td>Elite Greenhouses</td>
                  </tr>
                  <tr>
                    <td><input name="Malvern" type="checkbox" id="Malvern" value="Y"></td>
                    <td>Malvern Greenhouses</td>
                  </tr>
                  <tr>
                    <td><input name="Alton" type="checkbox" id="Alton" value="Y"></td>
                    <td>Alton Greenhouses</td>
                  </tr>
                  <tr>
                    <td><input name="RobComm" type="checkbox" id="RobComm" value="Y"></td>
                    <td>Robinsons Commercial Glasshouses</td>
                  </tr>
                  <tr>
                    <td><input name="RobLrg" type="checkbox" id="RobLrg" value="Y"></td>
                    <td>Robinsons Large Lean-to and Feature Greenhouses</td>
                  </tr>
                  <tr>
                    <td><input name="Summerhouses" type="checkbox" id="Summerhouses" value="Y"></td>
                    <td>Summerhouses</td>
                  </tr>
                  <tr>
                    <td><input name="Playhouses" type="checkbox" id="Playhouses" value="Y"></td>
                    <td>Playhouses</td>
                  </tr>
                  <tr>
                    <td><input name="Sheds" type="checkbox" id="Sheds" value="Y"></td>
                    <td>Sheds </td>
                  </tr>
                  <tr>
                    <td><input name="SiteVisit" type="checkbox" id="SiteVisit" value="Y"></td>
                    <td>I would like a FREE, No-obligation Site Vist to discuss my requirements and offer advice</td>
                  </tr>
                  <tr>
                    <td colspan="2"><strong>I am interested in:</strong></td>
                    </tr>
                  <tr>
                    <td><input name="Aluminium" type="checkbox" id="Aluminium" value="Y"></td>
                    <td>Aluminium</td>
                  </tr>
                  <tr>
                    <td><input name="Timber" type="checkbox" id="Timber" value="Y"></td>
                    <td>Timber</td>
                  </tr>
                  <tr>
                    <td><input name="Lean-to" type="checkbox" id="Lean-to" value="Y"></td>
                    <td>Lean-to</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Approximate size
                      <input name="Size" type="text" id="Size"></td>
                  </tr>
                  <tr>
                    <td><input name="Accessories" type="checkbox" id="Accessories" value="Y"></td>
                    <td>Accessories only (eg Staging) &ndash; specify<br>
                      <textarea name="accessories" cols="50" rows="3" id="accessories"></textarea></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td align="center" valign="middle"><input id="sgxelmForm1Button22" name="sgxelmForm1Button2" class="sgxelmForm1Button2" type="submit" value="Submit" onClick="return _browser.Form1_form_onsubmit();"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr valign="top">
                    <td><span class="sgxclass0">Write to us at:</span><span id="szrzbLabel7" name="szrzbLabel7" class="sgxelmForm1szrzbname">&nbsp; </span></td>
                    <td colspan="2"><p><span id="szrzbLabel7" name="szrzbLabel7" class="sgxelmForm1szrzbname">T.C. Munro,</span><span name="szrzbLabel7" class="sgxelmForm1szrzbname">The Hall, George Street, Falkirk, FK2 7EY </span></p></td>
                  </tr>
                  <tr>
                    <td><span class="sgxclass0">Telephone us on:</span><span id="szrzbLabel12" name="szrzbLabel12" class="sgxelmForm1szrzbname"></span></td>
                    <td><span id="szrzbLabel12" name="szrzbLabel12" class="sgxelmForm1szrzbname">&nbsp;0800 38 99 361 </span></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span id="szrzbLabel14" name="szrzbLabel14" class="sgxelmForm1szrzbname">07771 688300</span></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="3"><div align="center"><span class="szrzbLabel17" id="szrzbLabel17" name="szrzbLabel17"><strong>Thank you for your enquiry</strong></span></div></td>
                  </tr>
                </table>
                </form></td>
              <td valign="top"><img src="images/pic10.jpg" width="99" height="100" align="top"></td>
            </tr>
          </table>
        <!-- InstanceEndEditable --></td>
      </tr>
<?
include $toroot . "tpl/bot.php";
?>
