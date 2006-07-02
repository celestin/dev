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
class HTML_banners {
	function showBanners( &$rows, &$pageNav, $option ) {
		global $my;
?>
	<form action="index2.php" method="post" name="adminForm">
	<table class="adminheading">
		<tr>
			<th>Banner Manager</th>
		</tr>
	</table>
	<table class="adminlist">
		<tr>
			<th width="20">#</th>
			<th width="20"><input type="checkbox" name="toggle" value="" onClick="checkAll(<?php echo count( $rows ); ?>);" /></th>
			<th align="left" nowrap>Banner Name</th>
			<th nowrap>Impressions Made</th>
			<th nowrap>Impressions Left</th>
			<th nowrap>Clicks</th>
			<th nowrap>% Clicks</th>
			<th nowrap>Published</th>
			<th nowrap>Checked Out</th>
		</tr>
<?php
$k = 0;
for ($i=0, $n=count( $rows ); $i < $n; $i++) {
	$row = &$rows[$i];
	$impleft = $row->imptotal - $row->impmade;
	if($impleft < 0)
	$impleft = "unlimited";

	if ($row->impmade != 0) {
		$percentClicks = substr(100 * $row->clicks/$row->impmade, 0, 5);
	} else {
		$percentClicks = 0;
	}
?>
		<tr class="<?php echo "row$k"; ?>">
			<td width="20" align="center"><?php echo $pageNav->rowNumber( $i ); ?></td>
			<td width="20"><?php echo mosHTML::idBox( $i, $row->bid, ($row->checked_out && $row->checked_out != $my->id ) ); ?>
			<td width="42%" align="left">
				<?php
				if ( $row->checked_out && ( $row->checked_out != $my->id ) ) {
					?>
					<?php echo $row->name; ?>
					&nbsp;[ <i>Checked Out</i> ]
					<?php
				} else {
					?>
					<a href="#edit" onclick="return listItemTask('cb<?php echo $i; ?>','edit')">
					<?php echo $row->name; ?>
					</a>
					<?php
				}
				?>
				</td>
			<td width="11%" align="center"><?php echo $row->impmade;?></td>
			<td width="11%" align="center"><?php echo $impleft;?></td>
			<td width="8%" align="center"><?php echo $row->clicks;?></td>
			<td width="8%" align="center"><?php echo $percentClicks;?></td>
<?php
$task = $row->showBanner ? 'unpublish' : 'publish';
$img = $row->showBanner ? 'publish_g.png' : 'publish_x.png';
$alt = $row->showBanner ? 'Published' : 'Unpublished';
?>
			<td width="10%" align="center"><a href="javascript: void(0);" onClick="return listItemTask('cb<?php echo $i;?>','<?php echo $task;?>')">
			<img src="images/<?php echo $img;?>" width="12" height="12" border="0" alt="<?php echo $alt; ?>" /></a></td>
			<td width="12%" align="center"><?php echo $row->checked_out ? $row->editor : "";?>&nbsp;</td>
<?php		$k = 1 - $k; ?>
		</tr>
<?php	}
?>
	</table>
	<?php echo $pageNav->getListFooter(); ?>

	<input type="hidden" name="option" value="<?php echo $option; ?>">
	<input type="hidden" name="task" value="">
	<input type="hidden" name="boxchecked" value="0">
	</form>
<?php
	}

	function bannerForm( &$_row, &$lists, $_option ) {
		global $mosConfig_live_site;
		mosMakeHtmlSafe( $_row, ENT_QUOTES, 'custombannercode' );
?>
	<script language="javascript">
	<!--
	function changeDisplayImage() {
		if (document.adminForm.imageurl.value !='') {
			document.adminForm.imagelib.src='../images/banners/' + document.adminForm.imageurl.value;
		} else {
			document.adminForm.imagelib.src='images/blank.png';
		}
	}
	function submitbutton(pressbutton) {
		var form = document.adminForm;
		if (pressbutton == 'cancel') {
			submitform( pressbutton );
			return;
		}
		// do field validation
		if (form.name.value == "") {
			alert( "You must provide a banner name." );
		} else if (getSelectedValue('adminForm','cid') < 1) {
			alert( "Please select a client." );
		} else if (!getSelectedValue('adminForm','imageurl')) {
			alert( "Please select an image." );
		} else if (form.clickurl.value == "") {
			alert( "Please fill in the URL for the banner." );
		} else {
			submitform( pressbutton );
		}
	}
	//-->
	</script>
	<table class="adminheading">
		<tr>
			<th><?php echo $_row->bid ? 'Edit' : 'Add';?> Banner</th>
		</tr>
	</table>
	<form action="index2.php" method="post" name="adminForm">
	<table class="adminform">
		<tr>
			<td width="20%">Banner Name:</td>
			<td width="80%"><input class="inputbox" type="text" name="name" value="<?php echo $_row->name;?>"></td>
		</tr>
		<tr>
			<td>Client Name:</td>
			<td align="left"><?php echo $lists['cid']; ?></td>
		</tr>
		<tr>
			<td>Impressions Purchased:</td>
<?php	if ($_row->imptotal == "0") {
	$unlimited="checked";
	$_row->imptotal="";
} else {
	$unlimited = "";
}
?>
			<td><input class="inputbox" type="text" name="imptotal" size="12" maxlength="11" value="<?php echo $_row->imptotal;?>">&nbsp;Unlimited <input type="checkbox" name="unlimited" <?php echo $unlimited;?>></td>
		</tr>
		<tr>
			<td valign="top">Banner URL:</td>
			<td align="left"><?php echo $lists['imageurl']; ?></td>
		</tr>
		<tr>
		  <td>Show Banner : </td>
		  <td><?php echo $lists['showBanner']; ?></td>
	  </tr>
		<tr>
			<td>Click URL:</td>
			<td><input class="inputbox" type="text" name="clickurl" size="50" maxlength="200" value="<?php echo $_row->clickurl;?>"></td>
		</tr>
		<tr>
			<td valign="top">Custom banner code:</td>
			<td><textarea class="inputbox" cols="70" rows="5" name="custombannercode"><?php echo $_row->custombannercode;?></textarea></td>
		</tr>

		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr><td valign="top">Banner Image:</td>
			<td valign="top">
				<?php
				if (eregi("swf", $_row->imageurl)) {
					?>
						<img src="images/blank.png" name="imagelib">
					<?php
				}
				elseif (eregi("gif|jpg|png", $_row->imageurl)) {
						?>
						<img src="../images/banners/<?php echo $_row->imageurl; ?>" name="imagelib">
					<?php 
				}
				else {
					?>
						<img src="images/blank.png" name="imagelib">
					<?php
				}
				?>
			</td>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
	</table>

	<input type="hidden" name="option" value="<?php echo $_option; ?>">
	<input type="hidden" name="bid" value="<?php echo $_row->bid; ?>">
	<input type="hidden" name="task" value="">
	<input type="hidden" name="impmade" value="<?php echo $_row->impmade; ?>">
	</form>
<?php
	}
}

