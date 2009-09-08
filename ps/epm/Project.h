/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Creates and manages MySQL Project databases
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  20-Dec-04    File added.
 * CAM  30-Dec-04    Added serverName to createDatabase.
 * CAM  03-Jan-05    Changed OurSQL pointers to refs.
 * CAM  04-Jan-05    Added indexes to sourcefile.
 * CAM  08-Jan-05    Changed executeQuery to executeResultlessQuery.
 * CAM  13-Jan-05    Added username and password to createDatabase.
 * CAM  24-Jan-05    Added Halstead metrics and changed save of value to float.
 * CAM  03-Feb-05    39 : Added Project Snapshot Date.
 * CAM  14-Mar-05    78 : Ensure sourcemetric.mvalue is double - large enough for big values.
 * CAM  19-Mar-05    81 : Remove BINARY attribute to sourcefile.sf_name - matching will be case insensitive.
 * CAM  04-May-05    50 : Set Language.
 * CAM  12-May-05    96 : Added VB.
 * CAM  18-May-05    97 : Added PL/SQL.
 * CAM  13-Aug-05    114 : Added Perl.
 * CAM  23-Aug-05    114 : Corrected n2 from Operators to Operands.
 * CAM  28-Nov-05    164 : Added NFILE to insert into metric table.
 * CAM  07-Feb-06    187 : Ensure Project Names are MySQL-quoted to allow user-entered names.
 * CAM  13-Feb-06    185 : Corrected the duplication of PRIMARY and UNIQUE indices on the same columns.
 * CAM  16-Feb-06    188 : Added MS VS 6 DSP parsing.
 * CAM  18-Mar-06    211 : Changed CPP_COM to EOL_COM.
 * CAM  18-Jul-06    272 : Added CHG,DEL,ADD LLOC metrics.
 * CAM  19-Sep-06    117 : Added SLOC* metrics.
 * CAM  25-Oct-07    319 : Remove duplicate filenames during project creation.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  30-May-08    365 : Incorrect not null field in sourcefile.
 * CAM  17-Apr-2009  10430 : Added Churn metrics.
 * CAM  28-Apr-2009  10436 : Allowed use of blank file extensions.
 * CAM  09-Sep-2009  10479 : Add PLOC.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "OurSQL.h"
using namespace metrics;

#define CAM_STRNCPY(X,S,Y,Z) strcpy_s(X, S, Y); X[Z]='\0'

OurSQL &projDb = OurSQL();
OurSQL &metDb = OurSQL();
extern Extension *ext;

bool isFileOk(char *filename) {
  struct stat buf;

  if (stat(filename,&buf)!=0) {
    cout << filename << " could not be found." << endl;
    return false;
  }

  return true;
}

void verifyName(char *projname) {
  for (char *c=projname; *c!='\0'; c++) {
    if (*c==' ') *c='_';
  }
}

void validateSQL(char *sql) {
  for (char *c=sql; *c!='\0'; c++) {
    if (*c=='\\') *c='/';
  }
}

void win32Realpath(char *path) {
  for (char *c=path; *c!='\0'; c++) {
    if (*c=='/') *c='\\';
  }
}

void fileCopy(const char *source, const char *target) {
  ifstream in( source, ios::binary);
  ofstream out( target, ios::binary );

  int c=0;

  while (!in.eof()) {
    in.read((char*) &c,1);
    out.write((char*) &c,1);
  }

  in.close( );
  out.close( );
}

