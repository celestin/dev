<?php
/**
* @version $Id$
* @package Mambo_4.5.1
* @copyright (C) 2000 - 2004 Miro International Pty Ltd
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* Mambo is Free Software
*/

/** ensure this file is being included by a parent file */
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );

// load the html drawing class
$mainframe->setPageTitle(_HITCHCOCK_TITLE);

if ( !isset( $op ) ) {
  $op = '';
}

//Load Vars
$con_id = intval( mosGetParam( $_REQUEST ,'con_id', 0 ) );
$hitchcock_id = intval( mosGetParam( $_REQUEST ,'hitchcock_id', 0 ) );
$catid = intval( mosGetParam( $_REQUEST ,'catid', 0 ) );

switch( $task ) {
  default:
    hitchcockpage( $option, $hitchcock_id );
    break;
}

switch( $op ) {
  case 'search':
    search_min( $con_id, $option );
    break;
}


function hitchcockpage( $option, $hitchcock_id ) {
  global $mainframe, $database, $my, $Itemid;

  $hymn_no = trim(mosGetParam($_POST, 'hymn_no', '' ));
  $keywords = trim(mosGetParam($_POST, 'keywords', ''));

?>
  <form action="<?php echo sefRelToAbs('index.php?option='.$option.'&amp;Itemid='.$Itemid); ?>" method="post" name="searchForm" target="_top" id="searchForm">
  <table border=0>

    <tr>
      <td><?php echo(_HITCHCOCK_NAME);?></td>
      <td><?php echo(_HITCHCOCK_MEANING);?></td>
    </tr>

    <tr>
      <td><input type="text" name="keywords" size="40" class="inputbox" value="<?php echo $keywords;?>" /></td>
      <td><select name="author" id="author" class="contact_email">
        <option value="ALL">All</option>
        <option value="CAC">CAC</option>
        <option value="JT">JT</option>
        <option value="JBS">JBS</option>
        <option value="FER">FER</option>
      </select></td>
    </tr>

    <tr>


    <td colspan=2><input type="submit" name="hymn_search" value="<?php echo(_HITCHCOCK_GO);?>" class="button" /></td>
    </tr>
  </table>
  <input type="hidden" name="sitename" value="<?php echo $sitename; ?>" />
  <input type="hidden" name="op" value="search" />
  </form>
<?
}

function search_min($con_id, $option) {
  global $database;

  $keywords = trim(mosGetParam($_POST, 'keywords', ''));
  $author = trim(mosGetParam($_POST, 'author', ''));

  $keywordsList = explode(" ", $keywords);

  //stylesheet();

  ?>
  <table border=0 cellspacing=0 cellpadding=1>
  <tr><td valign=top>
  <?

  $whereClause = "";

  $i = 0;
  if ($keywords != "") {
    foreach($keywordsList as $keyword) {
      if ($keyword != "") {
        if (empty($whereClause)) {
          $whereClause = "where ";
        } else {
          $whereClause .= "and ";
        }

        $whereClause .= "text like '%".$keyword."%' ";
        $i++;
      }
    }

    if ($author != "ALL") {
      $whereClause = $whereClause . "and author='".$author."' ";
    }
  }

  echo '<table border=0 cellspacing=0 cellpadding=2>';
  echo '<tr><th>Servant</th><th>Text</th></tr>';
  $verseSql = "SELECT * FROM min $whereClause";
  $database->setQuery($verseSql);
  $hymn_lines = $database->loadObjectlist();

  foreach ($hymn_lines as $hline) {
    echo '<tr><td valign=top><b>'.$hline->author.'</b><br>Vol '.$hline->vol.'<br>'.
         $hline->page.' ('.$hline->para.')</td>';
    echo '<td>'.$hline->text.'</td></tr>';
  }


  ?>
  </td></tr>
  </table>
  <?

}

?>
