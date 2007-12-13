/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * HTML Reporting
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  02-Jan-05  File added.
 * CAM  04-Jan-05  Changed report to use frames.
 * CAM  08-Jan-05  Added Single HTML report.
 * CAM  24-Jan-05  Calculate Halstead metrics on Project.
 * CAM  26-Jan-05  Added formatting for Changed metrics (new table).
 * CAM  31-Jan-05  Added options for Unchanged, Added, Deleted filelists.
 * CAM  31-Jan-05    37 : Changed 'A' and Added to 'N' and New.
 * CAM  03-Feb-05    39 : Added Project Snapshot Date to report, move change calcs to Metrics.
 * CAM  03-Feb-05    40 : Added Changed/Added/Deleted files to Project metrics.
 * CAM  24-Mar-05    82 : Removed redundant code.
 * CAM  24-Mar-05    83 : Represent Project E in 1000s.
 * CAM  26-Mar-05    79 : Moved common code to Report class.
 * CAM  04-May-05    50 : Display Language in report.
 * CAM  28-Nov-05   164 : Check item.isShow().
 * CAM  28-Jan-06   174 : Added link to new epm_chg_ex.pdf.
 * CAM  28-Jan-06   168 : If a MetricSet has been specified, only display chosen metrics.
 * CAM  07-Feb-06   187 : Check getItems() are report error if zero.
 * CAM  26-Mar-06   222 : Added link to new proof_ada.pdf.
 * CAM  01-Jun-06   252 : Re-instate Halstead metrics for Project level, but only show Min/Max/Avg.
 * CAM  18-Jul-06   272 : Added CHG,DEL,ADD LLOC metrics.
 * CAM  18-Jul-06   265 : Added MetricsHelp legend.
 * CAM  19-Jul-06   285 : Change script tag in EPM HTML H2 report to </script>.
 * CAM  20-Jul-06   285 : Changed MetricsHelp to call javascript in the href rather than onclick.
 * CAM  13-Dec-07   328 : Added MetricsDefinitions.pdf.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <fstream>
#include <iostream>
#include <vector>
using namespace std;

#include "HTMLReport.h"
#include "ReportItem.h"
using namespace metrics;

HTMLReport::HTMLReport(OurSQL &db, std::string path) : Report(db, path) {
  setPath();
}

void HTMLReport::htmlStart(ofstream &current, string &title, int border, string &className) {
  current << "<html><head>" << endl
          << "<title>" << title << "</title>" << endl
          << "<link href=style.css rel=stylesheet type=text/css>" << endl
          << "<script language=\"Javascript\" src=\"metrics.js\"></script>" << endl
          << "</head>" << endl
          << "<body ";

  if (className.compare("none")) {
    current << "class=\"" << className << "\" ";
  }

  current << " topmargin=" << border << " leftmargin=" << border << ">" << endl;

  // MetricsHelp Div
  current <<
    "<div id=\"mhTable\" name=\"methelp\" style=\"display:none;position:absolute;\">" << endl <<
    "  <table class=\"mhBox\" onclick=\"smhClose();\" border=0 cellspacing=0 cellpadding=4 width=\"500\">" << endl <<
    "    <tr>" << endl <<
    "      <td class=\"mhMetCode\" width=\"100\" id=\"mhCode\"></td>" << endl <<
    "      <td class=\"mhMetName\" id=\"mhName\"></td>" << endl <<
    "      <td class=\"mhMetName\" width=\"10\"><img width=\"10\" height=\"10\" " <<
            "src=\"http://www.powersoftware.com/img/epm/close_off.gif\" " <<
            "onClick=\"smhClose();return false;\" " <<
            "onMouseOver=\"this.src='http://www.powersoftware.com/img/epm/close_on.gif';\" " <<
            "onMouseOut=\"this.src='http://www.powersoftware.com/img/epm/close_off.gif';\"></td>" << endl <<
    "    </tr>" << endl <<
    "    <tr><td id=\"mhDesc\" colspan=2></td></tr>" << endl <<
    "  </table>" << endl <<
    "</div>" << endl;

}

