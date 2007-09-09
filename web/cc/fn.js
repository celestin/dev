/* * * * * * * * * * * * * * * * * * * * * * * *
 * mpower Testing
 * Copyright (c) 2005 Monitor
 *
 * Common Javascript Functions.
 *
 * $Log: /web/cc/fn.js $
 * 
 * 1     11/02/06 22:14 Craig
 *
 * Who  When         Why
 * CAM  11-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

function getObjRef(p_ref) {
  return document.all ? document.all[p_ref] : document.getElementById(p_ref);
}

function setHouse(p_house) {
  var txtHouse = getObjRef("uhousehold");
  var frmAction = document.action_form;
  if (txtHouse && frmAction) {
    txtHouse.value = p_house;
    frmAction.submit();
  }
}

