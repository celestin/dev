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
class HTML_admin_misc {

	/**
	* Control panel
	*/
	function controlPanel() {
	    global $mosConfig_absolute_path, $mainframe;
		?>
		<table class="adminheading" border="0">
		<tr>
			<th class="cpanel">
			Control Panel
			</th>
		</tr>
		</table>
		<?php
		$path = $mosConfig_absolute_path . '/administrator/templates/' . $mainframe->getTemplate() . '/cpanel.php';
		if (file_exists( $path )) {
		    require $path;
		} else {
		    echo '<br />';
			mosLoadAdminModules( 'cpanel', 1 );
		}
	}

	function get_php_setting($val) {
		$r =  (ini_get($val) == '1' ? 1 : 0);
		return $r ? 'ON' : 'OFF';
	}

	function get_server_software() {
		if (isset($_SERVER['SERVER_SOFTWARE'])) {
			return $_SERVER['SERVER_SOFTWARE'];
		} else if (($sf = getenv('SERVER_SOFTWARE'))) {
			return $sf;
		} else {
			return 'n/a';
		}
	}

	function system_info( $version, $option ) {
		global $mosConfig_absolute_path, $database;
		//$tab = mosGetParam( $_REQUEST, 'tab', 'tab1' );
		$width = 400;	// width of 100%
		$tabs = new mosTabs(0);
		?>

		<table class="adminheading">
		<tr>
			<th class="info">
			Information
			</th>
		</tr>
		</table>
		<?php
		$tabs->startPane("sysinfo");
		$tabs->startTab("System Info","system-page");
		?>
		<table class="adminform">
		<tr>
			<th colspan="2">
			System Information
			</th>
		</tr>
		<tr>
			<td valign="top" width="250">
			<b>
			PHP built On:
			</b>
			</td>
			<td>
			<?php echo php_uname(); ?>
			</td>
		</tr>
		<tr>
			<td>
			<b>
			Database Version:
			</b>
			</td>
			<td>
			<?php echo mysql_get_server_info(); ?> 
			</td>
		</tr>
		<tr>
			<td>
			<b>
			PHP Version:
			</b>
			</td>
			<td>
			<?php echo phpversion(); ?>
			</td>
		</tr>
		<tr>
			<td>
			<b>
			Web Server:
			</b>
			</td>
			<td>
			<?php echo HTML_admin_misc::get_server_software(); ?>
			</td>
		</tr>
		<tr>
			<td>
			<b>
			WebServer to PHP interface:
			</b>
			</td>
			<td>
			<?php echo php_sapi_name(); ?>
			</td>
		</tr>
		<tr>
			<td>
			<b>
			Mambo Version:
			</b>
			</td>
			<td>
			<?php echo $version; ?>
			</td>
		</tr>
		<tr>
			<td>
			<b>
			User Agent:
			</b>
			</td>
			<td>
			<?php echo phpversion() <= "4.2.1" ? getenv( "HTTP_USER_AGENT" ) : $_SERVER['HTTP_USER_AGENT'];?>
			</td>
		</tr>
		<tr>
			<td valign="top">
			<b>
			Relevant PHP Settings:
			</b>
			</td>
			<td> 
				<table cellspacing="1" cellpadding="1" border="0">
				<tr>
					<td>
					Safe Mode:
					</td>
					<td>
					<?php echo HTML_admin_misc::get_php_setting('safe_mode'); ?>
					</td>
				</tr>
				<tr>
					<td>
					Open basedir:
					</td>
					<td>
					<?php echo (($ob = ini_get('open_basedir')) ? $ob : 'none'); ?>
					</td>
				</tr>
				<tr>
					<td>
					Display Errors:
					</td>
					<td>
					<?php echo HTML_admin_misc::get_php_setting('display_errors'); ?>
					</td>
				</tr>
				<tr>
					<td>
					Short Open Tags:
					</td>
					<td>
					<?php echo HTML_admin_misc::get_php_setting('short_open_tag'); ?>
					</td>
				</tr>
				<tr>
					<td>
					File Uploads:
					</td>
					<td>
					<?php echo HTML_admin_misc::get_php_setting('file_uploads'); ?>
					</td>
				</tr>
				<tr>
					<td>
					Magic Quotes:
					</td>
					<td>
					<?php echo HTML_admin_misc::get_php_setting('magic_quotes_gpc'); ?>
					</td>
				</tr>
				<tr>
					<td>
					Register Globals:
					</td>
					<td>
					<?php echo HTML_admin_misc::get_php_setting('register_globals'); ?>
					</td>
				</tr>
				<tr>
					<td>
					Output Buffering:
					</td>
					<td>
					<?php echo HTML_admin_misc::get_php_setting('output_buffering'); ?>
					</td>
				</tr>
				<tr>
					<td>
					Session save path:
					</td>
					<td>
					<?php echo (($sp=ini_get('session.save_path'))?$sp:'none'); ?>
					</td>
				</tr>
				<tr>
					<td>
					Session auto start:
					</td>
					<td>
					<?php echo intval( ini_get( 'session.auto_start' ) ); ?>
					</td>
				</tr>
				<tr>
					<td>
					XML enabled:
					</td>
					<td>
					<?php echo extension_loaded('xml')?'Yes':'No'; ?>
					</td>
				</tr>
				<tr>
					<td>
					Zlib enabled:
					</td>
					<td>
					<?php echo extension_loaded('zlib')?'Yes':'No'; ?>
					</td>
				</tr>
				<tr>
					<td>
					Disabled Functions:
					</td>
					<td>
					<?php echo (($df=ini_get('disable_functions'))?$df:'none'); ?>
					</td>
				</tr>
				<?php
				$query = "SELECT name FROM #__mambots"
				. "\nWHERE folder='editors' AND published='1'"
				. "\nLIMIT 1";
				$database->setQuery( $query );
				$editor = $database->loadResult();
				?>
				<tr>
					<td>
					WYSIWYG Editor:
					</td>
					<td>
					<?php echo $editor; ?>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top">
			<b>
			Configuration File:
			</b>
			</td>
			<td>
			<?php
			$cf = file( "$mosConfig_absolute_path/configuration.php" );
			foreach ($cf as $k=>$v) {
				if (eregi( 'mosConfig_host', $v)) {
					$cf[$k] = '$mosConfig_host = \'xxxxxx\'';
				} else if (eregi( 'mosConfig_user', $v)) {
					$cf[$k] = '$mosConfig_user = \'xxxxxx\'';
				} else if (eregi( 'mosConfig_password', $v)) {
					$cf[$k] = '$mosConfig_password = \'xxxxxx\'';
				} else if (eregi( 'mosConfig_db ', $v)) {
					$cf[$k] = '$mosConfig_db = \'xxxxxx\'';
				} else if (eregi( '<?php', $v)) {
					$cf[$k] = '&lt;?php';
				}
			}
			echo implode( "<br />", $cf );
			?>
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab("PHP Info","php-page");
		?>
		<table class="adminform">
		<tr>
			<th colspan="2">
			PHP Information
			</th>
		</tr>
		<tr>
			<td>
			<?php
			ob_start();
			phpinfo(INFO_GENERAL | INFO_CONFIGURATION | INFO_MODULES);
			$phpinfo = ob_get_contents();
			ob_end_clean();
			preg_match_all('#<body[^>]*>(.*)</body>#siU', $phpinfo, $output);
			$output = preg_replace('#<table#', '<table class="adminlist" align="center"', $output[1][0]);
			$output = preg_replace('#(\w),(\w)#', '\1, \2', $output);
			$output = preg_replace('#border="0" cellpadding="3" width="600"#', 'border="0" cellspacing="1" cellpadding="4" width="95%"', $output);
			$output = preg_replace('#<hr />#', '', $output);
			echo $output;
			?>
			</td>
		</tr>
		</table>
		<?php
		$tabs->endTab();
		$tabs->startTab('Permissions','perms');
		?>
		<table class="adminform">
          <tr>
            <th colspan="2"> Directory Permissions</th>
          </tr>
          <tr>
            <td>
        <strong>For all Mambo functions and features to work ALL of the following directories should be writeable:</strong>
			<?php
mosHTML::writableCell( 'administrator/backups' );
mosHTML::writableCell( 'administrator/components' );
mosHTML::writableCell( 'administrator/modules' );
mosHTML::writableCell( 'administrator/templates' );
mosHTML::writableCell( 'cache' );
mosHTML::writableCell( 'components' );
mosHTML::writableCell( 'images' );
mosHTML::writableCell( 'images/banners' );
mosHTML::writableCell( 'images/stories' );
mosHTML::writableCell( 'language' );
mosHTML::writableCell( 'mambots' );
mosHTML::writableCell( 'mambots/content' );
mosHTML::writableCell( 'mambots/search' );
mosHTML::writableCell( 'media' );
mosHTML::writableCell( 'modules' );
mosHTML::writableCell( 'templates' );

?>
		
            </td>
          </tr>
        </table>
		<?php
		$tabs->endTab();		
		$tabs->endPane();
		?>
		<?php 
	}

