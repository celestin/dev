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

$mainframe->setPageTitle(_HYMNSEARCH_TITLE);

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
    search_hymns($con_id, $option);
    break;
}


function eastons_searchpage($option, $eastons_search_id) {
  global $mainframe, $database, $my, $Itemid;

  $eastons_no = trim(mosGetParam($_POST, 'eastons_no', ''));
  $keywords = trim(mosGetParam($_POST, 'keywords', ''));
  $author = trim(mosGetParam($_POST, 'author', ''));
  $meter_id = trim(mosGetParam($_POST, 'meter_id', ''));
  $language = trim(mosGetParam($_POST, 'language', ''));

  stylesheet();

?>
  <script>
  function getObjRef(p_ref) {
    return document.all ? document.all[p_ref] : document.getElementById(p_ref);
  }

  function view_hymn(eastons_no) {
    var frm = getObjRef("searchForm");
    frm.eastons_no.value = eastons_no;
    frm.submit();
  }

  function view_author(author) {
    var frm = getObjRef("searchForm");
    frm.keywords.value = "";
    frm.author.value = author;
    frm.submit();
  }

  function toggle_language() {
    var frm = getObjRef("searchForm");
    frm.meter_id.value = "ALL";
    frm.submit();
  }
  </script>

  <form action="<?php echo sefRelToAbs('index.php?option='.$option.'&amp;Itemid='.$Itemid); ?>" method="post" name="searchForm" target="_top" id="searchForm">
  <table border=0>

    <tr>
      <td><?php echo(_HYMNSEARCH_NO);?></td>
      <td><?php echo(_HYMNSEARCH_TEXT);?></td>
      <td><?php echo(_HYMNSEARCH_AUTHOR);?></td>
    </tr>

    <tr>
      <td><input type="text" name="eastons_no" size="10" class="inputbox" value="<?php echo $eastons_no;?>" /></td>
      <td><input type="text" name="keywords" size="40" class="inputbox" value="<?php echo $keywords;?>" /></td>
      <td><input type="text" name="author" size="20" class="inputbox" value="<?php echo $author;?>" /></td>
    </tr>

    <tr>
    <td><select name="language" id="language" class="dropdown" onchange="toggle_language();">
    <option value="" <? echo ($language == "" ? "SELECTED" : ""); ?>>English</option>
    <option value="_de" <? echo ($language == "_de" ? "SELECTED" : ""); ?>>Deutsche</option>
    </select></td>

    <td><select name="meter_id" id="meter_id" class="dropdown">
    <option value="ALL">All Meters</option>
<?
  $meterSql = "SELECT m.id, m.meter, m.rhythm, m.chorus, m.disp_order ".
              "FROM hymn$language h, hymn_meter m ".
              "WHERE h.meter_id=m.id ".
              "GROUP BY disp_order, id, meter, rhythm, chorus ".
              "ORDER BY disp_order, meter, rhythm, chorus";
  $meterRes = mysql_query($meterSql) or die("</select><h1>Query failed</h1><pre>$meterSql</pre>");

  while ($row = mysql_fetch_row($meterRes)) {
    $sel = "";
    if ($row[0] == $meter_id) {
      $sel = "SELECTED ";
    }
?>
    <option <?echo $sel; ?>value="<? echo $row[0]; ?>"><? echo trim("$row[1] $row[2] $row[3]"); ?></option>
<?
  }

  mysql_free_result($meterRes);

?>
    </select></td>
    <td colspan=2><input type="submit" name="eastons_search" value="<?php echo(_HYMNSEARCH_HYMN);?>" class="button" />
    <a href="http://www.southesk.com/index.php?option=com_content&task=view&id=34&Itemid=2">Need help?</a></td>
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

function output_eastons_lines($hymn_lines) {
?>
<table border=0 cellspacing=0 cellpadding=4 width=300>
<?
    foreach ($hymn_lines as $hline) {
?>
  <tr><td><a href="javascript:void();" onClick="view_hymn('<? echo $hline->hymn_no; ?>');return false;"><? echo nbsp($hline->hymn_no); ?></a></td?
  <td title="<? echo $hline->meter; ?>"><? echo $hline->line_text; ?></td></tr>
<?
    }
?>
</table>
<?
}

function body_search($keywordsList, $searchType) {
  global $database, $language, $meter_id;

  describe_search($searchType);

  $whereClause = "";

  $i = 0;
  foreach($keywordsList as $keyword) {
    if ($keyword != "") {
      $whereClause = $whereClause . "and d.line_text like '%".$keyword."%' ";
      $i++;
    }
  }

  if (!empty($meter_id) && $meter_id != "ALL") {
    $whereClause = $whereClause . "and h.meter_id='$meter_id' ";
    if ($i == 0) {
      $whereClause = $whereClause . "and d.vers_no=1 and d.line_no=1 ";
    }
  }

  $verseSql = "SELECT DISTINCT d.hymn_no, d.line_text " . //, d.vers_no, d.line_no, d.line_text, h.meter ".
              "FROM hymn_line$language d, hymn$language h ".
              "WHERE d.hymn_no = h.hymn_no $whereClause ".
              "ORDER BY d.hymn_no,d.vers_no,d.line_no";

  $database->setQuery($verseSql);
  $hymn_lines = $database->loadObjectlist();
  output_hymn_lines($hymn_lines);
}

function author_search($authorList, $searchType) {
  global $database, $language, $meter_id;

  describe_search($searchType);

  $whereClause = "WHERE ";

  $i = 0;
  foreach($authorList as $auth) {
    if ($i > 0) {
      $whereClause .= "AND ";
    }
    $whereClause .= "fullname LIKE '%".$auth."%' ";
    $i++;
  }

?>
  <table border=0 cellspacing=0 cellpadding=4>
<?
  $verseSql = "SELECT author,fullname,surname,firstnames,author_life,bio_url ".
              "FROM author $whereClause order by surname,fullname";
  $verseRes = mysql_query($verseSql) or die("<h1>Query failed</h1><pre>$verseSql</pre>");

  for ($count = 1; $row = mysql_fetch_row($verseRes); ++$count) {
    $details = "$row[3] $row[2] $row[4]";

    if (!empty($row[5])) {
      $details = "<a target=\"_blank\" href=\"$row[5]\">$details</a>";
    }
?>
  <tr>
    <td><b><? echo $row[1]; ?></b><br>
      <? echo $details; ?></td>
  </tr>
<?
    $compSql = "SELECT h.hymn_no, d.line_text " .
               "FROM hymn$language h, hymn_line$language d " .
               "WHERE h.hymn_no = d.hymn_no " .
               "AND d.line_no = 1 " .
               "AND d.vers_no = 1 " .
               "AND h.author = $row[0] " .
               "ORDER BY h.hymn_no";

?><tr><td colspan=4><?

    $database->setQuery($compSql);
    $hymn_lines = $database->loadObjectlist();
    output_hymn_lines($hymn_lines);

?></td></tr><?
  }

  mysql_free_result($verseRes);

?>
</table>
<?
}

function show_hymn($hymn, $language) {
  global $database;
  $verseCount = 0;

  if ($hymn < 0 || $hymn > 456) {
    echo "<h1 class=error>Please enter a Hymn from 1 to 456.</h1>";
    return;
  }

  echo "<table border=0 cellspacing=0 cellpadding=2><tr>\n";

  echo "<td class=hymn>$hymn</td>\n";
  $hymnSql = "SELECT m.meter, m.rhythm, m.chorus ".
             "FROM hymn$language h, hymn_meter m ".
             "WHERE h.meter_id=m.id ".
             "AND hymn_no=$hymn";
  $database->setQuery($hymnSql);
  $hymn_hdr = $database->loadObjectlist();

  $metdesc = $hymn_hdr[0]->meter;
  if (!empty($hymn_hdr[0]->rhythm)) $metdesc .= "&nbsp;<i>" . $hymn_hdr[0]->rhythm ."</i>";
  if (!empty($hymn_hdr[0]->chorus)) $metdesc .= "<br>Chorus ". $hymn_hdr[0]->chorus;

  echo "<td class=\"meter\">$metdesc</td></tr>";

  $hymnSql = "SELECT vers_no, COUNT(*) line_count ".
             "FROM hymn_line$language ".
             "WHERE hymn_no=$hymn ".
             "GROUP BY vers_no ".
             "ORDER BY if(vers_no=1,0,if(vers_no=99,1,vers_no)) ";
  $database->setQuery($hymnSql);
  $hymn_vers = $database->loadObjectlist();
  $verse_desc = "";

  foreach ($hymn_vers as $verse) {
    $verseSql = "SELECT line_no,line_text FROM hymn_line$language where hymn_no=$hymn and vers_no=".$verse->vers_no." order by vers_no,line_no";
    $database->setQuery($verseSql);
    $hymn_lines = $database->loadObjectlist();

    foreach ($hymn_lines as $line) {
?>
  <tr>
<?
      $verse_desc = "&nbsp;";
      $verse_class = "lines";
      if ($verse==99) {
        $verse_class = "chorus";
      } else {
        if ($line->line_no == 1) {
          echo "<td class=verse rowspan=" . $verse->line_count . ">" . $verse->vers_no . "</td>\n";
        }
      }

      echo "<td class=$verse_class>" . $line->line_text . "</td></tr>\n";
    }

?>
  </tr><tr><td colspan=2>&nbsp;</td></tr>
<?
  }

  $hymnSql = "SELECT a.fullname FROM hymn$language h, author a where h.author = a.author and h.hymn_no=$hymn";
  $database->setQuery($hymnSql);
  $authors = $database->loadObjectlist();
  echo "<tr><td colspan=2 class=author><a href=\"javascript:void();\" onclick=\"view_author('" . $authors[0]->fullname . "');\">" . $authors[0]->fullname . "</a></td></tr>\n";
  echo "</table>\n";
}

function search_hymns($con_id, $option) {
  global $database;

  $hymn_no = trim(mosGetParam($_POST, 'hymn_no', ''));
  $keywords = trim(mosGetParam($_POST, 'keywords', ''));
  $author = trim(mosGetParam($_POST, 'author', ''));
  $meter_id = trim(mosGetParam($_POST, 'meter_id', ''));
  $language = trim(mosGetParam($_POST, 'language', ''));

?>
<table border=0 cellspacing=0 cellpadding=4>
<tr><td valign=top width="350">
<?

  if (!empty($hymn_no)) {
    show_hymn($hymn_no, $language);
  }

?>
</td><td valign=top>
<?

  $keywordsList = explode(" ", $keywords);
  $authorList = explode(" ", $author);

  $metdesc = "";
  if ($meter_id != "ALL") {

    $sql = "SELECT m.meter, m.rhythm, m.chorus ".
           "FROM hymn_meter m ".
           "WHERE m.id = $meter_id";
    $database->setQuery($sql);
    $meter_list = $database->loadObjectlist();

    $metdesc = $meter_list[0]->meter;
    if (!empty($meter_list[0]->rhythm)) $metdesc .= "&nbsp;<i>" . $meter_list[0]->rhythm ."</i>";

    $metdesc = "of meter \"$metdesc\"";
  }

  if (!empty($keywords) > 0) {
    body_search($keywordsList, "Hymns $metdesc containing \"$keywords\"");
  } else if (!empty($author) > 0) {
    author_search($authorList, "Authors like \"$author\" and their hymns");
  } else if ($meter_id != "ALL") {
    body_search($keywordsList, "Hymns $metdesc");
  }
?>
</td></tr>
</table>
<?
}
?>
