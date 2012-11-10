/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Krakatau Essential Metrics (EMETRICS.EXE)
* Copyright (c) 2000,2008 Power Software
* Author Craig McKay <craig@frontburner.co.uk>
*
* $Id$
*
* Who  When       Why
* CAM  28-Mar-08  348 : File added to source control.
* CAM  14-Apr-08  353 : Added program information block, including version 1.00.002.
* CAM  20-Apr-08  354 : Ensure all parameters are passed to the metrics.exe thread.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "batch.h"
#include "math.h"

using namespace std ;
using namespace metrics ;

// Global Variables

int OPTION_MASK = 0 ;     // mask for options given at the command line
int METRIC_MASK = 0 ;     // mask for metrics chosen at the command line

char *img_dir = NULL ;
char *ins_dir = NULL ;

int nProjects = 0 ;

char *projname[PROJECT_MAX] ;
char *filelistname[PROJECT_MAX] ;
char *directory[PROJECT_MAX] ;
ifstream filelist[PROJECT_MAX] ;

char *csvfile = NULL ;

char *xmlfile = NULL ;

char *symb_dir = NULL ;
char *grid_dir = NULL ;
char *symb_file = NULL ;
char *grid_file = NULL ;

bool autocreate = false ;


char **files = NULL ;
int nfiles = 0 ;

char *tmp_file = NULL ;

bool eval=false ;
const int EVAL_FILE_MAX = 5 ;

//ofstream sql_log("sql.txt") ;

void showHelp(int source) {

  cout << "\nUsage: emetrics [options] name" << endl;

  cout << "\nOptions\n" << endl ;
  cout << "   -c  csv_file     Create CSV report." << endl ;

#ifdef PM
  cout << "   -d  dir          Select files relative to <dir>." << endl ;
  cout << "   -f1 filelist     Filelist containing NEW project." << endl ;
  cout << "   -f2 filelist     Filelist containing OLD project." << endl ;
#else
  cout << "   -f  filelist     Obtain files from the given file list." << endl ;
#endif

  cout << "   -h1 html_file    Create single page HTML report." << endl ;
  cout << "   -h2 html_dir     Create multiple page HTML report." << endl ;
  cout << "   -h3 html_file    Create single page HTML report (grid)." << endl ;
  cout << "   -h4 html_dir     Create multiple page HTML report (grid)." << endl ;
  cout << "   -x  xml_file     Create XML report." << endl ;
  //  cout << "   -r        Recursively include (sub) directories." << endl ;
  //  cout << "   -C        Include complexity metrics." << endl ;
  //  cout << "   -H        Include halstead metrics." << endl ;
  //  cout << "   -L        Include line counting metrics (default)." << endl ;
  //  cout << "   -O        Include object oriented metrics." << endl ;
  cout << "   -?               Show this help screen." << endl ;

  cout << "\nName" << endl ;
  cout << "\nA name to give the project." << endl  ;

  cout << "\nSource of error: " << source << endl;

  //  cout << "\nFiles\n" << endl ;
  //  cout << "<files> is either a list of files (including wildcards)" ;
  //  cout << "\nor, if the -f option has been a given, the path of a file" ;
  //  cout << "\nwhich contains a list of files. NOTE: when using the -d" ;
  //  cout << "\noption all relative filenames will be relative to the given" ;
  //  cout << "\ndirectory." << endl ;

  exit(1) ;
}

void verifyName(int index=0) {
  for (char *c=projname[index] ; *c!='\0' ; c++) {
    if (*c==' ') *c='_' ;
  }
}

void validateSQL(char *sql) {
  for (char *c=sql ; *c!='\0' ; c++) {
    if (*c=='\\') *c='/' ;
  }
}

void fileCopy(const char *source, const char *target) {
  ifstream in( source, ios::binary) ;
  ofstream out( target, ios::binary ) ;

  int c=0 ;

  while (!in.eof()) {
    in.read((char*) &c,1) ;
    out.write((char*) &c,1) ;
  }

  in.close( ) ;
  out.close( ) ;
}

void parseCmdLineOptions(int argc, char *argv[]) {

  bool gotName = false;
  int nProjName = 0;
  bool oem = false;

  cout << "\nEssential Metrics (EM) Version 1.00.002\n"
    << "Copyright (c) 2001,2008 SourceCodeMetrics.com.  All rights reserved.\n" << endl;

  for (int i=1 ; i<argc ; i++) {

    if (argv[i]) { // Check not NULL

      char *c ;
      if (argv[i][0]=='-') {
        c = argv[i] + 1;

        switch (*c) {
        case 'a':
          if (!strcmp(c,"auto")) {
            // Automatically create directories that do not exist
            autocreate = true ;
          } else {
            showHelp(1) ;
          }
          break ;
        case 'c':
          if (++i<argc && argv[i]) {
            csvfile = (char*) malloc(PATH_MAX*sizeof(char)) ;
            realpath(argv[i],csvfile) ;
            OPTION_MASK |= CSV_MASK ;
          } else {
            showHelp(2) ;
          }
          break ;
#ifndef PM
        case 'd':
          if (++i<argc && argv[i]) {
            directory[0] = (char*) malloc(PATH_MAX*sizeof(char)) ;
            realpath(argv[i],directory[0]) ;
            OPTION_MASK |= DIR_MASK ;
          } else {
            showHelp(3) ;
          }
          break ;
#endif
        case 'f':
#ifdef PM
          if (*++c) {
            if (++i<argc && argv[i]) {
              switch (*c) {
        case '1':
          nProjects++ ;
          filelistname[0] = (char*) malloc(PATH_MAX*sizeof(char)) ;
          realpath(argv[i],filelistname[0]) ;
          OPTION_MASK |= FILE_LIST_MASK ;
          break ;
        case '2':
          nProjects++ ;
          filelistname[1] = (char*) malloc(PATH_MAX*sizeof(char)) ;
          realpath(argv[i],filelistname[1]) ;
          OPTION_MASK |= FILE_LIST_MASK ;
          break ;
              }
            } else {
              showHelp(4) ;
            }
          } else {
            showHelp(5) ;
          }
#else
          if (++i<argc && argv[i]) {
            filelistname[0] = (char*) malloc(PATH_MAX*sizeof(char)) ;
            realpath(argv[i],filelistname[0]) ;
            OPTION_MASK |= FILE_LIST_MASK ;
            nProjects = 1 ;
          } else {
            showHelp(6) ;
          }
#endif
          break ;
        case 'h':
          if (*++c) {
            if (++i<argc && argv[i]) {
              switch (*c) {
        case '1':
          OPTION_MASK |= SINGLE_SYMB_MASK ;
          symb_file = (char*) malloc(PATH_MAX*sizeof(char)) ;
          realpath(argv[i],symb_file) ;
          break ;
        case '2':
          OPTION_MASK |= MULTIPLE_SYMB_MASK ;
          symb_dir = (char*) malloc(PATH_MAX*sizeof(char)) ;
          realpath(argv[i],symb_dir) ;
          break ;
        case '3':
          OPTION_MASK |= SINGLE_GRID_MASK ;
          grid_file = (char*) malloc(PATH_MAX*sizeof(char)) ;
          realpath(argv[i],grid_file) ;
          break ;
        case '4':
          OPTION_MASK |= MULTIPLE_GRID_MASK ;
          grid_dir = (char*) malloc(PATH_MAX*sizeof(char)) ;
          realpath(argv[i],grid_dir) ;
          break ;
              }
            } else {
              showHelp(7) ;
            }
          } else {
            showHelp(8) ;
          }
          break ;
        case 'o':
          if (!strcmp(c,"oem")) {
            oem = true ;
            ins_dir = _strdup(".") ;
            img_dir = _strdup(".\\img") ;

            OPTION_MASK |= OEM_MASK ;
          } else {
            showHelp(9) ;
          }
          break ;
        case 'r':
          break ;
        case 'x':
          if (++i<argc && argv[i]) {
            xmlfile = (char*) malloc(PATH_MAX*sizeof(char)) ;
            realpath(argv[i],xmlfile) ;
            OPTION_MASK |= XML_MASK ;
          } else {
            showHelp(10) ;
          }
          break ;
        case 'C':
          break ;
        case 'H':
          break ;
        case 'L':
          break ;
        case 'O':
          break ;
        default:
          break ;
        }

      } else if (nProjName < nProjects) {
        // Name must come at the end
        if (i<argc-nProjects) showHelp(11) ;
        projname[nProjName++] = argv[i] ;

      } else {
        cout << "arg " << i << ":" << argv[i] << endl;
        showHelp(12) ;
      }

    }

  }

  if (!nProjects || nProjects!=nProjName || (!nProjects && !oem)) {
    showHelp(13) ;
  }

}