char* getFileType(char *srcf, char *rval) {
  strcpy_s(rval, MAX_PATH, "CP");
  char *lastperiod = strrchr(srcf, '.');

  if (lastperiod == NULL)
  {
    // If there is no period, look for an extension with only a space, and return this language
    for (int i=0; i<ext->nLang; i++) {
      for (int j=0; j<ext->nType[i]; j++) {
        for (int k=0; k<ext->nExt[i][j]; k++) {
          if (ext->sExt[i][j][k].fDesc[0] == ' ') {
            strcpy_s(rval, MAX_PATH, ext->sLang[i].fDesc);
            return rval;
          }
        }
      }
    }
  }
  else
  {
    // Period was found, skip past the period itself and look for a matching extension
    lastperiod++;

    for (int i=0; i<ext->nLang; i++) {
      for (int j=0; j<ext->nType[i]; j++) {
        for (int k=0; k<ext->nExt[i][j]; k++) {
          if (!_stricmp(lastperiod, ext->sExt[i][j][k].fDesc)) {
            strcpy_s(rval, MAX_PATH, ext->sLang[i].fDesc);
            return rval;
          }
        }
      }
    }
  }

  // Otherwise, it's C++!
  return rval;
}

bool getNextFiles(char *buff, char *currentFile, int bsize, int index=0) {

  int size = 0;
  int count = 0;

  int chop = strlen(relpath[index]);
  buff[0] = '\0';
  if (OPTION_MASK & FILE_LIST_MASK) {

    if (strlen(tmp_file)) {
      size = (strlen(tmp_file)*2)-chop;

      getFileType(fn_res+chop, ftype);
      _itoa_s((index+1), sindex, 100, 10);

      sprintf_s(currentFile, bsize, "('%s','%s','%s',%s),", fn_res, fn_res+chop, ftype, sindex);
      strcat_s(buff, bsize, currentFile);
      currentFile[0] = '\0';
      size += 15;
      count++;

      tmp_file[0] = '\0';
    }

    void *ret = filelist[index].getline(fn_buff,PATH_MAX);

    while (size<bsize && ret) {
      if (strlen(fn_buff)) {
        realpath(fn_buff,fn_res);
        size += (strlen(fn_res)*2)-chop;
        size += 15;

        if (size<bsize) {
          getFileType(fn_res+chop, ftype);
          _itoa_s((index+1), sindex, 100, 10);

          sprintf_s(currentFile, bsize, "('%s','%s','%s',%s),", fn_res, fn_res+chop, ftype, sindex);
          strcat_s(buff, bsize, currentFile);

          currentFile[0] = '\0';
          fn_buff[0] = '\0';
          fn_res[0] = '\0';

          ret = filelist[index].getline(fn_buff,PATH_MAX);
        } else {
          ret = NULL;
        }
      }
    }

    if (strlen(fn_res)) {
      strcpy_s(tmp_file, PATH_MAX, fn_res);
    }

    if (buff) buff[strlen(buff)-1] = '\0';
    return size>0;
  }

  return false;
}