	function credits( $version ) { 
		?>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td bgcolor="#FFFFFF"> 
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
				<tr>
					<td align="center">
					<?php echo $version; ?> 
					</td>
				</tr>
				<tr>
					<td align="center">
					<b>
					Credits
					</b>
					<br /><br />
					</td>
				<tr>
					<td align="center">
					<script language="JavaScript1.2">
					/*
					Fading Scroller- By DynamicDrive.com
					For full source code, and usage terms, visit http://www.dynamicdrive.com
					This notice MUST stay intact for use
					*/
					var delay=1000 //set delay between message change (in miliseconds)
					var fcontent=new Array()
					begintag='' //set opening tag, such as font declarations
					fcontent[0]="<h3>Robert Castley<br /></h3>Mambo Project Manager";
					fcontent[1]="<h3>Emir Sakic<br /></h3>Mambo Developer";
					fcontent[2]="<h3>Andrew Eddie<br /></h3>Mambo Lead Developer";
					fcontent[3]="<h3>Ron Bakker<br /></h3>Mambo Developer";
					fcontent[4]="<h3>Phil Taylor<br /></h3>Mambo Developer";
					fcontent[5]="<h3>Nick Designer<br /></h3>Web Design";
					fcontent[6]="<h3>Rey Gigataras<br /></h3>Mambo Developer";
					fcontent[7]="<h3>Michelle Bisson<br /></h3>Documentation Manager";
					fcontent[8]="<h3>Brian Teeman<br /></h3>Counsellor";
					fcontent[9]="<h3>Tim Broeker<br /></h3>Web Standards";
					fcontent[10]="<h3>Mitch Pirtle<br /></h3>Database/PHP Developer";
					fcontent[11]="<h3>Alex Kempkens<br /></h3>Mambo Developer";
					fcontent[12]="<h3>Andy Miller<br /></h3>Mambo Developer";
					fcontent[13]="<h3>Past Contributions</h3>Steen Rabol<br />James Logan";
					closetag=''
					
					var fwidth='250px' //set scroller width
					var fheight='100px' //set scroller height
					
					var fadescheme=0 //set 0 to fade text color from (white to black), 1 for (black to white)
					var fadelinks=1 //should links inside scroller content also fade like text? 0 for no, 1 for yes.
					
					///No need to edit below this line/////////////////
					
					var hex=(fadescheme==0)? 255 : 0
					var startcolor=(fadescheme==0)? "rgb(255,255,255)" : "rgb(0,0,0)"
					var endcolor=(fadescheme==0)? "rgb(0,0,0)" : "rgb(255,255,255)"
					
					var ie4=document.all&&!document.getElementById
					var ns4=document.layers
					var DOM2=document.getElementById
					var faderdelay=0
					var index=0
					
					if (DOM2)
					faderdelay=2000
					
					//function to change content
					function changecontent(){
						if (index>=fcontent.length)
							index=0
							if (DOM2){
								document.getElementById("fscroller").style.color=startcolor
								document.getElementById("fscroller").innerHTML=begintag+fcontent[index]+closetag
								linksobj=document.getElementById("fscroller").getElementsByTagName("A")
								if (fadelinks)
									linkcolorchange(linksobj)
									colorfade()
								} else if (ie4)
									document.all.fscroller.innerHTML=begintag+fcontent[index]+closetag
								else if (ns4){
								document.fscrollerns.document.fscrollerns_sub.document.write(begintag+fcontent[index]+closetag)
								document.fscrollerns.document.fscrollerns_sub.document.close()
							}
						index++
						setTimeout("changecontent()",delay+faderdelay)
					}
					
					// colorfade() partially by Marcio Galli for Netscape Communications.  ////////////
					// Modified by Dynamicdrive.com
					
					frame=20;
					
					function linkcolorchange(obj){
						if (obj.length>0){
							for (i=0;i<obj.length;i++)
								obj[i].style.color="rgb("+hex+","+hex+","+hex+")"
							}
						}
					
					function colorfade() {
					// 20 frames fading process
					if(frame>0) {
						hex=(fadescheme==0)? hex-12 : hex+12 // increase or decrease color value depd on fadescheme
						document.getElementById("fscroller").style.color="rgb("+hex+","+hex+","+hex+")"; // Set color value.
						if (fadelinks)
							linkcolorchange(linksobj)
							frame--;
							setTimeout("colorfade()",20);
						} else {
							document.getElementById("fscroller").style.color=endcolor;
							frame=20;
							hex=(fadescheme==0)? 255 : 0
						}
					}
					
					if (ie4||DOM2)
						document.write('<div id="fscroller" style="border:0px solid black;width:'+fwidth+';height:'+fheight+';padding:2px"></div>')
						window.onload=changecontent
					</script>
					<ilayer id="fscrollerns" width=&{fwidth}; height=&{fheight};>
						<layer id="fscrollerns_sub" width=&{fwidth}; height=&{fheight}; left=0 top=0></layer>
					</ilayer>
					</td>
				</tr>
				</table>
			</td>
		</tr>
</table>

		<table class="adminform">
		<tr>
			<th>
			Application
			</th>
			<th>
			URL
			</th>
			<th>
			Version
			</th>
			<th>
			License
			</th>
		</tr>
		<tr>
			<td>
			JSCookMenu
			</td>
			<td>
			<a href="http://www.cs.ucla.edu/%7Eheng/JSCookMenu/index.html" target="_blank">
			http://www.cs.ucla.edu/~heng/JSCookMenu/index.html
			</a>
			</td>
			<td>
			1.25
			</td>
			<td>
			<a href="http://www.cs.ucla.edu/%7Eheng/JSCookMenu/copyright.html" target="_blank">
			http://www.cs.ucla.edu/%7Eheng/JSCookMenu/copyright.html
			</a>
			</td>
		</tr>
		<tr>
			<td>
			TinyMCE Editor
			</td>
			<td>
			<a href="http://tinymce.moxiecode.com/" target="_blank">
			http://tinymce.moxiecode.com/
			</a>
			</td>
			<td>
			1.31
			</td>
			<td>
			<a href="http://www.gnu.org/copyleft/lesser.html" target="_blank">
			LGPL
			</a>
			</td>
		</tr>
		<tr>
			<td>
			DOMIT &amp; DOMIT RSS
			</td>
			<td>
			<a href="http://www.engageinteractive.com/" target="_blank">
			http://www.engageinteractive.com/
			</a>
			</td>
			<td>
			0.98/0.3</td>
			<td>
			<a href="http://www.gnu.org/copyleft/lesser.html" target="_blank">
			LGPL
			</a>
			</td>
		</tr>
		<tr>
			<td>
			PCLZip/PLCTar
			</td>
			<td>
			<a href="http://www.phpconcept.net" target="_blank">
			http://www.phpconcept.net
			</a>
			</td>
			<td>
			2.0-rc1
			</td>
			<td>
			<a href="http://www.gnu.org/copyleft/lesser.html" target="_blank">
			LGPL
			</a>
			</td>
		</tr>
		<tr>
			<td>
			phpGACL
			</td>
			<td>
			<a href="http://phpgacl.sf.net" target="_blank">
			http://phpgacl.sf.net
			</a>
			</td>
			<td>
			3.2.2
			</td>
			<td>
			<a href="http://www.gnu.org/copyleft/lesser.html" target="_blank">
			LGPL
			</a>
			</td>
		</tr>
		<tr>
			<td>
			Calendar
			</td>
			<td>
			<a href="http://dynarch.com/mishoo/calendar.epl" target="_blank">
			http://dynarch.com/mishoo/calendar.epl
			</a>
			</td>
			<td>
			0.9.2
			</td>
			<td>
			<a href="http://www.gnu.org/copyleft/lesser.html" target="_blank">
			LGPL
			</a>
			</td>
		</tr>
		<tr>
			<td>
			overLIB
			</td>
			<td>
			<a href="http://www.bosrup.com/web/overlib" target="_blank">
			http://www.bosrup.com/web/overlib
			</a>
			</td>
			<td>
			4.00
			</td>
			<td>
			<a href="http://www.bosrup.com/web/overlib/?License" target="_blank">
			http://www.bosrup.com/web/overlib/?License
			</a>
			</td>
		</tr>
		<tr>
			<td>
			ezPDF
			</td>
			<td>
			<a href="http://www.ros.co.nz/pdf" target="_blank">
			http://www.ros.co.nz/pdf
			</a>
			</td>
			<td
			>0.0.9
			</td>
			<td>
			Public Domain
			</td>
		<tr>
			<td>
			Icons
			</td>
			<td>
			<a href="http://www.foood.net" target="_blank">
			http://www.foood.net
			</a>
			</td>
			<td>
			N/A
			</td>
			<td>
			<a href="http://www.foood.net/agreement.htm" targer="_blank">
			http://www.foood.net/agreement.htm
			</a>
			</td>
		</tr>
		<tr>
			<td>
			XP-Style Tabs
			</td>
			<td>
			<a href="http://webfx.eae.net/" target="_blank">
			http://webfx.eae.net/
			</a>
			</td>
			<td>
			1.02
			</td>
			<td>
			Public Domain
			</td>
		</tr>
		<tr>
			<td>
			PHPMailer
			</td>
			<td>
			<a href="http://phpmailer.sourceforge.net/" target="_blank">
			http://phpmailer.sourceforge.net/
			</a>
			</td>
			<td>
			1.72
			</td>
			<td>
			<a href="http://www.gnu.org/copyleft/lesser.html" target="_blank">
			LGPL
			</a>
			</td>
		</tr>
		<tr>
			<td>
			Feedcreator
			</td>
			<td>
			<a href="http://www.bitfolge.de/rsscreator-en.html" target="_blank">
			http://www.bitfolge.de/rsscreator-en.html
			</a>
			</td>
			<td>
			1.71
			</td>
			<td>
			<a href="http://www.gnu.org/licenses/gpl.html" target="_blank">
			GPL
			</a>
			</td>
		</tr>
		</table>
		<?php	
	}

