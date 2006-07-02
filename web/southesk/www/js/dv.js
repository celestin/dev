
// extract front part of string prior to searchString
function getFront(mainStr,searchStr){
  foundOffset = mainStr.indexOf(searchStr)
  if (foundOffset == -1) {
    return null
  }
  return mainStr.substring(0,foundOffset)
}

// extract back end of string after searchString
function getEnd(mainStr,searchStr) {
  foundOffset = mainStr.indexOf(searchStr)
  if (foundOffset == -1) {
    return null
  }
  return mainStr.substring(foundOffset+searchStr.length,mainStr.length)
}

// insert insertString immediately before searchString
function insertString(mainStr,searchStr,insertStr) {
  var front = getFront(mainStr,searchStr)
  var end = getEnd(mainStr,searchStr)
  if (front != null && end != null) {
    return front + insertStr + searchStr + end
  }
  return null
}

// remove deleteString
function deleteString(mainStr,deleteStr) {
  return replaceString(mainStr,deleteStr,"")
}

// replace searchString with replaceString
function replaceString(mainStr,searchStr,replaceStr) {
  var front = getFront(mainStr,searchStr)
  var end = getEnd(mainStr,searchStr)
  if (front != null && end != null) {
    return front + replaceStr + end
  }
  return null
}

// check the entered February date for too high a value
function checkLeapMonth(mm,dd,yyyy) {
  if (yyyy % 4 > 0 && dd > 28) {
    alert("February of " + yyyy + " has only 28 days.")
    return false
  } else if (dd > 29) {
    alert("February of " + yyyy + " has only 29 days.")
    return false
  }
  return true
}

// Leading Zeroes
function lz(value, nz) {
  var val= "" + value;
  var rv = val;
  var nzs = 2;
  if (nz) nzs = nz;

  for (var i=0; i<nzs-val.length; i++) {
    rv = "0" + val;
  }
  return rv;
}

