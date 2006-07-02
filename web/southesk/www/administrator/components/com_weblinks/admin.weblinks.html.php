<?php
/**
* @version $Id: admin.weblinks.html.php,v 1.22 2004/09/21 16:36:46 stingrey Exp $
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
class HTML_weblinks {

	function showWeblinks( $option, &$rows, &$lists, &$search, &$pageNav ) {
		global $my;
		?>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<th>
			Weblink Manager
			</th>
			<td>
			Filter:
			</td>
			<td>
			<input type="text" name="search" value="<?php echo $search;?>" class="text_area" onChange="document.adminForm.submit();" />
			</td>
			<td width="right">
			<?php echo $lists['catid'];?>
			</td>
		</tr>
		</table>

		<table class="adminlist">
		<tr>
			<th width="20">
			<input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count( $rows ); ?>);" />
			</th>
			<th class="title" width="40%" nowrap="nowrap">
			Title
			</th>
			<th width="10%" nowrap="nowrap">
			Published
			</th>
			<th width="10%" nowrap="nowrap">
			Approved
			</th>
			<th colspan="2">
			Reorder
			</th>
			<th width="25%" align="center" nowrap="nowrap">
			Category
			</th>
			<th width="10%" align="left" nowrap="nowrap">
			Hits
			</th>
			<th width="10%" nowrap="nowrap">
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
				<?php
				if ( $row->checked_out && ( $row->checked_out != $my->id ) ) {
					?>
					<?php echo $row->title; ?>
					&nbsp;[ <i>Checked Out</i> ]
					<?php
				} else {
					?>
					<a href="#edit" onclick="return listItemTask('cb<?php echo $i;?>','edit')">
					<?php echo $row->title; ?>
					</a>
					<?php
				}
				?>
				</td>
				<td width="10%" align="center">
				<a href="javascript: void(0);" onclick="return listItemTask('cb<?php echo $i;?>','<?php echo $task;?>')">
				<img src="images/<?php echo $img;?>" width="12" height="12" border="0" alt="<?php echo $alt; ?>" />
				</a>
				</td>
				<?php
				if ( $row->approved ) {
					?>
					<td width="10%" align="center">
					<img src="images/tick.png">
					</td>
					<?php
				} else { 
					?>
					<td width="10%" align="center">&nbsp;</td>
					<?php		
				} 
				?>
				<td>
				<?php echo $pageNav->orderUpIcon( $i, ($row->catid == @$rows[$i-1]->catid) ); ?>
				</td>
      			<td>
				<?php echo $pageNav->orderDownIcon( $i, $n, ($row->catid == @$rows[$i+1]->catid) ); ?>
				</td>
				<td width="25%" align="center">
				<?php echo $row->category; ?>
				</td>
				<td width="10%">
				<?php echo $row->hits; ?>
				</td>
				<?php
				if ( $row->checked_out ) { 
					?>
					<td width="10%" align="center"><?php echo $row->editor; ?></td>
					<?php		
				} else { 
					?>
					<td width="10%" align="center">&nbsp;</td>
					<?php		
				} 
				?>
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

/**
* Writes the edit form for new and existing record
*
* A new record is defined when <var>$row</var> is passed with the <var>id</var>
* property set to 0.
* @param mosWeblink The weblink object
* @param array An array of select lists
* @param string The option
*/
	function editWeblink( &$row, &$lists, $option ) {
		mosMakeHtmlSafe( $row, ENT_QUOTES, 'description' );
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			var form = document.adminForm;
			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}

			// do field validation
			if (form.title.value == ""){
				alert( "Weblink item must have a title" );
			} else if (form.catid.value == "0"){
				alert( "You must select a category." );
			} else if (form.url.value == ""){
				alert( "You must have a url." );
			} else {
				submitform( pressbutton );
			}
		}
		</script>
		<table class="adminheading">
		<tr>
			<th>
			<?php echo $row->id ? 'Edit' : 'Add';?> Weblink
			</th>
		</tr>
		</table>

		<form action="index2.php" method="post" name="adminForm" id="adminForm">
		<table class="adminform">
		<tr>
			<td width="20%" align="right">
			Name:
			</td>
			<td width="80%">
			<input class="text_area" type="text" name="title" size="50" maxlength="250" value="<?php echo $row->title;?>" />
			</td>
		</tr>

		<tr>
			<td valign="top" align="right">
			Category:
			</td>
			<td>
			<?php echo $lists['catid']; ?>
			</td>
		</tr>

		<tr>
			<td valign="top" align="right">
			URL:
			</td>
			<td>
			<input class="text_area" type="text" name="url" value="<?php echo $row->url; ?>" size="50" maxlength="250" />
			</td>
		</tr>

		<tr>
			<td valign="top" align="right">
			Description:
			</td>
			<td>
			<textarea class="text_area" cols="50" rows="5" name="description" style="width:500px" width="500"><?php echo $row->description; ?></textarea>
			</td>
		</tr>

		<tr>
			<td valign="top" align="right">
			Ordering:
			</td>
			<td>
			<?php echo $lists['ordering']; ?>
			</td>
		</tr>
		<tr>
			<td valign="top" align="right">
			Approved:
			</td>
			<td>
			<?php echo $lists['approved']; ?>
			</td>
		</tr>
		<tr>
			<td valign="top" align="right">
			Published:
			</td>
			<td>
			<?php echo $lists['published']; ?>
			</td>
		</tr>
		</table>

		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="task" value="" />
		</form>
		<?php
	}
}
?>
