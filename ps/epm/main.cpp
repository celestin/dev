/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EPM entry point
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  19-Dec-04  File added.
 * CAM  30-Dec-04  Added -s servername.
 * CAM  04-Jan-05  Attempting to add FLEXlm licensing.
 * CAM  08-Jan-05  Exit on failed license check.
 * CAM  08-Jan-05  Improve error messages.
 * CAM  13-Jan-05  Added -u username and -p password.
 * CAM  19-Jan-05  If localhost, start a local MySQL server.
 * CAM  24-Jan-05  Use 'Metrics' class rather than array.
 * CAM  26-Jan-05  Increment ADD_SLOC and DEL_SLOC for Added/Deleted files respectively.
 * CAM  26-Jan-05  Changed command line help from 'csp' to 'epm'.
 * CAM  14-Mar-05    78 : Correct LOC count.
 * CAM  26-Mar-05    79 : Added CSV reports.
 * CAM  29-Mar-05    85 : Added XML reports.
 * CAM  04-May-05    50 : Added Language (C/C++).
 * CAM  05-May-05    49 : Added Java.
 * CAM  12-May-05    96 : Added VB.
 * CAM  17-May-05    97 : Added PL/SQL.
 * CAM  02-Aug-05    76 : Added ADA.
 * CAM  13-Aug-05   114 : Added Perl.
 * CAM  23-Aug-05   115 : Added XML Config.
 * CAM  16-Jan-06   177 : Added EPM Version No.
 * CAM  28-Jan-06   168 : Added -m MetricSet.
 * CAM  28-Jan-06   168 : Version 1.08.000.
 * CAM  07-Feb-06   184 : Version 1.08.001.
 * CAM  07-Feb-06   187 : Use MYSQL_PARAM_SIZE to malloc spaces for params.
 * CAM  13-Feb-06   185 : Version 1.08.002.
 * CAM  21-Feb-06   188 : Moved file checking in initFileSource to Project.h.
 * CAM  21-Feb-06   188 : Version 1.09.000.
 * CAM  11-Mar-06   199 : Separate Diff by Language.
 * CAM  14-Mar-06   202 : Version 1.09.002.
 * CAM  18-Mar-06   211 : Version 1.09.003.
 * CAM  18-Mar-06   220 : Version 1.09.004.
 * CAM  25-Mar-06   221 : Version 1.10.000.
 * CAM  08-Apr-06   230 : Version 1.10.001.
 * CAM  11-May-06   241 : Allow EPM to be run from any location.  Version 1.10.002.
 * CAM  11-May-06   252 : Min/Max/Avg in HTML Reports.  Version 1.10.003.
 * CAM  06-Jun-06   255 : Version 1.10.004.
 * CAM  18-Jul-06   272 : Version 1.11.000.
 * CAM  18-Jul-06   286 : Ensure ADD_LLOC and DEL_LLOC are reported on New/Del files.
 * CAM  22-Jul-06   291 : Ensure "lines" of 64Kb semi-colon are truncated and diff'ing continues.
 * CAM  19-Sep-06   117 : Added ASP.
 * CAM  27-Oct-06   117 : Version 1.12.000.
 * CAM  09-Nov-06   301 : Version 1.13.000.
 * CAM  10-Jul-07   314 : Added IDL.
 * CAM  10-Jul-07   314 : Version 1.14.000.
 * CAM  26-Jul-07   316 : Added VHDL.
 * CAM  26-Jul-07   316 : Version 1.15.000.
 * CAM  26-Jul-07   317 : Version 1.15.001.
 * CAM  26-Oct-07   319 : Version 1.15.002.
 * CAM  01-Nov-07   321 : Version 1.15.003.
 * CAM  28-Nov-07   323 : Call PHP Parser. Version 1.15.004.
 * CAM  10-Dec-07   324 : Added JSP.
 * CAM  10-Dec-07   325 : Added XML.
 * CAM  01-Nov-07   325 : Version 1.16.000.
 * CAM  13-Dec-07   328 : Version 1.16.001.
 * CAM  04-Jan-08   330 : Version 1.16.002.
 * CAM  24-Apr-08   358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  24-Apr-08   359 : Version 1.16.003.
 * CAM  26-Apr-08   360 : Version 1.16.004.
 * CAM  30-May-08   365 : Only start the MySQL process if required.  Version 1.16.005.
 * CAM  14-Apr-2009  10400 : Added JavaScript language support.
 * CAM  14-Apr-2009  10401 : Added HTML language support.
 * CAM  14-Apr-2009  10403 : Added Python language support.  Changed non-logical lines languages to set NSC (LLOC) to SLOC.
 * CAM  16-Apr-2009  10402 : Added Assembler language support.
 * CAM  17-Apr-2009  10430 : Added calculation of Churn metrics.
 * CAM  18-Apr-2009  10434 : Version 1.17.000.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "Diff.h"
#include "DiffAda.h"
#include "DiffAsm.h"
#include "DiffASP.h"
#include "DiffCpp.h"
#include "DiffOracle.h"
#include "DiffPerl.h"
#include "DiffVB.h"
#include "OurSQL.h"
#include "Utilities.h"
#include "CSVReport.h"
#include "XMLReport.h"
#include "ReportItem.h"
#include "HTMLReport.h"
#include "batch.h"
#include "Db.h"
#include "Metric.h"
#include "Lang.h"
#include "Extension.h"

using namespace metrics;

