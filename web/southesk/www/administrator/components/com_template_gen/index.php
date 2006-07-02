<? 
define( "_VALID_MOS", 1 );
include_once ("../../../globals.php");
require_once ("../../../configuration.php");
require_once( $mosConfig_absolute_path . "/includes/mambo.php" );
$database = new database( $mosConfig_host, $mosConfig_user, $mosConfig_password, $mosConfig_db, $mosConfig_dbprefix );
$mainframe = new mosMainFrame( $database, $option, '../../../' );
session_name( 'mosadmin' );
session_start();
$session_id = mosGetParam( $_SESSION, 'session_id', '' );
$logintime = mosGetParam( $_SESSION, 'session_logintime', '' );
$my = new mosUser( $database );
$my->id = mosGetParam( $_SESSION, 'session_user_id', '' );
$my->username = mosGetParam( $_SESSION, 'session_username', '' );
$my->usertype = mosGetParam( $_SESSION, 'session_usertype', '' );
$my->gid = mosGetParam( $_SESSION, 'session_gid', '' );
if ($session_id == md5( $my->id.$my->username.$my->usertype.$logintime )) {
	$database->setQuery( "SELECT * FROM #__session"
	. "\nWHERE session_id='$session_id'"
	//. "\n	AND (usertype='administrator' OR usertype='superadministrator')"
	);
	if (!$result = $database->query()) {
		echo $database->stderr();
	}
	if ($database->getNumRows( $result ) <> 1) {
		echo "<script>document.location.href='index.php'</script>\n";
		exit();
	}
} else {
	echo "<script>document.location.href='$mosConfig_live_site/administrator/index.php'</script>\n";
	exit();
}
////////////////Template Gen code
extract ($_POST);
extract ($_GET);
$previewimage_dir = $mosConfig_live_site.'/images/M_images/';
$_SESSION['TemplateDir'] = "$mosConfig_absolute_path/templates";
include("includes/form1.php");
?><!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Mambo Template Generator</title>
<script language="JavaScript" src="includes/javascript.js" type="text/javascript"></script><?php 
		if ($do == "preview"){
			$page_width = $_SESSION['page_width'];
			$column = $_SESSION['column'];
			$header = $_SESSION['header'];
			$footer = $_SESSION['footer'];
			$nu_images = $_SESSION['uploadNeed'];
			$image_slect = $_SESSION['image_slect'];
			include("includes/formtags.php");
			include("includes/include.php");
  			
			if (file_exists("$image_dir/favicon.ico")){
				echo '<link rel="shortcut icon" href="images/favicon.ico"/>';
			}
		};
?><style type="text/css">
body {
	border : 0;
	margin : 0;
	padding-bottom : 10px;
	}
#wrapper {
 	border: 1px solid transparent;
	min-width: 400px;
	margin: 0 -1px;
	<?php if ( $page_width != 'fullpage') { 
echo'width:800px;';
}
else{
echo 'width:100%;';
}
?>}
 #outer {
	border-left-width: 150px;
	border-left-color: #FFFFFF;
	<?php if ( $column == 'three_col' ) {?>
	border-right-width: 150px;
	border-right-color: #FFFFFF;
	border-right-style: solid;<?php } ?>
	background-color: #FFFFFF;
	width: auto; border-left-style: solid; 
}
#header{
	background-color : #FFFFFF;
	height : 40px;
}
#footer {
	background-color : #FFFFFF;
	height : 40px;
}
#inner { margin: 0; width: 100%; }
#header { width: 100%; position: relative; z-index: 13; }
.clear { clear: both; }
/* Mozilla code */
#outer > #inner { border-bottom: 1px solid transparent; }
#leftcol {
	margin-right: 1px;
	float: left; position: relative; z-index: 10; 
	width: 150px;             
	margin-left: -150px;      
}<?php if ( $column == 'three_col' ) {?>
#rightcol { 
 margin-left: 1px;
 float: left; position: relative; z-index: 11;
 width: 150px;             
 margin-right: -150px;   
}
<?php } ?>
#center {
 margin: 0 -3px 0 -2px;
 float: left; width: 100%; position: relative; z-index: 12;  }
.content {
	padding: 5px 5px 5px 5px;
	text-align : left;
	 width: 90%;
}
.edit{
	display: inline;
	margin-right : 30px;
}
.red{
	color : Red;
	font-size : larger;
}
.editimage{
	height : 24px;
	width : 24px;
	border : 0px;
	padding-right : 150px;
	float: right;
	vertical-align : text-bottom;
}
.hideessentials{
	text-align : right;
	border : 4px double Black;
	padding-bottom : 5px;
	padding-right : 55px;
	width : 50%;
}
.date{
	width : 100%;
}

