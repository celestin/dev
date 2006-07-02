
	<form action="index.php?do=done" method="post" name="templatePreview" id="templatePreview">	<!-- Template details -->
		<div id="templatedetails" style="display:none">
<p><img src="<?php echo $mosConfig_live_site; ?>/images/save_f2.png" alt="" class="editimage" onClick="hide('templatedetails')"/></p>
<p class="contentheading">Template Details</p>
<p>This section produces the Template installation file</p>
			<div class="left">
<p>Template Author:				
				<input type="text" name="author"  size="40" /></p>
<p>Author Email:				
				<input type="text" name="email"  size="40" /></p>
<p>Author Url:				
				<input type="text" name="url"  size="40" /></p>
			</div>
			<div class="right">
<p>Copyright:
				<select name="copyright" class="font">
					<option value="GNU/GPL License" selected>GNU/GPL License</option>
					<option value="Creative Commons Attribution-NonCommercial-ShareAlike License, 2004">Creative Commons Attribution - NonCommercial - ShareAlike License, 2004.</option>
					<option value="CR">Copyright</option>
				</select></p>
<p>Version:				
				<input type="text" name="version"  size="10" /></p>
<p>Description:				
				<input type="text" name="description"  size="40" /></p>
			</div>
		</div>	<!-- Layout -->
		<div id="layout" style="display:none"><fieldset><legend>Page Layout</legend>
			<div class="left">
<p>Page</p><?php specialbgfield('body','body');?><br/><?php if ($nu_images >= 1){ image_list('body','body');}?>
			</div>
			<div class="right">