#include <io.h>
#include <iostream>
#include <list>
#include <process.h>
#include <set>
#include <stdio.h>
#include <vector>
#include <windows.h>
#pragma comment(lib, "wsock32.lib")

using namespace std;

extern FILE *yyin_cs, *yyin_c, *yyin_j, *yyin_jsp, *yyin_vb, *yyin_s1, *yyin_ada, *yyin_pl, *yyin_asp, *yyin_php, *yyin_idl,
            *yyin_vhdl, *yyin_xml, *yyin_jt, *yyin_ht, *yyin_py, *yyin_ay;
extern void lexclear_cs();
extern void lexclear_c();
extern void lexclear_j();
extern void lexclear_jsp();
extern void lexclear_vb();
extern void lexclear_s1();
extern void lexclear_ada();
extern void lexclear_pl();
extern void lexclear_asp();
extern void lexclear_php();
extern void lexclear_idl();
extern void lexclear_vhdl();
extern void lexclear_xml();
extern void lexclear_jt();
extern void lexclear_ht();
extern void lexclear_py();
extern void lexclear_ay();
extern int yylex_cs();
extern int yylex_c();
extern int yylex_j();
extern int yylex_jsp();
extern int yylex_vb();
extern int yylex_s1();
extern int yylex_ada();
extern int yylex_pl();
extern int yylex_asp();
extern int yylex_php();
extern int yylex_idl();
extern int yylex_vhdl();
extern int yylex_xml();
extern int yylex_jt();
extern int yylex_ht();
extern int yylex_py();
extern int yylex_ay();

extern int j_comments_cs,c_comments_cs,cpp_comments_cs,com_loc_cs,nsemi_cs,noperands_cs,noperators_cs;
extern set<int> sloc_cs,operators_cs;
extern vector<char*> operands_cs[255];

extern int j_comments_c,c_comments_c,cpp_comments_c,com_loc_c,nsemi_c,noperands_c,noperators_c;
extern set<int> sloc_c,operators_c;
extern vector<char*> operands_c[255];

extern int j_comments_j,c_comments_j,cpp_comments_j,com_loc_j,nsemi_j,noperands_j,noperators_j;
extern set<int> sloc_j,operators_j;
extern vector<char*> operands_j[255];

extern int c_comments_jsp,cpp_comments_jsp,com_loc_jsp,nsemi_jsp,noperands_jsp,noperators_jsp;
extern set<int> sloc_jsp,operators_jsp;
extern set<int> slnat_jsp,sltag_jsp,slhtm_jsp,slscr_jsp;
extern vector<char*> operands_jsp[255];

extern int cpp_comments_vb,com_loc_vb,noperands_vb,noperators_vb;
extern set<int> sloc_vb,operators_vb;
extern vector<char*> operands_vb[255];

extern int c_comments_s1,cpp_comments_s1,com_loc_s1,nsemi_s1,noperands_s1,noperators_s1;
extern set<int> sloc_s1,operators_s1;
extern vector<char*> operands_s1[255];

extern int c_comments_ada,cpp_comments_ada,com_loc_ada,nsemi_ada,noperands_ada,noperators_ada;
extern set<int> sloc_ada,operators_ada;
extern vector<char*> operands_ada[255];

extern int c_comments_pl,cpp_comments_pl,com_loc_pl,nsemi_pl,noperands_pl,noperators_pl;
extern set<int> sloc_pl,operators_pl;
extern vector<char*> operands_pl[255];

extern int c_comments_asp,cpp_comments_asp,com_loc_asp,nsemi_asp,noperands_asp,noperators_asp;
extern set<int> sloc_asp,operators_asp;
extern set<int> slnat_asp,sltag_asp,slhtm_asp,slscr_asp;
extern vector<char*> operands_asp[255];

extern int c_comments_php,cpp_comments_php,com_loc_php,nsemi_php,noperands_php,noperators_php;
extern set<int> sloc_php,operators_php;
extern set<int> slnat_php,slhtm_php,slscr_php;
extern vector<char*> operands_php[255];

extern int j_comments_idl,c_comments_idl,cpp_comments_idl,com_loc_idl,nsemi_idl,noperands_idl,noperators_idl;
extern set<int> sloc_idl,operators_idl;
extern vector<char*> operands_idl[255];

extern int j_comments_vhdl,c_comments_vhdl,cpp_comments_vhdl,com_loc_vhdl,nsemi_vhdl,noperands_vhdl,noperators_vhdl;
extern set<int> sloc_vhdl,operators_vhdl;
extern vector<char*> operands_vhdl[255];

extern int c_comments_xml,cpp_comments_xml,com_loc_xml,nsemi_xml,noperands_xml,noperators_xml;
extern set<int> sloc_xml,operators_xml;
extern set<int> sltag_xml;
extern vector<char*> operands_xml[255];

extern int c_comments_jt,cpp_comments_jt,com_loc_jt,nsemi_jt,noperands_jt,noperators_jt;
extern set<int> sloc_jt,operators_jt;
extern set<int> sltag_jt;
extern vector<char*> operands_jt[255];

extern int c_comments_ht,cpp_comments_ht,com_loc_ht,nsemi_ht,noperands_ht,noperators_ht;
extern set<int> sloc_ht,operators_ht;
extern set<int> slnat_ht,slhtm_ht,slscr_ht;
extern vector<char*> operands_ht[255];

extern int c_comments_py,cpp_comments_py,com_loc_py,nsemi_py,noperands_py,noperators_py;
extern set<int> sloc_py,operators_py;
extern vector<char*> operands_py[255];

