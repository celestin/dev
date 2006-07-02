function show()
{
for(var I=0;I<arguments.length;I++)
{
var obj=document.getElementById(arguments[I]);
obj.style.display = '';

}
}
function hide()
{
for(var I=0;I<arguments.length;I++)
{
var obj=document.getElementById(arguments[I]);
obj.style.display = 'none';

}
}

function menu(the_element)
{
var menu_items = ["mainpreview","layout","fontcontent","messentials","rowcols","mgeneral","msmall","mmenu","mform","mtab","mother","mcontent","msection","mcategories","mmodule","mpoll","msearch","mcontact","mnewsfeed","templatedetails"];
	for (var i=0;i<menu_items.length;i++) {
		a = document.getElementById(menu_items[i]).style
			if (menu_items[i] == the_element) {
				a.display = ''
			} else {
				a.display = 'none'
			}
	}
}	

function addCSSRule (selectorText, declarations) {
   var styleSheet;
   if (document.styleSheets) {
     if (document.styleSheets.length === 0) {
       var styleElement;
       if (document.createElement && (styleElement = 
document.createElement('style'))) {
         styleElement.type = 'text/css';
         document.getElementsByTagName('head')[0].appendChild(styleElement);
         styleSheet = styleElement.sheet;
       }
     }
     if (document.styleSheets.length > 0) {
       styleSheet = document.styleSheets[document.styleSheets.length - 1];
       if (styleSheet.insertRule) {
         styleSheet.insertRule(
           selectorText + ' { ' + declarations + ' }',
           styleSheet.cssRules.length
         );
       }
       else if (styleSheet.addRule) {
         styleSheet.addRule(selectorText, declarations);
       }
     }
   }
}



function styleSize(field,selectorText, declarations)
	 {
		re = /^\d{2,3}(px)|%$/;
		if (re.test(field.value))
		{
			addCSSRule (selectorText, declarations);
		}
		else
		{
			alert("Please enter a valid size in Pixel or % \nWith no empty spaces \nEg: 122px 0r 40%");
			field.value = "";
			field.focus();
			
			
		}
		
		
	 }
	
function  hrSize(field,selectorText, declarations)
	 {
		re = /^\d(px)$/;
		if (re.test(field.value))
		{
			addCSSRule (selectorText, declarations);
		}
		else
		{
			alert("Please enter a valid size in Pixel eg 4px");
			field.value = "";
			field.focus();
		}
	 }
function  padSize(field,selectorText, declarations)
	 {
		re = /^\d{1,2}(px)$/;
		if (re.test(field.value))
		{
			addCSSRule (selectorText, declarations);
		}
		else
		{
			alert("Please enter a valid size in Pixel eg 4px");
			field.value = "";
			field.focus();
		}
	 }
	 
function isName(field){
   var regex = /^[0-9a-z_]*$/;
    if(!regex.test(field.value)){
       alert('Only enter numbers, lowercase letters and underscore in this field');
       field.value = field.value.replace(/[^0-9a-z_]/g,"");
    }
  }
  function isNumber(field){
   var regex = /^[0-9]*$/;
    if(!regex.test(field.value)){
       alert('Enter a number between 0 and 9');
       field.value = field.value.replace(/[^0-9]/g,"");
    }
  }

 function verify(theForm){

if(theForm.TemplateName.value ==''){
alert ('You must name your template');
theForm.TemplateName.focus();
return false;


}
}

var clickedField;
var element_property;
var element_id;
var oldColor;

function getstyle(eid,prop){
element_id=eid;
element_property=prop;
newWin=open('ColorEditor.html','Color','height=350,width=390,left=299,top=299,dependent=yes,directories=no,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no');
newWin.focus();
}


function setColor(a) 
{
if (clickedField) {
             clickedField.value=a;
			 }
}

setColor("FFFFFF");