void initFileSource(int index=0) {

  struct stat buf;

  if (OPTION_MASK & FILE_LIST_MASK) {

    if (stat(filelistname[index],&buf)!=0) {
      cout << filelistname[index] << " could not be found." << endl ;
      exit(1) ;
    } else {
      filelist[index].open(filelistname[index]) ;
    }
  }
}

bool getNextFiles(char *buff, int bsize, int index=0) {

  int size = 0 ;
  int count = 0 ;
  strcpy(buff,"") ;

  if (OPTION_MASK & FILE_LIST_MASK) {

    if (tmp_file) {
      size = strlen(tmp_file) ;
      strcat(buff,"('") ;
      strcat(buff,tmp_file) ;
      strcat(buff,"',1),") ;
      size += 7 ;
      count++ ;

      free (tmp_file) ;
      tmp_file = NULL ;
    }

    char fn_buff[PATH_MAX] ;
    char fn_res[PATH_MAX] ;

    void *ret = filelist[index].getline(fn_buff,PATH_MAX) ;

    if (ret) {
      if (strlen(fn_buff)) {
        realpath(fn_buff,fn_res) ;
        size += strlen(fn_res) ;
        size += 7 ;
      }

      while (size<bsize && ret) {
        if (strlen(fn_buff)) {
          strcat(buff,"('") ;
          strcat(buff,fn_res) ;
          strcat(buff,"',1),") ;
        }

        ret = filelist[index].getline(fn_buff,PATH_MAX) ;

        if (strlen(fn_buff)) {
          count++ ;
          if (eval && count>=EVAL_FILE_MAX) break ;

          realpath(fn_buff,fn_res) ;
          size += strlen(fn_res) ;
          size += 7 ;
        }
      }

      buff[strlen(buff)-1] = '\0' ;

      if (fn_res) {
        tmp_file = _strdup(fn_res) ;
      }
    }

    return size>0 ;
  }

  return false ;
}

bool setupDir(const char *dir) {

  struct stat buf;
  if (stat(dir,&buf)!=0) {
    if (!autocreate) {
      cout << dir << " does not exist: do you want to create it? [y/n]" << flush ;

      string s;
      cin >> s ;

      if ((s!="y") && (s!="Y")) {
        return false ;
      }
    }
  }

  char *dir1 = _strdup(dir) ;
  char *dir2 = _strdup(dir) ;

  char *c1 = dir1 ;

  while (*c1!='\0') {

#ifdef WIN32
    while (*c1!='\\' && *c1!='/' && *c1!='\0') c1++ ;
#else
    while (*c1!='/' && *c1!='\0') c1++ ;
#endif

    if (*c1!='\0') {
      *c1='\0' ;
      MkDir(dir1) ;
      *c1='/' ;

      c1++ ;
    } else {
      MkDir(dir1) ;
    }
  }

  return true ;
}

bool setupFile(const char *file) {
  char *file1 = _strdup(file) ;
  char *c1 = file1 ;

  while (*c1!='\0') c1++ ;

#ifdef WIN32
  while (*c1!='\\' && *c1!='/' && c1!=file1) c1-- ;
#else
  while (*c1!='/' && c1!=file) c1-- ;
#endif

  if (c1!=file1) {
    *c1 = '\0' ;

    return setupDir(file1) ;
  }

  return true ;
}

void copyImages(const char* dir) {
  char source_buff[PATH_MAX] ;
  char target_buff[PATH_MAX] ;

  // Create the image dir

  strcpy(target_buff,dir) ;
  strcat(target_buff,"/img") ;

  MkDir(target_buff) ;

  // Now copy the files.

  strcpy(source_buff,img_dir) ;
  strcat(source_buff,"/") ;
  strcat(source_buff,"up.gif") ;

  strcpy(target_buff,dir) ;
  strcat(target_buff,"/img/") ;
  strcat(target_buff,"up.gif") ;

  fileCopy(source_buff,target_buff) ;

  strcpy(source_buff,img_dir) ;
  strcat(source_buff,"/") ;
  strcat(source_buff,"back.gif") ;

  strcpy(target_buff,dir) ;
  strcat(target_buff,"/img/") ;
  strcat(target_buff,"back.gif") ;

  fileCopy(source_buff,target_buff) ;

  strcpy(source_buff,img_dir) ;
  strcat(source_buff,"/") ;
  strcat(source_buff,"forward.gif") ;

  strcpy(target_buff,dir) ;
  strcat(target_buff,"/img/") ;
  strcat(target_buff,"forward.gif") ;

  fileCopy(source_buff,target_buff) ;

  strcpy(source_buff,img_dir) ;
  strcat(source_buff,"/") ;
  strcat(source_buff,"pslogo.gif") ;

  strcpy(target_buff,dir) ;
  strcat(target_buff,"/img/") ;
  strcat(target_buff,"pslogo.gif") ;

  fileCopy(source_buff,target_buff) ;

}

#define PAGE_SIZE 10
#define INDEX_SIZE 5

