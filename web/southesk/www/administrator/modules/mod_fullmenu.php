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
* Full DHTML Admnistrator Menus
* @package Mambo_4.5.1
*/
class mosFullAdminMenu {
	/**
	* Show the menu
	* @param string The current user type
	*/
	function show( $usertype='' ) {
		global $acl, $database;
		global $mosConfig_live_site, $mosConfig_enable_stats, $mosConfig_caching;

		// cache some acl checks
		$canConfig = $acl->acl_check( 'administration', 'config', 'users', $usertype );

		$manageTemplates = $acl->acl_check( 'administration', 'manage', 'users', $usertype, 'components', 'com_templates' );
		$manageTrash = $acl->acl_check( 'administration', 'manage', 'users', $usertype, 'components', 'com_trash' );
		$manageMenuMan = $acl->acl_check( 'administration', 'manage', 'users', $usertype, 'components', 'com_menumanager' );
		$manageLanguages = $acl->acl_check( 'administration', 'manage', 'users', $usertype, 'components', 'com_languages' );
		$installModules = $acl->acl_check( 'administration', 'install', 'users', $usertype, 'modules', 'all' );
		$editAllModules = $acl->acl_check( 'administration', 'edit', 'users', $usertype, 'modules', 'all' );
		$installMambots = $acl->acl_check( 'administration', 'install', 'users', $usertype, 'mambots', 'all' );
		$editAllMambots = $acl->acl_check( 'administration', 'edit', 'users', $usertype, 'mambots', 'all' );
		$installComponents = $acl->acl_check( 'administration', 'install', 'users', $usertype, 'components', 'all' );
		$editAllComponents = $acl->acl_check( 'administration', 'edit', 'users', $usertype, 'components', 'all' );

		$canMassMail = $acl->acl_check( 'administration', 'manage', 'users', $usertype, 'components', 'com_massmail' );
		$canManageUsers = $acl->acl_check( 'administration', 'manage', 'users', $usertype, 'components', 'com_users' );

		$database->setQuery( "SELECT title,params"
		. "\nFROM #__modules"
		. "\nWHERE module='mod_mainmenu'"
		. "\nORDER BY title"
		);
		$modMenus = $database->loadObjectList();
?>
<div id="myMenuID"></div>
<script language="JavaScript" type="text/javascript">
var myMenu =
[
[null,'Home','index2.php',null,'Home Page'],
_cmSplit,
[null,'Site',null,null,'Site Menu',
<?php if ($canConfig) { ?>
['<img src="../includes/js/ThemeOffice/config.png" />','Global Configuration','index2.php?option=com_config',null,'Configuration'],
<?php } ?>
<?php if ($manageLanguages) { ?>
['<img src="../includes/js/ThemeOffice/language.png" />','Languages',null,null,'Manage languages',
['<img src="../includes/js/ThemeOffice/language.png" />','Language Manager','index2.php?option=com_languages',null,'Manage Languages'],
['<img src="../includes/js/ThemeOffice/install.png" />','Install','index2.php?option=com_installer&element=language',null,'Install Languages'],
],
<?php } ?>
['<img src="../includes/js/ThemeOffice/media.png" />','Media Manager','index2.php?option=com_media',null,'Manage Media Files'],
['<img src="../includes/js/ThemeOffice/preview.png" />', 'Preview', null, null, 'Preview',
['<img src="../includes/js/ThemeOffice/preview.png" />','In New Window','<?php echo $mosConfig_live_site; ?>','_blank','<?php echo $mosConfig_live_site; ?>'],
['<img src="../includes/js/ThemeOffice/preview.png" />','Inline','index2.php?option=com_admin&task=preview',null,'<?php echo $mosConfig_live_site; ?>'],
['<img src="../includes/js/ThemeOffice/preview.png" />','Inline with Positions','index2.php?option=com_admin&task=preview2',null,'<?php echo $mosConfig_live_site; ?>'],
],
['<img src="../includes/js/ThemeOffice/globe1.png" />', 'Statistics', null, null, 'Site Statistics',
<?php
if ($mosConfig_enable_stats == 1) {
	?>
	['<img src="../includes/js/ThemeOffice/globe4.png" />', 'Browser, OS, Domain', 'index2.php?option=com_statistics', null, 'Browser, OS, Domain'],
	['<img src="../includes/js/ThemeOffice/globe3.png" />', 'Page Impressions', 'index2.php?option=com_statistics&task=pageimp', null, 'Page Impressions'],
	<?php
}
?>
['<img src="../includes/js/ThemeOffice/search_text.png" />', 'Search Text', 'index2.php?option=com_statistics&task=searches', null, 'Search Text']
],
<?php if ($manageTemplates) { ?>
['<img src="../includes/js/ThemeOffice/template.png" />','Template Manager',null,null,'Change site template',
['<img src="../includes/js/ThemeOffice/template.png" />','Site Templates','index2.php?option=com_templates',null,'Change site template'],
['<img src="../includes/js/ThemeOffice/install.png" />','Install','index2.php?option=com_installer&element=template&client=',null,'Install Site Templates'],
_cmSplit,
['<img src="../includes/js/ThemeOffice/template.png" />','Administrator Templates','index2.php?option=com_templates&client=admin',null,'Change admin template'],
['<img src="../includes/js/ThemeOffice/install.png" />','Install','index2.php?option=com_installer&element=template&client=admin',null,'Install Administrator Templates'],
_cmSplit,
['<img src="../includes/js/ThemeOffice/template.png" />','Module Positions','index2.php?option=com_templates&task=positions',null,'Template positions']
],
<?php } ?>
<?php if ($manageTrash) { ?>
['<img src="../includes/js/ThemeOffice/trash.png" />','Trash Manager','index2.php?option=com_trash',null,'Manage Trash'],
<?php } ?>
<?php if ($canManageUsers || $canMassMail) { ?>
['<img src="../includes/js/ThemeOffice/users.png" />','User Manager',null,null,'Manage users',
<?php	if ($canManageUsers) { ?>
['<img src="../includes/js/ThemeOffice/users_add.png" />','Add/Edit Users','index2.php?option=com_users&task=view',null,'Add/Edit Users'],
<?php	} ?>
<?php	if ($canMassMail) { ?>
['<img src="../includes/js/ThemeOffice/mass_email.png" />','Mass Mail','index2.php?option=com_massmail',null,'Send an e-mail to a register user group']
<?php	} ?>
],
<?php } ?>
],
_cmSplit,
[null,'Menu',null,null,'Manage Site Structure',
<?php	if ($manageMenuMan) { ?>
['<img src="../includes/js/ThemeOffice/menus.png" />','Menu Manager','index2.php?option=com_menumanager',null,'Menu Manager'],
_cmSplit,
<?php	} ?>
<?php
foreach ($modMenus as $modMenu) {
	mosMakeHtmlSafe($modMenu);
	$modParams = mosParseParams( $modMenu->params );
	$menuType = @$modParams->menutype;
	if (!$menuType) {
		$menuType = 'mainmenu';
	}
	?>
	['<img src="../includes/js/ThemeOffice/menus.png" />','<?php echo $modMenu->title;?>','index2.php?option=com_menus&menutype=<?php echo $menuType;?>',null,''],
	<?php
}
?>
],
_cmSplit,
[null,'Content',null,null,'Content Management',
['<img src="../includes/js/ThemeOffice/edit.png" />','Content Managers',null,null,'Content Managers',
['<img src="../includes/js/ThemeOffice/edit.png" />','All Content Items','index2.php?option=com_content&sectionid=0',null,'Manage Content Items'],
<?php $database->setQuery( "SELECT a.id, a.title, a.name,"
. "\n	COUNT(DISTINCT c.id) AS numcat, COUNT(DISTINCT b.id) AS numarc"
. "\nFROM #__sections AS a"
. "\nLEFT JOIN #__categories AS c ON c.section=a.id"
. "\nLEFT JOIN #__content AS b ON b.sectionid=a.id AND b.state=-1"
. "\nWHERE a.scope='content'"
. "\nGROUP BY a.id"
. "\nORDER BY a.ordering"
);
$types = $database->loadObjectList();
foreach ($types as $type) {
	$txt = addslashes( $type->title ? $type->title : $type->name );
	?>
	['<img src="../includes/js/ThemeOffice/document.png" />','<?php echo $txt;?>', null, null,'<?php echo $txt;?>',
	<?php if ($type->numcat) { ?>
	['<img src="../includes/js/ThemeOffice/edit.png" />', '<?php echo $txt;?> Items', 'index2.php?option=com_content&sectionid=<?php echo $type->id;?>',null,null],
	<?php } ?>
	['<img src="../includes/js/ThemeOffice/add_section.png" />', 'Add/Edit <?php echo $txt;?> Categories', 'index2.php?option=com_categories&section=<?php echo $type->id;?>',null, null],
	<?php if ($type->numarc) { ?>
	['<img src="../includes/js/ThemeOffice/backup.png" />', '<?php echo $txt;?> Archive', 'index2.php?option=com_content&task=showarchive&sectionid=<?php echo $type->id;?>',null,null],
	<?php } ?>
	],
	<?php
} ?>
],
_cmSplit,
['<img src="../includes/js/ThemeOffice/edit.png" />','Other Managers',null,null,'Other Managers',
['<img src="../includes/js/ThemeOffice/home.png" />','Frontpage Manager','index2.php?option=com_frontpage',null,'Manage Frontpage Items'],
['<img src="../includes/js/ThemeOffice/edit.png" />','Static Content Manager','index2.php?option=com_typedcontent',null,'Manage Typed Content Items'],
['<img src="../includes/js/ThemeOffice/edit.png" />','Archive Manager','index2.php?option=com_content&task=showarchive&sectionid=0',null,'Manage Archive Items'],
['<img src="../includes/js/ThemeOffice/add_section.png" />','Section Manager','index2.php?option=com_sections&scope=content',null,'Manage Content Sections'],
['<img src="../includes/js/ThemeOffice/add_section.png" />','Category Manager','index2.php?option=com_categories&section=content',null,'Manage Content Categories'],
],
],
<?php
if ($installComponents) {
	?>
	_cmSplit,
	[null,'Components',null,null,'Install/Uninstall',
	<?php
	if ($installComponents) {
		?>
		['<img src="../includes/js/ThemeOffice/install.png" />','Install/Uninstall','index2.php?option=com_installer&element=component',null,'Install/Uninstall components'],
		_cmSplit,
		<?php
	} ?>
	<?php
	$database->setQuery( "SELECT * FROM #__components WHERE name <> 'frontpage' and name <> 'media manager' ORDER BY ordering,name" );
	$comps = $database->loadObjectList();	// component list
	$subs = array();	// sub menus
	// first pass to collect sub-menu items
	foreach ($comps as $row) {
		if ($row->parent) {
			if (!array_key_exists( $row->parent, $subs )) {
				$subs[$row->parent] = array();
			}
			$subs[$row->parent][] = $row;
		}
	}
	$topLevelLimit = 19; //You can get 19 top levels on a 800x600 Resolution
	$topLevelCount = 0;
	foreach ($comps as $row) {
		if ($editAllComponents | $acl->acl_check( 'administration', 'edit', 'users', $usertype, 'components', $row->option )) {
			if ($row->parent == 0 && (trim( $row->admin_menu_link ) || array_key_exists( $row->id, $subs ))) {
				$topLevelCount++;
				if ($topLevelCount > $topLevelLimit) {
					continue;
				}
				$name = addslashes( $row->name );
				$alt = addslashes( $row->admin_menu_alt );
				$link = $row->admin_menu_link ? "'index2.php?$row->admin_menu_link'" : "null";
				echo "\n	['<img src=\"../includes/$row->admin_menu_img\" />','$name',$link,null,'$alt'";
				if (array_key_exists( $row->id, $subs )) {
					echo ',';
					foreach ($subs[$row->id] as $sub) {
						$name = addslashes( $sub->name );
						$alt = addslashes( $sub->admin_menu_alt );
						$link = $sub->admin_menu_link ? "'index2.php?$sub->admin_menu_link'" : "null";
						echo "\n		['<img src=\"../includes/$sub->admin_menu_img\" />','$name',$link,null,'$alt'],";
					}
				}
				echo "\n	],";
			}
		}
	}
	if ($topLevelLimit < $topLevelCount) {
		echo "\n	['<img src=\"../includes/js/ThemeOffice/sections.png\" />','More Components...','index2.php?option=com_admin&task=listcomponents',null,'More Components'],\n";
	}
	?>
	],
	<?php
	if ($installModules | $editAllModules) {
		?>
		_cmSplit,
		[null,'Modules',null,null,null,
		<?php
		if ($installModules) {
			?>
			['<img src="../includes/js/ThemeOffice/install.png" />', 'Install/Uninstall', 'index2.php?option=com_installer&element=module', null, 'Install custom modules'],
			_cmSplit,
			<?php
		} ?>
		<?php
		if ($editAllModules) {
			?>
			['<img src="../includes/js/ThemeOffice/module.png" />', 'Site Modules', "index2.php?option=com_modules", null, 'Manage Site modules'],
			['<img src="../includes/js/ThemeOffice/module.png" />', 'Administrator Modules', "index2.php?option=com_modules&client=admin", null, 'Manage Administrator modules'],
			<?php
		} ?>
		],
		<?php
	} ?>
	<?php
} ?>
<?php
if ($installModules | $editAllModules) {
	?>
	_cmSplit,
	[null,'Mambots',null,null,null,
	<?php
	if ($installModules) {
		?>
		['<img src="../includes/js/ThemeOffice/install.png" />', 'Install/Uninstall', 'index2.php?option=com_installer&element=mambot', null, 'Install custom mambot'],
		_cmSplit,
		<?php
	} ?>
	<?php
	if ($editAllModules) {
		?>
		['<img src="../includes/js/ThemeOffice/module.png" />', 'Site Mambots', "index2.php?option=com_mambots", null, 'Manage Site Mambots'],
		//['<img src="../includes/js/ThemeOffice/module.png" />', 'Manage Administrator Modules', "index2.php?option=com_mambots&client=admin", null, 'Manage installed modules'],
		<?php
	} ?>
	],
	<?php
} ?>
<?php
if ($canConfig) {
	?>
	_cmSplit,
	[null,'Messages',null,null,null,
	['<img src="../includes/js/ThemeOffice/messaging_inbox.png" />','Inbox','index2.php?option=com_messages',null,'Private Messages'],
	['<img src="../includes/js/ThemeOffice/messaging_config.png" />','Configuration','index2.php?option=com_messages&task=config',null,'Configuration']
	],
	_cmSplit,
	[null,'System',null,null,null,
	<?php
	if ($canConfig) { ?>
	['<img src="../includes/js/ThemeOffice/checkin.png" />', 'Global Checkin', 'index2.php?option=com_checkin', null,'Check-in all checked-out items'],
	['<img src="../includes/js/ThemeOffice/sysinfo.png" />', 'System Info', 'index2.php?option=com_admin&task=sysinfo', null, 'System Info'],
	<?php
	if ($mosConfig_caching) { ?>
	['<img src="../includes/js/ThemeOffice/config.png" />','Clean Cache','index2.php?option=com_content&task=clean_cache',null,'Clean the content items cache'],
	<?php
	} ?>
	<?php
	} ?>
	],
	<?php
} ?>
_cmSplit,
[null,'Help',null,null,null,
['<img src="../includes/js/ThemeOffice/help.png" />','Index','index2.php?option=com_admin&task=help',null,'A big thanks to those involved'],
['<img src="../includes/js/ThemeOffice/credits.png" />','Credits','index2.php?option=com_admin&task=credits',null,'A big thanks to those involved'],
['<img src="../includes/js/ThemeOffice/license.png" />','License','index2.php?option=com_admin&task=help&page=apdx.license',null,'GNU/GPL License'],
['<img src="../includes/js/ThemeOffice/help.png" />', 'Support', 'index2.php?option=com_admin&task=help&page=apdx.support', null, 'Mambo Support'],
],
];
cmDraw ('myMenuID', myMenu, 'hbr', cmThemeOffice, 'ThemeOffice');
</script>
<?php
	}
}
$cache =& mosCache::getCache( 'mos_fullmenu' );

mosFullAdminMenu::show( $my->usertype );
//$cache->call( 'mosFullAdminMenu::show', $my->usertype );
?>
