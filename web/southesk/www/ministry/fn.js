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
