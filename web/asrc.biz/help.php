<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Help Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  31-Aug-2004  File created.
 * CAM  29-May-2004  5 : Corrected PHP.
 * CAM  22-Jun-2007  10130 : Added Key to Colour-coding.
 * CAM  31-Jul-2007  10147 : Remove Gym, Social and Social Restricted.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Help";
include 'tpl/top.php';
?>

<h3>Key to Membership Types</h3>
<table border=0 cellpadding=5 cellspacing=0>
<tr><td class="keyitem">OP</td><td class="member_type_op">Off Peak</tr>
<tr><td class="keyitem">BG</td><td class="member_type_bg">Business Group</tr>
<tr><td class="keyitem">F</td><td class="member_type_f">Family</tr>
<tr><td class="keyitem">I</td><td class="member_type_i">Intermediate</tr>
<tr><td class="keyitem">J</td><td class="member_type_j">Junior</tr>
<tr><td class="keyitem">O</td><td class="member_type_o">Ordinary</tr>
<tr><td class="keyitem">ST</td><td class="member_type_st">Student</tr>
<tr><td class="keyitem">A</td><td class="member_type_a">Admin</tr>
<tr><td class="keyitem">U</td><td class="member_type_u">Guest</tr>
<tr><td class="keyitem">Y</td><td class="member_type_y">Unspecified</tr>
<tr><td class="keyitem">Z</td><td class="member_type_z">Unknown</tr>
</table>

<?
include 'tpl/bot.php';
?>
