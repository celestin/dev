<?php
function form1(){
				?>
		
	<div id="forms">
		<form name="form1" method="post" action="index.php?do=create_directory" onSubmit="return verify(document.form1)">
			<div class="formrow">	Template Name:				
				<input type="text" name="TemplateName" onkeyup="isName(this)"  size="40" />
<p>Images to upload:				
				<input type="text" name="uploadNeed" id="uploadNeed" maxlength="1" onkeyup="isNumber(this)" size="1" value="0"/></p>
			</div><fieldset><legend>Page Layout</legend>
			<div class="formrow">	Page Alignment:<br/>				
				<input type="radio" name="page_width" id="fullpage" checked value="fullpage" />Full				
				<input type="radio" name="page_width" id="pagecenter" value="pagecenter" />Centered				
				<input type="radio" name="page_width" id="pageleft" value="pageleft" />Left
			</div>
			<div class="formrow">	Header				
				<input type="radio" name="header" checked value="header"  />Show				
				<input type="radio" name="header" value="none"  />Hide
			</div>
			<div class="formrow">				
				<input type="radio" name="column" id="2col" checked value="two_col" />2 Column
			</div>
			<div class="formrow">				
				<input type="radio" name="column" id="3col" value="three_col" />3 Column
			</div>
			<div class="formrow">	Footer				
				<input type="radio" name="footer"  value="footer" />Show				
				<input type="radio" name="footer"  value="none" />Hide
			</div>			
			<input type="submit" name="NextPage" value="Next"/></fieldset>
		</form>
	</div>
</div><?
}

switch ($do) {

		case "create_directory":
				$TemplateName =  $_POST['TemplateName'];
				$TemplateDir = $_SESSION['TemplateDir'];
				if(is_dir("$TemplateDir/$TemplateName") ){
					$tryagain = "<p><strong>You already have a template named <em>$TemplateName</em> please rename your new template</strong></p>";
					$do = "default";
				}
				else{
					$_SESSION['TemplateName'] = $TemplateName;
					$_SESSION['image_slect'] = "$mosConfig_live_site/templates/$TemplateName/images/";
					$_SESSION['column'] = $_POST['column'];
					$_SESSION['page_width'] = $_POST['page_width'];
					$_SESSION['header'] = $_POST['header'];
					$_SESSION['footer'] = $_POST['footer'];
					$_SESSION['uploadNeed'] = $_POST['uploadNeed'];
					$TemplateName = $_SESSION['TemplateName'];
					$uploadNeed = $_SESSION['uploadNeed'];
					$_SESSION['image_dir'] = "$TemplateDir/$TemplateName/images";
					$_SESSION['new_template'] = "$TemplateDir/$TemplateName";
					$image_dir = $_SESSION['image_dir'];
					$new_template = $_SESSION['new_template'];
					mkdir("$new_template",0777);
					mkdir("$image_dir",0777);
					mkdir("$new_template/css",0777);
					if ($uploadNeed >= 1){
					$do = "upload_form";
					}
					else{
					
						$do = "preview";
						
						break ;
					}
				}
		break 1;
		
		case "upload_image";
				
				$image_dir = $_SESSION['image_dir'];
				for($x=0;$x<$uploadNeed;$x++){
					$file_name = $_FILES['uploadFile'. $x]['name'];
					$file_type = $_FILES['uploadFile'. $x]['type'];
					$file_tmp_name = $_FILES['uploadFile'. $x]['tmp_name'];
					$file_name = stripslashes($file_name);
					$file_name = str_replace("'","",$file_name);
					$num = $x+1;
					$copy = move_uploaded_file("$file_tmp_name","$image_dir/$file_name");
 					if(!$copy){
 						$message = "image $num $file_name | could not be uploaded!<br>";
 					}
				}
				
				$do = "preview";
				
			break 1;

}?>