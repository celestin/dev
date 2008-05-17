/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * AJAX functions
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-May-2008  10232 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

 var d;
 var ie5 = (document.all && document.getElementById);
 var ns6 = (!document.all && document.getElementById);
 var opacIn = 0;
 var opacOut = 0;
 var currentItem = null;
 
 function showDiv(item, img) {
  if (currentItem == item) return;

  d = document.all.popup;
  d.style.width = 200;
  d.style.height = 50;
  d.style.left = img.offsetLeft + 25;
  d.style.top = img.offsetTop - 54;
  d.innerHTML = "<b>" + cont[item][0] + "</b>" + "... " + cont[item][1];

  opacIn = opacOut = 0;
  fadeIn();

  d.style.display = "inline";
  d.style.cursor = "hand";

  currentItem = item;
}

function hideDiv() {
  currentItem = null;

  opacIn = opacOut = 100;
  fadeOut();
  
  d.style.cursor = "pointer";
}

function fadeIn() {
  if(opacIn < 100){
    opacIn+=10;
    setOpacity(d, opacIn);
    setTimeout('fadeIn()', 0);
  }
}

function fadeOut() {
  if(opacOut > 0){
    opacOut-=5;
    setOpacity(d, opacOut);
    setTimeout('fadeOut()', 0);
  }
}

function setOpacity(obj, opacity) {
  opacity = (opacity == 100)?99.999:opacity;

  // IE/Win
  obj.style.filter="progid:DXImageTransform.Microsoft.Alpha(opacity=" + opacity + ");";

  // Safari<1.2, Konqueror
  obj.style.KHTMLOpacity = opacity/100;

  // Older Mozilla and Firefox
  obj.style.MozOpacity = opacity/100;

  // Safari 1.2, newer Firefox and Mozilla, CSS3
  obj.style.opacity = opacity/100;
}
