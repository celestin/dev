<?php

extract ($_POST);




  
 function fontfields($tag)
 {
 echo 'Font Family <select name="style[' . $tag . '][font-family]" class="font" onchange="addCSSRule(\''.$tag."', 'font-family:'+this.options[this.selectedIndex].value)\">";
 echo '<option value="">Body Default</option>
				<option value="Arial,Verdana,Helvetica,sans-serif">Arial,Verdana,Helvetica,sans-serif</option>
				<option value="Verdana,Helvetica,Arial,sans-serif">Verdana,Helvetica,Arial,sans-serif</option>
				<option>Trebuchet MS, Verdana, Helvetica, Arial, Sans-serif;</option>
				<option value="Comic Sans MS,Verdana,Helvetica,sans-serif">Comic Sans MS,Verdana,Helvetica,sans-serif</option>
				<option value="Times New Roman,Georgia,Courier,serif">Times New Roman,Georgia,Courier,serif</option>
			    <option value="Courier New, Courier, monospace">Courier New, Courier, monospace</option>
				<option value="MS Serif, New York, serif">MS Serif, New York, serif</option>
				<option value="cursive">Cursive</option>
				<option value="fantasy">Fantasy</option>
				<option value="monospace">Monospace</option>
				</select><br/>
		Font Size <select name="style[' . $tag . '][font-size]" onchange="addCSSRule(\''.$tag."', 'font-size:'+this.options[this.selectedIndex].value)\">";
 echo '<option value="">Body Default</option>
				<option value="8px">8px</option>
				<option value="9px">9px</option>
				<option value="10px">10px</option>
				<option value="11px">11px</option>
				<option value="12px">12px</option>
				<option value="13px">13px</option>
				<option value="14px">14px</option>
				<option value="16px">16px</option>
				<option value="18px">18px</option>
				<option value="20px">20px</option>
				<option value="25px">25px</option>
				</select><br/>
		Line Height <select name="style[' . $tag . '][line-height]" onchange="addCSSRule(\''.$tag."', 'line-height:'+this.options[this.selectedIndex].value)\">";
 echo '<option value="normal">Body Default</option>
				<option value="12px">12px</option>
				<option value="13px">13px</option>
				<option value="14px">14px</option>
				<option value="16px">16px</option>
				<option value="18px">18px</option>
				<option value="20px">20px</option>
				<option value="25px">25px</option>
				</select><br/>';
    	fontcolor($tag);
		echo'<br/>
  Font Weight
			    <select name="style[' . $tag . '][font-weight]" onchange="addCSSRule(\''.$tag."', 'font-weight:'+this.options[this.selectedIndex].value)\">";
 echo '<option value="normal">Normal</option>
				<option value="bold">Bold</option>
			    </select><br/>
			Font Style
			    <select name="style[' . $tag . '][font-style]" onchange="addCSSRule(\''.$tag."', 'font-style:'+this.options[this.selectedIndex].value)\">";
 echo '<option value="normal">Normal</option>
				<option value="italic">Italic</option>
			    </select><br/>
				Text Align <select name="style[' . $tag . '][text-align]" onchange="addCSSRule(\''.$tag."', 'text-align:'+this.options[this.selectedIndex].value)\">";
 echo '<option value="left">Left - Default</option>
				<option value="center">Center</option>
				<option value="right">Right</option>
				<option value="justify">Justify</option>
			</select>
		';
		
       
	}
	function textdecfield($tag){
	echo ('<br/>Text Decoration <select name="style[' . $tag . '][text-decoration]" onchange="addCSSRule(\''.$tag."', 'text-decoration:'+this.options[this.selectedIndex].value)\">");
 echo ('		<option value=""></option>
 				<option value="underline">Underline</option>
				<option value="none">None</option>
			</select><br/>');
			}
	function borderfields($Btag)
{
echo (' Border Width <select name="style[' . $Btag . '][border-width]" onchange="addCSSRule(\''.$Btag."', 'border-width:'+this.options[this.selectedIndex].value)\">");
 echo ('<option value="">No Border</option>
				<option value="1px">1px</option>
				<option value="2px">2px</option>
				<option value="3px">3px</option>
				<option value="4px">4px</option>
				<option value="5px">5px</option>
				<option value="10px">10px</option>
				<option value="20px">20px</option>
			</select><br/>
	Border Style <select name="style[' . $Btag . '][border-style]" onchange="addCSSRule(\''.$Btag."', 'border-style:'+this.options[this.selectedIndex].value)\">");
 echo 			('<option value="">None</option>
 				<option value="solid">Solid</option>
				<option value="dotted">Dotted</option>
				<option value="dashed">Dashed</option>
				<option value="double">Double</option>
				<option value="groove">Groove</option>
				<option value="ridge">Ridge</option>
				<option value="inset">Inset</option>
				<option value="outset">Outset</option>
			</select><br/>
	 Border Color <input type="text"  id="' . $Btag . 'font" name="style[' . $Btag . '][border-color]" onClick="oldColor=this.value;clickedField=this;getstyle(\''. $Btag . '\',\'border-color:\');" onChange="setColor(this.value);"/>');
}
function padfields($Ptag,$Pselector){
echo ('<select name="style[' . $Ptag . ']['.$Pselector.']" onchange="addCSSRule(\''.$Ptag."', '".$Pselector.":'+this.options[this.selectedIndex].value)\">");
 echo ('<option value="">None</option>
				<option value="1px">1px</option>
				<option value="2px">2px</option>
				<option value="3px">3px</option>
				<option value="4px">4px</option>
				<option value="5px">5px</option>
				<option value="6px">6px</option>
				<option value="7px">7px</option>
				<option value="8px">8px</option>
				<option value="9px">9px</option>
				<option value="10px">10px</option>
			</select>');
			
}
function bgcolor($tag) {
		echo '<br/>Background Color <input type="text"  id="' . $tag . '_bg" name="style[' . $tag . '][background-color]" onClick="oldColor=this.value;clickedField=this;getstyle(\''. $tag . '\',\'background-color: #\');" onChange="setColor(this.value);"/>';
	}
function fontcolor($tag) {
		echo 'Font Color <input type="text"  id="' . $tag . 'font" name="style[' . $tag . '][color]" onClick="oldColor=this.value;clickedField=this;getstyle(\''. $tag . '\',\'color:#\');" onChange="setColor(this.value);"/>';
	}

	function specialbgfield($tag,$element) {
		echo 'Background Color <input type="text"  id="' . $tag . '_bg" name="' . $tag . '_bg" onClick="oldColor=this.value;clickedField=this;getstyle(\''. $element . '\',\'background-color: #\');" onChange="setColor(this.value);"/>';
	}
	
	
function cursorfield($Ctag){
 echo 			'<br/>Cursor <select name="style[' . $Ctag . '][cursor]" onchange="addCSSRule(\''.$Ctag."', 'cursor:'+this.options[this.selectedIndex].value)\">";
 echo           '<option value="default">Default</option>
 				<option value="pointer">Pointer</option>
 				<option value="crosshair">Crosshair</option>
				</select><br/>';
}
$image_dir = $_SESSION['image_dir'];


		
		
		$img_array = Array();
		$handle = opendir("$image_dir");
		while (false !== ($file = readdir($handle))) 
		{
   			if ($file != "." && $file != "..") 
			{
   				$img_array[] = $file;
   			}
		}
		closedir($handle);
		sort ($img_array);
		reset ($img_array);

$_SESSION['img_array'] = $img_array;
function image_list($tagv,$tag){
global $img_array,$image_dir,$image_slect;
		echo '<p>Background Image <select  name="' . $tagv . '_bg_image" onchange="addCSSRule(\''.$tag.'\', \'background-image:url('.$image_slect.'/\'+this.options[this.selectedIndex].value+\');\')">
<option value=""></option>';
		foreach ($img_array as $val) 
		{
   			echo "<option value=\"$val\">$val</option>";
		}
		echo '</select><br/>
		Background Repeat <select name="' . $tagv . '_bg_repeat" onchange="addCSSRule(\''.$tag."', 'background-repeat:'+this.options[this.selectedIndex].value)\">";
 echo           '<option value="repeat">repeat</option>
 				<option value="no-repeat">no-repeat</option>
 				<option value="repeat-y">repeat-y</option>
 				<option value="repeat-x">repeat-x</option>
				</select></p>';
}


?> 