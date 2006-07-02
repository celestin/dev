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
* HTML class for all menumanager component output
* @package Mambo_4.5.1
*/
class HTML_menumanager {
	/**
	* Writes a list of the menumanager items
	*/
	function show ( $option, $menus, $pageNav ) {
		?>
		<script language="javascript" type="text/javascript">
		function menu_listItemTask( id, task, option ) {
			var f = document.adminForm;
			cb = eval( 'f.' + id );
			if (cb) {
				cb.checked = true;
				submitbutton(task);
			}
			return false;
		}
		</script>

		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<th class="menus">
			Menu Manager
			</th>
		</tr>
		</table>

		<table class="adminlist">
		<tr>
			<th width="20">#</th>
			<th width="20">&nbsp;</th>
			<th width="20px">&nbsp;</th>
			<th width="20%" align="left" nowrap="true">
			Menu Name
			</th>
			<th class="title" width="20%" nowrap="true">
			Menu Type
			</th>
			<th width="5%" nowrap="true">
			Module ID
			</th>
			<th width="5%">
			Items
			</th>
			<th width="50%">&nbsp;</th>
		</tr>
		<?php
		$k = 0;
		$i = 0;
		$n = count( $menus );
		foreach ( $menus as $menu ) {
			?>
			<tr class="<?php echo "row". $k; ?>">
				<td align="center" width="30px">
				<?php echo $i + 1 + $pageNav->limitstart;?>
				</td>
				<td width="30px" align="center">
				<input type="radio" id="cb<?php echo $i;?>" name="cid[]" value="<?php echo $menu->id; ?>" onclick="isChecked(this.checked); " />
				</td>
				<td width="20px"></td>
				<td align="left">
				<?php
				if ( @!$menu->title ) {
					?>
					<small>No module assigned to menu</small>
					<?php
				} else {
					?>
					<a href="#edit" onClick="return listItemTask('cb<?php echo $i;?>','edit')">
					<?php
					echo $menu->title;
					?>
					</a>
					<?php
				}
				?>
				</td>
				<td>
					<a href="index2.php?option=com_menus&menutype=<?php echo $menu->type; ?>">
					<?php
				echo $menu->type;
					?>
					</a>
				</td>
				<td align="center">
				<?php
					?>
					<a href="index2.php?option=com_modules&task=edit&moduleid=<?php echo $menu->id;?>">
					<?php
				echo $menu->id;
					?>
					</a>
					<?php
				?>
				</td>
				<td align="center">
				<?php
				echo $menu->num;
				?>
				</td>
				<td>&nbsp;</td>
			</tr>
			<?php
			$k = 1 - $k;
			$i++;
		}
		?>
		</table>
		<?php echo $pageNav->getListFooter(); ?>

		<input type="hidden" name="option" value="<?php echo $option; ?>" />
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="boxchecked" value="0" />
		</form>
		<?php
	}


	/**
	* writes a form to take the name of the menu you would like created
	* @param option	display options for the form
	*/
	function edit ( &$row, $option ) {
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			if (pressbutton == 'savemenu') {
				if ( document.adminForm.title.value == '' ) {
					alert( 'Please enter a name for your menu' );
					document.adminForm.title.focus();
				}
				else if ( document.adminForm.params.value == '' ) {
					alert( 'Please enter a menu type for your menu' );
					document.adminForm.params.focus();
				} else {
					submitform( 'savemenu' );
				}
			} else {
				submitform( pressbutton );
			}
		}
		</script>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<th class="menus">
			Menu Details
			</th>
		</tr>
		</table>

		<table class="adminform">
		<tr height="45px;">
			<td width="100px" align="left">
			<strong>Menu name:</strong>
			</td>
			<td>
			<input class="inputbox" type="text" name="title" size="30" value="<?php echo $row->title ? $row->title : "";?>" />
			</td>
		<tr>
		<tr height="45px;">
			<td width="100px" align="left">
			<strong>Menu type:</strong>
			</td>
			<td>
			<input class="inputbox" type="text" name="params" size="30" value="<?php echo isset($row->menutype) ? $row->menutype : ""; ?>" />
			</td>
		<tr>
		<tr>
			<td colspan="2">
			</td>
		<tr>
		</tr>
			<td colspan="2">
			A mod_mainmenu module, with the same name will automatically be created/modified when you save this menu.
			</td>
		</tr>
		<tr>
			<td colspan="2">
			</td>
		<tr>
		</table>
		<br /><br />

		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="iscore" value="<?php echo $row->iscore; ?>" />
		<input type="hidden" name="published" value="<?php echo $row->published; ?>" />
		<input type="hidden" name="position" value="<?php echo $row->position; ?>" />
		<input type="hidden" name="module" value="<?php echo $row->module; ?>" />