	function ListComponents() {
		global $database, $acl, $my;
			mosLoadAdminModule( 'components' );
		}

	/**
	* Display Help Page
	*/
	function help() {
		global $mosConfig_live_site;
		$helpsearch = mosGetParam( $_REQUEST, 'helpsearch', '' );
		$page = mosGetParam( $_REQUEST, 'page', 'apdx.whatsnew' );
		$toc = getHelpToc( $helpsearch );
		?>
		<style type="text/css">
		.helpIndex {
			border: 0px;
			width: 95%;
			height: 400px;
			padding: 0px 5px 0px 10px;
			overflow: auto;
		}
		.helpFrame {
			border-left: 2px solid #222;
			border-right: none;
			border-top: none;
			border-bottom: none;
			width: 95%;
			height: 400px;
			padding: 0px 5px 0px 10px;
		}
		</style>
		<table class="adminform">
		<tr>
			<th colspan="2" class="title">
			Help
			</th>
		</tr>
		<tr>
			<td colspan="2">
			<form name="adminForm">
			<strong>Search:</strong>
			<input class="text_area" type="hidden" name="option" value="com_admin" />
			<input type="hidden" name="task" value="help" />
			<input type="text" name="helpsearch" value="<?php echo $helpsearch;?>" class="inputbox" />
			<input type="submit" value="Go" class="button" />
			<input type="button" value="Clear Results" class="button" onclick="f=document.adminForm;f.helpsearch.value='';f.submit()" />
			</form>
			</td>
		</tr>
		<tr>
			<td width="20%" valign="top">
			<strong>Index</strong>
			<div class="helpIndex">
			<?php
			foreach ($toc as $k=>$v) {
			echo '<br /><a href="' . $mosConfig_live_site . '/help/' . $k . '" target="helpFrame">' . $v . '</a>';
			}
			?>
			</div>
			</td>
			<td>
			<iframe name="helpFrame" src="<?php echo $mosConfig_live_site . '/help/' . $page . '.xml';?>" class="helpFrame" /></iframe>
			</td>
		</tr>
		</table>
		<?php
	}

