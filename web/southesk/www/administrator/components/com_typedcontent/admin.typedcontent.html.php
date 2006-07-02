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
class HTML_typedcontent {

	/**
	* Writes a list of the content items
	* @param array An array of content objects
	*/
	function showContent( &$rows, &$pageNav, $option, $search, &$lists ) {
		global $my, $mosConfig_live_site;
		?>
		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<form action="index2.php" method="post" name="adminForm">

		<table class="adminheading">
		<tr>
			<th class="edit">
			Static Content Manager
			</th>
			<td>
			Filter:&nbsp;
			</td>
			<td>
			<input type="text" name="search" value="<?php echo $search;?>" class="text_area" onChange="document.adminForm.submit();" />
			</td>
			<td>
			&nbsp;&nbsp;&nbsp;Order:&nbsp;
			</td>
			<td>
			<?php echo $lists['order']; ?>
			</td>
		</tr>
		</table>

		<table class="adminlist">
		<tr>
			<th width="5px">
			<input type="checkbox" name="toggle" value="" onClick="checkAll(<?php echo count( $rows ); ?>);" />
			</th>
			<th class="title" width="40%">
			Title
			</th>
			<th width="5%">
			Published
			</th>
			<th width="10%">
			Access
			</th>
			<th width="5%">
			ID
			</th>
			<th width="10%" align="left">
			Author
			</th>
			<th width="1%" align="left">
			Links
			</th>
			<th width="10%" nowrap="nowrap" align="center">
			Checked Out
			</th>
			<th></th>
		</tr>
		<?php
		$k = 0;
		for ($i=0, $n=count( $rows ); $i < $n; $i++) {
			$row = &$rows[$i];
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
			$link = 'index2.php?option=com_typedcontent&task=edit&id='. $row->id;
			?>
			<tr class="<?php echo "row$k"; ?>">
				<td>
				<?php echo mosHTML::idBox( $i, $row->id, ($row->checked_out && $row->checked_out != $my->id ) ); ?>
				</td>
				<td>
				<?php
				if ( $row->checked_out && ( $row->checked_out != $my->id ) ) {
					?>
					<?php 
					echo $row->title; 
					if ( $row->title_alias ) {
						echo ' (<i>'. $row->title_alias .'</i>)'; 
					}
					?>
					[ <i>Checked Out</i> ]
					<?php
				} else {
					?>
					<a href="<?php echo $link; ?>">
					<?php 
					echo $row->title; 
					if ( $row->title_alias ) {
						echo ' (<i>'. $row->title_alias .'</i>)'; 
					}
					?>
					</a>
					<?php
				}
				?>
				</td>
				<?php
				$now = date( "Y-m-d h:i:s" );
				if ( $now <= $row->publish_up && $row->state == "1" ) {
					$img = 'publish_y.png';
					$alt = 'Published';
				} else if ( ( $now <= $row->publish_down || $row->publish_down == "0000-00-00 00:00:00" ) && $row->state == "1" ) {
					$img = 'publish_g.png';
					$alt = 'Published';
				} else if ( $now > $row->publish_down && $row->state == "1" ) {
					$img = 'publish_r.png';
					$alt = 'Expired';
				} elseif ( $row->state == "0" ) {
					$img = "publish_x.png";
					$alt = 'Unpublished';
				}
				$times = '';
				if (isset($row->publish_up)) {
					if ($row->publish_up == '0000-00-00 00:00:00') {
						$times .= "<tr><td>Start: Always</td></tr>";
					} else {
						$times .= "<tr><td>Start: $row->publish_up</td></tr>";
					}
				}
				if (isset($row->publish_down)) {
					if ($row->publish_down == '0000-00-00 00:00:00') {
						$times .= "<tr><td>Finish: No Expiry</td></tr>";
					} else {
						$times .= "<tr><td>Finish: $row->publish_down</td></tr>";
					}
				}
				if ( $times ) {
					?>
					<td align="center">
					<a href="javascript: void(0);" onMouseOver="return overlib('<table><?php echo $times; ?></table>', CAPTION, 'Publish Information', BELOW, RIGHT);" onMouseOut="return nd();" onClick="return listItemTask('cb<?php echo $i;?>','<?php echo $row->state ? "unpublish" : "publish";?>')">
					<img src="images/<?php echo $img;?>" width="12" height="12" border="0" alt="<?php echo $alt; ?>" />
					</a>
					</td>
					<?php
				}
				?>
				<td align="center">
				<a href="javascript: void(0);" onclick="return listItemTask('cb<?php echo $i;?>','<?php echo $task_access;?>')" <?php echo $color_access; ?>>
				<?php echo $row->groupname;?>
				</a>
				</td>
				<td align="center">
				<?php echo $row->id;?>
				</td>
				<td align="left">
				<?php echo $row->creator;?>
				</td>
				<td align="center">
				<?php echo $row->links;?>
				</td>
				<td align="left" colspan="2">
				<?php
				if ($row->checked_out) {
					?>
					<?php echo $row->editor; ?>
					<?php
				} else {
					?>
					&nbsp;
					<?php
				}
				?>
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
		<br />

		<?php
		mosCommonHTML::ContentLegend();
		?>
	    <script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
		<?php
	}

	function edit( &$row, &$images, &$lists, $myid, &$params, $option, &$menus ) {
		global $mosConfig_live_site;
		//mosMakeHtmlSafe( $row );
		$tabs = new mosTabs(0);
		// used to hide "Reset Hits" when hits = 0
		if ( !$row->hits ) {
			$visibility = "style='display: none; visbility: hidden;'";
		} else {
			$visibility = "";
		}
		?>

		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<link rel="stylesheet" type="text/css" media="all" href="<?php echo $mosConfig_live_site; ?>/includes/js/calendar/calendar-mos.css" title="green" />
		<!-- import the calendar script -->
		<script type="text/javascript" src="<?php echo $mosConfig_live_site; ?>/includes/js/calendar/calendar.js"></script>
		<!-- import the language module -->
		<script type="text/javascript" src="<?php echo $mosConfig_live_site; ?>/includes/js/calendar/lang/calendar-en.js"></script>
		<script language="javascript" type="text/javascript">
		var folderimages = new Array;
		<?php
		$i = 0;
		foreach ($images as $k=>$items) {
			foreach ($items as $v) {
				echo "\n	folderimages[".$i++."] = new Array( '$k','".addslashes( $v->value )."','".addslashes( $v->text )."' );";
			}
		}
		?>

		function submitbutton(pressbutton) {
			var form = document.adminForm;
			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}

			if ( pressbutton ==' resethits' ) {
				if (confirm('Are you sure you want to reset the Hits to Zero? \nAny unsaved changes to this content will be lost.')){
					submitform( pressbutton );
					return;
				} else {
					return;
				}
			}

			if ( pressbutton == 'menulink' ) {
				if ( form.menuselect.value == "" ) {
					alert( "Please select a Menu" );
					return;
				} else if ( form.link_name.value == "" ) {
					alert( "Please enter a Name for this menu item" );
					return;
				} else if ( confirm('Are you sure you want to create a menu link to this Static Content item? \nAny unsaved changes to this content will be lost.' ) ){
					submitform( pressbutton );
				} else {
					return;
				}
			}

			var temp = new Array;
			for (var i=0, n=form.imagelist.options.length; i < n; i++) {
				temp[i] = form.imagelist.options[i].value;
			}
			form.images.value = temp.join( '\n' );

			try {
				document.adminForm.onsubmit();
			}
			catch(e){}
			if (trim(form.title.value) == ""){
				alert( "Content item must have a title" );
			} else if (trim(form.name.value) == ""){
				alert( "Content item must have a name" );
			} else {
				if ( form.reset_hits.checked ) {
					form.hits.value = 0;
				} else {
				}
				<?php getEditorContents( 'editor1', 'introtext' ) ; ?>
				submitform( pressbutton );
			}
		}

		</script>

		<table class="adminheading">
		<tr>
			<th>
			<?php echo $row->id ? 'Edit' : 'Add';?> Typed Content
			</th>
		</tr>
		</table>

		<form action="index2.php" method="post" name="adminForm">

		<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
			<td width="60%" valign="top">
				<table class="adminform">
				<tr>
					<th colspan="3">
					Item Details
					</th>
				<tr>
				<tr>
					<td align="left">
					Title:
					</td>
					<td>
					<input class="inputbox" type="text" name="title" size="30" maxlength="100" value="<?php echo $row->title; ?>" />
					</td>
				</tr>
				<tr>
					<td align="left">
					Title Alias:
					</td>
					<td>
					<input class="inputbox" type="text" name="title_alias" size="30" maxlength="100" value="<?php echo $row->title_alias; ?>" />
					</td>
				</tr>
				<tr>
					<td valign="top" align="left" colspan="2">
					Text: (required)<br />
					<?php
					// parameters : areaname, content, hidden field, width, height, rows, cols
					editorArea( 'editor1',  $row->introtext, 'introtext', 500, 400, '65', '50' );
					?>
					</td>
				</tr>
				</table>
			</td>
			<td width="40%" valign="top">
				<?php
				$tabs->startPane("content-pane");
				$tabs->startTab("Publishing","publish-page");
				?>
				<table class="adminform">
				<tr>
					<th colspan="2">
					Publishing Info
					</th>
				<tr>
				<tr>
					<td valign="top" align="right">
					State:
					</td>
					<td>
					<?php echo $row->state > 0 ? 'Published' : 'Draft Unpublished'; ?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					Published:
					</td>
					<td>
					<input type="checkbox" name="published" value="1" <?php echo $row->state ? 'checked="checked"' : ''; ?> />
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					Access Level:
					</td>
					<td>
					<?php echo $lists['access']; ?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					Author Alias:
					</td>
					<td>
					<input type="text" name="created_by_alias" size="30" maxlength="100" value="<?php echo $row->created_by_alias; ?>" class="inputbox" />
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					Change Creator:
					</td>
					<td>
					<?php echo $lists['created_by']; ?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					Override Created Date
					</td>
					<td>
					<input class="inputbox" type="text" name="created" id="created" size="25" maxlength="19" value="<?php echo $row->created; ?>" />
					<input name="reset" type="reset" class="button" onClick="return showCalendar('created', 'y-mm-dd');" value="...">
					</td>
				</tr>
				<tr>
					<td width="20%" align="right">
					Start Publishing:
					</td>
					<td width="80%">
					<input class="inputbox" type="text" name="publish_up" id="publish_up" size="25" maxlength="19" value="<?php echo $row->publish_up; ?>" />
					<input type="reset" class="button" value="..." onclick="return showCalendar('publish_up', 'y-mm-dd');">
					</td>
				</tr>
				<tr>
					<td width="20%" align="right">
					Finish Publishing:
					</td>
					<td width="80%">
					<input class="inputbox" type="text" name="publish_down" id="publish_down" size="25" maxlength="19" value="<?php echo $row->publish_down; ?>" />
					<input type="reset" class="button" value="..." onclick="return showCalendar('publish_down', 'y-mm-dd');">
					</td>
				</tr>
				</table>
				<br />
				<table class="adminform">
				<tr>
					<td width="90px" valign="top" align="right">
					<strong>State</strong>
					</td>
					<td>
					<?php echo $row->state > 0 ? 'Published' : ($row->state < 0 ? 'Archived' : 'Draft Unpublished');?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					<strong>Hits</strong>
					</td>
					<td>
					<?php echo $row->hits;?>
					<div <?php echo $visibility; ?>>
					<input name="reset_hits" type="button" class="button" value="Reset Hit Count" onClick="submitbutton('resethits');">
					</div>
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					<strong>Version</strong>
					</td>
					<td>
					<?php echo "$row->version";?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					<strong>Created</strong>
					</td>
					<td>
					<?php echo $row->created ? "$row->created</td></tr><tr><td valign='top' align='right'><strong>By</strong></td><td>$row->creator" : "New document";?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					<strong>Last Modified</strong>
					</td>
					<td>
					<?php echo $row->modified ? "$row->modified</td></tr><tr><td valign='top' align='right'><strong>By</strong></td><td>$row->modifier" : "Not modified";?>
					</td>
				</tr>
				<tr>
					<td valign="top" align="right">
					<strong>Expires</strong>
					</td>
					<td>
					<?php echo "$row->publish_down";?>
					</td>
				</tr>
				</table>
				<?php
				$tabs->endTab();
				$tabs->startTab("Images","images-page");
				?>
				<table class="adminform">
				<tr>
					<th colspan="2">
					MOSImage Control
					</th>
				<tr>
				<tr>
					<td colspan="6">
					Sub-folder: <?php echo $lists['folders'];?>
					</td>
				</tr>
				<tr>
					<td>
					Gallery Images
					<br />
					<?php echo $lists['imagefiles'];?>
					<br />
					<input class="button" type="button" value="Add" onClick="addSelectedToList('adminForm','imagefiles','imagelist')" />
					</td>
					<td valign="top">
					<img name="view_imagefiles" src="../images/M_images/blank.png" width="100" />
					</td>
				</tr>
				<tr>
					<td>
					Content Images:
					<br />
					<?php echo $lists['imagelist'];?>
					<br />
					<input class="button" type="button" value="up" onClick="moveInList('adminForm','imagelist',adminForm.imagelist.selectedIndex,-1)" />
					<input class="button" type="button" value="down" onClick="moveInList('adminForm','imagelist',adminForm.imagelist.selectedIndex,+1)" />
					<input class="button" type="button" value="remove" onClick="delSelectedFromList('adminForm','imagelist')" />
					</td>
					<td valign="top">
					<img name="view_imagelist" src="../images/M_images/blank.png" width="100" />
					</td>
				</tr>
				<tr>
					<td>
					Edit the image selected:
						<table>
						<tr>
							<td align="right">
							Source
							</td>
							<td>
							<input type="text" name= "_source" value="" />
							</td>
						</tr>
						<tr>
							<td align="right">
							Align
							</td>
							<td>
							<?php echo $lists['_align']; ?>
							</td>
						</tr>
						<tr>
							<td align="right">
							Alt Text
							</td>
							<td>
							<input type="text" name="_alt" value="" />
							</td>
						</tr>
						<tr>
							<td align="right">
							Border
							</td>
							<td>
							<input type="text" name="_border" value="" size="3" maxlength="1" />
							</td>
						</tr>
						<tr>
							<td align="right"></td>
							<td>
							<input class="button" type="button" value="Apply" onClick="applyImageProps()" />
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<?php
				$tabs->endTab();
				$tabs->startTab("Parameters","params-page");
				?>
				<table class="adminform">
				<tr>
					<th colspan="2">
					Parameter Control
					</th>
				<tr>
				<tr>
					<td>
					<?php echo $params->render();?>
					</td>
				</tr>
				</table>
				<?php
				$tabs->endTab();
				$tabs->startTab("Meta Info","metadata-page");
				?>
				<table class="adminform">
				<tr>
					<th colspan="2">
					Meta Data
					</th>
				<tr>
				<tr>
					<td align="left">
					Description:<br />
					<textarea class="inputbox" cols="40" rows="5" name="metadesc" style="width:300px"><?php echo str_replace('&','&amp;',$row->metadesc); ?></textarea>
					</td>
				</tr>
				<tr>
					<td align="left">
					Keywords:<br />
					<textarea class="inputbox" cols="40" rows="5" name="metakey" style="width:300px"><?php echo str_replace('&','&amp;',$row->metakey); ?></textarea>
					</td>
				</tr>
				</table>
				<?php
				$tabs->endTab();
				if ($row->id) {
				$tabs->startTab("Link to Menu","link-page");
				?>
				<table class="adminform">
				<tr>
					<th colspan="2">
					Link to Menu
					</th>
				<tr>
				<tr>
					<td colspan="2">
					This will create a 'Link - Static Content' in the menu you select
					<br /><br />
					</td>
				<tr>
				<tr>
					<td valign="top" width="90px">
					Select a Menu
					</td>
					<td>
					<?php echo $lists['menuselect']; ?>
					</td>
				<tr>
				<tr>
					<td valign="top" width="90px">
					Menu Item Name
					</td>
					<td>
					<input type="text" name="link_name" class="inputbox" value="" size="30" />
					</td>
				<tr>
				<tr>
					<td>
					</td>
					<td>
					<input name="menu_link" type="button" class="button" value="Link to Menu" onClick="submitbutton('menulink');" />
					</td>
				<tr>
				<tr>
					<th colspan="2">
					Existing Menu Links
					</th>
				</tr>
				<?php
				if ( $menus == NULL ) {
					?>
					<tr>
						<td colspan="2">
						None
						</td>
					</tr>
					<?php
				} else {
					foreach( $menus as $menu ) {
						?>
						<tr>
							<td colspan="2">
							<hr />
							</td>
						</tr>
						<tr>
							<td width="90px" valign="top">
							Menu
							</td>
							<td>
							<?php echo $menu->menutype; ?>
							</td>
						</tr>
						<tr>
							<td width="90px" valign="top">
							Link Name
							</td>
							<td>
							<strong>
							<?php echo $menu->name; ?>
							</strong>
							</td>
						</tr>
						<tr>
							<td width="90px" valign="top">
							State
							</td>
							<td>
							<?php
							switch ( $menu->published ) {
								case -2:
									echo '<font color="red">Trashed</font>';
									break;
								case 0:
									echo 'UnPublished';
									break;
								case 1:
								default:
									echo '<font color="green">Published</font>';
									break;
							}
							?>
							</td>
						</tr>
						<?php
					}
				}
				?>
				<tr>
					<td colspan="2">
					</td>
				</tr>
				</table>
				<?php
				$tabs->endTab();
				}
				$tabs->endPane();
				?>
		    </td>
		</tr>
		</table>

		<input type="hidden" name="images" value="" />
		<input type="hidden" name="option" value="<?php echo $option; ?>" />
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="hits" value="<?php echo $row->hits; ?>" />
		<input type="hidden" name="task" value="" />
		</form>
				<script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
		<?php
	}
}
?>
