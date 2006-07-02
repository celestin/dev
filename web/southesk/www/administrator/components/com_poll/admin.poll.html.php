<?php
/**
* @version $Id: admin.poll.html.php,v 1.17 2004/09/13 11:33:32 stingrey Exp $
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
class HTML_poll {

	function showPolls( &$rows, &$pageNav, $option ) {
		global $my;
		?>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<th>Poll Manager</th>
		</tr>
		</table>

		<table class="adminlist">
		<tr>
			<th width="20">
			<input type="checkbox" name="toggle" value="" onClick="checkAll(<?php echo count( $rows ); ?>);" />
			</th>
			<th align="left">
			Poll Title
			</th>
			<th width="15%" align="center">
			Options
			</th>
			<th width="15%" align="center">
			Published
			</th>
			<th width="20%" align="center">
			Checked Out	
			</th>
		</tr>
		<?php
		$k = 0;
		for ($i=0, $n=count( $rows ); $i < $n; $i++) {
			$row = &$rows[$i];
			$task = $row->published ? 'unpublish' : 'publish';
			$img = $row->published ? 'publish_g.png' : 'publish_x.png';
			$alt = $row->published ? 'Published' : 'Unpublished';
			?>
			<tr class="<?php echo "row$k"; ?>">
				<td width="20">
				<?php echo mosHTML::idBox( $i, $row->id, ($row->checked_out && $row->checked_out != $my->id ) ); ?>
				</td>
				<td width="50%">
				<a href="#edit" onclick="return listItemTask('cb<?php echo $i;?>','edit')">
				<?php echo $row->title; ?>
				</a>
				</td>
				<td width="" align="center">
				<?php echo $row->numoptions; ?>&nbsp;
				</td>
				<td width="10%" align="center">
				<a href="javascript: void(0);" onclick="return listItemTask('cb<?php echo $i;?>','<?php echo $task;?>')">
				<img src="images/<?php echo $img;?>" width="12" height="12" border="0" alt="<?php echo $alt; ?>" />
				</a>
				</td>
				<td width="10%" align="center">
				<?php echo $row->editor; ?>&nbsp;
				</td>
			</tr>
			<?php	
			$k = 1 - $k; 
		} 
		?>
		</table>
		<?php echo $pageNav->getListFooter(); ?>
		
		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="boxchecked" value="0" />
		</form>
		<?php
	}


	function editPoll( &$row, &$options, &$lists ) {
		mosMakeHtmlSafe( $row, ENT_QUOTES );
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			var form = document.adminForm;
			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}
			// do field validation
			if (form.title.value == "") {
				alert( "Poll must have a title" );
			} else if( isNaN( parseInt( form.lag.value ) ) ) {
				alert( "Poll must have a non-zero lag time" );
			//} else if (form.menu.options.value == ""){
			//	alert( "Poll must have pages." );
			//} else if (form.adminForm.textfieldcheck.value == 0){
			//	alert( "Poll must have options." );
			} else {
				submitform( pressbutton );
			}
		}
		</script>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr> 
			<th>
			<?php echo $row->id ? 'Edit' : 'Add';?> Poll
			</th>
		</tr>
		</table>

		<table class="adminform">
		<tr>
			<td width="10%">
			Title:
			</td>
			<td>
			<input class="inputbox" type="text" name="title" size="60" value="<?php echo $row->title; ?>" />
			</td>
   			<td width="20px">&nbsp;
			
			</td>
			<td width="100%" rowspan="20" valign="top">
			Show on menu items:
			<br />
			<?php echo $lists['select']; ?>
			</td>
		</tr>
		<tr>
			<td>
			Lag:
			</td>
			<td>
			<input class="inputbox" type="text" name="lag" size="10" value="<?php echo $row->lag; ?>" /> (seconds between votes)
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<br /><br />
			Options:
			</td>
		</tr>
		<?php
		for ($i=0, $n=count( $options ); $i < $n; $i++ ) { 
			?>
			<tr>
				<td>
				<?php echo ($i+1); ?>
				</td>
				<td>
				<input class="inputbox" type="text" name="polloption[<?php echo $options[$i]->id; ?>]" value="<?php echo htmlspecialchars( $options[$i]->text, ENT_QUOTES ); ?>" size="60" />
				</td>
			</tr>
			<?php	
		}
		for (; $i < 12; $i++) { 
			?>
			<tr>
				<td>
				<?php echo ($i+1); ?>
				</td>
				<td>
				<input class="inputbox" type="text" name="polloption[]" value="" size="60"/>
				</td>
			</tr>
			<?php	
		}
		?>
		</table>

		<input type="hidden" name="task" value="">
		<input type="hidden" name="option" value="com_poll" />
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="textfieldcheck" value="<?php echo $n; ?>" />
		</form>
		<?php
	}

}
?>
