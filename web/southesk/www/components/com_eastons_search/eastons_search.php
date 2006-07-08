<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Southesk.com
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Easton's Bible Dictionary Search View
 *
 * $Id: hymn_search.php 176 2006-07-02 17:21:02Z craig $
 *
 * Who  When         Why
 * CAM  02-Jul-2006  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

/** Ensure this file is being included by a parent file */
defined('_VALID_MOS') or die('Direct Access to this location is not allowed.');

$mainframe->setPageTitle(_EASTONS_TITLE);

if (!isset($op)) {
  $op = '';
}

//Load Vars
$con_id = intval(mosGetParam($_REQUEST ,'con_id', 0));
$eastons_search_id = intval(mosGetParam($_REQUEST ,'eastons_search_id', 0));
$catid = intval(mosGetParam($_REQUEST ,'catid', 0));

switch ($task) {
  default:
    eastons_searchpage($option, $eastons_search_id);
    break;
}

switch ($op) {
  case 'search':
    search_eastons($con_id, $option);
    break;
}


function eastons_searchpage($option, $eastons_search_id) {
  global $mainframe, $database, $my, $Itemid;

  $word = trim(mosGetParam($_POST, 'word', ''));
  $meaning = trim(mosGetParam($_POST, 'meaning', ''));

  stylesheet();

?>
  <form action="<?php echo sefRelToAbs('index.php?option='.$option.'&amp;Itemid='.$Itemid); ?>" method="post" name="searchForm" target="_top" id="searchForm">
  <table border=0>

    <tr>
      <td><?php echo(_EASTONS_WORD);?></td>
      <td><?php echo(_EASTONS_MEANING);?></td>
    </tr>

    <tr>
      <td><input type="text" name="word" size="40" class="inputbox" value="<?php echo $word;?>" /></td>
      <td><input type="text" name="meaning" size="40" class="inputbox" value="<?php echo $meaning;?>" /></td>
    </tr>

  </tr><tr>
    <td colspan=2><input type="submit" name="eastons_search" value="<?php echo(_EASTONS_GO);?>" class="button" />
    </tr>
  </table>
  <input type="hidden" name="sitename" value="<?php echo $sitename; ?>" />
  <input type="hidden" name="op" value="search" />
  </form>

<?
}

function stylesheet() {
?>
<style type="text/css">
.error {
  font-size:13px;
  color:#1269A0;
}
.dropdown {
  font-size:13px;
  background:#F0F0F0;
  color:#1269A0;
}
.lines {
  font-family: Georgia, Arial, Helvetica;
  font-size:14px;
}
.verse {
  font-family: Georgia, Arial, Helvetica;
  font-size:24px;
  font-weight:normal;
  vertical-align: top;
}
.chorus {
  font-family: Georgia, Arial, Helvetica;
  font-style:italic;
  color:29166F;
}
.hymn {
  font-size:13px;
  font-weight:bold;
  color:29166F;
}
.meter {
  font-size:12px;
  font-weight:bold;
  text-align: right;
  color:CC0066;
}
.author {
  font-size:12px;
  font-weight:bold;
  text-align: right;
}
.searchType {
  font-size:10px;
  font-weight:bold;
  color:#FFFFFF;
  background:#D20466;
  padding:4px;
  text-align: left;
}
</style>
<?
}

function nbsp($value) {
  if ($value == "") {
    return "&nbsp;";
  }

  return $value;
}

function describe_search($searchType) {
?>
  <div class="searchType"><? echo $searchType; ?></div>
<?
}


function search_eastons($con_id, $option) {
  global $database;

  $word = trim(mosGetParam($_POST, 'word', ''));
  $meaning = trim(mosGetParam($_POST, 'meaning', ''));

  $meaningList = explode(" ", $meaning);

  //stylesheet();

  ?>
  <table border=0 cellspacing=0 cellpadding=1>
  <tr><td valign=top>
  <?

  $whereClause = "";

  $i = 0;
  if ($meaning != "") {
    foreach($meaningList as $mng) {
      if ($mng != "") {
        $whereClause .= "AND l.line LIKE '%".$mng."%' ";
        $i++;
      }
    }
  }

  if ($word != "") {
    $whereClause .= "AND x.name LIKE '%".$word."%' ";
  }


  echo "\n<!-- $whereClause -->\n";

  echo '<table border=0 cellspacing=0 cellpadding=2>';
  echo '<tr><th>Word</th><th>Meaning</th></tr>';
  $wordSql = "SELECT x.name,l.line,l.para FROM easton_lex x, easton_lines l WHERE l.lex_id=x.id $whereClause ORDER BY x.name,l.para";
  //echo "<pre>$wordSql</pre>";
  $database->setQuery($wordSql);
  $defns = $database->loadObjectlist();

  foreach ($defns as $def) {
    echo '<tr>';
    if ($prevname != $def->name) {
      echo '<td valign=top><b>'.$def->name.'</b><br></td>';
    } else {
      echo '<td>&nbsp;</td>';
    }
    echo '<td>'.$def->line.'</td></tr>';
    $prevname = $def->name;
  }


  ?>
  </td></tr>
  </table>
  <?

}