bool createDatabase(string serverName, string userName, string password,
                    string databaseName, int projects) {
  char sql[QUERY_MAX];
  bool recreate = (projects > 0);

  // Create the Database
  projDb.connect(serverName, userName, password);
  if (!projDb.connected()) return false;

  if (recreate) {
    strcpy_s(sql, QUERY_MAX, "drop database if exists `");
    strcat_s(sql, QUERY_MAX, databaseName.c_str());
    strcat_s(sql, QUERY_MAX, "`");
    projDb.executeResultlessQuery(sql);
    strcpy_s(sql, QUERY_MAX, "create database `");
    strcat_s(sql, QUERY_MAX, databaseName.c_str());
    strcat_s(sql, QUERY_MAX, "`");
    projDb.executeResultlessQuery(sql);
    projDb.disconnect();
  }

  // Connect to the Database and create tables
  projDb.connect(serverName, userName, password, databaseName);
  metDb.connect(projDb.getHost(), userName, password, projDb.getDB());
  if (!projDb.connected()) return false;

  if (!recreate) return true;

  projDb.executeResultlessQuery("CREATE TABLE IF NOT exists metric (mid int not null, m_name varchar(10) not null, m_desc varchar(255) NOT NULL, primary key (mid))");
  projDb.executeResultlessQuery("INSERT INTO metric VALUES (100,'LOC','Lines of Code'),(101,'SLOC','Source Lines of Code'),(106,'PLOC','Number of Preprocessor Directive Lines of Code (often beginning with #)'),(107,'LLOC','Number of Logical Lines of Code (terminated by semi-colons)'),(108,'N1','Total No. of Operators'),(109,'N2','Total No. of Operands'),(110,'n1','No. of unique or distinct Operators'),(111,'n2','No. of unique or distinct Operands'),(112,'N','Halstead program Length (calculated as N1 + N2)'),(113,'n','Halstead program Vocabulary (calculated as n1 + n2)'),(114,'V','Halstead Volume (calculated as V = Nlog2n)'),(115,'D','Halstead program Difficulty'),(116,'E','Halstead program Effort (calculated as D * V)'),(117,'B','Halstead Bug Prediction'),(118,'J_COM','Java-style Comment Lines'),(119,'C_COM','C-style Comment Lines'),(120,'EOL_COM','To End Of Line Comment Lines'),(121,'COM_LOC','Total Comment Lines'),(122,'BYTES','File size in bytes'),(123,'NFILE','Number of Files')");
  projDb.executeResultlessQuery("INSERT INTO metric VALUES (102,'SLOC_NAT','Native Source Lines of Code'),(103,'SLOC_TAG','Tag Source Lines of Code'),(104,'SLOC_HTM','HTML Source Lines of Code'),(105,'SLOC_SCR','Script Source Lines of Code')");
  projDb.executeResultlessQuery("INSERT INTO metric VALUES (124,'CHG_SLOC','Changed Source Lines of Code'),(125,'DEL_SLOC','Deleted Source Lines of Code'),(126,'ADD_SLOC','Added Source Lines of Code'),(127,'CRN_SLOC','Churn Source Lines of Code'),(128,'CHG_LLOC','Changed Logical Lines of Code'),(129,'DEL_LLOC','Deleted Logical Lines of Code'),(130,'ADD_LLOC','Added Logical Lines of Code'),(131,'CRN_LLOC','Churn Logical Lines of Code'),(132,'CHG_FILE','Changed Files'),(133,'DEL_FILE','Deleted Files'),(134,'ADD_FILE','Added Files'),(135,'CRN_FILE','Churn Files')");

  projDb.executeResultlessQuery("CREATE TABLE IF NOT EXISTS project (projid int not null, pr_name varchar(255) binary not null, snap_date varchar(255) binary, base_dir varchar(255) NOT NULL, external_type char(3) NULL, external_source varchar(255) NULL, PRIMARY KEY (projid))");

  projDb.executeResultlessQuery("CREATE TABLE IF NOT EXISTS sourcefile (sfid int AUTO_INCREMENT not null, projid int not null, sf_name varchar(255) binary not null, sf_shortname varchar(255) NOT NULL, sf_type varchar(20) NOT NULL, sf_last_mod int unsigned, PRIMARY KEY (sfid), KEY PROJECT (projid), KEY SHORTNAME (sf_shortname))");
  projDb.executeResultlessQuery("CREATE TABLE IF NOT EXISTS sourcemetric (sfid int not null, mid int not null, mvalue double not null, PRIMARY KEY (sfid,mid))");

  projDb.executeResultlessQuery("CREATE TABLE IF NOT EXISTS comparefile (sfid int not null, sfid2 int not null, status varchar(1) not null, PRIMARY KEY (sfid))");

  char fn_res[PATH_MAX];
  char proj_name[PATH_MAX];
  char snapshot_date[PATH_MAX];
  char source_list[PATH_MAX];
  void *ret;
  char external_type[PATH_MAX];
  bool fileListRead = true;

  for (int i=0; i<projects; i++) {
    // Get Filelist Project Name
    ret = filelist[i].getline(proj_name,PATH_MAX);
    if (ret && strlen(proj_name)) {
      verifyName(proj_name);
    }
    // Get Project Snapshot date
    ret = filelist[i].getline(snapshot_date,PATH_MAX);
    if (ret) {
      cout << "Project " << i << " name " << proj_name << " (snapshot at " << snapshot_date << ")" << endl;
    }
    // Get Filelist Project Root path
    ret = filelist[i].getline(fn_res,PATH_MAX);
    if (ret && strlen(fn_res)) {
      relpath[i] = (char*) malloc((PATH_MAX)*sizeof(char)) ;

      if (fn_res[0] == '@') {
        fileListRead = false;
        filelist[i].close();

        CAM_STRNCPY(external_type, 260, fn_res+1, 3);
        realpath(fn_res+5,source_list);
        validateSQL(source_list);

        cout << "Project " << i << " external " << external_type << " " << source_list << endl;

        strcpy_s(relpath[i], PATH_MAX, source_list);
        for (int s=strlen(relpath[i])-2; s>=0; s--) {
          if (relpath[i][s] == '/') {
            relpath[i][s+1] = '\0';
            s=-1;
          }
        }

        sprintf_s(sql, QUERY_MAX, "INSERT INTO project (projid, pr_name, snap_date, base_dir, external_type, external_source) values ('%d','%s','%s','%s','%s','%s')", (i+1), proj_name, snapshot_date, relpath[i], external_type, source_list);
        projDb.executeResultlessQuery(sql);

      } else {
        realpath(fn_res,relpath[i]);
        validateSQL(relpath[i]);

        sprintf_s(sql, QUERY_MAX, "INSERT INTO project (projid, pr_name, snap_date, base_dir) values ('%d','%s','%s','%s')", (i+1), proj_name, snapshot_date, relpath[i]);
        projDb.executeResultlessQuery(sql);

        cout << "Project " << i << " path " << relpath[i] << endl;
      }
    }

    strcpy_s(qry, QUERY_MAX_EXTRA, "insert into sourcefile (sf_name,sf_shortname,sf_type,projid) values ");
    int val_index = strlen(qry);
    tmp_file[0] = '\0';

    if (fileListRead) {
      // Read the rest of the lines in the Project file as sourcefiles for the EPM project.
      getNextFiles(buffer,currentFile,QUERY_MAX,i);
      do {
        validateSQL(buffer);
        qry[val_index] = '\0';
        strcat_s(qry, QUERY_MAX_EXTRA, buffer);

        projDb.executeResultlessQuery(qry);
      } while (getNextFiles(buffer,currentFile,QUERY_MAX,i));

      // Remove any duplicates
      std::vector<int> dups;
      unsigned int f;

      strcpy_s(sql, QUERY_MAX, "SELECT sf2.sfid FROM sourcefile sf1 LEFT OUTER JOIN sourcefile sf2 ON sf1.sf_shortname = sf2.sf_shortname AND sf1.projid = sf2.projid AND sf2.sfid > sf1.sfid WHERE sf2.sfid IS NOT NULL ");

      if (projDb.executeQuery(sql)) {
        for (f=0; f<(unsigned int)projDb.rows(); f++) {
          dups.push_back(projDb.longCell(f,0));
        }
        projDb.clearResults();
      }

      for (f=0; f<dups.size(); f++) {
        sprintf_s(sql, QUERY_MAX, "DELETE FROM sourcefile WHERE sfid=%d", dups[f]);
        projDb.executeResultlessQuery(sql);
      }


    } else if (!strcmp(external_type, "DSP")) {
      // An external DSP filelist has been specified - parse *it*

      if (!isFileOk(source_list)) {
        exit(1);
      }
      int chop = strlen(relpath[i]);
      char ftype[100];
      char ltype[100];
      char projpath[PATH_MAX];
      char tmp[PATH_MAX];
      char fn_res[PATH_MAX];
      char current[PATH_MAX];
      ifstream ext_project;

      //cout << "parsing " << source_list << endl;
      ext_project.open(source_list);
      void *ret = ext_project.getline(buffer,QUERY_MAX);

      strcpy_s(projpath, PATH_MAX, relpath[i]);
      win32Realpath(projpath);

      while (ret) {
        if (strlen(buffer)) {
          strcpy_s(ltype, 100, buffer);
          ltype[7]='\0';

          if (!strcmp(ltype, "SOURCE=")) {
            strcpy_s(tmp, PATH_MAX, relpath[i]);
            strcat_s(tmp, PATH_MAX, buffer+7);
            realpath(tmp, fn_res);

            sprintf_s(current, PATH_MAX, "('%s','%s','%s',%d)", fn_res, fn_res, getFileType(fn_res, ftype), (i+1));
            validateSQL(current);
            strcpy_s(sql, QUERY_MAX, qry);
            strcat_s(sql, QUERY_MAX, current);
            projDb.executeResultlessQuery(sql);
          }
        }

        ret = ext_project.getline(buffer,QUERY_MAX);
      }

      // Now attempt to chop off the common part of the short filename
      int t=0;
      int rows=0;
      int minlen=0;

      // Determine the smallest filename (the maximum number of characters to check)
      sprintf_s(sql, QUERY_MAX, "SELECT MIN(LENGTH(sf_shortname)) FROM sourcefile WHERE projid=%d", (i+1));
      if (projDb.executeQuery(sql)) {
        minlen = projDb.longCell(0,0);
      }

      // Group by successively longer parts of the short filename until more than one occurence shows up
      while ((t<minlen) && (rows<2)) {
        sprintf_s(sql, QUERY_MAX, "SELECT COUNT(DISTINCT(SUBSTR(sf_shortname,1,%d))) FROM sourcefile WHERE projid=%d", t, (i+1));
        if (projDb.executeQuery(sql)) {
          rows = projDb.longCell(0,0);
        }
        t++;
      }

      if (rows>1) {
        // If more than one row, chop off the number of chars prior to the count that made more than one
        sprintf_s(sql, QUERY_MAX, "UPDATE sourcefile SET sf_shortname = SUBSTR(sf_shortname, %d) WHERE projid=%d", (t-1), (i+1));
        projDb.executeQuery(sql);
      }
    }
  }

  strcpy_s(sql, QUERY_MAX, "INSERT INTO comparefile(sfid, sfid2, status) SELECT sf1.sfid,sf2.sfid sfid2, 'C' status FROM sourcefile sf1 LEFT OUTER JOIN sourcefile sf2 ON sf1.sf_shortname = sf2.sf_shortname AND sf1.projid <> sf2.projid WHERE sf1.projid = 1 AND sf2.projid IS NOT NULL UNION SELECT sf1.sfid,NULL,'A' status FROM sourcefile sf1 LEFT OUTER JOIN sourcefile sf2 ON sf1.sf_shortname = sf2.sf_shortname AND sf1.projid <> sf2.projid WHERE sf1.projid = 1 AND sf2.projid IS NULL UNION SELECT sf2.sfid,NULL,'D' status FROM sourcefile sf1 RIGHT OUTER JOIN sourcefile sf2 ON sf1.sf_shortname = sf2.sf_shortname AND sf1.projid <> sf2.projid WHERE sf1.projid IS NULL AND sf2.projid = 2 ");
  projDb.executeResultlessQuery(sql);
  return true;
}

void saveDb(int sfid, Metrics& met, int start, int end) {
  char sql[QUERY_MAX];
  char tmp[256];
  int id;
  int i;

  strcpy_s(sql, QUERY_MAX, "INSERT INTO sourcemetric (sfid,mid,mvalue) VALUES ");

  for (i=start; i<=end; i++)
  {
    id = i + 100;
    sprintf_s(tmp, 256, "('%d','%d','%f'),", sfid, id, met.get(i,0));
    strcat_s(sql, QUERY_MAX, tmp);
  }
  sql[strlen(sql)-1] = '\0';  // remove last comma

  metDb.executeResultlessQuery(sql);
}

void closeDatabase() {
  projDb.disconnect();
  metDb.disconnect();
}