void createHTMLIndexes(OurSQL *conn, const char *dir, int diff_length, const char *cat_str) {

  char dl[10] ;
  char *qry ;
  //itoa(diff_length+1,dl) ;
  itoa(6,dl) ;

  qry = (char*) malloc(128*sizeof(char)) ;
  strcpy(qry,"select htmID, substring(startname,1,") ;
  strcat(qry,dl) ;
  strcat(qry,") as start, substring(endname,1,") ;
  strcat(qry,dl) ;
  strcat(qry,") as end, pagename from htmlindex") ;

  conn->executeQuery(qry) ;
  free(qry) ;

  int iSize = INDEX_SIZE ;
  int nPages = conn->rows() ;
  int nLevels = 1;//0 ;

  if (nPages<iSize) nLevels=1 ;
  while (iSize<nPages) {
    iSize *= iSize ;
    nLevels++ ;
  }

  string fname = "" ;
  int inc= (int) pow((double)INDEX_SIZE,(double)nLevels) ;

  ofstream index ;
  char ln[20] ;

  for (int i=nLevels,l=0 ; i>0 ; i--,l++) {

    itoa(l,ln) ;
    char mn[20] ;
    for (int j=0,m=0 ; j<nPages ; j+=inc,m++) {
      itoa(m,mn) ;

      int end = ((j+inc)<conn->rows()) ? j+inc : conn->rows() ;
      int nextinc = (int) (inc/INDEX_SIZE) ;

      fname = dir ;
      fname += "/ind/" ;
      fname += ln ;
      fname += "_" ;
      fname += cat_str ;
      fname += "_" ;
      fname += mn ;
      fname += ".html" ;

      index.clear() ;
      index.open(fname.c_str()) ;

      index << "<HTML>\n<HEAD></HEAD>\n\n<BODY>\n" ;
      index << "\t<TABLE WIDTH=\"100%\" HEIGHT=\"100%\" CELLSPACING=0 CELLPADDING=2>\n\n" ;
      index << "\t\t<TR VALIGN=top><TD><TABLE BGCOLOR=\"#000000\" WIDTH=\"100%\" CELLSPACING=2 CELLPADDING=0>\n" ;
      index << "\t\t\t<TR><TD><TABLE WIDTH=\"100%\" CELLSPACING=0 CELLPADDING=4>\n" ;
      index << "\t\t\t\t<TR VALIGN=top BGCOLOR=\"#EEEEFF\">\n" ;
      if (i!=nLevels) {
        index << "\t\t\t\t\t<TD ALIGN=left><A HREF=\"" ;
        index << (l-1) << "_" << cat_str << "_" << (int)(m/inc) << ".html" ;
        index << "\"><IMG SRC=\"../img/up.gif\" BORDER=0></A></TD>\n" ;
        index << "\t\t\t\t\t<TD>Index</TD>\n" ;
      } else {
        index << "\t\t\t\t\t<TD ALIGN=center>Index</TD>\n" ;
      }
      index << "\t\t\t\t</TR>\n" ;
      index << "\t\t\t</TABLE></TD></TR>\n" ;
      index << "\t\t</TABLE></TD></TR>\n\n" ;
      index << "\t\t<TR VALIGN=top ALIGN=center HEIGHT=\"100%\"><TD>" ;


      char nextln[20] ;
      itoa(l+1,nextln) ;

      for (int k=j,n=0 ; k<end ; k+=nextinc,n++) {
        if (i==1) {
          index << "<A\n\t\t\tHREF=\"" << "../" << cat_str << "/" << cat_str << (k+1) << ".html\" TARGET=\"content\">" ;
          index << conn->cell(k,1) << " - " << conn->cell(k,2) ;
          index << "</A><BR>" ;
        } else {
          int last = (k+nextinc)<conn->rows() ? k+nextinc-1 : conn->rows()-1 ;
          index << "<A\n\t\t\tHREF=\"" << nextln << "_" << cat_str << "_" << (int)(k/nextinc) << ".html\">" ;
          index << conn->cell(k,1) << " - " << conn->cell(last,2) ;
          index << "</A><BR>" ;
        }
      }

      index << "</TD>\n" ;
      index << "\t\t</TR>\n\n" ;
      index << "\t\t<TR VALIGN=bottom><TD><TABLE BGCOLOR=\"#000000\" WIDTH=\"100%\" CELLSPACING=2 CELLPADDING=0>\n" ;
      index << "\t\t\t<TR><TD><TABLE WIDTH=\"100%\" CELLSPACING=0 CELLPADDING=4>\n" ;
      index << "\t\t\t\t<TR VALIGN=top BGCOLOR=\"#EEEEFF\">\n" ;
      if (j!=0) {
        index << "\t\t\t\t\t<TD ALIGN=left><A HREF=\"" ;
        index << "../ind/" << l << "_" << cat_str << "_" << (m-1) << ".html" ;
        index << "\"><IMG SRC=\"../img/back.gif\" BORDER=0></A></TD>\n" ;
      }
      if (end!=conn->rows()) {
        index << "\t\t\t\t\t<TD ALIGN=right><A HREF=\"" ;
        index << "../ind/" << l << "_" << cat_str << "_" << (m+1) << ".html" ;
        index << "\"><IMG SRC=\"../img/forward.gif\" BORDER=0></A></TD>\n" ;
      }
      index << "\t\t\t\t</TR></TABLE></TD></TR>\n" ;
      index << "\t\t</TABLE></TD></TR>\n\n" ;
      index << "\t</TABLE>\n\t</BODY>\n</HTML>\n" << endl ;

      index.close() ;
    }

    inc = (int) (inc/INDEX_SIZE) ;
  }

  index.clear() ;

}

void createHTMLIndex(const char *dir, int nCats, char ** const cat_str) {
  string filename(dir) ;
  filename += "/index.html" ;

  ofstream index(filename.c_str()) ;

  index << "<HTML>\n<HEAD>\n</HEAD>\n\n" ;
  index << "<FRAMESET COLS=\"20%,80%\">\n" ;
  index << "\t<FRAMESET ROWS=\"25%,75%\">\n" ;
  index << "\t\t<FRAME SRC=\"ind/categories.html\" NAME=\"cat\">\n" ;
  index << "\t\t<FRAME SRC=\"ind/0_file_0.html\" NAME=\"nav\">\n" ;
  index << "\t</FRAMESET>\n" ;
  index << "<FRAME SRC=\"project/project1.html\" NAME=\"content\">\n" ;
  index << "</FRAMESET>\n" ;
  index << "<NOFRAMES>\n" ;
  index << "\t<H2>This Report requires a frame-enabled browser</H2>\n" ;
  index << "</NOFRAMES>\n" ;
  index << "</HTML>\n" << endl ;

  index.close() ;

  index.clear() ;

  filename = dir ;
  filename += "/ind/categories.html" ;

  index.open(filename.c_str()) ;

  index << "<HTML>\n<HEAD></HEAD>\n\n<BODY>\n" ;
  index << "\t<TABLE WIDTH=\"100%\" HEIGHT=\"100%\" CELLSPACING=0 CELLPADDING=2>\n\n" ;
  index << "\t\t<TR VALIGN=top><TD><TABLE BGCOLOR=\"#000000\" WIDTH=\"100%\" CELLSPACING=2 CELLPADDING=0>\n" ;
  index << "\t\t\t<TR><TD><TABLE WIDTH=\"100%\" CELLSPACING=0 CELLPADDING=4>\n" ;
  index << "\t\t\t\t<TR VALIGN=top BGCOLOR=\"#EEEEFF\">\n" ;
  index << "\t\t\t\t\t<TD ALIGN=center>Symbol Types</TD>\n" ;
  index << "\t\t\t\t</TR>\n" ;
  index << "\t\t\t</TABLE></TD></TR>\n" ;
  index << "\t\t</TABLE></TD></TR>\n\n" ;
  index << "\t\t<TR VALIGN=top HEIGHT=\"100%\"><TD><A\n" ;
  for (int i=0 ; i<nCats ; i++) {
    index << "\t\t\tHREF=\"0_"<< cat_str[i] << "_0.html\" target=\"nav\">" << cat_str[i] << "</a><BR><A\n" ;
  }
  index << "\t\t</TR>\n\n" ;

  index << "\t</TABLE>\n</BODY>\n</HTML>\n" << endl ;

  index.close() ;
}

void createPMReport(OurSQL *conn1, OurSQL *conn2) {
}