<p>Main Content Column</p><?php specialbgfield('main','#outer'); ?><br/><?php if ($nu_images >= 1){ image_list('outer','#outer');}?>
			</div></fieldset><?php 	if ( $page_width != 'fullpage') {
					echo'<fieldset><legend>Page Format</legend><div class="left">	
		<span class="red">*</span>Page Width % or px <input type="text" name="page_w" value="800px" onBlur="addCSSRule(\'#pagewidth\', \'width:\'+this.value)" onChange="styleSize(this.value,this,false)" />
		         </div>
				 <div class="right"></div></fieldset>';} 
				if ( $header == 'header' ) {
					echo '<fieldset><legend>Header</legend>
					<div class="left">	Height	<input type="text" name="header_height" onblur="addCSSRule(\'#header\', \'height:\'+this.value)" onChange="styleSize(this.value,this,false)" value="40px" /><br/>'; 
					specialbgfield('header','#header');
					echo '</div>
					<div class="right">';
					if ($nu_images >= 1){image_list('header','#header');}
					echo '</div></fieldset>';} 
		?><fieldset><legend>Column Properties</legend>
			<div class="left"><h4>Left Column</h4><span class="red">*</span>Width				
				<input type="text" name="left_width" value="150px"  onblur="styleSize(this,'#leftcol', 'width:'+this.value);addCSSRule('#leftcol', ' margin-left:-'+this.value);addCSSRule('#outer', 'border-left-width:'+this.value)"/><br/>Background Color				
				<input type="text"  id="left_bg" name="left_bg" onClick="oldColor=this.value;clickedField=this;getstyle('#outer','border-left-color:');" onChange="setColor(this.value);"/>
			</div><?php 
				if ( $column == 'three_col' ) {?>
			<div class="right"><h4>Right Column</h4>Width<span class="red">*</span>				
				<input type="text" name="right_width" value="150px"  onblur="styleSize(this,'#rightcol', 'width:'+this.value);addCSSRule('#rightcol', ' margin-right:-'+this.value);addCSSRule('#outer', '/*/*/ border-right-width:'+this.value)"/><br/>Background Color				
				<input type="text"  id="right_bg" name="right_bg" onClick="oldColor=this.value;clickedField=this;getstyle('#outer','border-right-color:');" onChange="setColor(this.value);"/>
			</div><?php
				}?></fieldset><?php 
				if ( $footer == 'footer' ) {?>
				
					<fieldset><legend>Footer</legend><div class="left">Text for footer<br/><textarea  id="footertext" name="footertext" onblur="writefooter();"></textarea><br/><script language="JavaScript" type="text/javascript">
function writefooter()
{
	var ft = document.getElementById("footertext").value;
	document.getElementById("footer").innerHTML=ft;
}

</script>
Height<input type="text" name="footer_height" onblur="styleSize(this,'#footer', 'height:'+this.value)" value="100px" /><br/>
Padding Top px<input type="text" name="style[#footer][padding-top]" maxlength="4" onBlur="padSize(this,'#footer', 'padding-top:'+this.value)"><br/>
					<?php specialbgfield('footer','#footer');?>
					
					</div><div class="right">
					<?php fontfields('#footer');
					if ($nu_images >= 1){ image_list('footer','#footer');}
					?><?php echo '</div></fieldset>';}?>
		</div>	<!-- mambo essentials -->
		<div id="messentials" style="display:none">
<p class="contentheading">Mambo Essentials</p><?php 
				if ($bd['browser']== 'MSIE'){ 
					echo 'You appear to be using Internet Explorer<br/>If it get\'s confused adding these elements  simply close the box by clicking the save button, then return to edit your styles<br/>';
				}
  				if ( $header == 'header' )  {
					echo '<br/>Site Name								
					<input type="radio" name="sitename" value="show" onClick="show(\'title\',\'sitenameform\')"/>Show								
					<input type="radio" name="sitename" value="hide" onClick="hide(\'title\',\'sitenameform\')"/>None<br/>
					<div id="sitenameform" class="hideessentials" style="display:none;">
					<p><img src="'.$mosConfig_live_site.'/images/save_f2.png" alt=""   onClick="hide(\'sitenameform\')"/></p>'; 
					fontfields('#title'); 
					echo '<br/>Padding'; 
					padfields('#title','padding'); 
					echo '</div>';
				}?>Show Search Box			
			<input type="radio" name="search" value="left" onclick="show('Lsearch')<?php if ( $column == 'three_col' ){?>;hide('Rsearch')<?php }?>"/>Left<?php 
				if ( $column == 'three_col' ) {
					echo '<input type="radio" name="search" value="right"  onClick="show(\'Rsearch\');hide(\'Lsearch\')"/>Right'; 
				}?>			
			<input type="radio" name="search" value="" onclick="hide(<?php if ( $column == 'three_col' ) {echo '\'Rsearch\',';}?>'Lsearch')"/>None<br/>Show Pathway			
			<input type="radio" name="path" value="main"  onclick="show('Mpathway','pathwayform');hide(<?php if ( $header == 'header' ) { 
					echo '\'Tpathway\',';
				}?>
				'Lpathway')"/>Main Column			
			<input type="radio" name="path" value="left" onClick="show('Lpathway','pathwayform');hide(<?php 
				if ( $header == 'header' ) { 
					echo '\'Tpathway\',';
				}?>
				'Mpathway')"/>Left<?php  
				if ( $header == 'header' )  {
					echo '<input type="radio" name="path" value="top"  onClick="show(\'Tpathway\',\'pathwayform\');hide(\'Lpathway\',\'Mpathway\')"/>Top';
				}?>			
			<input type="radio" name="path"  onClick="hide(<?php 
				if ( $header == 'header' ) { 
					echo '\'Tpathway\',';
				}?>
				'Mpathway','Lpathway','pathwayform')"/>None<br/>
			<div id="pathwayform" class="hideessentials" style="display:none">