void HTMLReport::htmlStart(ofstream &current, string &title) {
  string none;
  htmlStart(current, title, 1, none);
}

void HTMLReport::htmlStart(ofstream &current, string &title, int border) {
  string none;
  htmlStart(current, title, border, none);
}

void HTMLReport::htmlStart(ofstream &current, string &title, string &className) {
  htmlStart(current, title, 0, className);
}

void HTMLReport::htmlEnd(ofstream &current) {
  current << "</body></html>" << endl;
}

void HTMLReport::mainTable(ofstream &current) {
  current << "<table border=0 bgcolor=#0066cc cellpadding=0 cellspacing=0 width=\"100%\">"
          << "<tr><td align=left width=\"30\"><a target=_blank href=\"http://www.powersoftware.com/\">"
          << "<img border=0 src=\"http://www.powersoftware.com/img/psloz.png\"></a></td>"
          << "<td class=pageTitle>&nbsp;Essential Project Manager Metrics</td>"
          << "<td align=right>"
          << "<a class=top href=\"project_metrics.html\" target=item onclick=\"parent.nav.location.href='project.html';void(0);\">Project</a>&nbsp;|&nbsp;"
          << "<a class=top href=\"files.html\" target=nav>All Files</a>" << endl;

  if (isPM()) {
    current << "&nbsp;|&nbsp;"
            << "<a class=top href=\"files_un.html\" target=nav>Unchanged Files</a>&nbsp;|&nbsp;"
            << "<a class=top href=\"files_chg.html\" target=nav>Changed Files</a>&nbsp;|&nbsp;"
            << "<a class=top href=\"files_new.html\" target=nav>New Files</a>&nbsp;|&nbsp;"
            << "<a class=top href=\"files_del.html\" target=nav>Deleted Files</a></td></tr>" << endl;
  }

  current << "</table>" << endl;
}

void HTMLReport::projectTable(ofstream &current) {
  int nump = 1;
  if (isPM()) nump++;

  current << "<p class=itemTitle>Project Summary</p>" << endl;
  current << "<table border=1 cellspacing=0 cellpadding=2>" << endl;

  for (int p=0; p<nump; p++) {
    string projTitle = "Project";

    if (isPM()) {
      switch (p) {
        case 0:
          projTitle = "New " + projTitle;
          break;
        case 1:
          projTitle = "Old " + projTitle;
          break;
      }
    }

    current << "<tr><td class=r" << (p+1) << ">" << projTitle << "</td><td>"
            << project[p].getShortName() << "</td></tr>" << endl
            << "<tr><td class=r" << (p+1) << ">Snapshot Date</td><td>"
            << project[p].getText1() << "</td></tr>" << endl
            << "<tr><td class=r" << (p+1) << ">Base Directory</td><td>"
            << project[p].getLongName() << "</td></tr>" << endl;
  }
  current << "</table>" << endl;
}

void HTMLReport::navTable(ofstream &current, vector<ReportItem> &list, ItemStatus itemStatus) {
  current << "<table border=0 cellpadding=2 cellspacing=0>" << endl;
  ReportItem nav;
  bool show = true;
  string className;
  int alternate=0;

  for (long j=0; j<list.size(); j++) {
    nav = list[j];
    show = true;

    char chg = nav.getStatus().c_str()[0];

    switch (chg) {
    case 'A':
      className = " class=diffAdd";
      chg = 'N';
      break;
    case 'C':
      className = " class=diffChg";
      break;
    case 'D':
      className =" class=diffDel";
      break;
    default:
      chg = 32;
      className = "";
      break;
    }

    if ((itemStatus == STATUS_ALL) || (nav.getItemStatus() == itemStatus)) {
      current << "<tr><td width=16 align=center" << className << ">" << chg << "</td>"
              << "<td class=r" << ((alternate++ % 2) + 1) << ">"

              << "<a href=\"" << nav.getReportFile() << "\" target=\"item\">"
              << nav.getShortName() << "</a>"

              << "</td></tr>" << endl;
    }
  }

  current << "</table>" << endl;
}

