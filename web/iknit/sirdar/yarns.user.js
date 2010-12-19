/* * * * * * * * * * * * * * * * * * * * * * * *
 * iKnit (iknit.biz)
 * Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  23-Aug-2010  10776 : Created.
 * CAM  25-Aug-2010  10776 : Added SQL script generation.
 * CAM  23-Nov-2010  10776 : Added leaflets to SQL script generation.
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
// @name          iKnit Sirdar Wool Selector
// @namespace     http://iknit.biz/
// @description   Script to allow the selection of Sirdar wool products for inclusion on iKnit.biz
// @include       http://www.sirdar.co.uk/yarns/*
// ==/UserScript==

function addGlobalStyle(css) {
    var head, style;
    head = document.getElementsByTagName('head')[0];
    if (!head) { return; }
    style = document.createElement('style');
    style.type = 'text/css';
    style.innerHTML = css;
    head.appendChild(style);
}

addGlobalStyle('#product_template .ProductImage {  width: 150px; }');
addGlobalStyle('.shadeName {  display: none }');


var formAttr, breadtrail, allDivs, thisDiv, linkRef, oRequest, s, sSql, sLeafSql;

// Hide the attributes
formAttr = document.getElementById('product_details');
formAttr.style.display = "none";

// Get the Yarn Colours link
yarnLinks = document.evaluate(
    "//p[@class='YarnLink']",
    document,
    null,
    XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE,
    null);

linkRef = yarnLinks.snapshotItem(0).childNodes[0];

if (linkRef) {

  // Get the shades html
  oRequest = new XMLHttpRequest();
  oRequest.open("GET",linkRef,false);
  oRequest.setRequestHeader("User-Agent",navigator.userAgent);
  oRequest.send(null);

  s = oRequest.responseText; 
  var sUlText = '<ul class="products_categories_gridlayout yarns_gridlayout">';
  var i = s.indexOf(sUlText);
  s = '<h4>Shades</h4><ul>' + s.substring(i + sUlText.length);  // chop initial part of file

  i = s.indexOf('<div class="clear" id="em">');
  s = s.substring(0, i);   // chop end part of file
  
  var colourImageHtml = s;

  s = s.replace(/<img src/gi, "<img width=100 src");

  //s = s.replace(/<fieldset>/gi, "");
  //s = s.replace(/<\/fieldset>/gi, "");

  //s = s.replace(/<legend/gi, '<span style="display:none"');
  //s = s.replace(/<\/legend/gi, '</span');
  

  // Find the product image div
  allDivs = document.evaluate(
      "//div[@class='ProductImage']",
      document,
      null,
      XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE,
      null);

  thisDiv = allDivs.snapshotItem(0);
  
  var colourFrame = document.createElement('div');
  // Insert a new div *after* the product image
  thisDiv.parentNode.insertBefore(colourFrame, thisDiv.nextSibling);
  colourFrame.innerHTML = s;  // add yarn colours
  
  
  // Get breadtrail to pick out the elements for the database
  breadtrail = document.getElementById('breadcrumbs');

  var idx = breadtrail.childNodes.length;
  var yarnStyle, yarnPly, yarnName, yarnImg, yarnCode;

  yarnStyle = breadtrail.childNodes[1].title;
  if (idx == 4) 
  {
    yarnPly = breadtrail.childNodes[2].title;
  } else {
    yarnPly = "";
  }
  yarnName = breadtrail.childNodes[idx-1].title;


  // Determine Image and Code
  var largeImage = thisDiv.childNodes[0];

  yarnImg = largeImage.src;
  yarnImg = yarnImg.substring(yarnImg.lastIndexOf("/")+1).toLowerCase();

  yarnCode = yarnImg.substring(0, yarnImg.indexOf("-")).toUpperCase();

  sSql = 
    "DELETE FROM sirdar_yarn WHERE yarn_code = '" + yarnCode + "';\n" +
    "DELETE FROM sirdar_yarn_shade WHERE yarn_code = '" + yarnCode + "';\n\n" +
    "INSERT INTO sirdar_yarn (" +
      "yarn_code, yarn_name, ply_name, style_name, yarn_image"+
    ") VALUES ("+
      "'" + yarnCode + "', '" + yarnName + "', '" + yarnPly + "', '" + yarnStyle + "', '" + yarnImg + "'"+
    ");\n\n";

  
  // Now parse colours
  var delimiter = "<p><img src=\"images/products/shades/";
  var nextColour = colourImageHtml.indexOf(delimiter);  
  var colourImage, colourName, colourCode;
    
  while (nextColour >= 0) 
  {
    colourImageHtml = colourImageHtml.substring(nextColour + delimiter.length);
    
    i = colourImageHtml.indexOf("\"");
    colourImage = colourImageHtml.substring(0, i).toLowerCase();
    colourCode = colourImage.substring(0, colourImage.indexOf(".")).toUpperCase();    
    colourImageHtml = colourImageHtml.substring(i+1);
    colourImageHtml = colourImageHtml.substring(colourImageHtml.indexOf("\"")+1);
    
    i = colourImageHtml.indexOf("\"");
    colourName = colourImageHtml.substring(0, i);        
    colourImageHtml = colourImageHtml.substring(i+1);
        
    sSql = sSql +
      "INSERT INTO sirdar_yarn_shade (" +
        "yarn_code, shade_code, shade_name, shade_image"+
      ") VALUES ("+
        "'" + yarnCode + "', '" + colourCode + "', '" + colourName + "', '" + colourImage + "'"+
      ");\n";
        
    nextColour = colourImageHtml.indexOf(delimiter);
  }
  
  
  // Get the Leaflets
  leaflets = document.getElementById("RelatedProducts");
  sLeafSql = "DELETE FROM sirdar_yarn_leaflet WHERE yarn_code = '" + yarnCode + "';\n\n";

  if (leaflets) 
  {
    for (i=0; i<leaflets.childNodes.length; i++) 
    {  
      if (leaflets.childNodes[i].nodeName == "LI") 
      {
        li = leaflets.childNodes[i];
        
        leafletCode = li.childNodes[0].href;
        leafletCode = leafletCode.substring(leafletCode.lastIndexOf("/")+1);
        leafletImage = li.childNodes[0].childNodes[0].src;
        leafletImage = leafletImage.substring(leafletImage.lastIndexOf("/")+1);
        
        sLeafSql +=
          "INSERT INTO sirdar_yarn_leaflet (" +
            "yarn_code, leaflet_code, leaflet_image, leaflet_sirdar_image"+
          ") VALUES ("+
            "'" + yarnCode + "', '" + leafletCode + "', '" + leafletImage + "', 'http://www.sirdar.co.uk/images/products/designs/" + leafletImage + "'"+
          ");\n";        
      }    
    }
  }   
  
      
  // Write SQL  
  var sqlFrame = document.createElement('div');
  // Insert a new div *after* the product image
  thisDiv.parentNode.insertBefore(sqlFrame, colourFrame);
  sqlFrame.innerHTML = "<textarea cols='60' rows='8'>" + sLeafSql + "\n\n\n\n</textarea>";
}

