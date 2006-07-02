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
* Writes the edit form for new and existing content item
*
* A new record is defined when <var>$row</var> is passed with the <var>id</var>
* property set to 0.
* @package Mambo_4.5.1
*/
class components_menu_html { 


	function edit( &$menu, &$components, &$lists, &$params, $option ) {
		global $mosConfig_live_site;
		$tabs = new mosTabs(0);
		?>
		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			var form = document.adminForm;
			if (pressbutton == 'cancel') {
				submitform( pressbutton );
				return;
			}
	
			var comp_links = new Array;
			<?php	
			foreach ($components as $row) { 
				?>
				comp_links[ <?php echo $row->value;?> ] = 'index.php?<?php echo addslashes( $row->link );?>';
				<?php	
			} 
			?>
			
			if ( form.id.value == 0 ) {
				var comp_id = getSelectedValue( 'adminForm', 'componentid' );
				form.link.value = comp_links[comp_id];
			} else {
				form.link.value = comp_links[form.componentid.value];
			}
			
			if ( trim( form.name.value ) == "" ){
				alert( "Item must have a name" );
			} else if (form.componentid.value == ""){
				alert( "Please select a Component" );
			} else {
				submitform( pressbutton );
			}
		}
		</script>
	
		<form action="index2.php" method="post" name="adminForm">
	
		<table class="adminheading">
		<tr>
			<th>
			<?php echo $menu->id ? 'Edit' : 'Add';?> Menu Item :: Component
			</th>
		</tr>
		</table>
	
		<?php
		$tabs->startPane("module");
		$tabs->startTab("Details","Details-page");
		?>
		<table class="adminform">
		<tr>
			<td width="10%" align="right">Name:</td>
			<td width="80%">
			<input class="inputbox" type="text" name="name" size="50" maxlength="100" value="<?php echo htmlspecialchars( $menu->name, ENT_QUOTES ); ?>" />
			</td>
		</tr>
		<tr>
			<td valign="top" align="right">Component:</td>
			<td>
			<?php echo $lists['componentid']; ?>
			</td>
		</tr>
		<tr>
			<td width="10%" align="right">Url:</td>
			<td width="80%">
			<?php echo $lists['link']; ?>
			</td>
		</tr>
		<tr>
			<td align="right">Parent Item:</td>
			<td>
			<?php echo $lists['parent'];?>
			</td>
		</tr>
	
		<tr>
			<td valign="top" align="right">Ordering:</td>
			<td>
			<?php echo $lists['ordering']; ?>
			</td>
		</tr>
		<tr>
			<td valign="top" align="right">Access Level:</td>
			<td>
			<?php echo $lists['access']; ?>
			</td>
		</tr>
		<tr>
			<td valign="top" align="right">Published:</td>
			<td>
			<?php echo $lists['published']; ?>
			</td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Parameters","params-page");
		?>
		<table class="adminform">
		<tr>
			<td>
			<?php
			if ($menu->id) {
				echo $params->render();
			} else { 
				?>
				<strong>Parameter list will be available once you save this New menu item</strong>
				<?php
			}
			?>
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->endPane();
		?>
	
		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="id" value="<?php echo $menu->id; ?>" />
		<input type="hidden" name="link" value="" />
		<input type="hidden" name="menutype" value="<?php echo $menu->menutype; ?>" />
		<input type="hidden" name="type" value="<?php echo $menu->type; ?>" />
		<input type="hidden" name="task" value="" />
		</form>
		<script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
		<?php
	}

}
?>
