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
class HTML_content {

	/**
	* Writes a list of the content items
	* @param array An array of content objects
	*/
	function showContent( &$rows, $section, &$lists, $search, $pageNav, $option, $all=NULL, $redirect ) {
		global $my, $mosConfig_live_site;
		?>
		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<form action="index2.php" method="post" name="adminForm">

		<table class="adminheading">
		<tr>
			<?php
			if ( $all ) {
				?>
				<th class="edit">
				All Content Items
				</th>
				<?php
			} else {
				?>
				<th class="edit">
				<?php echo $section->title; ?> Items
				</th>
				<?php
			}
			?>
			<td>
			Filter:
			</td>
			<td>
			<input type="text" name="search" value="<?php echo $search;?>" class="text_area" onChange="document.adminForm.submit();" />
			</td>
			<?php
			if ( $all ) {
				?>
				<td width="right">
				<?php echo $lists['sectionid'];?>
				</td>
				<?php
			}
			?>
			<td width="right">
			<?php echo $lists['catid'];?>
			</td>
		</tr>
		</table>

		<table class="adminlist">
		<tr>
			<th width="5">
			<input type="checkbox" name="toggle" value="" onClick="checkAll(<?php echo count( $rows ); ?>);" />
			</th>
			<th class="title" width="30%">
			Title
			</th>
			<th width="5%">
			Published
			</th>
			<th nowrap="nowrap" width="5%">
			Front Page
			</th>
			<th colspan="2" align="center" width="5%">
			Reorder
			</th>
			<th width="10%">
			Access
			</th>
			<th width="2%">
			ID
			</th>
			<?php
			if ( $all ) {
				?>
				<th align="left">
				Section
				</th>
				<?php
			}
			?>
			<th align="left">
			Category
			</th>
			<th nowrap="nowrap">
			Checked Out
			</th>
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
			$link = 'index2.php?option=com_content&sectionid='. $redirect .'&task=edit&id='. $row->id;
			?>
			<tr class="<?php echo "row$k"; ?>">
				<td>
				<?php echo mosHTML::idBox( $i, $row->id, ($row->checked_out && $row->checked_out != $my->id ) ); ?>
				</td>
				<td>
				<?php
				if ( $row->checked_out && ( $row->checked_out != $my->id ) ) {
					?>
					<?php echo $row->title; ?> [ <i>Checked Out</i> ]
					<?php
				} else {
					?>
					<a href="<?php echo $link; ?>">
					<?php echo $row->title; ?>
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
				<a href="javascript: void(0);" onClick="return listItemTask('cb<?php echo $i;?>','toggle_frontpage')">
				<img src="images/<?php echo ( $row->frontpage ) ? 'tick.png' : 'publish_x.png';?>" width="12" height="12" border="0" alt="<?php echo ( $row->frontpage ) ? 'Yes' : 'No';?>" />
				</a>
				</td>
				<td align="right">
				<?php echo $pageNav->orderUpIcon( $i, ($row->catid == @$rows[$i-1]->catid) ); ?>
				</td>
				<td align="left">
				<?php echo $pageNav->orderDownIcon( $i, $n, ($row->catid == @$rows[$i+1]->catid) ); ?>
				</td>
				<td align="center">
				<a href="javascript: void(0);" onclick="return listItemTask('cb<?php echo $i;?>','<?php echo $task_access;?>')" <?php echo $color_access; ?>>
				<?php echo $row->groupname;?>
				</a>
				</td>
				<td align="left">
				<?php echo $row->id; ?>
				</td>
				<?php
				if ( $all ) {
					?>
					<td align="left">
					<?php echo $row->section_name; ?>
					</td>
					<?php
				}
				?>
				<td align="left">
				<?php echo $row->name; ?>
				</td>
				<td align="center">
				<?php echo $row->checked_out ? $row->editor : ""; ?>
				</td>
			</tr>
			<?php
			$k = 1 - $k;
		}
		?>
		</table>
		<?php echo $pageNav->getListFooter(); ?>
		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="sectionid" value="<?php echo $section->id;?>" />
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="boxchecked" value="0" />
		<input type="hidden" name="redirect" value="<?php echo $redirect;?>" />
		</form>
		<br />

		<?php
		mosCommonHTML::ContentLegend();
		?>
		<script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
		<?php
	}


