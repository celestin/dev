<?php
/**
* @version $Id: hitchcock.html.php,v 1.35 2004/09/26 10:37:23 stingrey Exp $
* @package Mambo_4.5.1
* @copyright (C) 2000 - 2004 Miro International Pty Ltd
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* Mambo is Free Software
*/

/** ensure this file is being included by a parent file */
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );


/**
* @package Mambo_4.5.1
*/
class HTML_hitchcock {

  function viewhitchcock( &$hitchcock, &$params, $count, &$list ) {
    //print_r( $hitchcock );
    global $mosConfig_live_site;
    global $mainframe, $Itemid;
    $template = $mainframe->getTemplate();
    $sitename = $mainframe->getCfg( 'sitename' );
    $hide_js = mosGetParam($_REQUEST,'hide_js', 0 );
    ?>
    <script language="JavaScript" type="text/javascript">
    <!--
    function validate(){
      if ( ( document.emailForm.text.value == "" ) || ( document.emailForm.email.value.search("@") == -1 ) || ( document.emailForm.email.value.search("[.*]" ) == -1 ) ) {
        alert( "<?php echo _CONTACT_FORM_NC; ?>" );
      } else {
      document.emailForm.action = "<?php echo sefRelToAbs("index.php?option=com_hitchcock&Itemid=$Itemid"); ?>"
      document.emailForm.submit();
      }
    }
    //-->
    </script>
    <script type="text/javascript">
    <!--
    function ViewCrossReference( selSelectObject ){
      var links = new Array();
      <?php
      $n = count( $list );
      for ($i = 0; $i < $n; $i++) {
         echo "\nlinks[".$list[$i]->value."]='"
          . sefRelToAbs( 'index.php?option=com_hitchcock&task=view&hitchcock_id='. $list[$i]->value .'&Itemid='. $Itemid )
          . "';";
      }
      ?>

      var sel = selSelectObject.options[selSelectObject.selectedIndex].value
      if (sel != "") {
        location.href = links[sel];
      }
    }
    //-->
    </script>
    <?php
    // For the pop window opened for print preview
    if ( $params->get( 'popup' ) ) {
      ?>
      <title><?php echo $sitename ." :: ". $hitchcock->name; ?></title>
      <link rel="stylesheet" href="<?php echo $mosConfig_live_site ."/templates/". $template ."/css/template_css.css";?>" type="text/css" />
      <?php
    }
    ?>
    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="contentpane<?php echo $params->get( 'pageclass_sfx' ); ?>">
    <?php
    // displays Page Title
    HTML_hitchcock::_writePageTitle( $params );
  }


  /**
  * Writes Page Title
  */
  function _writePageTitle( &$params ) {
    if ( $params->get( 'page_title' )  && !$params->get( 'popup' ) ) {
      ?>
      <tr>
        <td class="componentheading<?php echo $params->get( 'pageclass_sfx' ); ?>" colspan="2">
        <?php echo $params->get( 'header' ); ?>
        </td>
      </tr>
      <?php
    }
  }


  /**
  * Writes Email form
  */
  function _writeEmailForm( &$hitchcock, &$params, $sitename ) {
    if ( $hitchcock->email_to && !$params->get( 'popup' ) && $params->get( 'email_form' ) ) {
      ?>

<TABLE border=0 cellPadding=8 cellSpacing=0 width=650>
  <TBODY>
  <TR align=left vAlign=middle>
    <TD align=center height=30 vAlign=center width=290><FONT
      color=#660000 face="Arial, Helvetica, sans-serif"
      size=+2><B>Passage Lookup</B></FONT></TD>
    <TD colSpan=2 align=center><FONT color=#660000 face="Arial, Helvetica, sans-serif"
      size=+2><B>Word Search</B></FONT></TD></TR>
  <TR valign=middle>
    <TD align=left bgColor=#ffcc66 height=210 vAlign=top width=320><BR>
      <FORM action="http://bible.gospelcom.net/cgi-bin/bible" method=get><INPUT name=passage size=22><INPUT type=submit value=Lookup><INPUT type=reset value=Reset><BR><FONT
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
    <TD align=left bgColor=#3299cc rowSpan=2 width=320>
      <FORM action="http://bible.gospelcom.net/cgi-bin/bible" method=get><INPUT name=search size=22><INPUT type=submit value=Search><INPUT type=reset value=Reset><BR><FONT
      color=#000000 face="Arial, Helvetica, sans-serif" size=-2>Example: love
      Jesus</FONT><BR>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN
      class=SearchTypeDropdown><SELECT name=SearchType><OPTION selected
        value=AND>Matches ALL words<OPTION value=OR>Matches ANY word<OPTION
        value=EXACT>Exact phrase<OPTION value=FULL_TEXT>Approximate
        phrase<OPTION value=COUNT>Count Verses with these words</OPTION></SELECT>
      </SPAN><BR><BR>

      <INPUT name=version type=radio CHECKED value=DARBY>
      <SPAN class=VersionButtons>Darby Translation</SPAN><BR>
      <INPUT name=version type=radio value=KJV>
      <SPAN class=VersionButtons>King James Version</SPAN><BR>
      <INPUT name=version type=radio value=YLT>
      <SPAN class=VersionButtons>Young's Literal Translation</SPAN><BR><BR>

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
    <TD align=left bgColor=#ffcc66 height=110 vAlign=top width=250>
      <FORM action=/cgi-bin/bible method=get>View a list of the books of the
      Bible<BR><SELECT name=version><OPTION selected value=NIV-IBS>New
        International Version<OPTION value=NASB>New American Standard
        Bible<OPTION value=NLT>New Living Translation<OPTION value=KJV>King
        James Version<OPTION value=NKJV>New King James Version<OPTION
        value=AMP>Amplified Bible<OPTION value=RSV>Revised Standard
        Version<OPTION value=KJ21>21st Century King James Version<OPTION
        value=NIV>NIV (verse by verse)<OPTION value=WE>Worldwide English (New
        Testament)<OPTION value=YLT>Young's Literal Translation<OPTION
        value=DARBY>Darby Translation<OPTION value=ASV>American Standard
        Version</OPTION></SELECT> <INPUT name=passage type=hidden value=all>
      <INPUT name=language type=hidden value=english> <INPUT type=submit value=View></FORM></TD></TR></TBODY>
</TABLE>

      <?php
    } else {
      echo '&nbsp;';
    }
  }


  function nohitchcock( &$params ) {
    ?>
    <br /><br />
    <?php echo _CONTACT_NONE;?>
    <br /><br />
    <?php
    // displays back button
    mosHTML::BackButton ( $params );
  }
}
?>
