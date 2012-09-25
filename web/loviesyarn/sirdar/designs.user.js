/* * * * * * * * * * * * * * * * * * * * * * * *
 * iKnit (iknit.biz)
 * Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  25-Nov-2010  10823 : Added leaflets to SQL script generation.
 * * * * * * * * * * * * * * * * * * * * * * * */

// --------------------------------------------------------------------
//
// This is a Greasemonkey user script.  To install it, you need
// Greasemonkey 0.3 or later: http://greasemonkey.mozdev.org/
// Then restart Firefox and revisit this script.
// Under Tools, there will be a new menu item to "Install User Script".
// Accept the default configuration and install.
//
// To uninstall, go to Tools/Manage User Scripts,
// select "iKnit Sirdar Wool Selector", and click Uninstall.
//
// --------------------------------------------------------------------
//
// ==UserScript==
// @name          iKnit Sirdar Design Selector
// @namespace     http://iknit.biz/
// @description   Script to allow the selection of Sirdar wool products for inclusion on iKnit.biz
// @include       http://www.sirdar.co.uk/designs/*
// ==/UserScript==


// Hide the attributes

var imgDiv = document.getElementById('product_template');
imgDiv.setAttribute("style","float:right;");

var formAttr = document.getElementById('product_details');
//formAttr.style.display = "none";

var colourFrame = document.createElement('div');

colourFrame.setAttribute("style","float:right;");

formAttr.parentNode.insertBefore(colourFrame, formAttr.nextSibling);

var pd = document.createElement('div');
pd.innerHTML = formAttr.innerHTML;
var tab = pd.childNodes[1];
var tabCn = tab.childNodes;
var needleSize = "";

var s = "*\n";
for (i=tabCn.length-1; i>=0; i--)
{
  if (tabCn[i].nodeName == "DL")
  {
    var cells = tabCn[i].getElementsByTagName("dd");
    if (cells.length > 0) needleSize = cells[0].innerHTML;
  }
  if ((tabCn[i].nodeName != "TABLE")/* && (tabCn[i].nodeName != "DL")*/)
  {
    tab.removeChild(tabCn[i]);
  }
}

var productId = "";
var p=0;
var related = document.getElementById('RelatedProducts');
var imgs = related.getElementsByTagName("img");
for (i=0; i<imgs.length; i++)
{
  p = imgs[i].src.indexOf('products/navigation/');
  if (p >= 0)
  {
    productId = imgs[i].src.substr(p + 20, imgs[i].src.length);
    p = productId.indexOf('-');
    if (p >= 0)
    {
      productId = productId.substr(0, p);
    }
  }
}

colourFrame.innerHTML = "<h2>" + productId + "</h2><textarea cols='60' rows='8'>" + needleSize + "\n\n" + tab.innerHTML + "</textarea>";
