<div class="content">
						<div id="Lsearch" <?php echo SEARCHFORMPREVIEW; ?>
						<div id="leftpoll" style="display:none; cursor:pointer" onClick="hide('leftpoll')"><?php if ( $column == 'two_col' ) {echo POLLPREVIEW;}?>
						</div>
						<table cellspacing="0" cellpadding="1" class="moduletable">
							<tr>
								<th valign="top">	Main Menu
								</th>
							</tr>
							<tr>
								<td>
									&nbsp;<a href="#" class="mainlevel" onClick="menu('mainpreview');">Home</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('templatedetails');">Template Details</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('layout');">Layout</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('messentials');">Mambo Essentials</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('fontcontent');">Font Properties</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('mcategories');">Categories</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('mcontent');">Content</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('mgeneral');">General Styles</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('msmall');">Small Text</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('mmenu');">Mambo Menus</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('mform');">Mambo Forms</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('mtab');">Tab Buttons</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('mother');">General Other</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('msection');">Mambo Sections</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('rowcols');">Row Colors</a><br/>
&nbsp;<a href="#" class="mainlevel" onClick="menu('mmodule');">Mambo Modules</a><br/>
<img src="<?php echo $previewimage_dir; ?>blank.png" alt="" height="12" width="4"/><img src="<?php echo $previewimage_dir; ?>indent1.png" alt=""/>
&nbsp;<a href="#" class="sublevel" onClick="menu('mpoll');show('leftpoll');">Polls</a><br/>
<img src="<?php echo $previewimage_dir; ?>blank.png" alt="" height="12" width="4"/><img src="<?php echo $previewimage_dir; ?>indent1.png" alt=""/>
&nbsp;<a href="#" class="sublevel" onClick="menu('msearch');">Search</a><br/>
<img src="<?php echo $previewimage_dir; ?>blank.png" alt="" height="12" width="4"/><img src="<?php echo $previewimage_dir; ?>indent1.png" alt=""/>
&nbsp;<a href="#" class="sublevel" onClick="menu('mcontact');">Contact Page</a><br/>
<img src="<?php echo $previewimage_dir; ?>blank.png" alt="" height="12" width="4"/><img src="<?php echo $previewimage_dir; ?>indent1.png" alt=""/>
&nbsp;<a href="#" class="sublevel" onClick="menu('mnewsfeed');">News Feeds</a>
								</td>
							</tr>
						</table><br/>
						<div id="loginbox">
							<table cellspacing="0" cellpadding="1" class="moduletable">
								<tr>
									<th valign="top">	Login Form
									</th>
								</tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
											<tr>
												<td>
													<div>	Username
													</div>													
													<input type="text" class="inputbox" size="10" />
													<div>	Password
													</div>													
													<input type="password"  class="inputbox" size="10" /><br/>													
													<input type="submit" class="button" value="Login" />
												</td>
											</tr>
											<tr>
												<td>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div><br/>
						
					</div>