extern int c_comments_ay,cpp_comments_ay,com_loc_ay,nsemi_ay,noperands_ay,noperators_ay;
extern set<int> sloc_ay,operators_ay;
extern vector<char*> operands_ay[255];

extern bool validLicense();
extern bool validLanguage(Langs l);

extern int xmlConfig();
extern Extension *ext;

// Global Variables
char szAppDirectory[MAX_PATH];

int OPTION_MASK = 0;      // mask for options given at the command line
int METRIC_MASK = 0;      // mask for metrics chosen at the command line

char *img_dir = NULL;
char *ins_dir = NULL;

int nProjects = 0;
int nLOC = 0;
Lang lang;

char *projname = NULL;
char *filelistname[PROJECT_MAX];
char *relpath[PROJECT_MAX];
ifstream filelist[PROJECT_MAX];

#define LMAX 16384
char lbuf[LMAX];

char *servername = NULL;
bool bLocalDb = false;
char *musername = NULL;
char *mpassword = NULL;

char *metricsset = NULL;
char *csvfile = NULL;
char *xmlfile = NULL;
char *symb_dir = NULL;
char *grid_dir = NULL;
char *symb_file = NULL;
char *grid_file = NULL;

bool autocreate = false;

#define QUERY_MAX_EXTRA 8192

char tmp_file[PATH_MAX];
char fn_buff[PATH_MAX];
char fn_res[PATH_MAX];
char ftype[100];
char sindex[100];
char qry[QUERY_MAX_EXTRA];
char buffer[QUERY_MAX];
char currentFile[QUERY_MAX];

#include "Project.h"

Metrics met;