void HTMLReport::createFrameset() {
  ofstream frame;
  string filename, title;
  ReportItem firstFile = fileList[0];

  // Index page (with frames)
  frame.clear();
  filename = thePath + "index.html";
  frame.open(filename.c_str());
  frame << "<html><head>" << endl
        << "<title>Essential Project Manager - C# Metrics</title>" << endl
        << "</head>" << endl
        << "<frameset rows=34,*,22>" << endl
        << "  <frame name=top src=\"top.html\">" << endl
        << "  <frameset cols=400,*>" << endl
        << "    <frame name=nav src=\"project.html\">" << endl
        << "    <frame name=item src=\"project_metrics.html\">" << endl
        << "  </frameset>" << endl
        << "  <frame name=bot src=\"bot.html\">" << endl
        << "</frameset>" << endl;

  frame.close();
  string className = "pstext";

  // Top bar with Projects, File links
  filename = thePath + "top.html";
  frame.clear();
  frame.open(filename.c_str());
  title = "Top";
  htmlStart(frame, title, className);
  mainTable(frame);
  htmlEnd(frame);
  frame.close();

  // Bottom bar with Copyright
  filename = thePath + "bot.html";
  frame.clear();
  frame.open(filename.c_str());
  title = "Bottom";
  htmlStart(frame, title, className);
  frame << "<table border=0 cellspacing=0 cellpadding=2 width=\"100%\"><tr>" << endl;
  frame << "<td width=\"30%\" align=left><table border=0 cellspacing=0 cellpadding=0><tr>"
        << "<td><img src=\"http://www.powersoftware.com/img/tinypdf.png\"></td>"
        << "<td style=\"padding-left:8px;\"><a class=top href=\"http://www.powersoftware.com/epm/proof_ada.pdf\" target=\"_blank\">Proof of Results</a>"
        << "</td></tr></table></td>" << endl;
  frame << "<td width=\"40%\" align=center class=\"pstext\">Copyright &copy; 2004-2007 Powersoftware.com</td>" << endl;
  frame << "<td width=\"30%\" align=right><table border=0 cellspacing=0 cellpadding=0><tr>"
        << "<td><img src=\"http://www.powersoftware.com/img/tinypdf.png\"></td>"
        << "<td style=\"padding-left:8px;\"><a class=top href=\"http://www.powersoftware.com/epm/MetricsDefinitions.pdf\" target=\"_blank\">Metrics Definitions</a></td>"
        << "<td style=\"padding-left:30px;\"><img src=\"http://www.powersoftware.com/img/tinypdf.png\"></td>"
        << "<td style=\"padding-left:8px;\"><a class=top href=\"http://www.powersoftware.com/epm/epm_chg_ex.pdf\" target=\"_blank\">EPM Changed Metrics</a>"
        << "</td></tr></table></td>" << endl;
  frame << "</tr></table>" << endl;
  htmlEnd(frame);
  frame.close();

  // Project Metrics
  filename = thePath + "project_metrics.html";
  frame.clear();
  frame.open(filename.c_str());
  htmlStart(frame, title, 10);
  metTable(frame, project[0]);
  htmlEnd(frame);
  frame.close();

  // Project Summary
  filename = thePath + "project.html";
  frame.clear();
  frame.open(filename.c_str());
  htmlStart(frame, title, 10);
  projectTable(frame);
  htmlEnd(frame);
  frame.close();

  // Navigation for Files
  filename = thePath + "files.html";
  frame.clear();
  frame.open(filename.c_str());
  title = "Files Navigation";
  htmlStart(frame, title, 5);
  navTable(frame, fileList, STATUS_ALL);
  htmlEnd(frame);
  frame.close();

  // Navigation for Unchanged Files
  filename = thePath + "files_un.html";
  frame.clear();
  frame.open(filename.c_str());
  title = "Unchanged Files Navigation";
  htmlStart(frame, title, 5);
  navTable(frame, fileList, STATUS_UNCHANGED);
  htmlEnd(frame);
  frame.close();

  // Navigation for Changed Files
  filename = thePath + "files_chg.html";
  frame.clear();
  frame.open(filename.c_str());
  title = "Changed Files Navigation";
  htmlStart(frame, title, 5);
  navTable(frame, fileList, STATUS_CHANGED);
  htmlEnd(frame);
  frame.close();

  // Navigation for Added Files
  filename = thePath + "files_new.html";
  frame.clear();
  frame.open(filename.c_str());
  title = "Added Files Navigation";
  htmlStart(frame, title, 5);
  navTable(frame, fileList, STATUS_ADDED);
  htmlEnd(frame);
  frame.close();

  // Navigation for Deleted Files
  filename = thePath + "files_del.html";
  frame.clear();
  frame.open(filename.c_str());
  title = "Deleted Files Navigation";
  htmlStart(frame, title, 5);
  navTable(frame, fileList, STATUS_DELETED);
  htmlEnd(frame);
  frame.close();
}

