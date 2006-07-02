<?php
/**
* @version $Id: admin.categories.html.php,v 1.33 2004/09/22 22:04:44 stingrey Exp $
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
class categories_html {

	/**
	* Writes a list of the categories for a section
	* @param array An array of category objects
	* @param string The name of the category section
	*/
	function show( &$rows, $section, $section_name, $myid, &$pageNav, &$lists, $type ) {
		global $my;
		/*echo "<pre>";
		print_R($rows);		*/
		?>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<?php
			if ( $section == 'content') {
				?>
				<th class="categories">
				Category Manager
				</th>
				<td>
				Filter:
				</td>
				<td width="right"> 
				<?php echo $lists['sectionid'];?> 
				</td>
				<?php
			} else {
				?>
				<th class="categories">
				<?php echo $section_name;?> Categories
				</th>
				<?php
			}
			?>
		</tr>
		</table>
		
		<table class="adminlist">
		<tr>
			<th width="20">
			#
			</th>
			<th width="20">
			<input type="checkbox" name="toggle" value="" onClick="checkAll(<?php echo count( $rows );?>);" />
			</th>
			<th class="title">
			Category Name
			</th>
			<th width="10%">
			Published
			</th>
			<?php
			if ( $section <> 'content') {
				?>
				<th colspan="2">
				Reorder
				</th>
				<?php
			}
			?>
			<th width="10%">
			Access
			</th>
			<?php
			if ( $section == 'content') {
				?>
				<th width="12%" align="left">
				Section
				</th>
				<?php
			}
			?>
			<th width="12%">
			Category ID
			</th>
			<th width="12%">
			# Active
			</th>
			<?php
			if ( $type == 'content') {
				?>
				<th width="12%">
				# Trash
				</th>
				<?php
			}
			?>
			<th width="12%">
			Checked Out
			</th>
		  </tr>
		<?php
		$k = 0;
		for ($i=0, $n=count( $rows ); $i < $n; $i++) {
			$row = &$rows[$i];
			$img = $row->published ? 'tick.png' : 'publish_x.png';
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
				<td width="20" align="right">
				<?php echo $pageNav->rowNumber( $i ); ?>
				</td>
				<td width="20">
				<?php echo mosHTML::idBox( $i, $row->id, ($row->checked_out_contact_category && $row->checked_out_contact_category != $my->id ) ); ?>
				</td>
				<td width="35%">
				<?php
				if ( $row->checked_out_contact_category && ( $row->checked_out_contact_category != $my->id ) ) {
					?>
					<?php echo $row->name .' ( '. $row->title .' )'; ?>
					&nbsp;[ <i>Checked Out</i> ]
					<?php
				} else {
					?>
					<a href="#edit" onClick="return listItemTask('cb<?php echo $i;?>','edit')">
					<?php echo $row->name .' ( '. $row->title .' )'; ?>
					</a>
					<?php
				}
				?>
				</td>
				<td align="center">
				<a href="javascript: void(0);" onClick="return listItemTask('cb<?php echo $i;?>','<?php echo $task;?>')">
				<img src="images/<?php echo $img;?>" width="12" height="12" border="0" alt="<?php echo $alt;?>" />
				</a>
				</td>
				<?php
				if ( $section <> 'content' ) {
					?>
					<td>
					<?php echo $pageNav->orderUpIcon( $i ); ?>
					</td>
					<td>
					<?php echo $pageNav->orderDownIcon( $i, $n ); ?>
					</td>
					<?php
				}
				?>
				<td align="center">
				<a href="javascript: void(0);" onclick="return listItemTask('cb<?php echo $i;?>','<?php echo $task_access;?>')" <?php echo $color_access; ?>>
				<?php echo $row->groupname;?>
				</a>
				</td>
				<?php
				if ( $section == 'content' ) {
					?>
					<td align="left">
					<?php echo $row->section_name; ?>
					</td>
					<?php
				}
				?>
				<td align="center">
				<?php echo $row->id; ?>
				</td>
				<td align="center">
				<?php echo $row->active; ?>
				</td>
				<?php
				if ( $type == 'content') {
					?>
					<td align="center">
					<?php echo $row->trash; ?>
					</td>
					<?php 
				} ?>
				<td align="center">
				<?php  echo $row->checked_out_contact_category ? $row->editor : ""; ?>				
				</td>
				<?php		
				$k = 1 - $k; 
				?>
			</tr>
			<?php	
		} 
		?>
		</table>
		<?php echo $pageNav->getListFooter(); ?>
	
		<input type="hidden" name="option" value="com_categories" />
		<input type="hidden" name="section" value="<?php echo $section;?>" />
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="chosen" value="" />
		<input type="hidden" name="act" value="" />
		<input type="hidden" name="boxchecked" value="0" />
		<input type="hidden" name="type" value="<?php echo $type; ?>" />
		</form>
		<?php
	}

	/**
	* Writes the edit form for new and existing categories
	* @param mosCategory The category object
	* @param string
	* @param array
	*/
	function edit( &$row, $section, &$lists, $redirect, $menus ) {
		global $mosConfig_live_site;
		if ($row->image == "") {
			$row->image = 'blank.png';
		}
		mosMakeHtmlSafe( $row, ENT_QUOTES, 'description' );
		?>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton, section) {
			var form = document.adminForm;
			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}

			if ( pressbutton == 'menulink' ) {
				if ( form.menuselect.value == "" ) {
					alert( "Please select a Menu" );
					return;
				} else if ( form.link_type.value == "" ) {
					alert( "Please select a menu type" );
					return;
				} else if ( form.link_name.value == "" ) {
					alert( "Please enter a Name for this menu item" );
					return;
				} else if ( confirm('Are you sure you want to create a menu link? \nAny unsaved changes to this content will be lost.' ) ){
					submitform( pressbutton );
				} else {
					return;
				}
			}

			if ( form.name.value == "" ) {
				alert("Category must have a name");
			} else {
				<?php getEditorContents( 'editor1', 'description' ) ; ?>
				submitform(pressbutton);
			}
		}
		</script>
	
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<th class="categories">
			<?php echo $row->id ? 'Edit' : 'Add';?> Category <?php echo $row->name; ?>
			</th>
		</tr>
		</table>

		<table width="100%">
		<tr>
			<td valign="top">
				<table class="adminform">
				<tr>
					<th colspan="3">
					Category Details
					</th>
				<tr>
				<tr>
					<td>
					Category Title:
					</td>
					<td colspan="2">
					<input class="text_area" type="text" name="title" value="<?php echo $row->title; ?>" size="50" maxlength="50" title="A short name to appear in menus" />
					</td>
				</tr>
				<tr>
					<td>
					Category Name:
					</td>
					<td colspan="2">
					<input class="text_area" type="text" name="name" value="<?php echo $row->name; ?>" size="50" maxlength="255" title="A long name to be displayed in headings" />
					</td>
				</tr>
				<tr>
					<td>
					Section:
					</td>
					<td colspan="2">
					<?php echo $lists['section']; ?>
					</td>
				</tr>
				<tr>
					<td>
					Image:
					</td>
					<td>
					<?php echo $lists['image']; ?>
					</td>
					<td rowspan="4" width="50%">
					<script language="javascript" type="text/javascript">
					if (document.forms[0].image.options.value!=''){
					  jsimg='../images/stories/' + getSelectedValue( 'adminForm', 'image' );
					} else {
					  jsimg='../images/M_images/blank.png';
					}
					document.write('<img src=' + jsimg + ' name="imagelib" width="80" height="80" border="2" alt="Preview" />');
					</script>
					</td>
				</tr>
				<tr>
					<td>
					Image Position:
					</td>
					<td>
					<?php echo $lists['image_position']; ?>
					</td>
				</tr>
				<tr>
					<td>
					Ordering:
					</td>
					<td>
					<?php echo $lists['ordering']; ?>
					</td>
				</tr>
				<tr>
					<td>
					Access Level:
					</td>
					<td>
					<?php echo $lists['access']; ?>
					</td>
				</tr>
				<tr>
					<td>
					Published:
					</td>
					<td>
					<?php echo $lists['published']; ?>
					</td>
				</tr>
				<tr>
					<td valign="top">
					Description:
					</td>
					<td colspan="2">
					<?php
					// parameters : areaname, content, hidden field, width, height, rows, cols
					editorArea( 'editor1',  $row->description , 'description', '500', '200', '50', '5' ) ; ?>
					</td>
				</tr>
				</table>
			</td>
			<td valign="top">
			<?php
			if ( $row->section > 0 ) {
    				?>				
				<table class="adminform">
				<tr>
					<th colspan="2">
					Link to Menu
					</th>
				<tr>
				<tr>
					<td colspan="2">
					This will create a new menu item in the menu you select
					<br /><br />
					</td>
				<tr>
				<tr>
					<td valign="top" width="100px">
					Select a Menu
					</td>
					<td>
					<?php echo $lists['menuselect']; ?>
					</td>
				<tr>
				<tr>
					<td valign="top" width="100px">
					Select Menu Type
					</td>
					<td>
					<?php echo $lists['link_type']; ?>
					</td>
				<tr>
				<tr>
					<td valign="top" width="100px">
					Menu Item Name
					</td>
					<td>
					<input type="text" name="link_name" class="inputbox" value="" size="25" />
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
							<td width="90px" valign="top" align="right">
							<strong>
							Menu
							</strong>
							</td>
							<td>
							<?php echo $menu->menutype; ?>  
							</td>
						</tr>
						<tr>
							<td width="90px" valign="top" align="right">
							<strong>
							Type
							</strong>
							</td>
							<td>
							<?php echo $menu->type; ?>  
							</td>
						</tr>
						<tr>
							<td width="90px" valign="top" align="right">
							<strong>
							Item Name
							</strong>
							</td>
							<td>
							<strong>
							<?php echo $menu->name; ?>  
							</strong>
							</td>
						</tr>
						<tr>
							<td width="90px" valign="top" align="right">
							<strong>
							State
							</strong>
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
			}
			?>
			</td>
		</tr>
		</table>

		<input type="hidden" name="option" value="com_categories" />
		<input type="hidden" name="oldtitle" value="<?php echo $row->title ; ?>" />
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="sectionid" value="<?php echo $row->section; ?>" />
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
		</form>
		<?php 
	}


	/**
	* Form to select Section to move Category to
	*/
	function moveCategorySelect( $option, $cid, $SectionList, $items, $sectionOld, $contents, $redirect ) {
		?>
		<form action="index2.php" method="post" name="adminForm">
		<br />
		<table class="adminheading">
		<tr>
			<th class="categories">
			Move Category
			</th>
		</tr>
		</table>
		
		<br />
		<table class="adminform">
		<tr>
			<td width="3%"></td>
			<td align="left" valign="top" width="30%">
			<strong>Move to Section:</strong>
			<br />
			<?php echo $SectionList ?>
			<br /><br />
			</td>
			<td align="left" valign="top" width="20%">
			<strong>Categories being moved:</strong>
			<br />
			<?php
			echo "<ol>";
			foreach ( $items as $item ) {
				echo "<li>". $item->name ."</li>"; 
			}
			echo "</ol>";
			?>
			</td>
			<td valign="top" width="20%">
			<strong>Content Items being moved:</strong>
			<br />
			<?php
			echo "<ol>";
			foreach ( $contents as $content ) {
				echo "<li>". $content->title ."</li>"; 
			}
			echo "</ol>";
			?>
			</td>
			<td valign="top">
			This will move the Categories listed
			<br />
			and all the items within the category (also listed) 
			<br />
			to the selected Section.
			</td>.
		</tr>
		</table>
		<br /><br />
		
		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="section" value="<?php echo $sectionOld;?>" />
		<input type="hidden" name="boxchecked" value="1" />
		<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
		<input type="hidden" name="task" value="" />
		<?php
		foreach ( $cid as $id ) {
			echo "\n <input type=\"hidden\" name=\"cid[]\" value=\"$id\" />";
		}
		?>
		</form>
		<?php
	}


	/**
	* Form to select Section to copy Category to
	*/
	function copyCategorySelect( $option, $cid, $SectionList, $items, $sectionOld, $contents, $redirect ) {
		?>
		<form action="index2.php" method="post" name="adminForm">
		<br />
		<table class="adminheading">
		<tr>
			<th class="categories">
			Copy Category
			</th>
		</tr>
		</table>
		
		<br />
		<table class="adminform">
		<tr>
			<td width="3%"></td>
			<td align="left" valign="top" width="30%">
			<strong>Copy to Section:</strong>
			<br />
			<?php echo $SectionList ?>
			<br /><br />
			</td>
			<td align="left" valign="top" width="20%">
			<strong>Categories being copied:</strong>
			<br />
			<?php
			echo "<ol>";
			foreach ( $items as $item ) {
				echo "<li>". $item->name ."</li>"; 
			}
			echo "</ol>";
			?>
			</td>
			<td valign="top" width="20%">
			<strong>Content Items being copied:</strong>
			<br />
			<?php
			echo "<ol>";
			foreach ( $contents as $content ) {
				echo "<li>". $content->title ."</li>"; 
				echo "\n <input type=\"hidden\" name=\"item[]\" value=\"$content->id\" />";
			}
			echo "</ol>";
			?>
			</td>
			<td valign="top">
			This will copy the Categories listed
			<br />
			and all the items within the category (also listed) 
			<br />
			to the selected Section.
			</td>.
		</tr>
		</table>
		<br /><br />
		
		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="section" value="<?php echo $sectionOld;?>" />
		<input type="hidden" name="boxchecked" value="1" />
		<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
		<input type="hidden" name="task" value="" />
		<?php
		foreach ( $cid as $id ) {
			echo "\n <input type=\"hidden\" name=\"cid[]\" value=\"$id\" />";
		}
		?>
		</form>
		<?php
	}

} 
?>
