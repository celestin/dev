<?php
/**
* @version $Id: bible_search.php,v 1.34 2004/09/25 18:43:54 saka Exp $
* @package Mambo_4.5.1
* @copyright (C) 2000 - 2004 Miro International Pty Ltd
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* Mambo is Free Software
*/

/** ensure this file is being included by a parent file */
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );

// load the html drawing class
$mainframe->setPageTitle(_BIBLESEARCH_TITLE);

if ( !isset( $op ) ) {
  $op = '';
}

//Load Vars
$con_id = intval( mosGetParam( $_REQUEST ,'con_id', 0 ) );
$bible_search_id = intval( mosGetParam( $_REQUEST ,'bible_search_id', 0 ) );
$catid = intval( mosGetParam( $_REQUEST ,'catid', 0 ) );

switch( $task ) {
  default:
    bible_searchpage( $option, $bible_search_id );
    break;
}

switch( $op ) {
  case 'sendmail':
    sendmail( $con_id, $option );
    break;
}


function bible_searchpage( $option, $bible_search_id ) {
  global $mainframe, $database, $my, $Itemid;
?>
<TABLE border=0 cellPadding=8 cellSpacing=0>
  <TBODY>
  <TR align=left vAlign=middle>
    <TD class=componentheading>Passage Lookup</TD>
    <TD rowSpan=3></TD>
    <TD  class=componentheading>Word Search</TD></TR>
  <TR valign=middle>
    <TD align=left height=210 vAlign=top width=320>
      <FORM action="http://bible.gospelcom.net/cgi-bin/bible" method=get><INPUT name=passage size=22>&nbsp;<INPUT type=submit value=Lookup class=button><INPUT type=reset value=Reset class=button><BR><FONT
      color=#000000 face="Arial, Helvetica, sans-serif" size=-2>Example: Psalm
      100:1-5 ; John 3</FONT><BR><BR>
      <INPUT name=DARBY_version type=checkbox CHECKED value=yes>
      <SPAN class=VersionButtons>Darby Translation</SPAN><BR>
      <INPUT name=KJV_version type=checkbox value=yes>
      <SPAN class=VersionButtons>King James Version</SPAN><BR>
      <INPUT name=YLT_version type=checkbox value=yes>
      <SPAN class=VersionButtons>Young's Literal Translation</SPAN><BR>

      <INPUT name=showfn type=hidden value=yes>
      <INPUT name=showxref type=hidden value=yes>

      <INPUT name=language type=hidden value=english></FORM></TD>
    <TD align=left rowSpan=2>
      <FORM action="http://bible.gospelcom.net/cgi-bin/bible" method=get><INPUT name=search size=22>&nbsp;<INPUT type=submit value=Search class=button><INPUT type=reset value=Reset class=button><BR><FONT
      color=#000000 face="Arial, Helvetica, sans-serif" size=-2>Example: love
      Jesus</FONT><BR>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN
      class=SearchTypeDropdown><SELECT name=SearchType><OPTION selected
        value=AND>Matches ALL words<OPTION value=OR>Matches ANY word<OPTION
        value=EXACT>Exact phrase<OPTION value=FULL_TEXT>Approximate
        phrase<OPTION value=COUNT>Count Verses with these words</OPTION></SELECT>
      </SPAN><BR><BR>

      <INPUT name=version1 type=radio CHECKED value=16>
      <SPAN class=VersionButtons>Darby Translation</SPAN><BR>
      <INPUT name=version1 type=radio value=9>
      <SPAN class=VersionButtons>King James Version</SPAN><BR>
      <INPUT name=version1 type=radio value=45>
      <SPAN class=VersionButtons>Amplified Bible</SPAN><BR><BR>

      <SPAN class=SearchControls>
      <INPUT name=SearchWholeWords type=checkbox value=yes>Find whole words only<BR>
      <INPUT name=SearchAsLink type=checkbox value=yes>Display results as references only<BR><BR>
      Restrict search to<BR><SELECT
      name=restrict><OPTION selected><OPTION
        value=Books_of_Moses>Books of Moses<OPTION value=Gospels>Gospels<OPTION
        value=New_Testament>New Testament<OPTION
        value=Old_Testament>Old Testament<OPTION
        value=Major_Prophets>Major Prophets<OPTION
        value=Minor_Prophets>Minor Prophets<OPTION
        value=Wisdom_Books>Wisdom Books<OPTION
        value=OT_Historical_Books>OT Historical Books<OPTION
        value=Epistles>Epistles<OPTION
        value=Pauline_Epistles>Pauline Epistles<OPTION
        value=Apocalyptic_Books>Apocalyptic Books</OPTION></SELECT><BR>

        Start search at<BR><SELECT name=StartRestrict><OPTION selected><OPTION
        value=GEN>Genesis<OPTION value=EXOD>Exodus<OPTION
        value=LEV>Leviticus<OPTION value=NUM>Numbers<OPTION
        value=DEUT>Deuteronomy<OPTION value=JOSH>Joshua<OPTION
        value=JUDG>Judges<OPTION value=RUTH>Ruth<OPTION value=1SAM>1
        Samuel<OPTION value=2SAM>2 Samuel<OPTION value=1KGS>1 Kings<OPTION
        value=2KGS>2 Kings<OPTION value=1CHRON>1 Chronicles<OPTION
        value=2CHRON>2 Chronicles<OPTION value=EZRA>Ezra<OPTION
        value=NEH>Nehemiah<OPTION value=ESTH>Esther<OPTION value=JOB>Job<OPTION
        value=PS>Psalm<OPTION value=PROV>Proverbs<OPTION
        value=ECC>Ecclesiastes<OPTION value=SONG>Song of Solomon<OPTION
        value=ISA>Isaiah<OPTION value=JER>Jeremiah<OPTION
        value=LAM>Lamentations<OPTION value=EZEK>Ezekiel<OPTION
        value=DAN>Daniel<OPTION value=HOSEA>Hosea<OPTION value=JOEL>Joel<OPTION
        value=AMOS>Amos<OPTION value=OBAD>Obadiah<OPTION
        value=JONAH>Jonah<OPTION value=MICAH>Micah<OPTION
        value=NAHUM>Nahum<OPTION value=HAB>Habakkuk<OPTION
        value=ZEPH>Zephaniah<OPTION value=HAG>Haggai<OPTION
        value=ZECH>Zechariah<OPTION value=MAL>Malachi<OPTION
        value=MATT>Matthew<OPTION value=MARK>Mark<OPTION value=LUKE>Luke<OPTION
        value=JOHN>John<OPTION value=ACTS>Acts<OPTION value=ROM>Romans<OPTION
        value=1COR>1 Corinthians<OPTION value=2COR>2 Corinthians<OPTION
        value=GAL>Galatians<OPTION value=EPH>Ephesians<OPTION
        value=PHIL>Philippians<OPTION value=COL>Colossians<OPTION value=1THES>1
        Thessalonians<OPTION value=2THES>2 Thessalonians<OPTION value=1TIM>1
        Timothy<OPTION value=2TIM>2 Timothy<OPTION value=TIT>Titus<OPTION
        value=PHILEM>Philemon<OPTION value=HEB>Hebrews<OPTION
        value=JAS>James<OPTION value=1PET>1 Peter<OPTION value=2PET>2
        Peter<OPTION value=1JOHN>1 John<OPTION value=2JOHN>2 John<OPTION
        value=3JOHN>3 John<OPTION value=JUDE>Jude<OPTION
        value=REV>Revelation</OPTION></SELECT><BR>

        End search at<BR><SELECT
      name=EndRestrict><OPTION selected><OPTION value=GEN>Genesis<OPTION
        value=EXOD>Exodus<OPTION value=LEV>Leviticus<OPTION
        value=NUM>Numbers<OPTION value=DEUT>Deuteronomy<OPTION
        value=JOSH>Joshua<OPTION value=JUDG>Judges<OPTION value=RUTH>Ruth<OPTION
        value=1SAM>1 Samuel<OPTION value=2SAM>2 Samuel<OPTION value=1KGS>1
        Kings<OPTION value=2KGS>2 Kings<OPTION value=1CHRON>1 Chronicles<OPTION
        value=2CHRON>2 Chronicles<OPTION value=EZRA>Ezra<OPTION
        value=NEH>Nehemiah<OPTION value=ESTH>Esther<OPTION value=JOB>Job<OPTION
        value=PS>Psalm<OPTION value=PROV>Proverbs<OPTION
        value=ECC>Ecclesiastes<OPTION value=SONG>Song of Solomon<OPTION
        value=ISA>Isaiah<OPTION value=JER>Jeremiah<OPTION
        value=LAM>Lamentations<OPTION value=EZEK>Ezekiel<OPTION
        value=DAN>Daniel<OPTION value=HOSEA>Hosea<OPTION value=JOEL>Joel<OPTION
        value=AMOS>Amos<OPTION value=OBAD>Obadiah<OPTION
        value=JONAH>Jonah<OPTION value=MICAH>Micah<OPTION
        value=NAHUM>Nahum<OPTION value=HAB>Habakkuk<OPTION
        value=ZEPH>Zephaniah<OPTION value=HAG>Haggai<OPTION
        value=ZECH>Zechariah<OPTION value=MAL>Malachi<OPTION
        value=MATT>Matthew<OPTION value=MARK>Mark<OPTION value=LUKE>Luke<OPTION
        value=JOHN>John<OPTION value=ACTS>Acts<OPTION value=ROM>Romans<OPTION
        value=1COR>1 Corinthians<OPTION value=2COR>2 Corinthians<OPTION
        value=GAL>Galatians<OPTION value=EPH>Ephesians<OPTION
        value=PHIL>Philippians<OPTION value=COL>Colossians<OPTION value=1THES>1
        Thessalonians<OPTION value=2THES>2 Thessalonians<OPTION value=1TIM>1
        Timothy<OPTION value=2TIM>2 Timothy<OPTION value=TIT>Titus<OPTION
        value=PHILEM>Philemon<OPTION value=HEB>Hebrews<OPTION
        value=JAS>James<OPTION value=1PET>1 Peter<OPTION value=2PET>2
        Peter<OPTION value=1JOHN>1 John<OPTION value=2JOHN>2 John<OPTION
        value=3JOHN>3 John<OPTION value=JUDE>Jude<OPTION
        value=REV>Revelation</OPTION></SELECT></SPAN>
        <INPUT name=language type=hidden value=english><INPUT name=searchpage type=hidden value=0></FORM></TD></TR>
  <TR>
    <TD align=left height=110 vAlign=top>
      <FORM action=/cgi-bin/bible method=get>View a list of the books of the
      Bible<BR><SELECT name=version><OPTION
        value=DARBY>Darby Translation</OPTION></SELECT> <INPUT name=passage type=hidden value=all>
      <INPUT name=language type=hidden value=english><INPUT type=submit value=View class=button></FORM></TD></TR></TBODY>
</TABLE>
<?
}

?>
