<?php
function isIE(){

if(eregi("msie",$_SERVER['HTTP_USER_AGENT']) && !eregi("opera",$_SERVER['HTTP_USER_AGENT']) ){
 $val = explode(" ",stristr($_SERVER['HTTP_USER_AGENT'],"msie"));
 $bd['browser'] = $val[0];
 $bd['version'] = $val[1];
}

$bd['version'] = str_replace(";","",$bd['version']);
return($bd);
}
$bd = isIE();




define("PATHWAYPREVIEW",' <a href="" class="pathway">Home</a>  
					<img src="'.$previewimage_dir.'arrow.png" border="0" alt="arrow" />   
					<a href="" class="pathway">News</a>  
					<img src="'.$previewimage_dir.'arrow.png" border="0" alt="arrow" />   
					<a href="" class="pathway">Latest</a>  
					<img src="'.$previewimage_dir.'arrow.png" border="0" alt="arrow" />   Welcome to Mambo Template Generator ');
define("SEARCHFORMPREVIEW", 'style="display:none">
								<input type="text" name="searchword" size="17" value="search"  class="inputbox"  /><br/>								
								<input type="submit" name="option" class="button" value="GO" />								
								</div>');
define("POLLPREVIEW", '<table cellspacing="0" cellpadding="1" class="moduletable">
			  			<tr>
    			<th valign="top">Polls</th>
    		</tr>
			    		<tr>

    			<td>
				
	
	<table width="95%" border="0" cellspacing="0" cellpadding="1" align="center">
		<tr>
			<td colspan="2" class="poll"><b>Whats your HTML Rating</b></td>
		</tr>
		<tr><td align="center">

			<table class="pollstableborder" cellspacing="0" cellpadding="0" border="0">
			
		<tr>
			<td class="sectiontableentry2" valign="top"><input type="radio" name="voteid" value="13" /></td>
			<td class="sectiontableentry2" valign="top">Beginner</td>
		</tr>
		<tr>
			<td class="sectiontableentry1" valign="top"><input type="radio" name="voteid" value="14" /></td>

			<td class="sectiontableentry1" valign="top">Little Bit</td>
		</tr>
		<tr>
			<td class="sectiontableentry2" valign="top"><input type="radio" name="voteid" value="15" /></td>
			<td class="sectiontableentry2" valign="top">Average</td>
		</tr>
		<tr>
			<td class="sectiontableentry1" valign="top"><input type="radio" name="voteid" value="16" /></td>

			<td class="sectiontableentry1" valign="top">Expert</td>
		</tr>
		<tr>
			<td class="sectiontableentry2" valign="top"><input type="radio" name="voteid" value="17" /></td>
			<td class="sectiontableentry2" valign="top">Guru</td>
		</tr>
			
			</table>

		</td></tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" name="task_button" class="button" value="Vote" />&nbsp;&nbsp;
				<input type="button" name="option" class="button" value="Results" />
			</td>
		</tr>
	</table>

	<input type="hidden" name="id" value="2" />
	<input type="hidden" name="task" value="vote" />
	
    			</td>
			</tr>
      	</table>');
		
define("RIGHTMODULE", '<br/>
			<table cellspacing="0" cellpadding="1" class="moduletable">
			  			<tr>

    			<th valign="top">Latest News</th>
    		</tr>
			    		<tr>
    			<td>
			<table cellpadding="1" cellspacing="1" border="0">
	<tr>
		<td valign="top"><img src="'.$previewimage_dir.'arrow.png" alt="" />
		<a href="#">Visit MOSForge</a></td>

	</tr>
	<tr>
		<td valign="top"><img src="'.$previewimage_dir.'arrow.png" alt="" />
		<a href="#">Mambo Best Open Source Software</span></a></td>

	</tr>
	<tr>
		<td valign="top"><img src="'.$previewimage_dir.'arrow.png" alt="" />
		<a href="#">Mambo 4.6</a></td>

	</tr>
</table>    			</td>
			</tr>
      	</table>
		<br />
			<table cellspacing="0" cellpadding="1" class="moduletable">
			  			<tr>
    			<th valign="top">Hit Counter</th>

    		</tr>
			    		<tr>
    			<td>
			<div>40 Visitors </div>   			</td>
			</tr>
      	</table>');
		
define("SEARCHPREVIEW", ' 	<table cellpadding="3" cellspacing="0" border="0" width="98%" class="searchintro">
  <tr>
    <td colspan="3" align="left">Search Keyword: <b>Mambo</b>

		returned 1 matches    </td>
  </tr>
</table>
<br />
		<table cellpadding="1" cellspacing="0" border="0" width="98%" class="contentpane">
  		  <tr class="sectiontableentry1">
    <td width="15%"> 5 May</td>
    <td width="75%"><a href="#">Mambo Open Source</a></td>

    <td width="10%" rowspan="2"><span class="small">Welsh Cobs/Stallions</span></td>
  </tr>
  <tr class="sectiontableentry1">
    <td colspan="2">taffy &#133; </td>
  </tr>
  			  <tr>
    <td colspan="3">&nbsp;</td>

  </tr>
  <tr>
    <td colspan="3">
		Total 1 results found.  Search for <b>Mambo</b> with
        <img src="'.$previewimage_dir.'google.png" alt="" width="46" height="18" border="0" align="top" /> </td>
  </tr>

</table>');

define("ROWCOLORPREVIEW",'<table width="100%" cellpadding="4" cellspacing="0" border="0" align="center" class="contentpane">
 <tr>
            <td width="32" height="20" align="center" class="sectiontableheader">&nbsp;</td>

            <td width="85%" height="20" class="sectiontableheader">Link</td>
						<td width="15%" height="20" class="sectiontableheader" align="right">Hits</td>
          </tr>
                    <tr class="sectiontableentry1">
            <td width="32" height="20" align="center"> <img src="'.$previewimage_dir.'weblink.png" width="16" height="16" align="bottom" vspace="3" hspace="10" />
            </td>
            <td> <a href="http://mamboserver.com/" target="_blank" class="category">

              Mambo Open Source </a> <br /> Home of Mambo Open Source            </td>
						<td align="right">
							0						</td>
          </tr>
                    <tr class="sectiontableentry2">
            <td width="32" height="20" align="center"> <img src="'.$previewimage_dir.'weblink.png" width="16" height="16" align="bottom" vspace="3" hspace="10" />

            </td>
            <td> <a href="http://mos-tg.thehorsehost.com/" target="_blank" class="category">
              Mambo Template Generator </a> <br />            </td>
						<td align="right">
							0						</td>
          </tr>

                    <tr class="sectiontableentry1">
            <td width="32" height="20" align="center"> <img src="'.$previewimage_dir.'weblink.png" width="16" height="16" align="bottom" vspace="3" hspace="10" />
            </td>
            <td> <a href="http://forum.mamboserver.com/" target="_blank" class="category">
             Mambo Forums </a> <br />            </td>
						<td align="right">

							1						</td>
          </tr>
		  <tr class="sectiontableentry2">
            <td width="32" height="20" align="center"> <img src="'.$previewimage_dir.'weblink.png" width="16" height="16" align="bottom" vspace="3" hspace="10" />

            </td>
            <td> <a href="http://mosforge.net/" target="_blank" class="category">
              MOSForge </a> <br /> Host components, templates, plug-ins, modules and anything related to Mambo.            </td>
						<td align="right">
							0						</td>
          </tr>
                  </table><br/>');
				 

define("MAINPREVIEW", '<table cellpadding="0" cellspacing="1" border="0" width="100%" class="contentpaneopen">
  <tr>

        <td class="contentheading" width="100%">
			Welcome to Mambo Template Generator	        		
     

	&nbsp;
	</td>
    	    <td align="right"></td>

      </tr>

</table>
<table cellpadding="0" cellspacing="1" border="0" width="100%" class="contentpaneopen">
  <tr>
    <td width="70%" align="left" valign="top">
      	</td>
    <td valign="top" align="right">
	    </td>
  </tr>

  <tr>
	<td valign="top" colspan="2">

	    </td>
  </tr>
  <tr>
    <td valign="top" colspan="2">
	  
	  <br/><img src="'.$mosConfig_live_site.'/administrator/images/asterisk.png" width="48" height="46" style="float:left"  hspace="6" alt="Another logo" border="0" />Select a section to edit from the Main Menu.<br/> 
	  Only fields marked <span class="red">*</span> are required all others are optional.<br/> When you have completed all sections select "home" from the menu. To make your template files, click the generate button located at the bottom of this page.
	  <h4>Template Features:</h4>


<ul><li>No Html or Css knowledge needed</li>
	<li>Tableless CSS layout </li>
	<li>W3 Compliant pages</li>
	<li>Includes left, top, bottom and right(if 3 column layout) modules </li>
	<li>Optional Site Name, date, search boxes and pathway</li>
	</ul>
</td>
  </tr>
      </table>'); 

define("TABPREVIEW", '<table cellspacing="0" cellpadding="4" border="0" width="100%">
									<tr>
										<td class="ontab">	Content
										</td>
										<td class="offtab">	Images
										</td>
										<td class="offtab">	Publishing
										</td>
										<td class="offtab">	Metadata
										</td>
										<td width="90%" class="tabpadding">	&nbsp;
										</td>
									</tr>
								</table>');

define("CONTENTPREVIEW", '<table width="100%" cellpadding="1" cellspacing="0" border="0" align="center" class="contentpane">
									<tr>
										<td colspan="2" class="contentheading" width="100%">	The News
										</td>
									</tr>
									<tr>
										<td width="60%" valign="top" class="contentdescription" colspan="2">	Select a news topic from the list below, then select a news article to read.
										</td>
									</tr>
									<tr>
										<td colspan="2">	&nbsp;
										</td>
									</tr>
									<tr>
										<td colspan="2"><img src="'.$previewimage_dir.'arrow.png" alt=""/>&nbsp;<a  class="category">Latest News</a><i>(3 items)</i>
										</td>
									</tr>
								</table>');
								
define("SECTIONPREVIEW", '<table width="100%" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td class="sectiontableheader">	&nbsp;Date
										</td>
										<td class="sectiontableheader">	Item Title
										</td>
										<td align="center" class="sectiontableheader">	Author
										</td>
										<td align="center" class="sectiontableheader">	Hits
										</td>
									</tr>
									<tr>
										<td align="left">	&nbsp;Jun&nbsp;
										</td>
										<td><a>Welcome to Mambo Open Source</a>
										</td>
										<td align="center">
											<div>	Web Master
											</div>
										</td>
										<td align="center">	5
										</td>
									</tr>
								</table><br/><br/>');

define("CONTACTPREVIEW", '<div class="contact">
					 <div class="details"><b>Mona Lisa</b>
					 </div>	Chairperson<br/><br/></div><table width="100%" cellpadding="2" cellspacing="0" border="0" align="center" class="contact">
										<tr>
											<td width="16" align="center" class="icons"><img src="'.$previewimage_dir.'con_address.png" width="16" height="16" align="middle" alt="Address"/>&nbsp;
											</td>
											<td width="100%" class="details">	1836 Piccaso Dr
											</td>
										</tr>
										<tr>
											<td class="icons">	&nbsp;
											</td>
											<td class="details">	Pizza, AAUU, 24432
											</td>
										</tr>
										<tr>
											<td class="icons">	&nbsp;
											</td>
											<td class="details">	Italy
											</td>
										</tr>
										<tr>
											<td class="icons">	&nbsp;
											</td>
											<td class="details">	&nbsp;
											</td>
										</tr>
										<tr>
											<td class="icons"><img src="'.$previewimage_dir.'con_fax.png" align="middle" width="16" height="16" alt="Fax"/>&nbsp;
											</td>
											<td class="details">	1234 1234
											</td>
										</tr>
									</table>');
?>