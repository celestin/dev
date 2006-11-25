/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Javascript - Contact Popups
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Nov-2006  10012 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

gblProduct = "";

function contact_callme() {
  contact_popup("Call");
}

function contact_emailme() {
  contact_popup("Email");
}


function getObjRef(ref) {
  return document.all ? document.all[ref] : document.getElementById(ref);
}

function contact_popup(sType) {
  var cmTable = getObjRef("cmTable");
  var cmTitle = getObjRef("cmTitle");
  var cmIcon = getObjRef("cmIcon");
  var cmButton = getObjRef("cmButton");
  var cmTxt1 = getObjRef("cmTxt1");
  var contactTxt1 = getObjRef("contactTxt1");
  var contactType = getObjRef("contactType");

  cmTable.style.display = "inline";
  cmTitle.innerHTML = sType + " me now about the " + gblProduct;
  cmButton.value = sType + " me now!";
  contactType.value = sType.toUpperCase();

  if (sType == "Call") {
    cmTxt1.innerHTML = "Telephone";
    cmIcon.src = "img/ico/large/phone_me.png";
    contactTxt1.size = 20;
  } else {
    cmTxt1.innerHTML = "Email";
    cmIcon.src = "img/ico/large/email_me.png";
    contactTxt1.size = 50;
  }

  contactTxt1.value = "";
}

function contact_popupClose() {
  var cmTable = getObjRef("cmTable");
  cmTable.style.display = "none";
}


