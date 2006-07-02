<?php
/**
* @version $Id$
* @package Mambo_4.5.1
* @copyright (C) 2000 - 2004 Miro International Pty Ltd
* @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
* Mambo is Free Software
* @subpackage Installer
*/

/** ensure this file is being included by a parent file */
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );

function writableCell( $folder ) {
	echo '<tr>';
	echo '<td class="item">' . $folder . '/</td>';
	echo '<td align="left">';
	echo is_writable( $GLOBALS['mosConfig_absolute_path'] . '/' . $folder ) ? '<b><font color="green">Writeable</font></b>' : '<b><font color="red">Unwriteable</font></b>' . '</td>';
	echo '</tr>';
}

/**
* @package Mambo_4.5.1
*/
class HTML_installer
{
	function showInstallForm( $title, $option, $element, $client = "", $p_startdir = "", $backLink="" )
	{
	?>
	<script language="javascript" type="text/javascript">
		function submitbutton3(pressbutton) {
			var form = document.adminForm_dir;

			// do field validation
			if (form.userfile.value == ""){
				alert( "Please select a directory" );
			} else {
				form.submit();
			}
		}
	</script>
<form enctype="multipart/form-data" action="index2.php" method="post" name="filename">
	<input type="hidden" name="task" value="uploadfile" />
	<input type="hidden" name="option" value="<?php echo $option;?>">
	<input type="hidden" name="element" value="<?php echo $element;?>">
	<input type="hidden" name="client" value="<?php echo $client;?>">
	<table class="adminheading">
	  <tr>
	    <th><?php echo $title;?></th>
	    <td align="right" nowrap="true"><?php echo $backLink;?></td>
	  </tr>
	</table>
	<table class="adminform">
	  <tr>
	    <th>Upload Package File</th>
	  </tr>
	  <tr>
	    <td align="Left">Package File:&nbsp;<input class="text_area" name="userfile" type="file" />&nbsp;<input class="button" type="submit" value="Upload File &amp; Install" /></td>
	  </tr>
	</table>
</form>
<br />

<form enctype="multipart/form-data" action="index2.php" method="post" name="adminForm_dir">
	<input type="hidden" name="task" value="installfromdir" />
	<input type="hidden" name="option" value="<?php echo $option;?>">
	<input type="hidden" name="element" value="<?php echo $element;?>">
	<input type="hidden" name="client" value="<?php echo $client;?>">
	<table class="adminform">
	  <tr>
	    <th>Install from directory</th>
	  </tr>
	  <tr>
	    <td align="Left">
			Install directory:&nbsp;
			<input type="text" name="userfile" class="text_area" size="50" value="<?php echo $p_startdir; ?>"/>&nbsp;
			<input type="button" class="button" value="Install" onclick="submitbutton3()" />
		</td>
	  </tr>
	</table>
</form>
	<?php
	}
/**
* @param string
* @param string
* @param string
* @param string
*/
	function showInstallMessage( $message, $title, $url ) {
		global $PHP_SELF;
?>
<table class="adminheading">
	<tr>
		<th class="install">
			<?php echo $title; ?>
		</th>
	</tr>
</table>
<table class="adminform">
	<tr>
		<td align="Left">
			<strong><?php echo $message; ?></strong>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			[&nbsp;<a href="<?php echo $url;?>" style="font-size: 16px; font-weight: bold">Continue ...</a>&nbsp;]
		</td>
	</tr>
</table>
<?php
	}
}
?>
