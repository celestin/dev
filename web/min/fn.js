/* * * * * * * * * * * * * * * * * * * * * * * *
 * Database Connectivity
 * Copyright (c) 2005 Southesk.com
 *
 * $Log: /web/cc/db.php $
 *
 * 1     28/12/05 15:43 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */


function getObjRef(p_ref) {
  return document.all ? document.all[p_ref] : document.getElementById(p_ref);
}

function resetForm() {
  var txtSText = getObjRef("text");
  var frmAction = document.action_form;

  if (txtSText && frmAction) {
    txtSText.value = "";
    frmAction.submit();
  }
}

var xmlhttp=false;
/*@cc_on @*/
/*@if (@_jscript_version >= 5)
// JScript gives us Conditional compilation, we can cope with old IE versions.
// and security blocked creation of the objects.
 try {
  xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
 } catch (e) {
  try {
   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  } catch (E) {
   xmlhttp = false;
  }
 }
@end @*/
if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
  try {
    xmlhttp = new XMLHttpRequest();
  } catch (e) {
    xmlhttp=false;
  }
}
if (!xmlhttp && window.createRequest) {
  try {
    xmlhttp = window.createRequest();
  } catch (e) {
    xmlhttp=false;
  }
}


function alertContents() {
  if (xmlhttp.readyState == 4) {
     if (xmlhttp.status == 200) {
        var xmldoc = xmlhttp.responseText;
        var minres = getObjRef("minres");
        minres.innerHTML = xmldoc;

     } else {
        alert('There was a problem with the request.');
     }
  }
}
function do_xml() {

  alert("hello!");

/*
 xmlhttp.open("GET", "http://www.southesk.com",true);
 xmlhttp.onreadystatechange=alertContents;
 xmlhttp.send(null);
*/
  xmlhttp.open("GET", "scratch.txt",true);
  xmlhttp.onreadystatechange=function() {
   if (xmlhttp.readyState==4) {
    alert(xmlhttp.responseText)
   }
  }
 xmlhttp.send(null);
}