void HTMLReport::metTd(ofstream &current, ReportItem &currItem, int metId) {

  char itemType = 'P';
  if (currItem.getType() == ITEM_FILE) {
    itemType = 'F';
  }

  if (isSetMember(METID(metId))) {
    current << "<td class=metCode title=\"" << metDesc[metId] <<  "\">" <<
      "<a href=\"javascript:smh('" << itemType << "','" << METID(metId) << "');\">" << metCode[metId] << "</a>";
  } else {
    current << "<td class=metCode>&nbsp;</td>";
  }

  current << "</td>" << flush;
}

void HTMLReport::metTdVal(ofstream &current, int metId, long value) {
  string className;

  switch (metId) {
  case MET(CLOC):
  case MET(CLLOC):
  case MET(CFILE):
    className = "diffChg";
    break;
  case MET(DLOC):
  case MET(DLLOC):
  case MET(DFILE):
    className = "diffDel";
    break;
  case MET(ALOC):
  case MET(ALLOC):
  case MET(AFILE):
    className = "diffAdd";
    break;
  default:
    className = "val";
    break;
  }

  if (isSetMember(METID(metId))) {
    current << "<td align=right class=" << className << ">" << value << flush;
  } else {
    current << "<td>&nbsp;" << flush;
  }

  current << "</td>" << flush;
}

void HTMLReport::metTdNA(ofstream &current) {
  current << "<td align=right class=\"na\">-</td>" << flush;
}