void createReport(OurSQL *conn, Chosen chosen[]=NULL) {

  // To save wasted db access all of the reports can be created at once

  // These are the fields corresponding to the different types of reports
  ofstream *csv = NULL;

  HTMLWriter *s_grid = NULL;
  HTMLWriter *s_symb = NULL;

  HTMLWriter *m_symb = NULL;
  HTMLWriter *m_grid = NULL;


  // Only create the objects if that type of report is required.
  if (OPTION_MASK & CSV_MASK) {
    cout << "Creating CSV report\n  " << csvfile << "..." << endl;
    csv = new ofstream(csvfile) ;
  }

  // Get the category information
  conn->executeQuery("select distinct c.catid,c.catname from category c inner join symbol s on c.catid=s.catid where c.catid<>8 order by c.catid") ;

  // Setup arrays of categories and catids

  // Create the arrays
  int nCats = conn->rows() ;
  int *cat_id = (int*) malloc(nCats*sizeof(int)) ;
  char **cat_id_str = (char**) malloc(nCats*sizeof(char*)) ;
  char **cat_str = (char**) malloc(nCats*sizeof(char*)) ; ;
  string *singlehtmllinks = new string[nCats] ;

  int FILE_INDEX = -1 ;
  int CLASS_INDEX = -1 ;

  // Populate the arrays
  // Note: cheat - uses hard coded 4 and 5 for file and class

  // Create an array of links for the single html report
  // because this array only needs to be created once
  char tmpdir[PATH_MAX] ;

  if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
    strcpy(tmpdir,symb_dir) ;
    strcat(tmpdir,"/") ;
    strcat(tmpdir,"ind") ;

    MkDir(tmpdir) ;
  }
  if (OPTION_MASK & MULTIPLE_GRID_MASK) {
    strcpy(tmpdir,grid_dir) ;
    strcat(tmpdir,"/") ;
    strcat(tmpdir,"ind") ;

    MkDir(tmpdir) ;
  }

  int i ;
  for (i=0 ; i<nCats ; i++) {

    cat_id[i] = (int) conn->longCell(i,0) ;

    if (cat_id[i] == 4) FILE_INDEX=i ;
    if (cat_id[i] == 5) CLASS_INDEX=i ;

    cat_id_str[i] = _strdup(conn->cell(i,0).c_str()) ;
    cat_str[i] = _strdup(conn->cell(i,1).c_str());

    singlehtmllinks[i] = "<A HREF=\"#" ;
    singlehtmllinks[i] += conn->cell(i,1) ;
    singlehtmllinks[i] += "\">" ;
    singlehtmllinks[i] += conn->cell(i,1) ;
    singlehtmllinks[i] += "</A>" ;

    if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
      strcpy(tmpdir,symb_dir) ;
      strcat(tmpdir,"/") ;
      strcat(tmpdir,cat_str[i]) ;

      MkDir(tmpdir) ;
    }
    if (OPTION_MASK & MULTIPLE_GRID_MASK) {
      strcpy(tmpdir,grid_dir) ;
      strcat(tmpdir,"/") ;
      strcat(tmpdir,cat_str[i]) ;

      MkDir(tmpdir) ;
    }
  }

  if (OPTION_MASK & SINGLE_SYMB_MASK) {
    cout << "Creating Single Page HTML report\n  " << symb_file << "..." << endl;

    s_symb = new HTMLWriter(symb_file,true, true) ;
    s_symb->createNewFile() ;
  }

  if (OPTION_MASK & SINGLE_GRID_MASK) {
    cout << "Creating Single Grid HTML report\n  " << grid_file << "..." << endl;

    s_grid = new HTMLWriter(grid_file,true, true) ;
    s_grid->createNewFile() ;
  }

  if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
    cout << "Creating Multiple Page HTML report in\n  " << symb_dir << "..." << endl;

    createHTMLIndex(symb_dir,nCats,cat_str) ;
  }

  if (OPTION_MASK & MULTIPLE_GRID_MASK) {
    cout << "Creating Multiple Grid HTML report in\n  " << grid_dir << "..." << endl;

    createHTMLIndex(grid_dir,nCats,cat_str) ;
  }

  // Rather than create and free space for a query all the time
  // have one query buffer that is big enough for all of the queries
  char qry[256] ;

  long size=0 ;
  int nMet=0 ;

  for (i=0 ; i<nCats ; i++) {

    // Get the number of symbols for the current category
    strcpy(qry,"select count(*) from reportmethod where catid=") ;
    strcat(qry,cat_id_str[i]) ;
    conn->executeQuery(qry) ;

    size = conn->longCell(0,0) ;

    // Create the metricused temp table
    conn->executeQuery("drop table if exists metricused") ;
    conn->executeQuery("create table if not exists metricused (mttID int not null, mttCode varchar (10) BINARY not null, primary key (mttID) , unique index (mttID))") ;

    strcpy(qry,"insert metricused select m.mttID,t.mttCode from metric m inner join metrictype t on m.mttid=t.mttid where m.mttid like '") ;
    strcat(qry,cat_id_str[i]) ;
    strcat(qry,"%%'") ;
    conn->executeQuery(qry) ;

    // Obtain the metric types for this category
    strcpy(qry,"select mttID,mttCode from metricused order by mttID") ;
    conn->executeQuery(qry) ;

    nMet = conn->rows() ;

    // Create and populate arrays for holding the metric ids
    // and names for this category
    int *met_id = new int[nMet] ;
    string *met_str = new string[nMet] ;

    for (int c=0 ; c<nMet ; c++) {
      met_id[c] = (int) conn->longCell(c,0) ;
      met_str[c] = conn->cell(c,1) ;
    }

    if (OPTION_MASK & CSV_MASK) {
      // Output the header for this category to the file

      *csv << cat_str[i] << "," ;
      for (int j=0 ; j<nMet ; j++) {
        *csv << conn->cell(j,1) << "," ;
      }
      *csv << endl ;
    }

    // MULTIPLE HTML STUFF
    int mindiff = 0 ;

    //TODO - check masks
    // Create the index temporary table for the multi-page reports
    conn->executeQuery("drop table if exists htmlindex") ;
    conn->executeQuery("create table if not exists htmlindex (htmID int AUTO_INCREMENT not null, startname varchar (128) binary not null, endname varchar (128) binary not null, pagename varchar (128) binary not null, primary key (htmID) , unique index (htmID))") ;

    int nPages = (size%PAGE_SIZE)==0 ? (int) size/PAGE_SIZE : size/PAGE_SIZE+1 ;

    if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
      m_symb = new HTMLWriter(symb_dir,cat_str[i],true, true) ;
    }
    if (OPTION_MASK & MULTIPLE_GRID_MASK) {
      m_grid = new HTMLWriter(grid_dir,cat_str[i],true, true) ;
    }

    char psize[10] ;
    itoa(PAGE_SIZE,psize) ;

    if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
      m_symb->multipleHeader() ;
    }

    if (OPTION_MASK & SINGLE_SYMB_MASK) {
      s_symb->singleHeader(string(cat_str[i]),nCats,singlehtmllinks) ;
    }

    if (OPTION_MASK & SINGLE_GRID_MASK) {
      s_grid->singleHeader(string(cat_str[i]),nCats,singlehtmllinks) ;
      s_grid->metricTableHeader(nMet,met_str) ;
    }

    for (int j=0 ; j<nPages ; j++) {
      char jp[20] ;
      itoa(j*PAGE_SIZE,jp) ;

      bool firsttime = true ;
      char *startname, *endname ;

      // Create the symbol table for this category
      conn->executeQuery("drop table if exists reporttmp") ;
      conn->executeQuery("create table if not exists reporttmp (symid int not null, catid int not null, symname varchar (128) not null, psymid int, pcatid int, psymname varchar (128), ppgID int not null, filid int not null, sfname varchar (128), fpgID int not null, primary key (symid) , unique index (symid))") ;

      strcpy(qry,"insert reporttmp select * from reportmethod where catid=") ;
      strcat(qry,cat_id_str[i]) ;
      if (cat_id[i]!=4) {
        strcat(qry," order by symname limit ") ;
      } else {
        strcat(qry," order by sfname limit ") ;
      }
      strcat(qry,jp) ;
      strcat(qry,",") ;
      strcat(qry,psize) ;

      conn->executeQuery(qry) ;

      if (i!=FILE_INDEX) {
        strcpy(qry,"select r.symid,r.symname,r.psymid,r.pcatid,r.psymname,r.ppgid,r.filid,r.sfname,r.fpgid,m.metvalue,u.mttcode,u.mttid from reporttmp r inner join metric m on r.symid=m.symid inner join metricused u on m.mttid=u.mttid order by r.symname,r.symid,m.mttid") ;
      } else {
        strcpy(qry,"select r.symid,r.sfname,r.psymid,r.pcatid,r.psymname,r.ppgid,r.filid,r.symname,r.fpgid,m.metvalue,u.mttcode,u.mttid from reporttmp r inner join metric m on r.symid=m.symid inner join metricused u on m.mttid=u.mttid order by r.sfname,r.symid,m.mttid") ;
      }

      conn->executeQuery(qry) ;

      if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
        m_symb->createNewFile() ;
        m_symb->multipleHeader() ;
      }

      if (OPTION_MASK & MULTIPLE_GRID_MASK) {
        m_grid->createNewFile() ;
        m_grid->multipleHeader() ;
        m_grid->metricTableHeader(nMet,met_str) ;
      }

      string *values = new string[nMet] ;

      for (int k=0 ; k<conn->rows() ; k++) {
        long symid = conn->longCell(k,0) ;
        long oldid = symid ;

        if (OPTION_MASK & CSV_MASK) {
          *csv << conn->cell(k,1) << "," ;
        }

        string clink = "" ;
        string flink = "" ;

        string sclink = "" ;
        string sflink = "" ;

        switch (cat_id[i]) {
        case 7:
          if (conn->longCell(k,3)==5) {
            clink = "<A HREF=\"../" ;
            clink += cat_str[CLASS_INDEX] ;
            clink += "/" ;
            clink += cat_str[CLASS_INDEX] ;
            clink += conn->cell(k,5) ;
            clink += ".html#" ;
            clink += conn->cell(k,2) ;
            clink += "\">" ;
            clink += conn->cell(k,4) ;
            clink += "</A>" ;

            sclink = "<A HREF=\"#" ;
            sclink += conn->cell(k,2) ;
            sclink += "\">" ;
            sclink += conn->cell(k,4) ;
            sclink += "</A>" ;
          }
        case 5:
          flink = "<A HREF=\"../" ;
          flink += cat_str[FILE_INDEX] ;
          flink += "/" ;
          flink += cat_str[FILE_INDEX] ;
          flink += conn->cell(k,8) ;
          flink += ".html#" ;
          flink += conn->cell(k,6) ;
          flink += "\">" ;
          flink += conn->cell(k,7) ;
          flink += "</A>" ;

          sflink = "<A HREF=\"#" ;
          sflink += conn->cell(k,6) ;
          sflink += "\">" ;
          sflink += conn->cell(k,7) ;
          sflink += "</A>" ;
          break ;
        }

        if (i!=FILE_INDEX) {
          if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
            m_symb->symbolHeader(conn->cell(k,1),conn->cell(k,0),clink,flink) ;
          }
          if (OPTION_MASK & SINGLE_SYMB_MASK) {
            s_symb->symbolHeader(conn->cell(k,1),conn->cell(k,0),sclink,sflink) ;
          }
        } else {
          if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
            m_symb->symbolHeader(conn->cell(k,7),conn->cell(k,0),clink,flink) ;
          }
          if (OPTION_MASK & SINGLE_SYMB_MASK) {
            s_symb->symbolHeader(conn->cell(k,7),conn->cell(k,0),sclink,sflink) ;
          }
        }

        if (firsttime) {
          firsttime = false ;
          startname = _strdup(conn->cell(k,1).c_str()) ;
        }

        int metindex=0 ;
        while (symid==oldid)
        {
          while (met_id[metindex]!=conn->longCell(k,11) && metindex<nMet) metindex++ ;
          values[metindex] = conn->cell(k,9) ;

          // Make sure that there are more results
          if (++k<conn->rows())
          {
            symid = conn->longCell(k,0) ;
          }
          else
          {
            //no more results
            symid=-1 ;
          }

          metindex++ ;
        }
        k-- ;

        if (OPTION_MASK & CSV_MASK) {
          for (int cc=0 ; cc<metindex ; cc++) {
            *csv << values[cc] << "," ;
          }
        }

        if (OPTION_MASK & SINGLE_SYMB_MASK) {
          s_symb->symbolMetricTable(nMet,met_str,values) ;
        }
        if (OPTION_MASK & SINGLE_GRID_MASK) {
          s_grid->metricTableRow(conn->cell(k,1),nMet,values) ;
        }

        if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
          m_symb->symbolMetricTable(nMet,met_str,values) ;
        }
        if (OPTION_MASK & MULTIPLE_GRID_MASK) {
          m_grid->metricTableRow(conn->cell(k,1),nMet,values) ;
        }

        if (OPTION_MASK & CSV_MASK) {
          *csv << endl ;
        }

        oldid = symid ;
      }

      delete [] values ;
      // MULTIPLE HTML STUFF
      if (conn->rows()>0) {

        endname = _strdup(conn->cell(conn->rows()-1,1).c_str()) ;
        char *c1 = startname ;
        char *c2 = endname ;
        int l=0 ;
        while (*c1==*c2 && *c1!='\0') {
          l++ ;
          c1++ ;
          c2++ ;
        }

        if (l>mindiff) mindiff = l ;

        char htmlqry[1024] ;
        strcpy(htmlqry,"insert into htmlindex (startname,endname,pagename) values ('") ;
        strcat(htmlqry,startname) ;
        strcat(htmlqry,"','") ;
        strcat(htmlqry,endname) ;
        strcat(htmlqry,"','") ;
        strcat(htmlqry,jp) ;
        strcat(htmlqry,".html')") ;

        conn->executeQuery(htmlqry) ;
      }

      if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
        m_symb->closeFile() ;
      }

      if (OPTION_MASK & MULTIPLE_GRID_MASK) {
        m_grid->metricTableFooter() ;
        m_grid->closeFile() ;
      }

    }

    if (OPTION_MASK & SINGLE_SYMB_MASK) {
      s_symb->closeFile() ;
    }

    if (OPTION_MASK & SINGLE_GRID_MASK) {
      s_grid->metricTableFooter() ;
      s_grid->closeFile() ;
    }

    if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
      createHTMLIndexes(conn,symb_dir,mindiff,cat_str[i]) ;
      copyImages(symb_dir) ;
    }
    if (OPTION_MASK & MULTIPLE_GRID_MASK) {
      createHTMLIndexes(conn,grid_dir,mindiff,cat_str[i]) ;
      copyImages(grid_dir) ;
    }
  }

  if (OPTION_MASK & CSV_MASK) {
    csv->close() ;
  }
}