	/**
	* Writes a list of the content items
	* @param array An array of content objects
	*/
	function showArchive( &$rows, $section, &$lists, $search, $pageNav, $option, $all=NULL, $redirect ) {
		global $my;
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			if (pressbutton == 'remove') {
				if (document.adminForm.boxchecked.value == 0) {
					alert('Please make a selection from the list to send to Trash');
				} else if ( confirm('Are you sure you want to Trash the selected items? \nThis will not permanently delete the items.')) {
					submitform('remove');
				}
			} else {
				submitform(pressbutton);
			}
		}
		</script>
		<form action="index2.php" method="post" name="adminForm">

		<table class="adminheading">
		<tr>
			<th class="edit">
			<?php echo $section->title; ?>
			Archive
			<?php
			if ( $all ) {
				?>
				Manager
				<?php
			}
			?>
			</th>
			<td>
			Filter:
			</td>
			<td>
			<input type="text" name="search" value="<?php echo $search;?>" class="textarea" onChange="document.adminForm.submit();" />
			</td>
			<?php
			if ( $all ) {
				?>
				<td width="right">
				<?php echo $lists['sectionid'];?>
				</td>
				<?php
			}
			?>
			<td width="right">
			<?php echo $lists['catid'];?>
			</td>
		</tr>
		</table>

		<table class="adminlist">
		<tr>
			<th width="20">
			<input type="checkbox" name="toggle" value="" onClick="checkAll(<?php echo count( $rows ); ?>);" />
			</th>
			<th class="title" width="50%">
			Title
			</th>
			<th width="15%" align="left">
			Category
			</th>
		</tr>
		<?php
		$k = 0;
		for ($i=0, $n=count( $rows ); $i < $n; $i++) {
			$row = &$rows[$i];
			?>
			<tr class="<?php echo "row$k"; ?>">
				<td width="20">
				<?php echo mosHTML::idBox( $i, $row->id ); ?>
				</td>
				<td width="85%">
				<?php echo $row->title; ?>
				</td>
				<td width="15%">
				<?php echo $row->name; ?>
				</td>
			</tr>
			<?php
			$k = 1 - $k;
		}
		?>
		</table>