<p><img src="<?php echo $mosConfig_live_site; ?>/images/save_f2.png" alt="" onClick="hide('pathwayform')"/></p><?php fontfields('.pathway'); bgcolor('.pathway');?><br/>Padding<?php padfields('.pathway','padding');?>
			</div>	Show Date<?php  
				if ( $header == 'header' )  { 
					echo '<input type="radio" name="date" value="top" onClick="show(\'Tdate\',\'dateform\');hide(\'Mdate\')"/>Top';
				}?>			
			<input type="radio" name="date" value="left" onClick="show('Mdate','dateform')<?php 
				if ( $header == 'header' ) { 
					echo ';hide(\'Tdate\')';
				}?>"/>Above left Column			
			<input type="radio" name="date"   onClick="hide(<?php 
				if ( $header == 'header' ) { 
					echo '\'Tdate\',';
				}?>'Mdate','dateform')"/>None
			<div id="dateform" class="hideessentials" style="display:none">
<p><img src="<?php echo $mosConfig_live_site; ?>/images/save_f2.png" alt="" onClick="hide('dateform')"/></p><?php fontfields('.date');  bgcolor('.date'); 
				echo '<br/>Margin Left'; 
				padfields('.date','margin-left');?>
			</div>
		</div>	<!-- Font Properties -->
		<div id="fontcontent" style="display:none;"><span class="contentheading">Font Styles</span><fieldset><legend>Font Properties</legend>
			<div class="left"><?php fontfields('div'); ?>
			</div></fieldset><fieldset><legend>Links</legend>
			<div class="left">
<p><a class="anchor" href="#">Links</a></p><?php fontfields('a'); 
						textdecfield('a');?>
			</div>
			<div class="right">
<p><a class="ahover" href="#">Hover</a></p><?php fontfields('a:hover'); 
					textdecfield('a:hover');?>
			</div></fieldset>
		</div>	<!-- Categories -->
		<div id="mcategories" style="display:none"><span class="contentheading">Categories</span><fieldset>
			<div class="left">
				<div class="categorytitle">	Category Titles
				</div><?php fontfields('.categorytitle');?>
			</div>
			<div class="right">
				<div class="componentheading">	Component Heading
				</div><?php fontfields('.componentheading');?>
			</div></fieldset><fieldset><legend>Category Links</legend><img src="<?php echo $previewimage_dir; ?>arrow.png" alt=""/>&nbsp;
							<a class="category">Latest News</a><i>(3 items)</i>
			<div class="left">	Link<br/><?php fontfields('a.category');textdecfield('a.category');?>
			</div>
			<div class="right"><a class="categoryhover">Hover</a><br/><?php fontfields('a.category:hover');textdecfield('a.category:hover');?>
			</div></fieldset>
		</div>	<!-- Content -->
		<div id="mcontent" style="display:none"><?php echo CONTENTPREVIEW; ?><br/><fieldset>
			<div class="left">	Content Heading<br/><?php fontfields('.contentheading');?>
			</div>
			<div class="right">	Content Description<br/><?php fontfields('.contentdescription');?>
			</div></fieldset>
		</div>	<!-- General -->
		<div id="mgeneral" style="display:none"><span class="contentheading">General Styles</span><fieldset>
