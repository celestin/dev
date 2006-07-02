<?php
/**
* @version $Id: admin.frontpage.html.php,v 1.27 2004/09/16 06:38:24 stingrey Exp $
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
	function showList( &$rows, $search, $pageNav, $option ) {
		global $my;
		global $mosConfig_live_site;
		?>
		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<form action="index2.php" method="post" name="adminForm">
		<table class="adminheading">
		<tr>
			<th class="frontpage">
			Front Page Items
			</th>
			<td>
			Filter:
			</td>
			<td> 
			<input type="text" name="search" value="<?php echo $search;?>" class="inputbox" onChange="document.adminForm.submit();" />
			</td>
		</tr>
		</table>

		<table class="adminlist">
		<tr>
			<th width="20"> 
			<input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count( $rows ); ?>);" />
			</th>
			<th class="title" width="50%">
			Title
			</th>
			<th width="10%" nowrap="nowrap">
			Published
			</th>
			<th colspan="2" nowrap="nowrap">
			Reorder
			</th>
			<th width="10%" nowrap="nowrap">
			Access
			</th>
			<th width="15%" align="left">
			Category
			</th>
			<th>
			Order
			</th>
			<th width="10%" nowrap="nowrap">
			Checked Out
			</th>
		</tr>
		<?php
		$k = 0;
		for ($i=0, $n=count( $rows ); $i < $n; $i++) {
			$row = &$rows[$i];
			?>
			<tr class="<?php echo "row$k"; ?>">
				<td width="20">
				<?php echo mosHTML::idBox( $i, $row->id, ($row->checked_out && $row->checked_out != $my->id ) ); ?>
				</td>
				<td>
				<?php echo $row->title; ?> 
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
				    if ( isset( $row->publish_up ) ) {
						  if ( $row->publish_up == '0000-00-00 00:00:00' ) {
								$times .= '<tr><td>Start: Always</td></tr>';
						  } else {
								$times .= '<tr><td>Start: '. $row->publish_up .'</td></tr>';
						  }
				    }
				    if ( isset( $row->publish_down ) ) {
						  if ( $row->publish_down == '0000-00-00 00:00:00' ) {
								$times .= '<tr><td>Finish: No Expiry</td></tr>';
						  } else {
						  $times .= '<tr><td>Finish: '. $row->publish_down .'</td></tr>';
						  }
				    }
				if ( $times ) {
					?>
					<td align="center">
					<a href="javascript: void(0);" onmouseover="return overlib('<table><?php echo $times; ?></table>', CAPTION, 'Publish Information', BELOW, RIGHT);" onMouseOut="return nd();" onclick="return listItemTask('cb<?php echo $i;?>','<?php echo $row->state ? "unpublish" : "publish";?>')">
					<img src="images/<?php echo $img;?>" width="12" height="12" border="0" alt="<?php echo $alt;?>" />
					</a>
					</td>
					<?php
				}
				?>
				<td>
				<?php echo $pageNav->orderUpIcon( $i ); ?>
				</td>
				<td>
				<?php echo $pageNav->orderDownIcon( $i, $n ); ?>
				</td>
				<td align="center">
				<?php echo $row->groupname;?>
				</td>
				<td>
				<?php echo $row->name; ?>
				</td>
				<td align="center">
				<?php echo $row->fpordering;?>
				</td>
				<?php
				if (	$row->checked_out ) { 
					?>
					<td align="center">
					<?php echo $row->editor; ?>
					</td>
					<?php		
				} else { 
					?>
					<td align="center">&nbsp;</td>
					<?php		
				} 
				?>
			</tr>
			<?php		
			$k = 1 - $k; 
		} 
		?>
		</table>
		<?php echo $pageNav->getListFooter();?>

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
}
?>