void createXMLReport(OurSQL *conn, int depth) {

  // Get the category information
  conn->executeQuery("select c.catid,lower(c.catname) from category c") ;

  // Setup arrays of categories and catids

  // Create the arrays
  int nCats = conn->rows() ;

  int *cat_id = new int[nCats] ;
  int cat = -1 ;

  int i ;
  for (i=0 ; i<nCats ; i++) {
    if (cat<conn->intCell(i,0)) cat = conn->intCell(i,0) ;
  }

  char **cat_str = (char**) malloc((cat+1)*sizeof(char*)) ;
  for (i=0 ; i<nCats ; i++) {
    cat_str[conn->intCell(i,0)] = _strdup(conn->cell(i,1).c_str());
  }

  ofstream xml(xmlfile) ;
  xml << "<?xml version='1.0' encoding='UTF-8'?>" << endl ;

  char qry[1024] ;
  char tmp[20] ;

  conn->executeQuery("select count(*) from xmlreport") ;

  long c = conn->longCell(0,0) ;

  int index = 0 ;
  stack<int> id_stack ;

  long old_symid = -1 ;

  long *id_arr = new long[depth] ;
  long *old_parid = new long[depth] ;
  int *old_catid = new int[depth] ;

  index = 0 ;
  for (i=0 ; i<depth ; i++) {
    id_arr[i] = -5 ;
    old_parid[i] = -1 ;
    old_catid[i] = -1 ;
  }

  i=0 ;
  do {
    strcpy(qry,"drop table if exists xmltmp") ;
    conn->executeQuery(qry) ;

    int j;
    strcpy(qry,"create table if not exists xmltmp (xmlID int not null, ") ;
    for (j=0 ; j<depth ; j++) {
      strcat(qry," pID") ;
      itoa(j,tmp);
      strcat(qry,tmp) ;
      strcat(qry," int not null,") ;
    }
    strcat(qry," symID int not null, symParentID int not null, symName varchar (128) binary not null, sytID int not null, catID int not null, prtID int not null, primary key (xmlID), unique index (xmlID))") ;

    conn->executeQuery(qry) ;

    strcpy(qry,"insert xmltmp select * from xmlreport order by xmlID limit ") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry,",10") ;

    conn->executeQuery(qry) ;

    strcpy(qry,"select") ;
    for (j=0 ; j<depth ; j++) {
      strcat(qry," x.pID") ;
      itoa(j,tmp);
      strcat(qry,tmp) ;
      strcat(qry,",") ;
    }
    strcat(qry," x.symid,x.symname,x.catid,t.mttcode,m.metvalue,t.mttid from xmltmp x inner join metric m on x.symid=m.symid inner join metrictype t on m.mttid=t.mttid order by x.xmlID") ;

    conn->executeQuery(qry) ;

    for (j=0 ; j<conn->rows() ; j++) {

      if (old_symid!=conn->longCell(j,depth)) {

        while (old_parid[index]!=conn->intCell(j,index)) {
          xml << "</" << cat_str[old_catid[index]] << ">" << endl ;
          index -- ;
        }

        index++ ;

        xml << "<" << cat_str[conn->intCell(j,depth+2)] ;
        xml << " name=\"" << conn->cell(j,depth+1) << "\">" << endl ;

        old_symid = conn->longCell(j,depth) ;
        old_parid[index] = conn->intCell(j,index) ;
        old_catid[index] = conn->intCell(j,depth+2) ;
      }

      xml << "<metric code=\"" << conn->cell(j,depth+3) ;
      xml << "\" value=\"" << conn->cell(j,depth+4) << "\"/>" << endl ;
    }

    i += 10 ;
  } while (i<c) ;

  for (i=index ; i>0 ; i--) {
    xml << "</" << cat_str[old_catid[i]] << ">" << endl ;
  }

  xml.close();
}