void HTMLReport::metTable(ofstream &current, ReportItem &currItem) {
  int i,j;
  Metrics m;
  bool showStandard = true;
  char diffValue[512];
  int vstart=0,vend=MET(NFILE);

  if (currItem.getType() == ITEM_PROJECT) {
    m = projMet;
    current << "<p class=itemTitle>Project Metrics for "
            << currItem.getShortName() << " (" << currItem.getText1() << ")</p>" << endl;
  } else {
    m = met;
    current << "<p class=itemTitle>" << currItem.getShortName() << "<span class=itemType>&nbsp;("
            << currItem.getLangDesc() << ")</span></p>" << endl;
  }

  if (isPM()) {
    showStandard = ((currItem.getItemStatus() != STATUS_UNCHANGED || currItem.getType() == ITEM_PROJECT)  && isAnyChanged(currItem.getLastMetric()));

    current << "<table border=1 cellspacing=0 cellpadding=2>"
            << "<tr><th class=metHead width=70>Metric</th>";

    if (currItem.getItemStatus() == STATUS_CHANGED || currItem.getType() == ITEM_PROJECT) {
      current << "<th class=metHead width=90>Old</th>"
              << "<th class=metHead width=90>New</th>"
              << "<th class=metHead width=90>Diff</th></tr>" << endl;
    } else {
      current << "<th class=metHead width=90>Value</th></tr>" << endl;
    }

    for (i=0; i<MET(CLOC); i++) {
      if (m.isShow(currItem, i) && isSetMember(METID(i))) {
        metTd(current, currItem, i);
        float diff = (m.get(i,0) - m.get(i,1));

        if (diff != 0) {
          sprintf(diffValue, "%+d", (long)diff);
        } else {
          strcpy(diffValue, "&nbsp;");
        }

        if (currItem.getItemStatus() == STATUS_CHANGED || currItem.getType() == ITEM_PROJECT) {
          current << "<td class=val>" << (long) m.get(i,1) << "</td><td class=val>"
                  << (long) m.get(i,0) << "</td><td class=val>" << diffValue << "</td></tr>" << endl;
        } else {
          if (currItem.getItemStatus() == STATUS_DELETED) {
            j=1;
          } else {
            j=0;
          }

          current << "<td class=val>" << (long) m.get(i,j) << "</td></tr>" << endl;
        }
      }
    }

    current << "</table>";

    if (showStandard) {
      current << "<p class=itemTitle>Changed Metrics</p>" << endl;
      vstart = MET(CLOC);
      vend = MET(currItem.getLastMetric());
    }
  }

  string className;
  bool projectCompare = false;

  if (showStandard) {
    current << "<table border=1 cellspacing=0 cellpadding=2>"
            << "<tr><th class=metHead width=90>Metric</th>" << flush;

    if (currItem.getType() == ITEM_PROJECT && !isPM()) {
      current << "<th class=metHead width=90>Sum</th>"
              << "<th class=metHead width=90>Min</th>"
              << "<th class=metHead width=90>Max</th>"
              << "<th class=metHead width=90>Avg</th>" << endl;
    } else {
      current << "<th class=metHead width=90>Value</th>" << endl;
    }

    for (i=vstart; i<=vend; i++) {
      if (isSetMember(METID(i))) {
        current << "<tr>" << endl;

        bool showMet = true;
        if ((i >= MET(CLLOC)) && (i <= MET(ALLOC))) {
          showMet = currItem.getLang().hasLogicalLines();
        }

        if ((showMet && m.isShow(currItem, i)) || currItem.getType() == ITEM_PROJECT) {
          metTd(current, currItem, i);

          if (m.isShow(currItem, i)) {
            metTdVal(current, i, (long) m.get(i,0));
          } else {
            metTdNA(current);
          }

          if (currItem.getType() == ITEM_PROJECT && !isPM()) {
            if (m.isShow(ITEM_FILE, i)) {
              metTdVal(current, i, (long) m.get(i,2));
              metTdVal(current, i, (long) m.get(i,3));
              metTdVal(current, i, (long) m.get(i,4));
            } else {
              metTdNA(current);
              metTdNA(current);
              metTdNA(current);
            }
          }

          current << "</tr>" << endl;
        }
      }
    }

    current << "</table>" << endl;
  }
}

void HTMLReport::executeHTML() {
  ofstream current;
  string fname;

  if (getItems() == 0) {
    cout << "No source files found... " << flush;
    return;
  }

  for (int f=0; f<fileList.size(); f++) {
    current.clear();
    current.open(fileList[f].getReportFile(thePath).c_str()) ;
    htmlStart(current, fileList[f].getShortName(), 10);

    getMetrics(fileList[f]);
    metTable(current, fileList[f]);

    htmlEnd(current);
    current.close();
  }

  calculateProjectMetrics();

  createFrameset();
}

void HTMLReport::execute() {
  if (isPM()) {
    cout << "HTML PM Report... " << flush;
  } else {
    cout << "HTML single project Report... " << flush;
  }

  executeHTML();
  cout << "Done." << endl;
}