void setMetrics(int sfid, string filename) {
  int i;
  long sloc,j_com,c_com,cpp_com,com_loc;
  sloc=j_com=c_com=cpp_com=com_loc=0;

  met.clearMetrics();
  met.set(MET(LOC), (float)nLOC);    // Lines of Code

  switch (lang.getLanguage()) {
    case LANG_CPP:
    sloc = sloc_c.size();                   // Source Lines of Code
    met.set(MET(NSC), nsemi_c);             // Halstead
    met.set(MET(N1), noperators_c);
    met.set(MET(N1S), operators_c.size());
    met.set(MET(N2), noperands_c);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_c[i].size());
    }

    j_com = j_comments_c;                   // Comments
    c_com = c_comments_c;
    cpp_com = cpp_comments_c;
    com_loc = com_loc_c;
    break;

    case LANG_CS:
    sloc = sloc_cs.size();                  // Source Lines of Code
    met.set(MET(NSC), nsemi_cs);            // Halstead
    met.set(MET(N1), noperators_cs);
    met.set(MET(N1S), operators_cs.size());
    met.set(MET(N2), noperands_cs);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_cs[i].size());
    }

    j_com = j_comments_cs;                  // Comments
    c_com = c_comments_cs;
    cpp_com = cpp_comments_cs;
    com_loc = com_loc_cs;
    break;

    case LANG_JAVA:
    sloc = sloc_j.size();                   // Source Lines of Code
    met.set(MET(NSC), nsemi_j);             // Halstead
    met.set(MET(N1), noperators_j);
    met.set(MET(N1S), operators_j.size());
    met.set(MET(N2), noperands_j);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_j[i].size());
    }

    j_com = j_comments_j;                   // Comments
    c_com = c_comments_j;
    cpp_com = cpp_comments_j;
    com_loc = com_loc_j;
    break;

    case LANG_JSP:
    sloc = sloc_jsp.size();                     // Source Lines of Code
    met.set(MET(SLOC_TAG), sltag_jsp.size());   // Source Lines containing JSP Tags
    met.set(MET(SLOC_HTM), slhtm_jsp.size());   // Source Lines containing HTML
    met.set(MET(SLOC_NAT), slnat_jsp.size());   // Source Lines containing native, server-side code
    met.set(MET(SLOC_SCR), slscr_jsp.size());   // Source Lines containing client-side script

    met.set(MET(NSC), nsemi_jsp);               // Halstead
    met.set(MET(N1), noperators_jsp);
    met.set(MET(N1S), operators_jsp.size());
    met.set(MET(N2), noperands_jsp);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_jsp[i].size());
    }

    c_com = c_comments_jsp;                   // Comments
    cpp_com = cpp_comments_jsp;
    com_loc = com_loc_jsp;
    break;

    case LANG_VB:
    sloc = sloc_vb.size();                  // Source Lines of Code

    met.set(MET(N1), noperators_vb);        // Halstead
    met.set(MET(N1S), operators_vb.size());
    met.set(MET(N2), noperands_vb);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_vb[i].size());
    }

    cpp_com = cpp_comments_vb;              // Comments
    com_loc = com_loc_vb;
    break;

    case LANG_S1:
    sloc = sloc_s1.size();                   // Source Lines of Code

    met.set(MET(N1), noperators_s1);
    met.set(MET(N1S), operators_s1.size());
    met.set(MET(N2), noperands_s1);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_s1[i].size());
    }

    c_com = c_comments_s1;                   // Comments
    cpp_com = cpp_comments_s1;
    com_loc = com_loc_s1;
    break;

    case LANG_ADA:
    sloc = sloc_ada.size();                   // Source Lines of Code
    met.set(MET(NSC), nsemi_ada);             // Halstead
    met.set(MET(N1), noperators_ada);
    met.set(MET(N1S), operators_ada.size());
    met.set(MET(N2), noperands_ada);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_ada[i].size());
    }

    c_com = c_comments_ada;                   // Comments
    cpp_com = cpp_comments_ada;
    com_loc = com_loc_ada;
    break;

    case LANG_PERL:
    sloc = sloc_pl.size();                   // Source Lines of Code

    met.set(MET(N1), noperators_pl);
    met.set(MET(N1S), operators_pl.size());
    met.set(MET(N2), noperands_pl);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_pl[i].size());
    }

    c_com = c_comments_pl;                   // Comments
    cpp_com = cpp_comments_pl;
    com_loc = com_loc_pl;
    break;

    case LANG_ASP:
    sloc = sloc_asp.size();                     // Source Lines of Code
    met.set(MET(SLOC_TAG), sltag_asp.size());   // Source Lines containing ASP Tags
    met.set(MET(SLOC_HTM), slhtm_asp.size());   // Source Lines containing HTML
    met.set(MET(SLOC_NAT), slnat_asp.size());   // Source Lines containing native, server-side code
    met.set(MET(SLOC_SCR), slscr_asp.size());   // Source Lines containing client-side script

    met.set(MET(NSC), nsemi_asp);               // Halstead
    met.set(MET(N1), noperators_asp);
    met.set(MET(N1S), operators_asp.size());
    met.set(MET(N2), noperands_asp);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_asp[i].size());
    }

    c_com = c_comments_asp;                   // Comments
    cpp_com = cpp_comments_asp;
    com_loc = com_loc_asp;
    break;

    case LANG_PHP:
    sloc = sloc_php.size();                     // Source Lines of Code
    met.set(MET(SLOC_HTM), slhtm_php.size());   // Source Lines containing HTML
    met.set(MET(SLOC_NAT), slnat_php.size());   // Source Lines containing native, server-side code
    met.set(MET(SLOC_SCR), slscr_php.size());   // Source Lines containing client-side script

    met.set(MET(NSC), nsemi_php);               // Halstead
    met.set(MET(N1), noperators_php);
    met.set(MET(N1S), operators_php.size());
    met.set(MET(N2), noperands_php);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_php[i].size());
    }

    c_com = c_comments_php;                   // Comments
    cpp_com = cpp_comments_php;
    com_loc = com_loc_php;
    break;

    case LANG_IDL:
    sloc = sloc_idl.size();                   // Source Lines of Code
    met.set(MET(NSC), nsemi_idl);             // Halstead
    met.set(MET(N1), noperators_idl);
    met.set(MET(N1S), operators_idl.size());
    met.set(MET(N2), noperands_idl);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_idl[i].size());
    }

    c_com = c_comments_idl;                   // Comments
    cpp_com = cpp_comments_idl;
    com_loc = com_loc_idl;
    break;

    case LANG_VHDL:
    sloc = sloc_vhdl.size();                   // Source Lines of Code
    met.set(MET(NSC), nsemi_vhdl);             // Halstead
    met.set(MET(N1), noperators_vhdl);
    met.set(MET(N1S), operators_vhdl.size());
    met.set(MET(N2), noperands_vhdl);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_vhdl[i].size());
    }

    c_com = c_comments_vhdl;                   // Comments
    cpp_com = cpp_comments_vhdl;
    com_loc = com_loc_vhdl;
    break;

    case LANG_XML:
    sloc = sloc_xml.size();                     // Source Lines of Code
    met.set(MET(SLOC_TAG), sltag_xml.size());   // Source Lines containing xml Tags

    met.set(MET(N1), noperators_xml);
    met.set(MET(N1S), operators_xml.size());
    met.set(MET(N2), noperands_xml);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_xml[i].size());
    }

    c_com = c_comments_xml;                   // Comments
    cpp_com = cpp_comments_xml;
    com_loc = com_loc_xml;
    break;

    case LANG_JT:
    sloc = sloc_jt.size();                     // Source Lines of Code

    met.set(MET(NSC), nsemi_jt);               // Halstead
    met.set(MET(N1), noperators_jt);
    met.set(MET(N1S), operators_jt.size());
    met.set(MET(N2), noperands_jt);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_jt[i].size());
    }

    c_com = c_comments_jt;                   // Comments
    cpp_com = cpp_comments_jt;
    com_loc = com_loc_jt;
    break;

    case LANG_HTML:
    sloc = sloc_ht.size();                     // Source Lines of Code
    met.set(MET(SLOC_HTM), slhtm_ht.size());   // Source Lines containing HTML
    met.set(MET(SLOC_SCR), slscr_ht.size());   // Source Lines containing client-side script

    met.set(MET(N1), noperators_ht);
    met.set(MET(N1S), operators_ht.size());
    met.set(MET(N2), noperands_ht);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_ht[i].size());
    }

    c_com = c_comments_ht;                   // Comments
    cpp_com = cpp_comments_ht;
    com_loc = com_loc_ht;
    break;

    case LANG_PYTHON:
    sloc = sloc_py.size();                    // Source Lines of Code

    met.set(MET(N1), noperators_py);
    met.set(MET(N1S), operators_py.size());
    met.set(MET(N2), noperands_py);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_py[i].size());
    }

    c_com = c_comments_py;                   // Comments
    cpp_com = cpp_comments_py;
    com_loc = com_loc_py;
    break;

    case LANG_ASM:
    sloc = sloc_ay.size();                     // Source Lines of Code

    met.set(MET(NSC), nsemi_ay);               // Halstead
    met.set(MET(N1), noperators_ay);
    met.set(MET(N1S), operators_ay.size());
    met.set(MET(N2), noperands_ay);
    for (i=0;i<255;i++) {
      met.add(MET(N2S), operands_ay[i].size());
    }

    c_com = c_comments_ay;                   // Comments
    cpp_com = cpp_comments_ay;
    com_loc = com_loc_ay;
    break;
  }

  if (!lang.hasLogicalLines()) met.set(MET(NSC), sloc);

  met.set(MET(SLOC), sloc);
  met.set(MET(J_COM), j_com);
  met.set(MET(C_COM), c_com);
  met.set(MET(CPP_COM), cpp_com);
  met.set(MET(COM_LOC), com_loc);
  met.calculateHalstead();

  met.set(MET(BYTES), Utilities::getFileSize(filename));  // Filesize
  saveDb(sfid, met, MET(LOC), MET(BYTES));
}