.pollstableborder {
		border: 1px solid;
		padding: 1px;
		}
input, select {
	font-size : 12px;
	margin : 2px 5px 2px 10px;
}
.left {
	float: left;
	position: relative;
	margin: 0;
	text-align : right;
	width : 45%;
}
.right {
	float: right;
	position: relative;
	margin: 0;
	text-align : right;
	white-space : normal;
	width : 45%;
}
.h3{
	font-size : 16px;
	width : 400px;
	padding-left : 5px;
	font-weight : bold;
}

.font{
	width : 200px;
	line-height : 14px;
}

.hidebox{
	width : 100%;
}</style>
</head>
<body>
<?php if ( $page_width == 'pagecenter') { 
	echo '<div align="center">';
	} ?>
	<div id="wrapper"><?php if ($do == "preview"){ if ( $header == 'header' )  {
echo '<div class="date" id="Tdate" style="display:none">'; echo date("jS F Y"); echo '</div><div class="pathway" id="Tpathway"   style="display:none">' .PATHWAYPREVIEW.'</div>';}}?>
		<div id="header"><?php if ($do == "preview"){ echo ?>
			<div id="title" style="display:"><span class="tspan"><?php echo $mosConfig_sitename; ?></span>
			</div><?php }else{ echo '<h3 style="margin-left: 150px;">Mambo Template Generator</h3>';}?>
		</div><?php if ($do == "preview"){?>
		<div class="pathway" id="Lpathway" style="display:none"><?php echo PATHWAYPREVIEW; ?>
		</div>
		<div>
			<div class="date" id="Mdate" style=" display:none"><?php echo date("jS F Y"); ?>
			</div><?php } ?>
			<div id="outer">
				<div id="inner">
					<div id="leftcol">
						<div class="content"><?php 
				if ($do == "preview"){
					require("includes/leftcolumn.php");
				}
?>
						</div>
					</div>
					<div id="center">
						<div class="content"><?php 
				switch ($do){

		case "preview":
					echo $message;
					echo '<div class="pathway" id="Mpathway" style="display:none">';
					echo PATHWAYPREVIEW; 
					echo '</div>';
					include("includes/previewform.php");  
		break 1;
		
		case "upload_form";
		?>
							<form name="form2" enctype="multipart/form-data" method="post" action="index.php?do=upload_image">
<p><?php for($x=0;$x<$uploadNeed;$x++){?>								
								<input name="uploadFile<? echo $x;?>" type="file" id="uploadFile<? echo $x;?>"></p><?}?>
<p>								
								<input name="uploadNeed" type="hidden" value="<? echo $uploadNeed;?>">								
								<input type="submit" name="Submit" value="Submit"></p>
							</form><?php 
		break 1;
		
		case "done":
			$new_template = $_SESSION['new_template'];
			$nu_images = $_SESSION['uploadNeed'];
			$TemplateName = $_SESSION['TemplateName'];
			$header = $_SESSION['header'];
			$footer = $_SESSION['footer'];
			$column = $_SESSION['column'];
			$page_width = $_SESSION['page_width'];
			include("includes/index_html.php");
			include("includes/style.php");
			include("includes/templatedetails.php");
			echo '<input type="hidden" id="tname" value="'.$TemplateName.'">';
		?>
<script language="JavaScript" type="text/javascript">function exit ()
{
	var tn = document.getElementById("tname").value;
	opener.document.getElementById("message").innerHTML='Your template <em>'+tn+'</em> has been saved into your Mambo template folder and is ready to use';
	close ();
}
exit();
</script><?php
		break 1;
		
		default ;
					echo $tryagain;
					form1();
}
?>
						</div>
					</div><?php if ( $column == 'three_col' ) { echo '<!-- Right Column -->

	<div id="rightcol">
					<div class="content">
						<div id="Rsearch" ';
						echo SEARCHFORMPREVIEW;
						echo POLLPREVIEW;
						echo RIGHTMODULE;
			echo '<br /></div>
	</div>';}?>
					<div class="clear">
					</div>
				</div>
			</div><?php if ( $footer == 'footer' ) { echo '<div id="footer"></div>';}?>
		<?php if ( $page_width == 'pagecenter') { 
	echo '</div>';
	} ?>
</body>
</html>