/**
* Banner clients
* @package Mambo_4.5.1
*/
class HTML_bannerClient {
	function showClients( &$rows, &$pageNav, $option ) {
?>
	<form action="index2.php" method="post" name="adminForm">
	<table class="adminheading">
		<tr>
			<th>Banner Client Manager</th>
		</tr>
	</table>
	<table class="adminlist">
		<tr>
			<th width="20">#</th>
			<th width="20"><input type="checkbox" name="toggle" value="" onClick="checkAll(<?php echo count( $rows ); ?>);" /></th>
			<th align="left" nowrap>Client Name</th>
			<th align="left" nowrap>Contact</th>
			<th align="center" nowrap>No. of Active Banners</th>
			<th align="center" nowrap>Checked Out</th>
		</tr>
<?php
$k = 0;
for ($i=0, $n=count( $rows ); $i < $n; $i++) {
	$row = &$rows[$i];
?>
		<tr class="<?php echo "row$k"; ?>">
			<td width="20" align="center"><?php echo $pageNav->rowNumber( $i ); ?></td>
			<td width="20"><?php echo mosHTML::idBox( $i, $row->cid ); ?></td>
			<td width="40%"><a href="#edit" onclick="return listItemTask('cb<?php echo $i; ?>','editclient')"><?php echo $row->name; ?></a></td>
			<td width="40%"><?php echo $row->contact;?></td>
			<td width="20%" align="center"><?php echo $row->bid;?></td>
			<td width="10%" align="center"><?php echo (isset($row->editor) ? $row->editor : "&nbsp;");?></td>
		</tr>
<?php		$k = 1 - $k;
}
?>
	</table>
	<?php echo $pageNav->getListFooter(); ?>
	<input type="hidden" name="option" value="<?php echo $option; ?>">
	<input type="hidden" name="task" value="">
	<input type="hidden" name="boxchecked" value="0">
	</form>
<?php
	}

	function bannerClientForm( &$row, $option ) {
		mosMakeHtmlSafe( $row, ENT_QUOTES, 'extrainfo' );
?>
	<script language="javascript">
	<!--
	function submitbutton(pressbutton) {
		var form = document.adminForm;
		if (pressbutton == 'cancelclient') {
			submitform( pressbutton );
			return;
		}
		// do field validation
		if (form.name.value == "") {
			alert( "Please fill in the Client Name." );
		} else if (form.contact.value == "") {
			alert( "Please fill in the Contact Name." );
		} else if (form.email.value == "") {
			alert( "Please fill in the Contact Email." );
		} else {
			submitform( pressbutton );
		}
	}
	//-->
	</script>
	<table class="adminheading">
		<tr>
			<th><?php echo $row->cid ? 'Edit' : 'Add';?> Banner Client</th>
		</tr>
	</table>
	<form action="index2.php" method="post" name="adminForm">
	<table class="adminform">
		<tr>
			<td width="10%">Client Name:</td>
			<td><input class="inputbox" type="text" name="name" size="30" maxlength="60" valign="top" value="<?php echo $row->name; ?>"></td>
		</tr>
		<tr>
			<td width="10%">Contact Name:</td>
			<td><input class="inputbox" type="text" name="contact" size="30" maxlength="60" value="<?php echo $row->contact; ?>"></td>
		</tr>
		<tr>
			<td width="10%">Contact Email:</td>
			<td><input class="inputbox" type="text" name="email" size="30" maxlength="60" value="<?php echo $row->email; ?>"></td>
		</tr>
		<tr>
			<td valign="top">Extra Info:</td>
			<td><textarea class="inputbox" name="extrainfo" cols="60" rows="10"><?php echo str_replace('&','&amp;',$row->extrainfo);?></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
	</table>
	<input type="hidden" name="option" value="<?php echo $option; ?>">
	<input type="hidden" name="cid" value="<?php echo $row->cid; ?>">
	<input type="hidden" name="task" value="">
	</form>
<?php }
}
?>
