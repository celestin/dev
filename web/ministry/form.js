/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Javascript - Forms functions
 *
 * $Id$
 * 
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * CAM  15-Oct-2007  10187 : Added functions.
 * CAM  12-Nov-2007  10204 : Added Servant checkbox functions.
 * * * * * * * * * * * * * * * * * * * * * * * */

function getObjRef(ref) {
  return document.all ? document.all[ref] : document.getElementById(ref);
}

function submitSearchText() {
  var form = getObjRef("searchText");
  var txtKeywords = getObjRef("keywords");
  if (txtKeywords.value.length == 0) {
    txtKeywords.fgColor = "white";
    txtKeywords.value = "NULL";
  }
  form.submit();
}

function submitBookRef(bookid, chapter, vstart, vend) {
  var form = getObjRef("books");
  var txtBookId = getObjRef("bookid");
  var txtChapter = getObjRef("chapter");
  var txtVStart = getObjRef("vstart");
  var txtVEnd = getObjRef("vend");
  
  txtBookId.value = bookid;  
  if (typeof(chapter) != "undefined") txtChapter.value = chapter;
  if (typeof(vstart) != "undefined") txtVStart.value = vstart;
  if (typeof(vend) != "undefined") txtVEnd.value = vend;
  
  form.submit();
}

function uncheckAll() {
  var chkAuthorAll = getObjRef("author_filter[ALL]");
  if (chkAuthorAll != null) {
    chkAuthorAll.checked = false;
  }
}

function toggleServants(chkAll) {
  var inpAll = document.getElementsByTagName("input");
  for (var i=0; i<inpAll.length; i++) {
    if((inpAll[i].id.substring(0, 13) == "author_filter") && (inpAll[i] != chkAll)) {
      inpAll[i].checked = !chkAll.checked;
    }
  }
}