int createXMLTables(OurSQL *conn) {

  char qry[1024] ;
  char tmp[20] ;

  strcpy(qry,"drop table if exists xml0") ;
  conn->executeQuery(qry) ;

  strcpy(qry,"create table if not exists xml0 (symID int not null, pId0 int not null, primary key (symID) , unique index (symID))") ;
  conn->executeQuery(qry) ;

  strcpy(qry,"insert XML0 select symID, symparentid as pID0 from symbol where symid=1") ;
  conn->executeQuery(qry) ;

  int c = 1;
  int i;
  int j;

  for (i=1 ; c>0 ; i++) {

    strcpy(qry,"drop table if exists xml") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    conn->executeQuery(qry) ;

    strcpy(qry,"create table if not exists xml") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry," (symID int not null, pId0 int not null,") ;

    for (j=1 ; j<i+1 ; j++) {
      strcat(qry,"pID") ;
      itoa(j,tmp);
      strcat(qry,tmp) ;
      strcat(qry," int not null, ") ;
    }

    strcat(qry,"primary key (symID) , unique index (symID))") ;
    conn->executeQuery(qry) ;

    strcpy(qry,"insert xml") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry," select s.symID as symID, x.pID0 as pID0,") ;

    for (j=1 ; j<i ; j++) {
      strcat(qry,"x.pID") ;
      itoa(j,tmp);
      strcat(qry,tmp) ;

      strcat(qry," as pID") ;
      itoa(j,tmp);
      strcat(qry,tmp) ;
      strcat(qry,", ") ;
    }

    strcat(qry,"s.symparentid as pID") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry," from xml") ;
    itoa(i-1,tmp);
    strcat(qry,tmp) ;
    strcat(qry," x inner join symbol s on x.symid=s.symparentid where s.catid<>8") ;

    conn->executeQuery(qry) ;

    strcpy(qry,"select count(*) from xml") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    conn->executeQuery(qry) ;

    c = (int) conn->longCell(0,0) ;
  }

  int nTables = i ;

  strcpy(qry,"drop table if exists xml") ;
  conn->executeQuery(qry) ;

  strcpy(qry,"create table if not exists xml (symID int not null, ");

  for (i=0 ; i<nTables ; i++) {
    strcat(qry,"pID") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry," int not null, ") ;
  }

  strcat(qry,"primary key (symID) , unique index (symID))") ;
  conn->executeQuery(qry) ;


  for (i=0 ; i<nTables ; i++) {
    strcpy(qry,"insert XML select symID,") ;

    for (j=0 ; j<i+1 ; j++) {
      strcat(qry," pID") ;
      itoa(j,tmp);
      strcat(qry,tmp) ;
      strcat(qry,", ") ;
    }

    if (j<nTables) {
      strcat(qry," symID,") ;
      j++ ;
    }

    for ( ; j<nTables ; j++) {
      strcat(qry," 0,") ;
    }

    qry[strlen(qry)-1] = '\0' ;
    strcat(qry," from xml") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;

    conn->executeQuery(qry) ;
  }

  strcpy(qry,"drop table if exists xmlreport") ;
  conn->executeQuery(qry) ;

  strcpy(qry,"create table if not exists xmlreport (xmlID int AUTO_INCREMENT not null, ") ;
  for (i=0 ; i<nTables ; i++) {
    strcat(qry," pID") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry," int not null,") ;
  }
  strcat(qry," symID int not null, symParentID int not null, symName varchar (128) binary not null, sytID int not null, catID int not null, prtID int not null, primary key (xmlID), unique index (xmlID))") ;

  conn->executeQuery(qry) ;

  strcpy(qry,"insert xmlreport (symid,") ;
  for (i=0 ; i<nTables ; i++) {
    strcat(qry," pID") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry,",") ;
  }
  strcat(qry," symParentID, symName, sytID, catID, prtID) select x.symid as symid,") ;
  for (i=0 ; i<nTables ; i++) {
    strcat(qry," x.pID") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry," as pID") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry,",") ;
  }
  strcat(qry," s.symParentID as symParentID, s.symName as symName, s.sytID as sytID, s.catID as catID, s.prtID as prtID") ;
  strcat(qry," from xml x inner join symbol s on x.symid=s.symid order by") ;
  for (i=0 ; i<nTables ; i++) {
    strcat(qry," pID") ;
    itoa(i,tmp);
    strcat(qry,tmp) ;
    strcat(qry,",") ;
  }
  qry[strlen(qry)-1] = '\0' ;

  conn->executeQuery(qry) ;

  return nTables ;
}

void analyze() {
  int stdin_save=0,stdout_save=0,pid ;

  stdin_save = dup(0) ;
  stdout_save = dup(1) ;

  // Create pipes
  int writePipe[2];int readPipe[2];

#ifdef WIN32
  if (_pipe(writePipe,102400,_O_BINARY|_O_NOINHERIT)==-1) {
    cout << "Unable to create writePipe." << endl ;
    return ;
  }
  if (_pipe(readPipe,102400,_O_BINARY|_O_NOINHERIT)==-1) {
    cout << "Unable to create readPipe." << endl ;
    return ;
  }
#else
  pipe(writePipe) ;
  pipe(readPipe) ;
#endif

  // Create files to read and write from the pipes
  FILE *childRead =fdopen(readPipe[0],"r");
  FILE *childWrite =fdopen(writePipe[1],"w");

  // Dup the other ends of the pipe so that stdin and stdout
  // of the spawned process are these file descriptors
  dup2(writePipe[0],0) ;
  // shouldn't be commented out but hangs without it
  //dup2(readPipe[1],1) ;

#ifdef WIN32
  cout << "Spawning Metrics Analyser..." << endl;
  if ((pid=_spawnl(_P_NOWAIT,"bin/metrics.exe","bin/metrics.exe","-logfile","log/metrics.log",NULL))==-1) {
    dup2(stdin_save,0) ;
    dup2(stdout_save,1) ;

    // TODO handle the case when the analyser cannot be spawned
  }
#else
  if ((pid=fork())==0) {
    int rval=execl("bin/metrics.exe","bin/metrics.exe","-logfile","log/metrics.log",NULL) ;
  }
#endif
  else
  {
    dup2(stdin_save,0) ;
    dup2(stdout_save,1) ;

    for (int i=0 ; i<nProjects ; i++) {
      fprintf(childWrite,"%s\n",projname[i]);
      if (i==0) {
        fprintf(childWrite,"c:/source/\n");
      } else {
        fprintf(childWrite,"c:/source1/\n");
      }
//#ifdef LANGUAGE_CPP
      fprintf(childWrite,"NULL\n");
//#endif
      fprintf(childWrite,"1\n");
    }
    fprintf(childWrite,"END\n");
    fflush(childWrite) ;

#ifdef WIN32
    _cwait(NULL,pid,NULL) ;
#else
    waitpid(pid,NULL,NULL) ;
#endif
  }

}