void calcDiff(int sfid, string &filename, string &filename2) {
  met.clearMetrics();
  Diff *d;

  switch (lang.getLanguage()) {
    case LANG_CPP:
    case LANG_CS:
    case LANG_JAVA:
    case LANG_JT:
    case LANG_IDL:
    d = new DiffCpp(filename2.c_str(), filename.c_str());
    break;

    case LANG_ADA:
    case LANG_VHDL:
    d = new DiffAda(filename2.c_str(), filename.c_str());
    break;

    case LANG_S1:
    d = new DiffOracle(filename2.c_str(), filename.c_str());
    break;

    case LANG_PERL:
    case LANG_PYTHON:
    d = new DiffPerl(filename2.c_str(), filename.c_str());
    break;

    case LANG_VB:
    d = new DiffVB(filename2.c_str(), filename.c_str());
    break;

    case LANG_ASP:
    case LANG_JSP:
    case LANG_PHP:
    case LANG_HTML:
    case LANG_XML:
    d = new DiffASP(filename2.c_str(), filename.c_str());
    break;

    case LANG_ASM:
    d = new DiffAsm(filename2.c_str(), filename.c_str());
    break;
  }

  d->compare();

  met.set(MET(CLOC), d->getChangedLines());
  met.set(MET(DLOC), d->getDeletedLines());
  met.set(MET(ALOC), d->getInsertedLines());

  if (lang.hasLogicalLines())
  {
    d->compare(true);

    met.set(MET(CLLOC), d->getChangedLines());
    met.set(MET(DLLOC), d->getDeletedLines());
    met.set(MET(ALLOC), d->getInsertedLines());
  }
  else
  {
    // Set Logical Lines equal to Source Lines
    // This is how the LLOC metric itself is set, therefore changed metrics should mirror
    met.set(MET(CLLOC), d->getChangedLines());
    met.set(MET(DLLOC), d->getDeletedLines());
    met.set(MET(ALLOC), d->getInsertedLines());
  }

  met.calculateChurn();

  delete d;

  saveDb(sfid, met, MET(CLOC), MET(XLLOC));
}

void calcAddDel(int sfid, char status, int metid, float mvalue) {
  met.clearMetrics();

  if (status == 'A') {
    if (metid == SLOC) met.set(MET(ALOC), mvalue);
    if (metid == NSC)  met.set(MET(ALLOC), mvalue);
  } else {
    if (metid == SLOC) met.set(MET(DLOC), mvalue);
    if (metid == NSC)  met.set(MET(DLLOC), mvalue);
  }

  met.calculateChurn();

  if (metid == SLOC) {
    saveDb(sfid, met, MET(CLOC), MET(XLOC));
  } else if (metid == NSC) {
    saveDb(sfid, met, MET(CLLOC), MET(XLLOC));
  }
}


void showHelp() {
  cout << "\nUsage: epm [options] name" << endl;

  cout << "\nOptions\n" << endl;
  cout << "   -s  MySQL_server Name of the MySQL server to store data" << endl;
  cout << "   -u  MySQL_user   User to use when connecting to MySQL server" << endl;
  cout << "   -p  MySQL_pass   Password to use when connecting to MySQL server" << endl;
  cout << "   -fX filelist     Obtain files from the given file list (f1=new, f2=old)" << endl;
  cout << "   -m  metrics_set  Name of the Metrics Set (defined in epm.xml)" << endl;
  cout << "                    to apply to reports." << endl;
  cout << "   -c  csv_file     Create CSV report." << endl;
//  cout << "   -h1 html_file    Create single page HTML report." << endl;
  cout << "   -h2 html_dir     Create multiple page HTML report." << endl;
//  cout << "   -h3 html_file    Create single page HTML report (grid)." << endl;
//  cout << "   -h4 html_dir     Create multiple page HTML report (grid)." << endl;
  cout << "   -x  xml_file     Create XML report." << endl;
  cout << "   -?               Show this help screen." << endl;

  cout << "\nName" << endl;
  cout << "\nA name to give the project." << endl;

  exit(1);
}