		<input type="hidden" name="option" value="<?php echo $option; ?>" />
		<input type="hidden" name="task" value="savemenu" />
		<input type="hidden" name="boxchecked" value="0" />
		</form>
		<?php
		}


		/**
		* A delete confirmation page
		* Writes list of the items that have been selected for deletion
		*/
		function showDelete( $option, $cid, $type, $items, $module ) {
		?>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<th>
			Delete Menu: <?php echo $module[0]->title;?>
			</th>
		</tr>
		</table>

		<br />
		<table class="adminform">
		<tr>
			<td width="3%"></td>
			<td align="left" valign="top" width="20%">
			<strong>Menu/Module being Deleted:</strong>
			<br />
			<font color="#000066"><strong><?php echo $module[0]->title; ?></strong></font>
			<br /><br />
			</td>
			<td align="left" valign="top" width="25%">
			<strong>Menu Items being Deleted:</strong>
			<br />
			<?php
			echo "<ol>";
			foreach ( $items as $item ) {
				echo "<li>". $item->name ."</li>";
			}
			echo "</ol>";
			?>
			</td>
			<td>
			* This will <strong><font color="#FF0000">Delete</font></strong> this Menu, <br />ALL its Menu Items and the Module associated with it *
			<br /><br /><br />
			<div style="border: 1px dotted gray; width: 70px; padding: 10px; margin-left: 100px;">
			<a class="toolbar" href="javascript:if (confirm('Are you sure you want to Deleted this menu? \nThis will Delete the Menu, its Items and the Module.')){ submitbutton('deletemenu');}" onmouseout="MM_swapImgRestore();"  onmouseover="MM_swapImage('remove','','images/delete_f2.png',1);">
			<img name="remove" src="images/delete.png" alt="Delete" border="0" align="middle" />
			&nbsp;Delete
			</a>
			</div>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		</table>
		<br /><br />

		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="sectionid" value="<?php echo $sectionid; ?>" />
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="type" value="<?php echo $type; ?>" />
		<?php
		foreach ($cid as $id) {
			echo "\n<input type=\"hidden\" name=\"cid[]\" value=\"$id\" />";
		}
		?>
		<input type="hidden" name="boxchecked" value="1" />
		</form>
		<?php
	}


	/**
	* A copy confirmation page
	* Writes list of the items that have been selected for copy
	*/
	function showCopy( $option, $cid, $type, $items ) {
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			if (pressbutton == 'copymenu') {
				if ( document.adminForm.menu_name.value == '' ) {
					alert( 'Please enter a name for the copy of the Menu' );
				} else {
					submitform( 'copymenu' );
				}
			} else {
				submitform( pressbutton );
			}
		}
		</script>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<th>
			Copy Menu
			</th>
		</tr>
		</table>

		<br />
		<table class="adminform">
		<tr>
			<td width="3%"></td>
			<td align="left" valign="top" width="30%">
			<strong>New Menu Name:</strong>
			<br />
			<input class="inputbox" type="text" name="menu_name" size="30" value="" />
			<br /><br />
			<strong>Menu being copied:</strong>
			<br />
			<font color="#000066"><strong><?php echo $type; ?></strong></font>
			<br /><br />
			</td>
			<td align="left" valign="top" width="25%">
			<strong>Menu Items being copied:</strong>
			<br />
			<?php
			echo "<ol>";
			foreach ( $items as $item ) {
				echo "<li>". $item->name ." - ". $item->id ."</li>";
				echo "\n <input type=\"hidden\" name=\"mids[]\" value=\"$item->id\" />";
			}
			echo "</ol>";
			?>
			</td>
			<td valign="top">
			A mod_mainmenu module, with the same name
			<br />
			will automatically be created when you save this menu.
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		</table>
		<br /><br />

		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="type" value="<?php echo $type; ?>" />
		<input type="hidden" name="cid" value="<?php echo $cid; ?>" />
		</form>
		<?php
	}



}
?>
