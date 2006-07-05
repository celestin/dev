/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Javascript - Photo functions
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  04-Jul-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

function getObjRef(p_ref) {
  return document.all ? document.all[p_ref] : document.getElementById(p_ref);
}

function thumb_over(img) {

  var th = getObjRef("thumb[]");

  if (typeof th != 'undefined') {
    // In Firefox/Netscape - it handles the borders correctly anyway!
    return;
  }

  alert(th.length);

  //for (var i=0; i<

}