		<?php echo $pageNav->getListFooter(); ?>
		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="sectionid" value="<?php echo $section->id;?>" />
		<input type="hidden" name="task" value="showarchive" />
		<input type="hidden" name="returntask" value="showarchive" />
		<input type="hidden" name="boxchecked" value="0" />
		<input type="hidden" name="redirect" value="<?php echo $redirect;?>" />
		</form>
		<?php
	}


	/**
	* Writes the edit form for new and existing content item
	*
	* A new record is defined when <var>$row</var> is passed with the <var>id</var>
	* property set to 0.
	* @param mosContent The category object
	* @param string The html for the groups select list
	*/
	function editContent( &$row, $section, &$lists, &$sectioncategories, &$images, $myid, &$params, $option, $redirect, &$menus ) {
		global $mosConfig_live_site;

		$sec = $section; 	//used in metadata include

		mosMakeHtmlSafe( $row );

		$mod_date = null;
		$create_date = null;
		if (intval( $row->modified ) <> 0) {
			$mod_date = mosFormatDate( $row->modified );
		}
		if (intval( $row->created ) <> 0) {
			$create_date = mosFormatDate( $row->created );
		}

		$tabs = new mosTabs(0);

		// used to hide "Reset Hits" when hits = 0
		if ( !$row->hits ) {
			$visibility = "style='display: none; visbility: hidden;'";
		} else {
			$visibility = "";
		}
		?>
		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<link rel="stylesheet" type="text/css" media="all" href="../includes/js/calendar/calendar-mos.css" title="green" />
		<!-- import the calendar script -->
		<script type="text/javascript" src="../includes/js/calendar/calendar.js"></script>
		<!-- import the language module -->
		<script type="text/javascript" src="../includes/js/calendar/lang/calendar-en.js"></script>
		<script language="javascript" type="text/javascript">

		var sectioncategories = new Array;
		<?php
		$i = 0;
		foreach ($sectioncategories as $k=>$items) {
			foreach ($items as $v) {
				echo "sectioncategories[".$i++."] = new Array( '$k','".addslashes( $v->value )."','".addslashes( $v->text )."' );\n\t\t";
			}
		}
		?>


		var folderimages = new Array;
		<?php
		$i = 0;
		foreach ($images as $k=>$items) {
			foreach ($items as $v) {
				echo "folderimages[".$i++."] = new Array( '$k','".addslashes( $v->value )."','".addslashes( $v->text )."' );\n\t\t";
			}
		}
		?>


		function submitbutton(pressbutton) {
			var form = document.adminForm;

			if (pressbutton =='resethits') {
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
				} else if ( confirm('Are you sure you want to create a menu link to this Content item? \nAny unsaved changes to this content will be lost.' ) ){
					submitform( pressbutton );
				} else {
					return;
				}
			}

			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}
			// assemble the images back into one field
			var temp = new Array;
			for (var i=0, n=form.imagelist.options.length; i < n; i++) {
				temp[i] = form.imagelist.options[i].value;
			}
			form.images.value = temp.join( '\n' );

			// do field validation
			if (form.title.value == ""){
				alert( "Content item must have a title" );
			} else if (form.sectionid.value == "-1"){
				alert( "You must select a Section." );
			} else if (form.catid.value == "-1"){
				alert( "You must select a Category." );
			} else {
				<?php getEditorContents( 'editor1', 'introtext' ) ; ?>
				<?php getEditorContents( 'editor2', 'fulltext' ) ; ?>
				submitform( pressbutton );
			}
		}
		</script>

		<form action="index2.php" method="post" name="adminForm">
		<input type="hidden" name="images" value="" />
		<table class="adminheading">
		<tr>
			<th class="edit">
			<?php echo $row->id ? 'Editing' : 'Adding';?> content in
			<?php echo $section;?>
			section
			</th>
		</tr>
		</table>

		<table cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td width="60%" valign="top">
				<table width="100%" class="adminform">
				<tr>
					<td width="100%">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr>
							<th colspan="4">
							Item Details
							</th>
						<tr>
						<tr>
							<td>
							Title:
							</td>
							<td>
							<input class="text_area" type="text" name="title" size="30" maxlength="100" value="<?php echo $row->title; ?>" />
							</td>
							<td>
							Section:
							</td>
							<td>
							<?php echo $lists['sectionid']; ?>
							</td>
						</tr>
						<tr>
							<td>
							Title Alias:
							</td>
							<td>
							<input name="title_alias" type="text" class="text_area" id="title_alias" value="<?php echo $row->title_alias; ?>" size="30" maxlength="100" />
							</td>
							<td>
							Category:
							</td>
							<td>
							<?php echo $lists['catid']; ?>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%">
					Intro Text: (required)
					<br /><?php
					// parameters : areaname, content, hidden field, width, height, rows, cols
					editorArea( 'editor1',  $row->introtext , 'introtext', 500, 200, '50', '15' ) ; ?>
					</td>
				</tr>
				<tr>
					<td width="100%">
					Main Text: (optional)
					<br /><?php
					// parameters : areaname, content, hidden field, width, height, rows, cols
					editorArea( 'editor2',  $row->fulltext , 'fulltext', 500, 350, '50', '15' ) ; ?>
					</td>
				</tr>
				</table>
			</td>
			<td valign="top" width="40%">
				<table>
				<tr>
					<td>
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
						Show on Frontpage:
						</td>
						<td>
						<input type="checkbox" name="frontpage" value="1" <?php echo $row->frontpage ? 'checked="checked"' : ''; ?> />
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
						<?php echo $lists['access']; ?> </td>
						</tr>
					<tr>
						<td valign="top" align="right">
						Author Alias:
						</td>
						<td>
						<input type="text" name="created_by_alias" size="30" maxlength="100" value="<?php echo $row->created_by_alias; ?>" class="text_area" />
						</td>
					</tr>
					<tr>
						<td valign="top" align="right">
						Change Creator:
						</td>
						<td>
						<?php echo $lists['created_by']; ?> </td>
					</tr>
					<tr>
						<td valign="top" align="right">Ordering:</td>
						<td>
						<?php echo $lists['ordering']; ?> </td>
					</tr>
					<tr>
						<td valign="top" align="right">
						Override Created Date
						</td>
						<td>
						<input class="text_area" type="text" name="created" id="created" size="25" maxlength="19" value="<?php echo $row->created; ?>" />
						<input name="reset" type="reset" class="button" onClick="return showCalendar('created', 'y-mm-dd');" value="...">
						</td>
					</tr>
					<tr>
						<td valign="top" align="right">
						Start Publishing:
						</td>
						<td>
						<input class="text_area" type="text" name="publish_up" id="publish_up" size="25" maxlength="19" value="<?php echo $row->publish_up; ?>" />
						<input type="reset" class="button" value="..." onClick="return showCalendar('publish_up', 'y-mm-dd');">
						</td>
					</tr>
					<tr>
						<td valign="top" align="right">
						Finish Publishing:
						</td>
						<td>
						<input class="text_area" type="text" name="publish_down" id="publish_down" size="25" maxlength="19" value="<?php echo $row->publish_down; ?>" />
						<input type="reset" class="button" value="..." onClick="return showCalendar('publish_down', 'y-mm-dd');">
						</td>
					</tr>
					</table>
					<br />
					<table class="adminform">
					<tr>
						<td width="90px" valign="top" align="right">
						<strong>State:</strong>
						</td>
						<td>
						<?php echo $row->state > 0 ? 'Published' : ($row->state < 0 ? 'Archived' : 'Draft Unpublished');?>
						</td>
					</tr>
					<tr >
						<td valign="top" align="right">
						<strong>
						Hits
						</strong>:
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
						<strong>
						Revised
						</strong>:
						</td>
						<td>
						<?php echo $row->version;?> times
						</td>
					</tr>
					<tr>
						<td valign="top" align="right">
						<strong>
						Created
						</strong>
						</td>
						<td>
						<?php echo $row->created ? "$create_date</td></tr><tr><td valign='top' align='right'><strong>By</strong></td><td>$row->creator" : "New document"; ?>
						</td>
					</tr>
					<tr>
						<td valign="top" align="right">
						<strong>
						Last Modified
						</strong>
						</td>
						<td>
						<?php echo $row->modified ? "$mod_date</td></tr><tr><td valign='top' align='right'><strong>By</strong></td><td>$row->modifier" : "Not modified";?>
						</td>
					</tr>
					</table>
					<?php
					$tabs->endTab();
					$tabs->startTab("Images","images-page");
					?>
					<table class="adminform" width="100%">
					<tr>
						<th colspan="2">
						MOSImage Control
						</th>
					<tr>
					<tr>
						<td colspan="6">Sub-folder: <?php echo $lists['folders'];?></td>
					</tr>
					<tr>
						<td>
						Gallery Images:
						<br />
						<?php echo $lists['imagefiles'];?>
						</td>
						<td valign="top">
						<img name="view_imagefiles" src="../images/M_images/blank.png" width="100" />
						</td>
					</tr>
					<tr>
						<td>
						<input class="button" type="button" value="Add" onClick="addSelectedToList('adminForm','imagefiles','imagelist')" />
						</td>
					</tr>
					<tr>
						<td>
						Content Images:
						<br />
						<?php echo $lists['imagelist'];?>
						</td>
						<td valign="top">
						<img name="view_imagelist" src="../images/M_images/blank.png" width="100" />
						</td>
					</tr>
					<tr>
						<td>
						<input class="button" type="button" value="up" onClick="moveInList('adminForm','imagelist',adminForm.imagelist.selectedIndex,-1)" />
						<input class="button" type="button" value="down" onClick="moveInList('adminForm','imagelist',adminForm.imagelist.selectedIndex,+1)" />
						<input class="button" type="button" value="remove" onClick="delSelectedFromList('adminForm','imagelist')" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							Edit the image selected:
							<table>
							<tr>
								<td align="right">
								Source:
								</td>
								<td>
								<input class="text_area" type="text" name= "_source" value="" />
								</td>
							</tr>
							<tr>
								<td align="right">
								Align:
								</td>
								<td>
								<?php echo $lists['_align']; ?>
								</td>
							</tr>
							<tr>
								<td align="right">
								Alt Text:
								</td>
								<td>
								<input class="text_area" type="text" name="_alt" value="" />
								</td>
							</tr>
							<tr>
								<td align="right">
								Border:
								</td>
								<td>
								<input class="text_area" type="text" name="_border" value="" size="3" maxlength="1" />
								</td>
							</tr>
							<tr>
								<td colspan="2">
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
						* These Parameters only control what you see when you click to view an item fully *
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
					$tabs->startTab("Meta Info","metadata-page");
					?>
					<table class="adminform">
					<tr>
						<th colspan="2">
						Meta Data
						</th>
					<tr>
					<tr>
						<td>
						Description:
						<br />
						<textarea class="text_area" cols="30" rows="3" style="width:300px; height:50px" name="metadesc" width="500"><?php echo str_replace('&','&amp;',$row->metadesc); ?></textarea>
						</td>
					</tr>
						<tr>
						<td>
						Keywords:
						<br />
						<textarea class="text_area" cols="30" rows="3" style="width:300px; height:50px" name="metakey" width="500"><?php echo str_replace('&','&amp;',$row->metakey); ?></textarea>
						</td>
					</tr>
					<tr>
						<td>
						<input type="button" class="button" value="Add Sect/Cat/Title" onClick="f=document.adminForm;f.metakey.value=document.adminForm.sectionid.options[document.adminForm.sectionid.selectedIndex].text+', '+getSelectedText('adminForm','catid')+', '+f.title.value+f.metakey.value;" />
						</td>
					</tr>
					</table>
					<?php
					$tabs->endTab();
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
						This will create a 'Link - Content Item' in the menu you select
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
								<hr/>
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
					$tabs->endPane();
					?>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="version" value="<?php echo $row->version; ?>" />
		<input type="hidden" name="mask" value="0" />
		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="redirect" value="<?php echo $redirect;?>" />
		<input type="hidden" name="task" value="" />
		</form>
		<script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
		<?php

	}


	/**
	* Form to select Section/Category to move item(s) to
	* @param array An array of selected objects
	* @param int The current section we are looking at
	* @param array The list of sections and categories to move to
	*/
	function moveSection( $cid, $sectCatList, $option, $sectionid, $items ) {
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			var form = document.adminForm;
			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}

			// do field validation
			if (!getSelectedValue( 'adminForm', 'sectcat' )) {
				alert( "Please select something" );
			} else {
				submitform( pressbutton );
			}
		}
		</script>

		<form action="index2.php" method="post" name="adminForm">
		<br />
		<table class="adminheading">
		<tr>
			<th class="edit">
			Move Items
			</th>
		</tr>
		</table>

		<br />
		<table class="adminform">
		<tr>
			<td align="left" valign="top" width="40%">
			<strong>Move to Section/Category:</strong>
			<br />
			<?php echo $sectCatList; ?>
			<br /><br />
			</td>
			<td align="left" valign="top">
			<strong>Items being Moved:</strong>
			<br />
			<?php
			echo "<ol>";
			foreach ( $items as $item ) {
				echo "<li>". $item->title ."</li>";
			}
			echo "</ol>";
			?>
			</td>
		</tr>
		</table>
		<br /><br />

		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="sectionid" value="<?php echo $sectionid; ?>" />
		<input type="hidden" name="task" value="" />
		<?php
		foreach ($cid as $id) {
			echo "\n<input type=\"hidden\" name=\"cid[]\" value=\"$id\" />";
		}
		?>
		</form>
		<?php
	}



	/**
	* Form to select Section/Category to copys item(s) to
	*/
	function copySection( $option, $cid, $sectCatList, $sectionid, $items  ) {
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			var form = document.adminForm;
			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}

			// do field validation
			if (!getSelectedValue( 'adminForm', 'sectcat' )) {
				alert( "Please select a Section/Category to copy the items to" );
			} else {
				submitform( pressbutton );
			}
		}
		</script>
		<form action="index2.php" method="post" name="adminForm">
		<br />
		<table class="adminheading">
		<tr>
			<th class="edit">
			Copy Content Items
			</th>
		</tr>
		</table>

		<br />
		<table class="adminform">
		<tr>
			<td align="left" valign="top" width="40%">
			<strong>Copy to Section/Category:</strong>
			<br />
			<?php echo $sectCatList; ?>
			<br /><br />
			</td>
			<td align="left" valign="top">
			<strong>Items being copied:</strong>
			<br />
			<?php
			echo "<ol>";
			foreach ( $items as $item ) {
				echo "<li>". $item->title ."</li>";
			}
			echo "</ol>";
			?>
			</td>
		</tr>
		</table>
		<br /><br />

		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="sectionid" value="<?php echo $sectionid; ?>" />
		<input type="hidden" name="task" value="" />
		<?php
		foreach ($cid as $id) {
			echo "\n<input type=\"hidden\" name=\"cid[]\" value=\"$id\" />";
		}
		?>
		</form>
		<?php
	}


}
?>
