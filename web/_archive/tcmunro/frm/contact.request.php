<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TC Munro
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Contact Us context
 *
 * $Id: contactus.php 342 2006-11-25 09:55:36Z craig $
 *
 * Who  When         Why
 * CAM  10-Oct-2006  File added to svn.
 * * * * * * * * * * * * * * * * * * * * * * * */

global $personname, $personaddress1, $personaddress2, $personaddress3,
       $personpostcode, $personphone, $personfax, $personemail,
       $bro_robinsons, $bro_dovetail, $bro_simplicity, $bro_ffawt, $bro_elite, $bro_malvern,
       $bro_alton, $bro_robcomm, $bro_roblrg, $bro_summerhouses, $bro_playhouses, $bro_sheds,
       $chk_sitevisit, $chk_aluminium, $chk_timber, $chk_leanto, $chk_accessories, $build_size, $build_accessories;

?>

<form enctype="multipart/form-data" action="contactus.php" method="POST">
  <input type="hidden" name="MAX_FILE_SIZE" value="300000" />

  <table width="100%" border="0" cellpadding="5" cellspacing="8">
    <tr>
      <td valign="top"><img src="images/pic11.jpg" width="100" height="106" align="top"></td>
      <td bgcolor="#CCCCCC">
        <table width="472" border="0">
          <tr>
            <td width="353" align="center"><span class="szrzbLabel3"><strong>Contact Us</strong></span></td>
            <td width="43">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td align="center">For FREE brochure fill in form below:</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>

<tr><td class="<? f_mand($personname); ?>">Name</td><td><input name="personname" size="40" value="<? echo $personname; ?>" /></td></tr>
<tr><td class="fld">Address</td><td><input name="personaddress1" size="50" value="<? echo $personaddress1; ?>" /></td></tr>
<tr><td class="fld">&nbsp;</td><td><input name="personaddress2" size="50" value="<? echo $personaddress2; ?>" /></td></tr>
<tr><td class="fld">&nbsp;</td><td><input name="personaddress3" size="50" value="<? echo $personaddress3; ?>" /></td></tr>
<tr><td class="fld">Postcode</td><td><input name="personpostcode" size="10" value="<? echo $personpostcode; ?>" /></td></tr>

<tr><td class="<? f_mand($personphone); ?>">Tel</td><td><input name="personphone" size="20" value="<? echo $personphone; ?>" /></td></tr>
<tr><td class="fld">Fax</td><td><input name="personfax" size="20" value="<? echo $personfax; ?>" /></td></tr>
<tr><td class="fld">Email</td><td><input name="personemail" size="40" value="<? echo $personemail; ?>" /></td></tr>

        <tr>
          <td colspan="2"><strong>I would like a FREE Brochure on the following:</strong></td>
          </tr>
        <tr>
          <td align="right"><input name="bro_robinsons" type="checkbox" value="Y"></td><td>Robinsons Greenhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_dovetail" type="checkbox" value="Y"></td><td>Dovetail Greenhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_simplicity" type="checkbox" value="Y"></td><td>Simplicity Greenhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_ffawt" type="checkbox" value="Y"></td><td>Fawt Greenhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_elite" type="checkbox" value="Y"></td><td>Elite Greenhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_malvern" type="checkbox" value="Y"></td><td>Malvern Greenhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_alton" type="checkbox" value="Y"></td><td>Alton Greenhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_robcomm" type="checkbox" value="Y"></td><td>Robinsons Commercial Glasshouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_roblrg" type="checkbox" value="Y"></td><td>Robinsons Large Lean-to and Feature Greenhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_summerhouses" type="checkbox" value="Y"></td><td>Summerhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_playhouses" type="checkbox" value="Y"></td><td>Playhouses</td>
        </tr>
        <tr>
          <td align="right"><input name="bro_sheds" type="checkbox" value="Y"></td><td>Sheds</td>
        </tr>
        <tr>
          <td align="right"><input name="chk_sitevisit" type="checkbox" value="Y"></td><td>I would like a FREE, No-obligation Site Vist to discuss my requirements and offer advice</td>
        </tr>
        <tr>
          <td colspan="2"><strong>I am interested in:</strong></td>
          </tr>
        <tr>
          <td align="right"><input name="chk_aluminium" type="checkbox" value="Y"></td><td>Aluminium</td>
        </tr>
        <tr>
          <td align="right"><input name="chk_timber" type="checkbox" value="Y"></td><td>Timber</td>
        </tr>
        <tr>
          <td align="right"><input name="chk_leanto" type="checkbox" value="Y"></td><td>Lean-to</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>Approximate size
            <input name="build_size" type="text"></td>
        </tr>
        <tr>
          <td align="right"><input name="chk_accessories" type="checkbox" value="Y"></td>
          <td>Accessories only (eg Staging) &ndash; specify<br>
            <textarea name="build_accessories" cols="50" rows="3" ></textarea></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td align="center" valign="middle"><input type="hidden" name="retry" value="Y"><input type="submit" value="Submit"></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr valign="top">
          <td><span class="sgxclass0">Write&nbsp;to&nbsp;us&nbsp;at:</span><span name="szrzbLabel7" class="sgxelmForm1szrzbname">&nbsp; </span></td>
          <td colspan="2"><p><span name="szrzbLabel7" class="sgxelmForm1szrzbname">T.C. Munro,</span><span name="szrzbLabel7" class="sgxelmForm1szrzbname">The Hall, George Street, Falkirk, FK2 7EY </span></p></td>
        </tr>
        <tr>
          <td><span class="sgxclass0">Telephone&nbsp;us&nbsp;on:</span><span name="szrzbLabel12" class="sgxelmForm1szrzbname"></span></td>
          <td><span name="szrzbLabel12" class="sgxelmForm1szrzbname">0800 38 99 361 </span></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><span name="szrzbLabel14" class="sgxelmForm1szrzbname">07771 688300</span></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td colspan="3"><div align="center"><span class="szrzbLabel17" name="szrzbLabel17"><strong>Thank you for your enquiry</strong></span></div></td>
        </tr>
      </table>
      </form></td>
    <td valign="top"><img src="images/pic10.jpg" width="99" height="100" align="top"></td>
  </tr>
</table>
