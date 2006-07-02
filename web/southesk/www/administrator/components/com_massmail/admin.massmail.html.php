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

/**
* @package Mambo_4.5.1
*/
class HTML_massmail {
	function messageForm( &$lists, $option ) {
?>
<script language="javascript" type="text/javascript">
	function submitbutton(pressbutton) {
		var form = document.adminForm;
		if (pressbutton == 'cancel') {
			submitform( pressbutton );
			return;
		}
		// do field validation
		if (form.mm_subject.value == ""){
			alert( "Please fill in the subject" );
		} else if (getSelectedValue('adminForm','mm_group') < 0){
			alert( "Please select a group" );
		} else if (form.mm_message.value == ""){
			alert( "Please fillin the message" );
		} else {
			submitform( pressbutton );
		}
	}
</script>

<form action="index2.php" name="adminForm" method="post">
<table class="adminheading">
	<tr>
		<th class="massemail">Mass Mail</th>
	</tr>
</table>
<table class="adminform">
	<tr>
		<td width="150">Group:</td>
		<td width="85%"><?php echo $lists['gid']; ?></td>
	</tr>
	<tr>
		<td width="150">Mail to Child Groups:</td>
		<td width="85%"><input type="checkbox" name="mm_recurse" value="RECURSE" /></td>
	</tr>
	<tr>
		<td width="150">Subject:</td>
		<td width="85%"><input class="inputbox" type="text" name="mm_subject" value="" size="50"></td>
	</tr>
	<tr>
		<td width="150" valign="top">Message:</td>
		<td width="85%"><textarea cols="50" rows="5" name="mm_message" wrap="virtual" class="inputbox"></textarea></td>
	</tr>
</table>
<input type="hidden" name="option" value="<?php echo $option; ?>">
<input type="hidden" name="task" value="">
</form>
<?php
	}
}
?>
