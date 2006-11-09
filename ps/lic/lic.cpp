/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * FLEXlm License Verifier
 * Copyright 2004-2005 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Performs the FLEXlm check
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  08-Jan-05  File added.
 * CAM  07-May-05  Added variety of EPM languages.
 * CAM  02-Aug-05    76 : Added ADA.
 * CAM  09-Aug-05   110 : Correct license problems.
 * CAM  12-Aug-05   110 : Glorious Twelfth - Correct license problems.
 * CAM  13-Aug-05   114 : Added Perl.
 * CAM  19-Sep-05   138 : Added KEPM.
 * CAM  27-Oct-06   117 : Added ASP.
 * CAM  04-Nov-06   301 : Added PHP.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "LicConfig.h"
#include "lmpolicy.h"

#include <direct.h>
#include <process.h>
#include <windows.h>

#include <iostream>
using namespace std;

#pragma comment(lib, "netapi32.lib")
#pragma comment(lib, "advapi32.lib")
#pragma comment(lib, "lmgr_md.lib")
#pragma comment(lib, "user32.lib")
#pragma comment(lib, "comdlg32.lib")
#pragma comment(lib, "comctl32.lib")
#pragma comment(lib, "uuid.lib")

#define LICENSE_PATH  ".\\license.dat"
#define BUFFLEN 256

int debug=0;
DWORD rval=0;

void inc(int flag, char* id) {
  if (!CHECKOUT(LM_RESTRICTIVE, id, LICENSE_VERSION, LICENSE_PATH)) {
    rval |= flag;

    if (debug==1) {
      cout << id << "(" << flag << ")" << " is licensed." << endl;
    }
  } else {
    if (debug==1) {
      cout << id << "(" << flag << ")" << " is NOT licensed." << endl;
    }
  }
}

DWORD main(int argc, char* argv[]) {
  if (argc>1) {
    debug=1;
  }

  inc(EPM_CS, LIC_CS);
  inc(EPM_CP, LIC_CP);
  inc(EPM_JV, LIC_JV);
  inc(EPM_VB, LIC_VB);
  inc(EPM_S1, LIC_S1);
  inc(EPM_AD, LIC_AD);
  inc(EPM_PL, LIC_PL);
  inc(EPM_AS, LIC_AS);
  inc(EPM_PH, LIC_PH);
  inc(EPM_KR, LIC_KR);

  if (debug) cout << endl << "Total:" << rval << endl;

  return rval;
}
