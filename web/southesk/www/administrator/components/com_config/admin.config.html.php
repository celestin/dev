<?php
/**
* @version $Id: admin.config.html.php,v 1.59 2004/09/22 18:44:10 prazgod Exp $
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
class HTML_config {

	function showconfig( &$row, &$lists, $option) {
		global $mosConfig_absolute_path, $mosConfig_live_site;
		$tabs = new mosTabs(0);
		?>

		<div id="overDiv" style="position:absolute; visibility:hidden; z-index:10000;"></div>
		<table class="adminheading">
		<tr>
			<th class="config">
			Global Configuration : 
			<span class="componentheading">
			configuration.php is :
			 <?php echo is_writable( '../configuration.php' ) ? '<b><font color="green"> Writeable</font></b>' : '<b><font color="red">Unwriteable</font></b>' ?>
			</span>
			</th>
		</tr>
		</table>
		<script language="javascript" type="text/javascript">
		function submitbutton(pressbutton) {
			var form = document.adminForm;
			if (pressbutton == 'save') {
				//if (confirm ("Are you sure?")) {
				submitform( pressbutton );
				//}
			} else {
				document.location.href = 'index2.php';
			}
		}
		</script>
		<form action="index2.php" method="post" name="adminForm">
		<?php
		$tabs->startPane("configPane");
		$tabs->startTab("Site","site-page");
		?>
		<table class="adminform">
		<tr>
			<td width="185">
			Site Offline:
			</td>
			<td><?php echo $lists['offline']; ?></td>
		</tr>
		<tr>
			<td valign="top">
			Offline Message:
			</td>
			<td> 
			<textarea class="text_area" cols="60" rows="2" style="width:500px; height:40px" name="config_offline_message"><?php echo $row->config_offline_message; ?></textarea>
			</td>
		</tr>
		<tr>
			<td valign="top">
			System Error Message:
			</td>
			<td> 
			<textarea class="text_area" cols="60" rows="2" style="width:500px; height:40px" name="config_error_message"><?php echo $row->config_error_message; ?></textarea>
			</td>
		</tr>
		<tr>
			<td>
			Site Name:
			</td>
			<td>
			<input class="text_area" type="text" name="config_sitename" size="50" value="<?php echo $row->config_sitename; ?>">
			</td>
		</tr>
			<td>
			Show UnAuthorized Links:
			</td>
			<td> 
			<?php echo $lists['auth']; ?> 
			</td>
		</tr>
		<tr>
			<td>
			Allow User Registration:
			</td>
			<td> 
			<?php echo $lists['allowuserregistration']; ?> 
			</td>
		</tr>
		<tr>
			<td>
			Use New Account Activation:
			</td>
			<td> 
			<?php echo $lists['useractivation']; ?> 
			</td>
		</tr>
		<tr>
			<td>
			Require Unique Email:
			</td>
			<td> 
			<?php echo $lists['uniquemail']; ?> 
			</td>
		</tr>
		<tr>
			<td>
			Debug Site:
			</td>
			<td> 
			<?php echo $lists['debug']; ?> 
			</td>
		</tr>
		<tr>
			<td>
			WYSIWYG Editor:
			</td>
			<td> 
			<?php echo $lists['editor']; ?> 
			</td>
		</tr>
		<tr>
			<td>
			List Length:
			</td>
			<td>
			<?php echo $lists['list_length']; ?>
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Locale","Locale-page");
		?>
		<table class="adminform">
		<tr>
			<td width="185">
			Language:
			</td>
			<td> 
			<?php echo $lists['lang']; ?> 
			</td>
		</tr>
		<tr>
			<td width="185">
			Time Offset:
			</td>
			<td>
			<?php echo $lists['offset']; ?>
			<?php
			$tip = "Current date/time configured to display: " . mosCurrentDate(_DATE_FORMAT_LC2);
			echo mosToolTip($tip);
			?>
			</td>
		</tr>
		<tr>
			<td width="185">
			Country Locale:
			</td>
			<td>
			<input class="text_area" type="text" name="config_locale" size="15" value="<?php echo $row->config_locale; ?>">
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Content","content-page");
		?>
		<table class="adminform">
		<tr>
			<td colspan="2">
			* These Parameters control Output elments*
			<br /><br />
			</td>
		</tr>
		<tr>
			<td width="200">
			Linked Titles:
			</td>
			<td width="100">
			<?php echo $lists['link_titles']; ?> 
			</td>
			<td width="*" align="left">
			<?php echo mosToolTip('Use hyperlinked titles'); ?>
			</td>
		</tr>
		<tr>
			<td width="200">
			Read More Link:
			</td>
			<td width="100">
			<?php echo $lists['readmore']; ?> 
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Item Rating/Voting:
			</td>
			<td>
			<?php echo $lists['vote']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Author Names:
			</td>
			<td>
			<?php echo $lists['hideauthor']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Created Date and Time:
			</td>
			<td>
			<?php echo $lists['hidecreate']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Modified Date and Time:
			</td>
			<td>
			<?php echo $lists['hidemodify']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Hits:
			</td>
			<td>
			<?php echo $lists['hits']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			PDF Icon:
			</td>
			<td>
			<?php echo $lists['hidepdf']; ?>
			</td>
			<?php
			if (!is_writable( "$mosConfig_absolute_path/media/" )) {
				echo "<td align=\"left\">";
				echo mosToolTip('Option not available as /media directory not writable');
				echo "</td>";
			} else {
				?>
				<td align="left">&nbsp;
							
				</td>
				<?php
			}
			?>
		</tr>
		<tr>
			<td>
			Print Icon:
			</td>
			<td>
			<?php echo $lists['hideprint']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Email Icon:
			</td>
			<td>
			<?php echo $lists['hideemail']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Icons:
			</td>
			<td>
			<?php echo $lists['icons']; ?>
			</td>
			<td align="left">
			<?php echo mosToolTip('Print, PDF & Email will utilise Icons or Text'); ?>
			</td>
		</tr>
		<tr>
			<td>
			Table of Contents on multi-page items:
			</td>
			<td>
			<?php echo $lists['multipage_toc']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Back Button:
			</td>
			<td>
			<?php echo $lists['back_button']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Content Item Navigation
			</td>
			<td>
			<?php echo $lists['item_navigation']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Database","db-page");
		?>
		<table class="adminform">
		<tr>
			<td width="185">
			Hostname:
			</td>
			<td width="786">
			<input class="text_area" type="text" name="config_host" size="25" value="<?php echo $row->config_host; ?>">
			</td>
		</tr>
		<tr>
			<td width="185">
			MySQL Username:
			</td>
			<td>
			<input class="text_area" type="text" name="config_user" size="25" value="<?php echo $row->config_user; ?>">
			</td>
		</tr>
		<tr>
			<td width="185">
			MySQL Password:
			</td>
			<td>
			<input class="text_area" type="text" name="config_password" size="25" value="<?php echo $row->config_password; ?>">
			</td>
		</tr>
		<tr>
			<td width="185">
			MySQL Database:
			</td>
			<td>
			<input class="text_area" type="text" name="config_db" size="25" value="<?php echo $row->config_db; ?>">
			</td>
		</tr>
		<tr>
			<td width="185">
			MySQL Database Prefix:
			</td>
			<td>
			<input class="text_area" type="text" name="config_dbprefix" size="10" value="<?php echo $row->config_dbprefix; ?>">
			&nbsp;<?php echo mosWarning('!! DO NOT CHANGE UNLESS YOU HAVE A DATABASE BUILT USING TABLES WITH THE PREFIX YOU ARE SETTING !!'); ?>
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Server","server-page");
		?>
		<table class="adminform">
		<tr>
			<td width="185">
			Absolute Path:
			</td>
			<td>
			<strong>
			<?php echo $row->config_path; ?>
			</strong>
			</td>
		</tr>
		<tr>
			<td>
			Live Site:
			</td>
			<td>
			<strong>
			<?php echo $row->config_live_site; ?>
			</strong>
			</td>
		</tr>
		<tr>
			<td>
			Secret Word:
			</td>
			<td>
			<strong>
			<?php echo $row->config_secret; ?>
			</strong>
			</td>
		</tr>
		<tr>
			<td width="185">
			GZIP Page Compression:
			</td>
			<td> 
			<?php echo $lists['gzip']; ?>
			<?php echo mosToolTip('Compress buffered output if supported'); ?>
			</td>
		</tr>
		<tr>
			<td>
			Login Session Lifetime:
			</td>
			<td>
			<input class="text_area" type="text" name="config_lifetime" size="10" value="<?php echo $row->config_lifetime; ?>">
			&nbsp;seconds&nbsp;
			<?php echo mosToolTip('Auto logout after this time of inactivity'); ?>
			</td>
		</tr>
		<tr>
			<td>
			Error Reporting:
			</td>
			<td> 
			<?php echo $lists['error_reporting']; ?> 
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Metadata","metadata-page");
		?>
		<table class="adminform">
		<tr>
			<td width="185" valign="top">
			Global Site Meta Description:
			</td>
			<td> 
			<textarea class="text_area" cols="50" rows="3" style="width:500px; height:50px" name="config_metadesc"><?php echo $row->config_metadesc; ?></textarea>
			</td>
		</tr>
		<tr>
			<td width="185" valign="top">
			Global Site Meta Keywords:
			</td>
			<td> 
			<textarea class="text_area" cols="50" rows="3" style="width:500px; height:50px" name="config_metakeys"><?php echo $row->config_metakeys; ?></textarea>
			</td>
		</tr>
		<tr>
			<td valign="top">
			Show Title Meta Tag : 
			</td>
			<td>
			<?php echo $lists['metatitle']; ?>
			&nbsp;&nbsp;&nbsp; 
			<?php echo mosToolTip('Show the title meta tag when viewing content items'); ?>
			</td>
		  	</tr>
		<tr>
			<td valign="top">
			Show Author Meta Tag: 
			</td>
			<td>
			<?php echo $lists['metaauthor']; ?>
			&nbsp;&nbsp;&nbsp; 
			<?php echo mosToolTip('Show the author meta tag when viewing content items'); ?>
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Mail","mail-page");
		?>
		<table class="adminform">
		<tr>
			<td>
			Mailer:
			</td>
			<td>
			<?php echo $lists['mailer']; ?>
			</td>
		</tr>
		<tr>
			<td>
			Mail From:
			</td>
			<td>
			<input class="text_area" type="text" name="config_mailfrom" size="25" value="<?php echo $row->config_mailfrom; ?>">
			</td>
		</tr>
		<tr>
			<td>
			From Name:
			</td>
			<td>
			<input class="text_area" type="text" name="config_fromname" size="25" value="<?php echo $row->config_fromname; ?>">
			</td>
		</tr>
		<tr>
			<td>
			SMTP Auth:
			</td>
			<td>
			<?php echo $lists['smtpauth']; ?>
			</td>
		</tr>
		<tr>
			<td>
			SMTP User:
			</td>
			<td>
			<input class="text_area" type="text" name="config_smtpuser" size="15" value="<?php echo $row->config_smtpuser; ?>">
			</td>
		</tr>
		<tr>
			<td>
			SMTP Pass:
			</td>
			<td>
			<input class="text_area" type="text" name="config_smtppass" size="12" value="<?php echo $row->config_smtppass; ?>">
			</td>
		</tr>
		<tr>
			<td>
			SMTP Host:
			</td>
			<td>
			<input class="text_area" type="text" name="config_smtphost" size="20" value="<?php echo $row->config_smtphost; ?>">
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Cache","cache-page");
		?>
		<table class="adminform" border="0">
		<?php
		if (is_writeable($row->config_cachepath)) {
			?>
			<tr>
				<td width="100">
				Caching:
				</td>
				<td width="500"> 	
				<?php echo $lists['caching']; ?> 
				</td>
				<td width="*">&nbsp;
												
				</td>
			</tr>
			<?php
		}
		?>
		<tr>
			<td>
			Cache Folder:
			</td>
			<td>
			<input class="text_area" type="text" name="config_cachepath" size="50" value="<?php echo $row->config_cachepath; ?>" />
			<?php 
			if (is_writeable($row->config_cachepath)) {
				echo mosToolTip('Current cache is directory is <b>Writeable</b>');
			} else {
				echo mosWarning('The cache directory is UNWRITEABLE - please set this directory to CHMOD755 before turning on the cache');
			}
			?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		<tr>
			<td>
			Cache Time:
			</td>
			<td>
			<input class="text_area" type="text" name="config_cachetime" size="5" value="<?php echo $row->config_cachetime; ?>" /> 	
			seconds
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("Statistics","stats-page");
		?>
		<table class="adminform">
		<tr>
			<td width="200">
			Statistics:
			</td>
			<td width="100">
			<?php echo $lists['enable_stats']; ?>
			</td>
			<td width="*" align="left">
			<?php echo mostooltip('Enable/disable collection of site statistics'); ?>
			</td>
		</tr>
		<tr>
			<td>
			Log Content Hits by Date:
			</td>
			<td>
			<?php echo $lists['log_items']; ?>
			</td>
			<td align="left">
			<span class="error">
			<?php echo mosWarning('WARNING : Large amounts of data will be collected'); ?>
			</span>
			</td>
		</tr>
		<tr>
			<td>
			Log Search Strings:
			</td>
			<td>
			<?php echo $lists['log_searches']; ?>
			</td>
			<td align="left">&nbsp;
						
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("SEO","seo-page");
		?>
		<table class="adminform">
		<tr>
			<td width="200">
			<strong> 
			Search Engine Optimization
			</strong>
			</td>
			<td width="100">&nbsp;
			  
			</td>
			<td width="*" align="left">&nbsp;
			  
			</td>
		</tr>
		<tr>
			<td> 
			Search Engine Friendly URLs: 
			</td>
			<td> 
			<?php echo $lists['sef']; ?>&nbsp; 
			</td>
			<td align="left">
			<span class="error">
			<?php echo mosWarning('Apache only! Rename htaccess.txt to .htaccess before activating'); ?> 
			</span> 
			</td>
		</tr>
		<tr>
			<td>
			Dynamic Page Titles:  
			</td>
			<td>
			<?php echo $lists['pagetitles']; ?> 
			</td>
			<td align="left">
			<?php echo mosToolTip('Dynamically changes the page title to reflect current content viewed'); ?> 
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->endPane();
		?>

		<input type="hidden" name="option" value="<?php echo $option; ?>">
		<input type="hidden" name="config_path" value="<?php echo $row->config_path; ?>">
		<input type="hidden" name="config_live_site" value="<?php echo $row->config_live_site; ?>">
		<input type="hidden" name="config_secret" value="<?php echo $row->config_secret; ?>">
		<input type="hidden" name="task" value="">
		</form>
		<script language="Javascript" src="<?php echo $mosConfig_live_site;?>/includes/js/overlib_mini.js"></script>
		<?php
	}

}
?>
