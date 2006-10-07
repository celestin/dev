/* * * * * * * * * * * * * * * * * * * * * * * *
 * New Search form
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  30-Sep-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

// Global Variables

var num=0;
var interval = null;
var mkIndex=0;

function doLists(make,model)  {
model = model.toUpperCase();
make = make.toUpperCase();
num++;
  if (num < 100)  {
    if (typeof get_makes == 'function' && typeof get_range =='function' && typeof _model=='object' && typeof make_v=='object' && typeof make_d=='object')  {
      get_makes(make);
      if (document.qSearch && document.qSearch.make && typeof document.qSearch.make.selectedIndex == 'number')  {
        mkIndex = document.qSearch.make.selectedIndex;
      }
      get_range(_model[mkIndex], model);
      clearInterval(interval);
    }
  }
  else {
    clearInterval(interval);
  }
}

function getcookieField(FLDval)
{
  var ourcookie = "user";
  var allcookies = document.cookie;
  var FIELD = null;

  if (allcookies != "")
  {

    var start = allcookies.indexOf(ourcookie + "=");
    if (start != -1)
    {
      start += ourcookie.length + 1;
      var end = allcookies.indexOf(";",start);
      if (end == -1) end = allcookies.length;
      var usercookie = allcookies.substring(start,end);
      var celements = usercookie.split('&')
      for (cnt=0;cnt<celements.length;cnt++)
      {
        celements[cnt] = celements[cnt].split('=');
        if (celements [cnt][0] == FLDval)
        FIELD = unescape(celements[cnt][1]);
      }
    }
  }
  return FIELD;
}

function get_makes(req_make)  {
  var dropDown;
  selectedIndex = 0;

  if (document.qSearch && document.qSearch.make)  {
    dropDown = document.qSearch.make;
  }
  else if(document.search && document.search.make)  {
    dropDown=document.search.make;
  }
  else if (document.forms[0] && document.forms[0].make)  {
    dropDown = document.forms[0].make;
  }

  if (dropDown)  {
    dropDown.length = 0;

    for(index=0; index<make_d.length; index++)  {

      dropDown[index] = new Option(make_d[index],make_v[index]);

      if (make_d[index]=="Make" || make_d[index]=="MAKE")  {
        dropDown[index] = new Option(make_d[index],"");
        }

      if (make_d[index]=="ANY MAKE")  {
        dropDown[index] = new Option(make_d[index],"ANY");
        }


      if(make_v[index].toUpperCase() == req_make){
        selectedIndex = index;

      }
      }
    dropDown.options[selectedIndex].selected = true;
  }
  select_make(req_make);

  dropDown.style.display = "inline";
}

function get_range(ranges,req_model)  {

  selectedIndex = 0;
  var dropDown;

  if (document.qSearch && document.qSearch.model)  {
    dropDown = document.qSearch.model;
  }
  else if(document.search && document.search.model)  {
    dropDown=document.search.model;
  }
  else if (document.forms[0] && document.forms[0].model)  {
    dropDown = document.forms[0].model;
  }

  if (dropDown)  {

    dropDown.length = 0;

    for(index=0; index<ranges.length; index++)  {

      dropDown[index] = new Option(ranges[index],ranges[index]);

      if (ranges[index]=="Model" || ranges[index]=="MODEL")  {
        dropDown[index] = new Option(ranges[index],"");
        }

        if (ranges[index]=="ANY MODEL")  {
        dropDown[index] = new Option(ranges[index],"ANY");
        }

      if(ranges[index].toUpperCase() == req_model){
        selectedIndex = index;
      }
      else if (ranges[index].toUpperCase() == "ANY MODEL" && req_model == "ANY")  {
        selectedIndex = index;
      }
    }
    dropDown.options[selectedIndex].selected = true;
  }
}

function select_make(req_make)  {
  var dropDown;

  if (req_make == null)  {
    req_make="";
  }

  if (document.qSearch && document.qSearch.make)  {
    dropDown = document.qSearch.make;
  }
  else if(document.search && document.search.make)  {
    dropDown=document.search.make;
  }
  else if (document.forms[0] && document.forms[0].make)  {
    dropDown = document.forms[0].make;
  }

  if (dropDown)  {
    for (x=0; x<dropDown.length; x++)  {
      mk=dropDown.options[x].value;
      if ( mk.toUpperCase()==req_make)  {
        if (dropDown.options[x].selected==false)   {
          dropDown.options[x].selected=true;
        }
      }
    }
  }
}


function postCheck(){
        var users_postcode = getcookieField("PC");
        if (users_postcode && users_postcode != '') {
        document.qSearch.postcode.value= users_postcode.replace('+', ' ');
        }
  }


function getObjRef(ref) {
  return document.all ? document.all[ref] : document.getElementById(ref);
}

function setDropValue(dd, val) {
  var box = getObjRef(dd);
  for (var x=0; x<box.options.length; x++) {
    if (box.options[x].value == val) {
      box.selectedIndex=x;

      if (dd == "") {
        get_range(_model[x], '');
      }

      box.style.display = "inline";
      return;
    }
  }
  box.style.display = "inline";
}