<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * User Administration
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2006  10021 : File added.
 * CAM  22-Jun-2007  10132 : Removed session_register.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "User Administration";
include_once 'Main.php';
include 'tpl/top.php';

if (!$member->isAdmin()) {
  Msg::error("Only Administrative users may access this option.");
  exit();
}

$filter_id = NULL;        if (!empty($_POST['filter_id'])) $filter_id = $_POST['filter_id'];
$filter_parent = NULL;    if (!empty($_POST['filter_parent'])) $filter_parent = $_POST['filter_parent'];
$filter_fname = NULL;     if (!empty($_POST['filter_fname'])) $filter_fname = $_POST['filter_fname'];
$filter_lname = NULL;     if (!empty($_POST['filter_lname'])) $filter_lname = $_POST['filter_lname'];
$filter_type = NULL;      if (!empty($_POST['filter_type'])) $filter_type = $_POST['filter_type'];

$ftr = new Filter($filter_id, $filter_parent, $filter_fname, $filter_lname, $filter_type);
if ($ftr->isFiltered()) {
  $_SESSION['filter'] = $ftr;
} else {
  if (session_is_registered('filter')) $ftr = $_SESSION['filter'];
}

?>

<form action="users.php" method="post" name="" id="">
<table border=1 cellspacing=0 cellpadding=2>
  <tr>
    <th>ID</th>
    <th>Parent ID</th>
    <th>First name</th>
    <th>Surname</th>
    <th>Type</th>
    <th>Actions</th>
  </tr>

  <tr>
    <td><input name="filter_id" type="text" id="filter_id" size=5 value="<? echo $ftr->filter_id; ?>"></td>
    <td><input name="filter_parent" type="text" id="filter_parent" size=5 value="<? echo $ftr->filter_parent; ?>"></td>
    <td><input name="filter_fname" type="text" id="filter_fname" size=10 value="<? echo $ftr->filter_fname; ?>"></td>
    <td><input name="filter_lname" type="text" id="filter_lname" size=10 value="<? echo $ftr->filter_lname; ?>"></td>
    <td><select name="filter_type" id="filter_type"><option value="">All</option><?

    $sql = mysql_query("SELECT member_type mtype, type_name FROM member_type ".
                       "WHERE valid=1 ORDER BY disp_order");
    $name_check = mysql_num_rows($sql);

    if ($name_check > 0) {
      while ($row = mysql_fetch_array($sql)) {
        foreach($row AS $key => $val) {
          $$key = stripslashes($val);
        }

        echo "<option ";

        if ($mtype == $ftr->filter_type) echo "SELECTED ";

        echo "value=\"$mtype\">$type_name</option>";
      }
    }
    ?></select></td>
    <td align=center><input class="button" type="submit" value="Find">&nbsp;&nbsp;<a href="newuser.php">Create New</a></td>
  </tr>
<?

  if ($ftr->isFiltered()) {

    $ssql = "SELECT memberid,".
                   "parent,".
                   "first_name,".
                   "last_name,".
                   "member_type ".
            "FROM member " . $ftr->getFilter() .
            "ORDER BY first_name";
    $sql = mysql_query($ssql) or die (mysql_error());

    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      if (empty($parent)) $parent = "&nbsp;";
?>
  <tr>
    <td><? echo $memberid; ?></td>
    <td><? echo $parent; ?></td>
    <td><? echo $first_name; ?></td>
    <td><? echo $last_name; ?></td>
    <td><? echo $member_type; ?></td>
    <td align=center><a href="edituser.php?member_id=<? echo $memberid; ?>">Edit</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="deluser.php?member_id=<? echo $memberid; ?>">Delete</a></td>
  </tr>
<?
    }
  }

?>
</table>
</form>

<?
include 'tpl/bot.php';
?>