void parseCmdLineOptions(int argc, char *argv[]) {

  bool gotName = false;
  int nProjName = 0;

  bool oem = false;

  for (int i=1; i<argc; i++) {

    if (argv[i]) { // Check not NULL

      char *c;
      if (argv[i][0]=='-') {
        c = argv[i] + 1;

        switch (*c) {
        case 'a':
          if (!strcmp(c,"auto")) {
            // Automatically create directories that do not exist
            autocreate = true;
          } else {
            showHelp();
          }
          break;
        case 'c':
          if (++i<argc && argv[i]) {
            csvfile = (char*) malloc(PATH_MAX*sizeof(char));
            realpath(argv[i],csvfile);
            OPTION_MASK |= CSV_MASK;
          } else {
            showHelp();
          }
          break;
        case 'm':   // Metrics Set
          if (++i<argc && argv[i]) {
            metricsset = (char*) malloc(PATH_MAX*sizeof(char));
            metricsset = _strdup(argv[i]);
            OPTION_MASK |= METRICS_SET_MASK;
          } else {
            showHelp();
          }
          break;
        case 's':
          if (++i<argc && argv[i]) {
            servername = _strdup(argv[i]);
          } else {
            showHelp();
          }
          break;
        case 'u':
          if (++i<argc && argv[i]) {
            musername = (char*) malloc(MYSQL_PARAM_SIZE*sizeof(char));
            strcpy_s(musername, MYSQL_PARAM_SIZE, argv[i]);
          } else {
            showHelp();
          }
          break;
        case 'p':
          if (++i<argc && argv[i]) {
            mpassword = (char*) malloc(MYSQL_PARAM_SIZE*sizeof(char));
            strcpy_s(mpassword, MYSQL_PARAM_SIZE, argv[i]);
          } else {
            showHelp();
          }
          break;
        case 'f':
          if (*++c) {
            if (++i<argc && argv[i]) {
              switch (*c) {
              case '1':
                nProjects++;
                filelistname[0] = (char*) malloc(PATH_MAX*sizeof(char));
                realpath(argv[i],filelistname[0]);
                OPTION_MASK |= FILE_LIST_MASK;
                break;
              case '2':
                nProjects++;
                filelistname[1] = (char*) malloc(PATH_MAX*sizeof(char));
                realpath(argv[i],filelistname[1]);
                OPTION_MASK |= FILE_LIST_MASK;
                break;
              }
            } else {
              showHelp();
            }
          } else {
            showHelp();
          }
          break;
        case 'h':
          if (*++c) {
            if (++i<argc && argv[i]) {
              switch (*c) {
              case '1':
                OPTION_MASK |= SINGLE_SYMB_MASK;
                symb_file = (char*) malloc(PATH_MAX*sizeof(char));
                realpath(argv[i],symb_file);
                break;
              case '2':
                OPTION_MASK |= MULTIPLE_SYMB_MASK;
                symb_dir = (char*) malloc(PATH_MAX*sizeof(char));
                realpath(argv[i],symb_dir);
                break;
              case '3':
                OPTION_MASK |= SINGLE_GRID_MASK;
                grid_file = (char*) malloc(PATH_MAX*sizeof(char));
                realpath(argv[i],grid_file);
                break;
              case '4':
                OPTION_MASK |= MULTIPLE_GRID_MASK;
                grid_dir = (char*) malloc(PATH_MAX*sizeof(char));
                realpath(argv[i],grid_dir);
                break;
              }
            } else {
              showHelp();
            }
          } else {
            showHelp();
          }
          break;
        case 'o':
          if (!strcmp(c,"oem")) {
            oem = true;
            ins_dir = _strdup(".");
            img_dir = _strdup(".\\img");

            OPTION_MASK |= OEM_MASK;
          } else {
            showHelp();
          }
          break;
        case 'r':
          break;
        case 'x':
          if (++i<argc && argv[i]) {
            xmlfile = (char*) malloc(PATH_MAX*sizeof(char));
            realpath(argv[i],xmlfile);
            OPTION_MASK |= XML_MASK;
          } else {
            showHelp();
          }
          break;
        case 'C':
          break;
        case 'H':
          break;
        case 'L':
          break;
        case 'O':
          break;
        default:
          break;
        }

      } else if (argv[i]) {
        // Name must come at the end
        projname = (char*) malloc(MYSQL_PARAM_SIZE*sizeof(char));
        strcpy_s(projname, MYSQL_PARAM_SIZE, argv[i]);
      }
    }
  }

  if ((musername && !mpassword) || (!musername && mpassword)) {
    cout << "If specifying MySQL user/password details you must specify both -u and -p." << endl;
    showHelp();
  }

  if (!projname) {
    cout << "You must enter a Project Name (at the end, after all options)." << endl;
    showHelp();
  } else if (!nProjects && !symb_dir && !csvfile && !xmlfile) {
    cout << "You must either use -fX to specify projects, or use a reporting option." << endl;
    showHelp();
  }

  if (!servername) {
    servername = (char*) malloc(MYSQL_PARAM_SIZE*sizeof(char));
    strcpy_s(servername, MYSQL_PARAM_SIZE, "localhost");
    bLocalDb = true;
  }

  if (!musername) {
    musername = (char*) malloc(MYSQL_PARAM_SIZE*sizeof(char));
    strcpy_s(musername, MYSQL_PARAM_SIZE, "root");
  }

  if (!mpassword) {
    mpassword = (char*) malloc(MYSQL_PARAM_SIZE*sizeof(char));
    strcpy_s(mpassword, MYSQL_PARAM_SIZE, "");
  }
}

void initFileSource(int index=0) {
  if (OPTION_MASK & FILE_LIST_MASK) {
    if (isFileOk(filelistname[index])) {
      filelist[index].open(filelistname[index]);
    } else {
      exit(1);
    }
  }
}

void closeFileSource(int index=0) {
  if (filelist[index].is_open()) {
    filelist[index].close();
  }
}