void setupDB(OurSQL *conn, int index=0) {

  char *qry ;

  // Create the sourcefile table
  qry = _strdup("drop table if exists sourcefile") ;
  conn->executeQuery(qry) ;
  free(qry) ;

  qry = _strdup("create table if not exists sourcefile ( srfID int AUTO_INCREMENT not null, srfName varchar(255) binary not null, subID int not null, primary key (srfID), unique index(srfID))") ;
  conn->executeQuery(qry) ;
  free(qry) ;

  qry = _strdup("alter table sourcefile add index filename (srfName)") ;
  conn->executeQuery(qry) ;
  free(qry) ;

  qry = _strdup("create table if not exists subproject (subID int not null, parID int not null, subName varchar(255) binary not null,subLevel int not null,symID int not null,primary key (subID), unique index(subID))") ;
  conn->executeQuery(qry) ;
  free(qry) ;

  qry = (char*) malloc(1024*sizeof(char)) ;
  strcpy(qry,"insert into subproject (subID,parID,subName,subLevel,symid) values (1,0,'") ;
  strcat(qry,projname[index]) ;
  strcat(qry,"',1,0)") ;

  conn->executeQuery(qry) ;
  free(qry) ;

  // Now populate the sourcefile table

  int val_index = 46 ; // the index of the start of the values
  qry = (char*) malloc((val_index+QUERY_MAX)*sizeof(char)) ;
  strcpy(qry,"insert into sourcefile (srfName,subID) values ") ;

  char buffer[QUERY_MAX] ;
  getNextFiles(buffer,QUERY_MAX,index) ;
  do {
    validateSQL(buffer) ;

    //sql_log << buffer << endl ;
    qry[val_index] = '\0' ;
    strcat(qry,buffer) ;

    conn->executeQuery(qry) ;
  } while (!eval && getNextFiles(buffer,QUERY_MAX,index)) ;

  free(qry) ;
}

void createTemporaryTables(OurSQL *conn) {
  //create the file temporary table
  conn->executeQuery("drop table if exists numberedfile") ;
  conn->executeQuery("create table if not exists numberedfile ( flnID int AUTO_INCREMENT not null, symid int not null, fname varchar(255) , sfname varchar(255), primary key (flnID), unique index(flnID))") ;

  conn->executeQuery("insert into numberedfile (symid,fname,sfname) select symid,symname,substring_index(symname, '/', -1) as shortname from ancestry where catid=4  order by shortname") ;

  //create the class temporary table
  conn->executeQuery("drop table if exists numberedclass") ;
  conn->executeQuery("create table if not exists numberedclass ( clnID int AUTO_INCREMENT not null, symid int not null, cname varchar(255) , primary key (clnID), unique index(clnID))") ;

  conn->executeQuery("insert into numberedclass (symid,cname) select symid,symname from ancestry where catid=5 order by symname") ;

  conn->executeQuery("drop table if exists reportmethod") ;
  conn->executeQuery("create table if not exists reportmethod (symid int not null, catid int not null, symName varchar (128) not null, psymid int not null, pcatid int not null, psymname varchar (128) , ppgID int not null, filid int not null, sfname varchar (128) , fpgID int not null, primary key (symid) , unique index (symid))") ;

  char *qry = (char*) malloc(4096*sizeof(char)) ;
  char tmp[10] ;
  itoa(PAGE_SIZE,tmp) ;

  strcpy(qry,"insert reportmethod select a.symid as symid,a.catid as catid,a.symname as symname,a.psymid as psymid,a.pcatid as pcatid ,a.psymname as psymname,ceiling(c.clnID/") ;
  strcat(qry,tmp) ;
  strcat(qry,") as ppgID,a.filid as filid,f.sfname as sfname ,ceiling(f.flnID/") ;
  strcat(qry,tmp) ;
  strcat(qry,") as fpgID from ancestry a left outer join numberedfile f on a.filid=f.symid left outer join numberedclass c on a.psymid=c.symid where a.catid<>4 order by a.symname") ;

  conn->executeQuery(qry) ;

  strcpy(qry,"insert reportmethod select a.symid as symid,a.catid as catid,a.symname as symname,a.psymid as psymid,a.pcatid as pcatid ,a.psymname as psymname,ceiling(c.clnID/") ;
  strcat(qry,tmp) ;
  strcat(qry,") as ppgID,a.filid as filid,f.sfname as sfname ,ceiling(f.flnID/") ;
  strcat(qry,tmp) ;
  strcat(qry,") as fpgID from ancestry a left outer join numberedfile f on a.symid=f.symid left outer join numberedclass c on a.psymid=c.symid where a.catid=4 order by f.sfname") ;

  conn->executeQuery(qry) ;

  free(qry) ;
}

void createPMTemporaryTables(OurSQL *conn, int status) {
  // TODO optimize - some of these queries are the same each time
  char *qry = (char*) malloc(4096*sizeof(char)) ;
  char tmp[10] ;

  itoa(status,tmp) ;

  //create the file temporary table
  conn->executeQuery("drop table if exists numberedfile") ;
  conn->executeQuery("create table if not exists numberedfile ( flnID int AUTO_INCREMENT not null, symid int not null, fname varchar(255) , sfname varchar(255), primary key (flnID), unique index(flnID))") ;

  strcpy(qry,"insert into numberedfile (symid,fname,sfname) select a.symid,a.symname,substring_index(a.symname, '/', -1) as shortname from ancestry a inner join symbolcomp s on a.symid=s.symid where a.catid=4 and s.mttStatus=") ;
  strcat(qry,tmp) ;
  strcat(qry," order by shortname") ;
  cout << qry << endl ;
  conn->executeQuery(qry) ;

  //create the class temporary table
  conn->executeQuery("drop table if exists numberedclass") ;
  conn->executeQuery("create table if not exists numberedclass ( clnID int AUTO_INCREMENT not null, symid int not null, cname varchar(255) , primary key (clnID), unique index(clnID))") ;

  strcpy(qry,"insert into numberedclass (symid,cname) select a.symid,a.symname from ancestry a inner join symbolcomp s on a.symid=s.symid where a.catid=5 and s.mttStatus=") ;
  strcat(qry,tmp) ;
  strcat(qry," order by symname") ;
  cout << qry << endl ;
  conn->executeQuery(qry) ;

  conn->executeQuery("drop table if exists reportmethod") ;
  conn->executeQuery("create table if not exists reportmethod (symid int not null, catid int not null, symName varchar (128) not null, psymid int not null, pcatid int not null, psymname varchar (128) , ppgID int not null, filid int not null, sfname varchar (128) , fpgID int not null, primary key (symid) , unique index (symid))") ;

  itoa(PAGE_SIZE,tmp) ;

  strcpy(qry,"insert reportmethod select a.symid as symid,a.catid as catid,a.symname as symname,a.psymid as psymid,a.pcatid as pcatid ,a.psymname as psymname,ceiling(c.clnID/") ;
  strcat(qry,tmp) ;
  strcat(qry,") as ppgID,a.filid as filid,f.sfname as sfname ,ceiling(f.flnID/") ;
  strcat(qry,tmp) ;
  strcat(qry,") as fpgID from ancestry a inner join numberedfile f on a.filid=f.symid left outer join numberedclass c on a.psymid=c.symid where a.catid<>4 order by a.symname") ;

  conn->executeQuery(qry) ;

  strcpy(qry,"insert reportmethod select a.symid as symid,a.catid as catid,a.symname as symname,a.psymid as psymid,a.pcatid as pcatid ,a.psymname as psymname,ceiling(c.clnID/") ;
  strcat(qry,tmp) ;
  strcat(qry,") as ppgID,a.filid as filid,f.sfname as sfname ,ceiling(f.flnID/") ;
  strcat(qry,tmp) ;
  strcat(qry,") as fpgID from ancestry a inner join numberedfile f on a.symid=f.symid left outer join numberedclass c on a.psymid=c.symid where a.catid=4 order by f.sfname") ;

  conn->executeQuery(qry) ;

  free(qry) ;
}