	/**
	* Preview site
	*/
	function preview( $tp=0 ) {
	    global $mosConfig_live_site;
	    $tp = intval( $tp );
		?>
		<style type="text/css">
		.previewFrame {
			border: none;
			width: 95%;
			height: 600px;
			padding: 0px 5px 0px 10px;
		}
		</style>
		<table class="adminform">
		<tr>
			<th width="50%" class="title">
			Site Preview
			</th>
			<th width="50%" style="text-align:right">
			<a href="<?php echo $mosConfig_live_site . '?tp=' . $tp;?>" target="_blank">
			Open in new window
			</a>
			</th>
		</tr>
		<tr>
			<td width="100%" valign="top" colspan="2">
			<iframe name="previewFrame" src="<?php echo $mosConfig_live_site . '?tp=' . $tp;?>" class="previewFrame" /></iframe>
			</td>
		</tr>
		</table>
		<?php
	}
}


function getHelpTOC( $helpsearch ) {
	global $mosConfig_absolute_path;

	$files = mosReadDirectory( $mosConfig_absolute_path . '/help/', '.xml$' );

	require_once( $mosConfig_absolute_path . '/includes/domit/xml_domit_lite_include.php' );

	$toc = array();
	foreach ($files as $file) {
		$xmlDoc =& new DOMIT_Lite_Document();
	    if ($xmlDoc->loadXML( $mosConfig_absolute_path . '/help/' . $file, false, true )) {
		    $elem = $xmlDoc->getElementsByPath( 'title', 1 );
		    if ($elem) {
		        if ($helpsearch) {
		            if (strpos( $xmlDoc->getText(), $helpsearch ) !== false) {
				    	$toc[$file] = $elem->getText();
					}
				} else {
				    $toc[$file] = $elem->getText();
				}
			}
		}
	}
	asort( $toc );
	return $toc;
}
?>