// date field validation (called by other validation functions that specify minYear/maxYear)
function isDate(gField) {
  var dd, mm;
  var inputStr = gField.value;
  var dispMonths = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");

  var DDMMYYYY = 1;
  var MMDDYYYY = 2;
  var timezones = new Array();
  timezones["UTC-1200"] = MMDDYYYY;
  timezones["UTC-1100"] = MMDDYYYY;
  timezones["UTC-1000"] = MMDDYYYY;
  timezones["UTC-0900"] = MMDDYYYY;
  timezones["UTC-0800"] = MMDDYYYY;
  timezones["PDT"]      = MMDDYYYY;
  timezones["PST"]      = MMDDYYYY;
  timezones["MDT"]      = MMDDYYYY;
  timezones["MST"]      = MMDDYYYY;
  timezones["CDT"]      = MMDDYYYY;
  timezones["CST"]      = MMDDYYYY;
  timezones["EDT"]      = MMDDYYYY;
  timezones["EST"]      = MMDDYYYY;
  timezones["UTC-0400"] = MMDDYYYY;
  timezones["UTC-0300"] = MMDDYYYY;
  timezones["UTC-0330"] = MMDDYYYY;
  timezones["UTC-0200"] = DDMMYYYY;
  timezones["UTC-0230"] = MMDDYYYY;
  timezones["UTC-0100"] = DDMMYYYY;
  timezones["UTC"]      = DDMMYYYY;
  timezones["UTC+0100"] = DDMMYYYY;
  timezones["UTC+0200"] = DDMMYYYY;
  timezones["UTC+0300"] = DDMMYYYY;
  timezones["UTC+0400"] = DDMMYYYY;
  timezones["UTC+0430"] = DDMMYYYY;
  timezones["UTC+0500"] = DDMMYYYY;
  timezones["UTC+0530"] = DDMMYYYY;
  timezones["UTC+0545"] = DDMMYYYY;
  timezones["UTC+0600"] = DDMMYYYY;
  timezones["UTC+0630"] = DDMMYYYY;
  timezones["UTC+0645"] = DDMMYYYY;
  timezones["UTC+0700"] = DDMMYYYY;
  timezones["UTC+0730"] = DDMMYYYY;
  timezones["UTC+0800"] = DDMMYYYY;
  timezones["UTC+0900"] = DDMMYYYY;
  timezones["UTC+0930"] = DDMMYYYY;
  timezones["UTC+1000"] = DDMMYYYY;
  timezones["UTC+1030"] = DDMMYYYY;
  timezones["UTC+1200"] = DDMMYYYY;
  timezones["UTC+1300"] = DDMMYYYY;
  timezones["UTC+1400"] = DDMMYYYY;

  var timezoneDate = new Date(Date.UTC(2002,2,12,12,0,0));
  var timezone = timezoneDate.toString();
  var timezoneEnd = timezone.indexOf(" ", 20);
  timezone = timezone.substring(20, timezoneEnd);
  var dateFormat = timezones[timezone];

  if (isNaN(dateFormat)){
    dateFormat = DDMMYYYY;
  }

  if(inputStr == "" || inputStr == " ") {
    return true;
  }

  // Check for "today", and replace with today's date
  if (inputStr.substring(0,3) == "tod") {
    var today = new Date() ;
    gField.focus() ;
    gField.select() ;
    gField.value = today.getDate() + " " + dispMonths[today.getMonth()] + " " + today.getYear() ;
    return true ;
  }

  // convert space delimiters to slashes
  while (inputStr.indexOf("  ") != -1) {
    inputStr = replaceString(inputStr,"  ","/")
  }
  // convert space delimiters to slashes
  while (inputStr.indexOf(" ") != -1) {
    inputStr = replaceString(inputStr," ","/")
  }
  // convert hyphen delimiters to slashes
  while (inputStr.indexOf("-") != -1) {
    inputStr = replaceString(inputStr,"-","/")
  }
  // convert period delimiters to slashes
  while (inputStr.indexOf(".") != -1) {
    inputStr = replaceString(inputStr,".","/")
  }
  var delim1 = inputStr.indexOf("/")
  var delim2 = inputStr.lastIndexOf("/")
  if (delim1 != -1 && delim1 == delim2) {
    // there is only one delimiter in the string
    alert("The date entry is not in an acceptable format.\n\nYou can enter dates in the following formats: " + ((dateFormat == DDMMYYYY)?"ddmm":"mmdd") + "yyyy, dd-mon-yyyy or " + ((dateFormat == DDMMYYYY)?"dd-mm":"mm-dd") + "-yyyy.  (If the month or date data is not available, enter \'01\' in the appropriate location.)")
    gField.focus()
    gField.select()
    gField.value = "";
    return false
  }
  if (delim1 != -1) {
    // there are delimiters; extract component values
    if (dateFormat == MMDDYYYY){
      mm = parseInt(inputStr.substring(0,delim1),10)
      dd = parseInt(inputStr.substring(delim1 + 1,delim2), 10)
      if (isNaN(dd)){
        dd = parseInt(inputStr.substring(0,delim1),10)
        mm = inputStr.substring(delim1 + 1,delim2)
      }
    }else{
      dd = parseInt(inputStr.substring(0,delim1),10)
      mm = inputStr.substring(delim1 + 1,delim2)
    }
    var yyyy = parseInt(inputStr.substring(delim2 + 1, inputStr.length),10)
  } else {
    // there are no delimiters; extract component values
    if (dateFormat == MMDDYYYY){
      mm = parseInt(inputStr.substring(0,2),10)
      dd = parseInt(inputStr.substring(2,4),10)
    }else{
      dd = parseInt(inputStr.substring(0,2),10)
      mm = parseInt(inputStr.substring(2,4),10)
    }
    var yyyy = parseInt(inputStr.substring(4,inputStr.length),10)
  }

  if (isNaN(dd) || isNaN(yyyy)) {
    // there is a non-numeric character in one of the component values
    alert("The date entry is not in an acceptable format.\n\nYou can enter dates in the following formats: " + ((dateFormat == DDMMYYYY)?"ddmm":"mmdd") + "yyyy, dd-mon-yyyy or " + ((dateFormat == DDMMYYYY)?"dd-mm":"mm-dd") + "-yyyy.")
    gField.focus();
    gField.select();
    gField.value = "";
    return false;
  }
  if( isNaN(mm) ) {
    var mon = new String(mm);
    mon = mon.toLowerCase();
    mm = false;
    for (var mc=0; mc<dispMonths.length; mc++) {
      if (mon == dispMonths[mc].toLowerCase()) {
        mm = mc + 1;
        break;
      }
    }

    if (!mm) {
      alert("The date entry is not in an acceptable format.\n\nYou can enter dates in the following formats: " + ((dateFormat == DDMMYYYY)?"ddmm":"mmdd") + "yyyy, dd-mon-yyyy or " + ((dateFormat == DDMMYYYY)?"dd-mm":"mm-dd") + "-yyyy.")
      gField.focus();
      gField.select();
      gField.value = "";
      return false;
    }
  }

  if (mm < 1 || mm > 12) {
    // month value is not 1 thru 12
    alert("Months must be entered between the range of 1 (January) and 12 (December).")
    gField.focus();
    gField.select();
    gField.value = "";
    return false;
  }

  if (dd < 1 || dd > 31) {
    // date value is not 1 thru 31
    alert("Days must be entered between the range of 1 and a maximum of 31 (depending on the month and year).")
    gField.focus();
    gField.select();
    gField.value = "";
    return false;
  }

  // validate year, allowing for checks between year ranges
  // passed as parameters from other validation functions
  if (yyyy < 100) {
    // entered value is two digits, which we allow for 1930-2029
    if (yyyy >= 30) {
      yyyy += 1900;
    } else {
      yyyy += 2000;
    }
  }

  var today = new Date();

  if (!checkMonthLength(mm,dd)) {
    gField.focus()
    gField.select()
    gField.value = "";
    return false
  }

  if (mm == 2) {
    if (!checkLeapMonth(mm,dd,yyyy)) {
      gField.focus();
      gField.select();
      gField.value = "";
      return false
    }
  }

  // put the Timezone-independant format back into the field
  var iMon = parseInt(""+mm,10);
  gField.value = lz(dd) + " " + dispMonths[iMon-1] + " " + yyyy;

  return true;
}

// check the entered month for too high a value
function checkMonthLength(mm,dd) {
  var months = new Array("","January","February","March","April","May","June","July","August","September","October","November","December")
  if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd > 30) {
    alert(months[mm] + " has only 30 days.")
    return false
  } else if (dd > 31) {
    alert(months[mm] + " has only 31 days.")
    return false
  }
  return true
}

function getTheYear() {
  var thisYear = (new Date()).getYear()
  thisYear = (thisYear < 100)? thisYear + 1900: thisYear
  return thisYear
}

function checkDate(Field) {
  var thisYear = getTheYear();
  if (!isDate(Field)) {
    alert("Invalid Date");
  } else {
    alert("Dave is Valid"); }
}
