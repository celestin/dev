<?php
/**
* @version $Id: admin.contact.html.php,v 1.26 2004/09/21 16:36:45 stingrey Exp $
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
class HTML_contact {
	
	function showContacts( &$rows, &$pageNav, $search, $option, &$lists ) {
		global $my;
		?>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr> 
			<th>
			Contact Manager
			</th>
			<td>
			Filter:
			</td>
			<td>
			<input type="text" name="search" value="<?php echo $search;?>" class="inputbox" onChange="document.adminForm.submit();" />
			</td>
			<td width="right">
			<?php echo $lists['catid'];?>
			</td>
		</tr>
		</table>

		<table class="adminlist">
		<tr> 
			<th width="20" nowrap="nowrap">
			#
			</th>
			<th width="20" class="title" nowrap="true">
			<input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count($rows); ?>);" />
			</th>
			<th width="30%" class="title" nowrap="true">
			Name
			</th>
			<th width="50" class="title" nowrap="true">
			Default
			</th>
			<th width="50" class="title" nowrap="true">
			Published
			</th>
			<th colspan="2" nowrap="nowrap">
			Reorder
			</th>
			<th nowrap="true" width="20%" align="center">
			Category
			</th>
			<th class="title" nowrap="true" width="20%">
			Linked to User
			</th>
			<th class="title" nowrap="true" width="20%">
			Checked Out 
			</th>
		</tr>
		<?php
		$k = 0;
		for ($i=0, $n=count($rows); $i < $n; $i++) {
			$row = $rows[$i];
			$img = $row->published ? 'tick.png' : 'publish_x.png';
			$task = $row->published ? 'unpublish' : 'publish';
			$alt = $row->published ? 'Published' : 'Unpublished';
			?>
			<tr class="<?php echo "row$k"; ?>"> 
				<td width="20">
				<?php echo $pageNav->rowNumber( $i ); ?>
				</td>
				<td width="20">
				<?php echo mosHTML::idBox( $i, $row->id, ($row->checked_out && $row->checked_out != $my->id ) ); ?>
				</td>
				<td width="20%">
				<?php
				if ( $row->checked_out && ( $row->checked_out != $my->id ) ) {
					?>
					<?php echo $row->name; ?>
					&nbsp;[ <i>Checked Out</i> ]
					<?php
				} else {
					?>
					<a href="#edit" onclick="return listItemTask('cb<?php echo $i;?>','edit')">
					<?php echo $row->name; ?>
					</a>
					<?php
				}
				?>
				</td>
				<?php		
				if ($row->default_con) { 
					?>
					<td width="50" align="center">
					<img src="images/tick.png" alt="default" />
					</td>
					<?php		
				} else { 
					?>
					<td width="50" align="center">&nbsp;
										
					</td>
					<?php		
				} 
				?>
				<td width="10%" align="center">
				<a href="javascript: void(0);" onClick="return listItemTask('cb<?php echo $i;?>','<?php echo $task;?>')">
				<img src="images/<?php echo $img;?>" width="12" height="12" border="0" alt="<?php echo $alt; ?>" />
				</a>
				</td>
				<td>
				<?php echo $pageNav->orderUpIcon( $i ); ?>
				</td>
				<td>
				<?php echo $pageNav->orderDownIcon( $i, $n ); ?>
				</td>
				<td align="center">
				<?php echo $row->category; ?>
				</td>
				<td>
				<?php echo $row->user; ?>
				</td>
				<td>
				<?php echo $row->checked_out ? $row->editor : ""; ?>
				</td>
			</tr>
			<?php 
			$k = 1 - $k;
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


	function editContact( &$row, &$lists, $option, &$params ) {
		global $mosConfig_live_site;

		if ($row->image == '') {
			$row->image = 'blank.png';
		}

		$tabs = new mosTabs(0);

		mosMakeHtmlSafe( $row, ENT_QUOTES, 'misc' );
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			var form = document.adminForm;
			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}

			// do field validation
			if ( form.name.value == "" ) {
				alert( "You must provide a name." );
			} else if ( form.catid.value == 0 ) {
				alert( "Please select a Category." );
			} else {
				submitform( pressbutton );
			}
		}
		</script>
		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<form action="index2.php" method="post" name="adminForm">

		<table class="adminheading">
		<tr> 
			<th>
			<?php echo $row->id ? 'Edit' : 'Add';?> Contact
			</th>
		</tr>
		</table>

		<table width="100%">
		<tr>
			<td width="60%" valign="top">
				<table width="100%" class="adminform">
				<tr>
					<th colspan="2">
					Contact Details
					</th>
				<tr>
				<tr> 
					<td width="20%" align="right">
					Category:
					</td>
					<td width="40%">
					<?php echo $lists['catid'];?>
					</td>
				</tr>
				<tr>
					<td width="20%" align="right">
					Linked to User:
					</td>
					<td >
					<?php echo $lists['user_id'];?>
					</td>
				</tr>
				<tr>
					<td width="20%" align="right">
					Name:
					</td>
					<td >
					<input class="inputbox" type="text" name="name" size="50" maxlength="100" value="<?php echo $row->name; ?>" />
					</td>
				</tr>
				<tr>
					<td align="right">
					Contact's Position:
					</td>
					<td>
					<input class="inputbox" type="text" name="con_position" size="50" maxlength="50" value="<?php echo $row->con_position; ?>" />
					</td>
				</tr>
				<tr> 
					<td align="right">
					E-mail:
					</td>
					<td>
					<input class="inputbox" type="text" name="email_to" size="50" maxlength="100" value="<?php echo $row->email_to; ?>" />
					</td>
				</tr>
				<tr> 
					<td align="right">
					Street Address:
					</td>
					<td>
					<input class="inputbox" type="text" name="address" size="50" value="<?php echo $row->address; ?>" />
					</td>
				</tr>
				<tr> 
					<td align="right">
					Town/Suburb:
					</td>
					<td>
					<input class="inputbox" type="text" name="suburb" size="50" maxlength="50" value="<?php echo $row->suburb;?>" />
					</td>
				</tr>
				<tr> 
					<td align="right">
					State/County:
					</td>
					<td>
					<input class="inputbox" type="text" name="state" size="50" maxlength="20" value="<?php echo $row->state;?>" />
					</td>
				</tr>
				<tr> 
					<td align="right">
					Country:
					</td>
					<td>
					<input class="inputbox" type="text" name="country" size="50" maxlength="50" value="<?php echo $row->country;?>" />
					</td>
				</tr>
				<tr> 
					<td align="right">
					Postal Code/ZIP:
					</td>
					<td>
					<input class="inputbox" type="text" name="postcode" size="25" maxlength="10" value="<?php echo $row->postcode; ?>" />
					</td>
				</tr>
				<tr> 
					<td align="right">
					Telephone:
					</td>
					<td>
					<input class="inputbox" type="text" name="telephone" size="25" maxlength="25" value="<?php echo $row->telephone; ?>" />
					</td>
				</tr>
				<tr> 
					<td align="right">
					Fax:
					</td>
					<td>
					<input class="inputbox" type="text" name="fax" size="25" maxlength="25" value="<?php echo $row->fax; ?>" />
					</td>
				</tr>
				<tr> 
					<td align="right" valign="top">
					Miscellaneous Info:
					</td>
					<td>
					<textarea name="misc" rows="5" cols="50" class="inputbox"><?php echo $row->misc; ?></textarea>
					</td>
				</tr>
				<tr> 
				</table>
			</td>
			<td width="40%" valign="top">
				<?php
				$tabs->startPane("content-pane");
				$tabs->startTab("Publishing","publish-page");
				?>
				<table width="100%" class="adminform">
				<tr>
					<th colspan="2">
					Publishing Info
					</th>
				<tr>
				<tr> 
					<td width="20%" align="right">
					Site Default:
					</td>
					<td > 
					<?php echo $lists['default_con']; ?> 
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
					Access:
					</td>
					<td> 
					<?php echo $lists['access']; ?> 
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;
										
					</td>
				</tr>
				</table>
				<?php
				$tabs->endTab();
				$tabs->startTab("Images","images-page");
				?>
				<table width="100%" class="adminform">
				<tr>
					<th colspan="2">
					Image Info
					</th>
				<tr>
				<tr> 
					<td align="left" width="20%">
					Image:
					</td>
					<td align="left">
					<?php echo $lists['image']; ?>
					</td>
				</tr>
				<tr>
					<td>
					</td>
					<td>
					<script language="javascript" type="text/javascript">
					if (document.forms[0].image.options.value!=''){
						jsimg='../images/stories/' + getSelectedValue( 'adminForm', 'image' );
					} else {
						jsimg='../images/M_images/blank.png';
					}
					document.write('<img src=' + jsimg + ' name="imagelib" width="100" height="100" border="2" alt="Preview" />');
					</script>
					</td>
				</tr>
				</table>
				<?php
				$tabs->endTab();
				$tabs->startTab("Parameters","params-page");
				?>
				<table class="adminform">
				<tr>
					<th>
					Parameters
					</th>
				</tr>
				<tr>
					<td>
					* These Parameters only control what you see when you click to view a Contact item *
					<br /><br />
					</td>
				</tr>
				<tr>
					<td>
					<?php echo $params->render();?>
					</td>
				</tr>
				</table>
				<?php
				$tabs->endTab();
				$tabs->endPane();
				?>
			</td>
		</tr>
		</table>

		<script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
		<input type="hidden" name="option" value="<?php echo $option; ?>" />
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="task" value="" />
		</form>
		<?php
	}
}
?>
