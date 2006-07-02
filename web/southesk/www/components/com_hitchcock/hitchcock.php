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

  $nametext = trim(mosGetParam($_POST, 'keywords', ''));
  $namemeaning = trim(mosGetParam($_POST, 'namemeaning', ''));

?>
  <form action="<?php echo sefRelToAbs('index.php?option='.$option.'&amp;Itemid='.$Itemid); ?>" method="post" name="searchForm" target="_top" id="searchForm">
  <table border=0>

    <tr>
      <td><?php echo(_HITCHCOCK_NAME);?></td>
      <td><?php echo(_HITCHCOCK_MEANING);?></td>
    </tr>

    <tr>
      <td><input type="nametext" name="nametext" size="40" class="inputbox" value="<?php echo $nametext;?>" /></td>
      <td><input type="namemeaning" name="namemeaning" size="40" class="inputbox" value="<?php echo $namemeaning;?>" /></td>
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

  $nametext = trim(mosGetParam($_POST, 'nametext', ''));
  $namemeaning = trim(mosGetParam($_POST, 'namemeaning', ''));

  $keywordsList = explode(" ", $namemeaning);

  //stylesheet();

  ?>
  <table border=0 cellspacing=0 cellpadding=1>
  <tr><td valign=top>
  <?

  $whereClause = "";

  $i = 0;
  if ($namemeaning != "") {
    foreach($keywordsList as $keyword) {
      if ($keyword != "") {
        if (empty($whereClause)) {
          $whereClause = "WHERE ";
        } else {
          $whereClause .= "AND ";
        }

        $whereClause .= "defn like '%".$keyword."%' ";
        $i++;
      }
    }
  }

  if ($nametext != "") {
    if (empty($whereClause)) {
      $whereClause = "WHERE ";
    } else {
      $whereClause .= "AND ";
    }
    $whereClause .= " word LIKE '%".$nametext."%' ";
  }


  echo "\n<!-- $whereClause -->\n";

  echo '<table border=0 cellspacing=0 cellpadding=2>';
  echo '<tr><th>Word</th><th>Meaning</th></tr>';
  $wordSql = "SELECT * FROM lex $whereClause";
  $database->setQuery($wordSql);
  $defns = $database->loadObjectlist();

  foreach ($defns as $def) {
    echo '<tr><td valign=top><b>'.$def->word.'</b><br></td>';
    echo '<td>'.$def->defn.'</td></tr>';
  }


  ?>
  </td></tr>
  </table>
  <?

}

?>