int main(int argc, char* argv[])
{

  int i ;
  parseCmdLineOptions(argc,argv) ;

  //  if (!(OPTION_MASK & OEM_MASK)) {

  for (i=0 ; i<nProjects ; i++) {
    verifyName(i) ;
    initFileSource(i) ;
  }

  if (CHECKOUT(LM_RESTRICTIVE, FEATURE, "1.0", "license.dat")) {
    cout << "\nYou are currently using an unlicensed copy of Essential Metrics." << endl ;
    cout << "\nThis can be used in exactly the same way as the full product, with the exception that that maximum number of files that can be analyzed is " ;
    cout << EVAL_FILE_MAX << "." << endl ;

    eval = true ;
  }

#ifdef WIN32
  HKEY key ;

  char *tmp_reg_path = (char*) malloc(PATH_MAX*sizeof(char)) ;
  unsigned char *tmp_img_dir = (unsigned char*) malloc(PATH_MAX*sizeof(char)) ;
  unsigned char *tmp_ins_dir = (unsigned char*) malloc(PATH_MAX*sizeof(char)) ;

  unsigned long size = PATH_MAX ;
  unsigned long type = -1 ;

#ifdef LANGUAGE_CPP
  tmp_reg_path = _strdup("Software\\Power Software\\Emetrics\\C/C++");
#else
  tmp_reg_path = _strdup("Software\\Power Software\\Emetrics\\Java");
#endif

  LONG success = RegOpenKeyEx(HKEY_LOCAL_MACHINE, tmp_reg_path, 0, KEY_QUERY_VALUE, &key) ;
  if (success == ERROR_SUCCESS) {

    success = RegQueryValueEx( key, "ins_dir", 0, &type, tmp_ins_dir, &size );
    if (success != ERROR_SUCCESS) {
      cout << "Error accessing the registry." << endl ;
      exit(1) ;
    }

    size = MAX_PATH ;

    success = RegQueryValueEx( key, "img_dir", 0, &type, tmp_img_dir, &size );
    if (success != ERROR_SUCCESS) {
      cout << "Error accessing the registry." << endl ;
      exit(1) ;
    }

    ins_dir = _strdup((char*)tmp_ins_dir) ;
    img_dir = _strdup((char*)tmp_img_dir) ;

    RegCloseKey(key) ;
  } else {
    cout << "Cannot access the registry." << endl ;
    exit(1) ;
  }
#endif

  //  }

  // Start the Database
  // Note: showHelp() automatically exits - however it is only called
  // in parseCmdLineOptions(...) so the db will always be killed

#ifdef WIN32

  OSVERSIONINFO oi;
  oi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO) ;

  HANDLE dbPID ;

  if (!(OPTION_MASK & OEM_MASK)) {

    string db = ins_dir ;
    GetVersionEx(&oi) ;
    if (oi.dwPlatformId==VER_PLATFORM_WIN32_WINDOWS) {
      db += "/db/bin/mysqld.exe" ;
    } else if (oi.dwPlatformId==VER_PLATFORM_WIN32_NT) {
      db += "/db/bin/mysqld-nt.exe --standalone" ;
    } else {
      return -1 ;
    }

    dbPID = createProcess(db) ;

    if (dbPID == NULL) {
      cout << db << endl;
      cout << "Cannot start the database, please contact Power Software." << endl ;
      exit(-1) ;
    }

    cout << "Database started." << endl;
  }
#endif


#ifndef PM
  if (OPTION_MASK & DIR_MASK) {
    //chdir(directory[0]) ;
  }
#endif

  char *qry ;
  int currProject = 0 ;

  if (!(OPTION_MASK & OEM_MASK)) {
    OurSQL testconn("test") ;
    testconn.connect() ;

    for (i=0 ; i<nProjects ; i++)
    {
      qry = _strdup("create database if not exists ") ;
      qry = (char*) realloc(qry, (strlen(qry)+strlen(projname[i])+1)*sizeof(char)) ;
      strcat(qry,projname[i]) ;
      testconn.executeQuery(qry) ;
      free(qry) ;
    }

    // Disconnect from 'test'
    testconn.disconnect() ;
  }

  // Now connect to the current DB
  OurSQL *projConn[PROJECT_MAX] ;

  for (i=0 ; i<nProjects ; i++ ) {
    projConn[i] = new OurSQL(projname[i]) ;
    projConn[i]->connect() ;

    if (!(OPTION_MASK & OEM_MASK)) {
      setupDB(projConn[i],i) ;
    }

  }

  if (OPTION_MASK & SINGLE_GRID_MASK) {
    if (!setupFile(grid_file)) {
      OPTION_MASK ^= SINGLE_GRID_MASK ;
    }
  }

  if (OPTION_MASK & SINGLE_SYMB_MASK) {
    if (!setupFile(symb_file)) {
      OPTION_MASK ^= SINGLE_SYMB_MASK ;
    }
  }

  if (OPTION_MASK & MULTIPLE_GRID_MASK) {
    if (!setupDir(grid_dir)) {
      OPTION_MASK ^= MULTIPLE_GRID_MASK ;
    }
  }

  if (OPTION_MASK & MULTIPLE_SYMB_MASK) {
    if (!setupDir(symb_dir)) {
      OPTION_MASK ^= MULTIPLE_SYMB_MASK ;
    }
  }

  if (OPTION_MASK & XML_MASK) {
    if (!setupFile(xmlfile)) {
      OPTION_MASK ^= XML_MASK ;
    }
  }

  if (!(OPTION_MASK & OEM_MASK)) {
    // Change to the installation dir so that
    // the executables can be located
    chdir(ins_dir) ;

    // Analyze the project
    analyze() ;
  }

#ifdef PM
  for (i=0 ; i<3 ; i++) {
    createPMTemporaryTables(projConn[0],i) ;
    createReport(projConn[0]) ;
  }

  createPMTemporaryTables(projConn[1],3) ;
  createReport(projConn[1]) ;
#else
  createTemporaryTables(projConn[0]) ;
  createReport(projConn[0]) ;

  if (OPTION_MASK & XML_MASK) {
    int depth = createXMLTables(projConn[0]) ;
    createXMLReport(projConn[0],depth) ;
  }

#endif


#ifdef WIN32
  if (!(OPTION_MASK & OEM_MASK))
  {
    if (oi.dwPlatformId==VER_PLATFORM_WIN32_WINDOWS)
    {
      string killdb = ins_dir ;
      killdb += "/db/bin/mysqladmin.exe shutdown" ;
      createProcess(killdb) ;
    }
    else if (oi.dwPlatformId==VER_PLATFORM_WIN32_NT)
    {
      TerminateProcess(dbPID, 0) ;

      cout << "Database stopped." << endl;
    }
  }
#endif

  if (!(OPTION_MASK & OEM_MASK)) {
    CHECKIN();
  }

  return 0 ;
}