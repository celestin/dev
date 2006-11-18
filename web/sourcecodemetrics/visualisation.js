/* * * * * * * * * * * * * * * * * * * * * * * *
 * SourceCodeMetrics.com
 * Copyright (c) 2006 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Javascript - Date validation
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Nov-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

sActiveMenu = "";

function getObjRef(ref) {
  return document.all ? document.all[ref] : document.getElementById(ref);
}

function scm_linkOver(sButton) {
  var button = getObjRef(sButton);
  if (button.className == "menuActive") {
    sActiveMenu = sButton;
  }
  button.className = "menuHover";
}

function scm_linkOut(sButton) {
  var button = getObjRef(sButton);
  if (sButton == sActiveMenu) {
    button.className = "menuActive";
  } else {
    button.className = "menuNormal";
  }
}