bool setupDir(const char *dir) {

  struct stat buf;
  if (stat(dir,&buf)!=0) {
    if (!autocreate) {
      cout << dir << " does not exist: do you want to create it? [y/n]" << flush;

      string s;
      cin >> s;

      if ((s!="y") && (s!="Y")) {
        return false;
      }
    }
  }

  char *dir1 = _strdup(dir);
  char *dir2 = _strdup(dir);

  char *c1 = dir1;

  while (*c1!='\0') {

    while (*c1!='\\' && *c1!='/' && *c1!='\0') c1++;

    if (*c1!='\0') {
      *c1='\0';
      MkDir(dir1);
      *c1='/';

      c1++;
    } else {
      MkDir(dir1);
    }
  }

  return true;
}

bool setupFile(const char *file) {
  char *file1 = _strdup(file);
  char *c1 = file1;

  while (*c1!='\0') c1++;

  while (*c1!='\\' && *c1!='/' && c1!=file1) c1--;

  if (c1!=file1) {
    *c1 = '\0';

    return setupDir(file1);
  }

  return true;
}


bool analyse(string &filename) {
  nLOC = 0;

  // Open to count lines
  FILE *src;
  fopen_s(&src, filename.c_str(),"r");
  if (src == NULL)   {
    fprintf(stderr,"Error - cannot open %s\n", filename.c_str());
    return false;
  }
  while (fgets(lbuf, LMAX, src)) ++nLOC;
  if ((nLOC > 0) && (lbuf[strlen(lbuf)-1] == 10)) ++nLOC;   // All-important increment!
  fclose(src);

  // Reopen to parse
  fopen_s(&src, filename.c_str(), "r");
  if (src == NULL)   {
    fprintf(stderr,"Error - cannot open %s\n", filename.c_str());
    return false;
  }

  // Select correct lexer
  switch (lang.getLanguage()) {
    case LANG_CPP:
      yyin_c = src;
      lexclear_c();
      yylex_c();
      break;
    case LANG_CS:
      yyin_cs = src;
      lexclear_cs();
      yylex_cs();
      break;
    case LANG_JAVA:
      yyin_j = src;
      lexclear_j();
      yylex_j();
      break;
    case LANG_JSP:
      yyin_jsp = src;
      lexclear_jsp();
      yylex_jsp();
      break;
    case LANG_VB:
      yyin_vb = src;
      lexclear_vb();
      yylex_vb();
      break;
    case LANG_S1:
      yyin_s1 = src;
      lexclear_s1();
      yylex_s1();
      break;
    case LANG_ADA:
      yyin_ada = src;
      lexclear_ada();
      yylex_ada();
      break;
    case LANG_PERL:
      yyin_pl = src;
      lexclear_pl();
      yylex_pl();
      break;
    case LANG_ASP:
      yyin_asp = src;
      lexclear_asp();
      yylex_asp();
      break;
    case LANG_PHP:
      yyin_php = src;
      lexclear_php();
      yylex_php();
      break;
    case LANG_IDL:
      yyin_idl = src;
      lexclear_idl();
      yylex_idl();
      break;
    case LANG_VHDL:
      yyin_vhdl = src;
      lexclear_vhdl();
      yylex_vhdl();
      break;
    case LANG_XML:
      yyin_xml = src;
      lexclear_xml();
      yylex_xml();
      break;
    case LANG_JT:
      yyin_jt = src;
      lexclear_jt();
      yylex_jt();
      break;
    case LANG_HTML:
      yyin_ht = src;
      lexclear_ht();
      yylex_ht();
      break;
    case LANG_PYTHON:
      yyin_py = src;
      lexclear_py();
      yylex_py();
      break;
    case LANG_ASM:
      yyin_ay = src;
      lexclear_ay();
      yylex_ay();
      break;
  }

  fclose(src);
  return true;
}