<hr class="hr"/>
<hr class="seperator"/>
			<div class="left">	Horizontal RuleBackground Color<input type="text" name="hr_bg" onClick="oldColor=this.value;clickedField=this;getstyle('hr','background-color:');" onChange="setColor(this.value);"/><br/>Width px or %<input type="text" name="hr_width" value="90%"  onBlur="styleSize(this,'hr','width:'+this.value)"/><br/>Height px or %<input type="text" name="hr_height" value="2px"  onBlur="hrSize(this,'hr','height:'+this.value)"/>
			</div>
			<div class="right">	Horizontal Rule Separator Color<input type="text" name="hrs_bg" onClick="oldColor=this.value;clickedField=this;getstyle('hr.seperator','background-color:');" onChange="setColor(this.value);"/><br/>Width  px or %				
				<input type="text" name="hrs_width" value="40%"  onBlur="styleSize(this,'hr.seperator','width:'+this.value)" /><br/>Height px or %<input type="text" name="hrs_height" value="2px" onChange="hrSize(this.value,this,false)" onBlur="addCSSRule('hr.seperator','height:'+this.value)"/>
			</div></fieldset><fieldset><legend class="pnav"><a href="#" class="pnav">&lt;&lt; Start</a><a href="#" class="pnav">&lt; Previous</a><a href="#" class="pnav">1</a><a href="#" class="pnav">Next &gt;</a><a href="#" class="pnav">End &gt;&gt;</a></legend>
			<div class="left"><?php fontfields('a.pnav');textdecfield('a.pnav');?>
			</div>
			<div class="right"><span class="pnavhover">Link Hover</span><br/><?php fontfields('.pnav:hover'); textdecfield('a.pnav:hover'); ?>
			</div></fieldset>
		</div>	<!-- Small Font -->
		<div id="msmall" style="display:none"><span class="contentheading">Small Text</span><br/><fieldset>
			<div class="left"><span class="small">This is small text</span><br/><?php fontfields('.small');?>
			</div>
			<div class="right"><span class="smalldark">This is small dark text</span><br/><?php fontfields('.smalldark');?>
			</div></fieldset>
		</div>	<!-- Menu -->
		<div id="mmenu" style="display:none"><span class="contentheading">Main Menu</span><fieldset><legend>Menu Item Link</legend>
			<div class="left"><?php fontfields('a.mainlevel');textdecfield('a.mainlevel');?>
			</div>
			<div class="right"><span class="mainlevelhover">Link Hover</span><br/><?php fontfields('a.mainlevel:hover');textdecfield('a.mainlevel:hover');?>
			</div></fieldset><fieldset><legend>Child Links</legend>
			<div class="left"><?php fontfields('a.sublevel');textdecfield('a.sublevel');?>
			</div>
			<div class="right"><span class="sublevelhover">Link Hover</span><br/><?php fontfields('a.sublevel:hover');textdecfield('a.sublevel:hover');?>
			</div></fieldset>
		</div>	<!-- forms -->
		<div id="mform" style="display:none"><span class="contentheading">Mambo Forms</span><fieldset><legend>Buttons</legend>
			<div class="left"><?php fontfields('.button');?>
			</div>
			<div class="right"><?php bgcolor('.button')?><br/><?php borderfields('.button');
					echo '<br/>Padding'; padfields('.button','padding');cursorfield('.button');?>
			</div></fieldset><fieldset><legend>Input Box</legend>
			<div class="left"><?php fontfields('.inputbox');?>
			</div>
			<div class="right"><?php bgcolor('.inputbox')?><br/><?php borderfields('.inputbox'); 
					echo '<br/>Padding'; padfields('.inputbox','padding');?>
			</div></fieldset>
		</div>	<!-- Tab -->
		<div id="mtab" style="display:none"><span class="contentheading">Tab Buttons</span><br/><?php echo TABPREVIEW;?><fieldset>
			<div class="left">	On Tab<br/><?php fontfields('.ontab'); bgcolor('.ontab'); ?><br/><?php borderfields('.ontab');
						echo '<br/>Padding'; padfields('.ontab','padding'); cursorfield('.ontab'); ?>
			</div>
			<div class="right">	Off Tab<br/><?php fontfields('.offtab'); bgcolor('.offtab'); ?><br/><?php borderfields('.offtab');
						echo '<br/>Padding';padfields('.offtab','padding'); cursorfield('.offtab'); ?>
			</div></fieldset>
		</div>	<!-- Other -->
		<div id="mother" style="display:none">
			<div><br/><span class="contentheading">Other</span><br/><span class="small">Written by Web Master</span><br/><span class="createdate">Thursday, 12 June 2003</span><br/>
			</div><fieldset>
			<div class="left">	Date Created<br/><?php fontfields('.createdate');?>
			</div>
			<div class="right">	Last updated on<br/><?php fontfields('.modifydate');?>
			</div></fieldset>
			<div class="modifydate">	Last Updated (Thursday, 12 June 2003)
			</div><a href "#" class="readon">	Read more...
					</a><fieldset><legend>Read On</legend>
			<div class="left"><span class="readon">Readon link</span><br/><?php fontfields('a.readon');?>
			</div>
			<div class="right"><span class="readonhover">Readon link hover</span><br/><?php fontfields('a.readon:hover');?>
			</div></fieldset>
		</div>	<!-- Section -->
		<div id="msection" style="display:none"><span class="contentheading">Sections</span><?php echo SECTIONPREVIEW;?><fieldset>
			<div class="left">	Section Heading<br/><?php fontfields('.sectiontableheader');?>
			</div>
			<div class="right">
			</div></fieldset>
		</div>	<!-- Rows -->
		<div id="rowcols" style="display:none"><span class="contentheading">Alternating Row Colors</span><?php echo ROWCOLORPREVIEW;?>Row 1<?php bgcolor('.sectiontableentry1');?><br/>Row 2<?php bgcolor('.sectiontableentry2');?>
		</div>	<!-- Module -->
		<div id="mmodule" style="display:none"><span class="contentheading">Modules</span><fieldset><legend>Module Table</legend>
			<div class="left">	Margin<?php padfields('table.moduletable','margin');?>
			</div>
			<div class="right">	Width px %				
				<input type="text" name="style[table.moduletable][width]" id="moduletable_width" value="100%" onblur="styleSize(this,'table.moduletable', 'width:'+this.value)"/>
			</div></fieldset><fieldset>
			<div class="left">	Module Heading<br/><?php fontfields('table.moduletable th ');?>
			</div>
			<div class="right">	Module Cells<br/><?php fontfields('table.moduletable td ');?>
			</div></fieldset>
		</div>	<!-- Polls-->
		<div id="mpoll" style="display:none"><span class="contentheading">Polls</span><fieldset>
			<div class="left"><?php fontfields('.poll');?>
			</div>
			<div class="right"><?php borderfields('.poll');?><?php if ( $column == 'two_col' ) {echo ('<div class="pollmessage">To close Poll preview click anywhere in the poll</div>');}?>
			</div></fieldset>
		</div>	<!-- Search -->
		<div id="msearch" style="display:none"><span class="contentheading">Search</span><?php echo SEARCHPREVIEW;?><fieldset>
			<div class="left"><?php fontfields('.searchintro');?>
			</div>
			<div class="right"><?php borderfields('.searchintro');?><br/>
			</div></fieldset>
		</div>	<!-- Contact -->
		<div id="mcontact" style="display:none"><span class="contentheading">Contact</span><?php echo CONTACTPREVIEW; ?><fieldset><legend>Contact</legend>
			<div class="left">	Table Style<br/><?php borderfields('table.contact'); 
						bgcolor('table.contact');?><br/>Icon Cells<?php  bgcolor('table.contact td.icons');?>
			</div>
			<div class="right">	Details<br/><?php fontfields('table.contact td.details');?>
			</div></fieldset>
		</div>	<!-- Newsfeeds -->
		<div id="mnewsfeed" style="display:none"><span class="contentheading">News Feeds</span><fieldset>
			<div class="left">	Newsfeed Headings<br/><?php fontfields('.newsfeedheading');?>
			</div>
			<div class="right">	Newsfeed<?php fontfields('.fase4rdf');?>
			</div></fieldset><fieldset>
			<div class="left">	Newsfeed Links<br/><?php fontfields('a.fase4rdf:link');textdecfield('a.fase4rdf');?>
			</div>
			<div class="right">	Hover<br/><?php fontfields('a.fase4rdf:hover');textdecfield('a.fase4rdf:hover');?>
			</div></fieldset><fieldset>
			<div class="left">	Newsfeed Date<br/><?php fontfields('.newsfeeddate');?>
			</div></fieldset>
		</div>	<!-- Main -->
		<div id="mainpreview" style="display:"><?php echo MAINPREVIEW; ?>			
			<input type="submit" name="NextPage" value="Generate Files" />
		</div>
	</form>