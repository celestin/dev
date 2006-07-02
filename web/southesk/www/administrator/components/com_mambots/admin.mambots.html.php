<?php
/**
* @version $Id: admin.mambots.html.php,v 1.13 2004/09/18 12:10:34 stingrey Exp $
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
class HTML_modules {

	/**
	* Writes a list of the defined modules
	* @param array An array of category objects
	*/
	function showMambots( &$rows, $client, &$pageNav, $option ) {
		global $my, $mosConfig_live_site;
	?>
	<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
	<form action="index2.php" method="post" name="adminForm">

	<table class="adminheading">
	<tr>
		<th class="modules">
		<?php echo $client == 'admin' ? 'Administrator' : 'Site';?> Mambot Manager
		</th>
	</tr>
	</table>

	<table class="adminlist">
	<tr>
		<th width="20">#</th>
		<th width="20">
		<input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count( $rows );?>);" />
		</th>
		<th class="title" width="40%">
		Mambot Name
		</th>
		<th nowrap="nowrap" width="10%">
  		Published
		</th>
		<th colspan="2" nowrap="true" width="5%">
		Reorder
		</th>
		<th nowrap="nowrap" width="10%">
		Access
		</th>
		<th nowrap="nowrap" align="left" width="10%">
		Type
		</th>
		<th nowrap="nowrap" align="left" width="10%">
		File
		</th>
		<th nowrap="nowrap" width="15%">
		Checked Out
		</th>
	</tr>
	<?php
	$k = 0;
	for ($i=0, $n=count( $rows ); $i < $n; $i++) {
		$row = &$rows[$i];
		$img = $row->published ? 'publish_g.png' : 'publish_x.png';
		$task = $row->published ? 'unpublish' : 'publish';
		$alt = $row->published ? 'Published' : 'Unpublished';
		if ( !$row->access ) {
			$color_access = 'style="color: green;"';
			$task_access = 'accessregistered';
		} else if ( $row->access == 1 ) {
			$color_access = 'style="color: red;"';
			$task_access = 'accessspecial';
		} else {
			$color_access = 'style="color: black;"';
			$task_access = 'accesspublic';
		}
		?>
		<tr class="<?php echo "row$k"; ?>">
			<td align="right"><?php echo $pageNav->rowNumber( $i ); ?></td>
			<td><?php echo mosHTML::idBox( $i, $row->id, ($row->checked_out && $row->checked_out != $my->id ) ); ?></td>
			<td>
			<a href="#edit" onclick="return listItemTask('cb<?php echo $i;?>','edit')">
			<?php echo $row->name; ?>
			</a>
			</td>
			<td align="center">
			<a href="javascript: void(0);" onclick="return listItemTask('cb<?php echo $i;?>','<?php echo $task;?>')">
			<img src="images/<?php echo $img;?>" border="0" alt="<?php echo $alt; ?>" />
			</a>
			</td>
			<td>
			<?php echo $pageNav->orderUpIcon( $i, ($row->folder == @$rows[$i-1]->folder && $row->ordering > -10000 && $row->ordering < 10000) ); ?>
			</td>
			<td>
			<?php echo $pageNav->orderDownIcon( $i, $n, ($row->folder == @$rows[$i+1]->folder && $row->ordering > -10000 && $row->ordering < 10000) ); ?>
			</td>
			<td align="center">
			<a href="javascript: void(0);" onclick="return listItemTask('cb<?php echo $i;?>','<?php echo $task_access;?>')" <?php echo $color_access; ?>>
			<?php echo $row->groupname;?>
			</a>
			</td>
			<td align="left" nowrap="true">
			<?php echo $row->folder;?>
			</td>
			<td align="left" nowrap="true">
			<?php echo $row->element;?>
			</td>
			<td align="center">
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
	<input type="hidden" name="client" value="<?php echo $client;?>" />
	<input type="hidden" name="boxchecked" value="0" />
	</form>
	<script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
<?php
	}

	/**
	* Writes the edit form for new and existing module
	*
	* A new record is defined when <var>$row</var> is passed with the <var>id</var>
	* property set to 0.
	* @param mosCategory The category object
	* @param array <p>The modules of the left side.  The array elements are in the form
	* <var>$leftorder[<i>order</i>] = <i>label</i></var>
	* where <i>order</i> is the module order from the db table and <i>label</i> is a
	* text label associciated with the order.</p>
	* @param array See notes for leftorder
	* @param array An array of select lists
	* @param object Parameters
	*/
	function editMambot( &$row, &$lists, &$params, $option ) {
		global $mosConfig_live_site;
		?>
		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			if (pressbutton == "cancel") {
				submitform(pressbutton);
				return;
			}
			// validation
			var form = document.adminForm;
			if (form.name.value == "") {
				alert( "Mambot must have a name" );
			} else if (form.element.value == "") {
				alert( "Mambot must have a filename" );
			} else {
				submitform(pressbutton);
			}
		}
		</script>
		<table class="adminheading">
		<tr>
			<th class="mambots">
			<?php echo $row->id ? 'Edit' : 'Add';?> Mambot -> <?php echo $row->name; ?>
			</th>
		</tr>
		</table>
	
		<form action="index2.php" method="post" name="adminForm">
		<table cellspacing="0" cellpadding="0" width="100%">
		<tr valign="top">
			<td width="60%" valign="top">
				<table class="adminform">
				<tr>
					<th colspan="2">
					Mambot Details
					</th>
				<tr>
				<tr>
					<td width="100" align="left">
					Name:
					</td>
					<td>
					<input class="text_area" type="text" name="name" size="35" value="<?php echo $row->name; ?>" />
					</td>
				</tr>
				<tr>
					<td valign="top" align="left">
					Folder:
					</td>
					<td>
					<?php echo $lists['folder']; ?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="left">
					Mambot file:
					</td>
					<td>
					<input class="text_area" type="text" name="element" size="35" value="<?php echo $row->element; ?>" />.php
					</td>
				</tr>
				<tr>
					<td valign="top" align="left">
					Mambot Order:
					</td>
					<td>
					<?php echo $lists['ordering']; ?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="left">
					Access Level:
					</td>
					<td>
					<?php echo $lists['access']; ?>
					</td>
				</tr>
				<tr>
					<td valign="top">
					Published:
					</td>
					<td>
					<?php echo $lists['published']; ?>
					</td>
				</tr>
				<tr>
					<td valign="top" colspan="2">&nbsp;
								
					</td>
				</tr>
				<tr>
					<td valign="top">
					Description:
					</td>
					<td>
					<?php echo $row->description; ?>
					</td>
				</tr>
				</table>
			</td>
			<td width="40%">
				<table class="adminform">
				<tr>
					<th colspan="2">
					Parameters
					</th>
				<tr>
				<tr>
					<td>
					<?php echo $params->render();?>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	
		<input type="hidden" name="option" value="<?php echo $option; ?>" />
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="client" value="<?php echo $row->client_id; ?>" />
		<input type="hidden" name="task" value="" />
		</form>
		<script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
		<?php
	}
}
?>