int main(int argc, char* argv[]) {
  int i,e;

  cout << "\nEssential Project Manager (EPM) Version 1.17.000\n"
       << "Copyright (c) 2004,2009 SourceCodeMetrics.com.  All rights reserved.\n\n"
       << "Includes our unique Changed Logical Lines of Code (LLOC) metrics\n" << endl;

  char szAppPath[MAX_PATH];
  GetModuleFileName(NULL, szAppPath, MAX_PATH);
  strncpy_s(szAppDirectory, MAX_PATH, szAppPath, strrchr(szAppPath, '\\') - (szAppPath-1));
  szAppDirectory[strlen(szAppDirectory)] = '\0';

  if (!validLicense()) {
    cout << "You must have a valid license.dat file." << endl;
    cout << "Please contact laurence.arthur@powersoftware.com." << endl << endl;
    return 1;
  }

  parseCmdLineOptions(argc,argv);

  if (e=xmlConfig()) {
    cerr << "Please correct problems in the XML Config file before proceding [Err:" << e << "]" << endl;
    return 1;
  }

  for (i=0; i<nProjects; i++) {
    initFileSource(i);
  }

  if (bLocalDb) startDatabase(true);

  // Now connect to the current DB
  if (!createDatabase(servername, musername, mpassword, projname, nProjects)) {
    cerr << "There was a problem connecting to the database on server '" << servername << "'." << endl;
    cerr << " * Username [" << musername << "]" << endl;
    cerr << " * Password [" << mpassword << "]" << endl;
    return 1;
  }

  if (OPTION_MASK & SINGLE_GRID_MASK) {
    if (!setupFile(grid_file)) {
      OPTION_MASK ^= SINGLE_GRID_MASK;
    }
  }

  if (OPTION_MASK & SINGLE_SYMB_MASK) {
    if (!setupFile(symb_file)) {
      OPTION_MASK ^= SINGLE_SYMB_MASK;
    }
  }

  if (OPTION_MASK & MULTIPLE_GRID_MASK) {
    if (!setupDir(grid_dir)) {
      OPTION_MASK ^= MULTIPLE_GRID_MASK;
    }
  }

  if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
    if (!setupDir(symb_dir)) {
      OPTION_MASK ^= MULTIPLE_SYMB_MASK;
    }
  }

  if (OPTION_MASK & XML_MASK) {
    if (!setupFile(xmlfile)) {
      OPTION_MASK ^= XML_MASK;
    }
  }

  if (nProjects > 0) {
    char sql[QUERY_MAX];
    char mid[QUERY_MAX];
    string filename,filename2;
    string shortname;
    char status;
    int sfid;
    int chop;
    int pct;
    int lastpct=-1;
    long mvalue;
    long metid;

    // Metrics Analysis
    for (i=0; i<nProjects; i++) {
      sprintf_s(sql, "select sfid,sf_name,sf_shortname,sf_type from sourcefile where projid=%d", (i+1));
      chop = strlen(relpath[i]);

      if (projDb.executeQuery(string(sql))) {
        for (int r=0; r<projDb.rows(); r++) {
          sfid = projDb.longCell(r,0);
          filename = projDb.cell(r,1);
          shortname = projDb.cell(r,2);
          lang.setLanguage(projDb.cell(r,3));

          pct = (int)((double)r/(double)projDb.rows()*100);

          if (validLanguage(lang.getLanguage())) {
            if (pct > lastpct) cout << "file " << sfid << ":" << shortname << " - " << lang.getDescription() << " (" << pct << "%)" << endl;

            if (analyse(filename)) {
              setMetrics(sfid, filename);
            }
          }
          lastpct = pct;
        }

        closeFileSource(i);
        projDb.clearResults();
      }
    }

    // Perform Unix Diff
    if (nProjects == 2) {
      strcpy_s(sql, QUERY_MAX, "SELECT cf.sfid, cf.sfid2, sf1.sf_name, sf1.sf_shortname, sf1.sf_type, sf2.sf_name sf_name2 FROM comparefile cf, sourcefile sf1, sourcefile sf2 WHERE cf.sfid = sf1.sfid AND cf.sfid2 = sf2.sfid AND cf.status = 'C'");
      lastpct = -1;
      if (projDb.executeQuery(string(sql))) {
        for (int r=0; r<projDb.rows(); r++) {
          sfid = projDb.longCell(r,0);
          filename = projDb.cell(r,2);
          shortname = projDb.cell(r,3);
          lang.setLanguage(projDb.cell(r,4));
          filename2 = projDb.cell(r,5);

          pct = (int)((double)r/(double)projDb.rows()*100);

          if (validLanguage(lang.getLanguage())) {
            if (pct > lastpct) cout << "diff " << sfid << ":" << shortname << " (" << pct << "%)" << endl;
            calcDiff(sfid, filename, filename2);
          }
          lastpct = pct;
        }
        projDb.clearResults();
      }

      strcpy_s(sql, QUERY_MAX, "SELECT cf.sfid, cf.status, sm.mvalue, sf1.sf_type, sm.mid ");
      strcat_s(sql, QUERY_MAX, "FROM sourcefile sf1, comparefile cf, sourcemetric sm ");
      strcat_s(sql, QUERY_MAX, "WHERE sf1.sfid = cf.sfid ");
      strcat_s(sql, QUERY_MAX, "AND cf.sfid = sm.sfid ");
      sprintf_s(mid, QUERY_MAX, "AND sm.mid IN (%d,%d) ", SLOC, NSC);
      strcat_s(sql, QUERY_MAX, mid);
      strcat_s(sql, QUERY_MAX, "AND cf.status in ('A','D') ");

      lastpct = -1;
      if (projDb.executeQuery(string(sql))) {
        for (int r=0; r<projDb.rows(); r++) {
          sfid = projDb.longCell(r,0);
          status = projDb.cell(r,1).c_str()[0];
          mvalue = projDb.longCell(r,2);
          lang.setLanguage(projDb.cell(r,3));
          metid = projDb.longCell(r,4);

          pct = (int)((double)r/(double)projDb.rows()*100);

          if (validLanguage(lang.getLanguage())) {
            if (pct > lastpct) cout << "add/del " << sfid << " (" << pct << "%)" << endl;
            calcAddDel(sfid, status, metid, (float)mvalue);
          }
          lastpct = pct;
        }
        projDb.clearResults();
      }
    }
  }

  // Reporting
  if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
    HTMLReport hr(projDb, symb_dir);
    if (OPTION_MASK & METRICS_SET_MASK) hr.setMetricsSet(metricsset);
    hr.execute();
  }

  if (OPTION_MASK & CSV_MASK) {
    CSVReport csv(projDb, csvfile);
    if (OPTION_MASK & METRICS_SET_MASK) csv.setMetricsSet(metricsset);
    csv.execute();
  }

  if (OPTION_MASK & XML_MASK) {
    XMLReport xml(projDb, xmlfile);
    if (OPTION_MASK & METRICS_SET_MASK) xml.setMetricsSet(metricsset);
    xml.execute();
  }

  closeDatabase();
  if (bLocalDb) stopDatabase();
  return 0;
}

