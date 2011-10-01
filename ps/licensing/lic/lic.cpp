/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * FLEXlm License Verifier
 * Copyright 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Performs the FLEXlm check
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Jan-05    File added.
 * CAM  07-May-05    Added variety of EPM languages.
 * CAM  02-Aug-05    76 : Added ADA.
 * CAM  09-Aug-05    110 : Correct license problems.
 * CAM  12-Aug-05    110 : Glorious Twelfth - Correct license problems.
 * CAM  13-Aug-05    114 : Added Perl.
 * CAM  19-Sep-05    138 : Added KEPM.
 * CAM  27-Oct-06    117 : Added ASP.
 * CAM  04-Nov-06    301 : Added PHP.
 * CAM  28-Jun-07    314 : Added Ericsson IDL.
 * CAM  17-Jul-07    316 : Added VHDL.
 * CAM  11-Dec-07    325 : Added JSP/XML.
 * CAM  26-Mar-09    10400 : Added AY/HT/JT/PY (#10400/10401/10402/10403).
 * CAM  24-Jun-2009  10449 : Added CSS Stylesheet (SS), Fortran (FT), Ruby (RB), Shell Script (SH), Text (TX) and Windows Batch File (WB).
 * CAM  10-Dec-2009  10508 : Added PowerBuilder (PB).
 * CAM  18-Jun-2011  10963 : Added Intel languages UC (UCode) and MMP (Modular Maths Processer).
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
  inc(EPM_ID, LIC_ID);
  inc(EPM_VH, LIC_VH);
  inc(EPM_JS, LIC_JS);
  inc(EPM_XM, LIC_XM);
  inc(EPM_KR, LIC_KR);
  inc(EPM_AY, LIC_AY);
  inc(EPM_HT, LIC_HT);
  inc(EPM_JT, LIC_JT);
  inc(EPM_PY, LIC_PY);
  inc(EPM_SS, LIC_SS);
  inc(EPM_FT, LIC_FT);
  inc(EPM_RB, LIC_RB);
  inc(EPM_SH, LIC_SH);
  inc(EPM_TX, LIC_TX);
  inc(EPM_WB, LIC_WB);
  inc(EPM_PB, LIC_PB);
  inc(EPM_UC, LIC_UC);
  inc(EPM_MP, LIC_MP);

  if (debug) cout << endl << "Total:" << rval << endl;

  return rval;
}
