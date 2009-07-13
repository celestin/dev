/* * * * * * * * * * * * * * * * * * * * * * * *
 * Dunc Smith Glasscraft
 * Copyright (c) 2009 Dunc Smith
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jul-2009  10459 : Added new images and file headers.
 * * * * * * * * * * * * * * * * * * * * * * * */

  function getXY(Obj) {
    for (var sumTop=0,sumLeft=0;Obj!=document.body;sumTop+=Obj.offsetTop,sumLeft+=Obj.offsetLeft, Obj=Obj.offsetParent);
    return {left:sumLeft,top:sumTop}
  }

  function getObj(p_ref) {
    return document.all ? document.all[p_ref] : document.getElementById(p_ref);
  }

  function showCard(cardLink) {
    var card = getObj("tdCard");
    if (card) {
      var path = cardLink.src.split("/") ;
      card.innerHTML = "<img src=\"./img/c/f/" + path[path.length-1] + "\">";
    }
  }

  function showMenu(root, id) {
    if (!bActive) return;

    hideMenu(id);

    var div = getObj(id);
    if (div) {
      var RelObjCords=getXY(root);
      div.style.display = "inline";

      div.style.top = RelObjCords.top + root.offsetHeight + 2;
      div.style.left = RelObjCords.left;
    }
  }

  function hideMenu(sMnu) {
    for (var i=0; i<aMnu.length; i++) {
      if (aMnu[i] != sMnu) { var div = getObj(aMnu[i]); if (div) div.style.display = "none"; }
    }
  }

  function activateMenu(really) {
    var mlsc = "http://www.mapleleavescards.com";
    var mlc = "http://www.mapleleafcards.com";
    if (top.location.href.substring(0, mlsc.length) == mlsc) {
      top.location.href = mlc;
    }

    if (really) { bActive = true; } else { setTimeout("activateMenu(true)",100); }
  }
