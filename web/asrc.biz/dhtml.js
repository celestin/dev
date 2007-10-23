/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  23-Oct-2007  10182 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

var b_timer = null; // blink timer
var b_on = true; // blink state
var blnkrs = null; // array of spans

function blink() {
  var tmp = document.getElementsByTagName("a");
  if (tmp) {
    blnkrs = new Array();
    var b_count = 0;
    for (var i = 0; i < tmp.length; ++i) {
      if (tmp[i].className == "blink") {
        blnkrs[b_count] = tmp[i];
        ++b_count;
      }
    }

    blinkTimer();
  }
}

function blinkTimer() {
  if (b_timer) {
    window.clearTimeout(b_timer);
    b_timer = null;
  }

  ival = 600;
  if (b_on) ival = 200;
  
  blinkIt();
  b_timer = window.setTimeout('blinkTimer()', ival);
}

function blinkIt() {
  for (var i = 0; i < blnkrs.length; ++i) {
    if (b_on == true) {
      blnkrs[i].style.visibility = "hidden";
    } else {
      blnkrs[i].style.visibility = "visible";
    }
  }
  
  b_on = !b_on;
} 