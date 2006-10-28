/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Creates and manages MySQL Project databases
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  20-Dec-04  File added.
 * CAM  30-Dec-04  Added serverName to createDatabase.
 * CAM  03-Jan-05  Changed OurSQL pointers to refs.
 * CAM  04-Jan-05  Added indexes to sourcefile.
 * CAM  08-Jan-05  Changed executeQuery to executeResultlessQuery.
 * CAM  13-Jan-05  Added username and password to createDatabase.
 * CAM  24-Jan-05  Added Halstead metrics and changed save of value to float.
 * CAM  03-Feb-05    39 : Added Project Snapshot Date.
 * CAM  14-Mar-05    78 : Ensure sourcemetric.mvalue is double - large enough for big values.
 * CAM  19-Mar-05    81 : Remove BINARY attribute to sourcefile.sf_name - matching will be case insensitive.
 * CAM  04-May-05    50 : Set Language.
 * CAM  12-May-05    96 : Added VB.
 * CAM  18-May-05    97 : Added PL/SQL.
 * CAM  13-Aug-05   114 : Added Perl.
 * CAM  23-Aug-05   114 : Corrected n2 from Operators to Operands.
 * CAM  28-Nov-05   164 : Added NFILE to insert into metric table.
 * CAM  07-Feb-06   187 : Ensure Project Names are MySQL-quoted to allow user-entered names.
 * CAM  13-Feb-06   185 : Corrected the duplication of PRIMARY and UNIQUE indices on the same columns.
 * CAM  16-Feb-06   188 : Added MS VS 6 DSP parsing.
 * CAM  18-Mar-06   211 : Changed CPP_COM to EOL_COM.
 * CAM  18-Jul-06   272 : Added CHG,DEL,ADD LLOC metrics.
 * CAM  19-Sep-06   117 : Added SLOC* metrics.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "OurSQL.h"
using namespace metrics;

#define CAM_STRNCPY(X,Y,Z) strcpy(X, Y); X[Z]='\0'

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
  strcpy(rval, "CP");
  char *lastperiod = strrchr(srcf, '.');

  if (lastperiod != NULL) {
    lastperiod++;

    for (int i=0; i<ext->nLang; i++) {
      for (int j=0; j<ext->nType[i]; j++) {
        for (int k=0; k<ext->nExt[i][j]; k++) {
          if (!stricmp(lastperiod, ext->sExt[i][j][k].fDesc)) { strcpy(rval, ext->sLang[i].fDesc); }
        }
      }
    }
  }

  return rval;
}

bool getNextFiles(char *buff, int bsize, int index=0) {

  int size = 0;
  int count = 0;
  strcpy(buff,"");
  char current[4096];
  char ftype[100];
  int chop = strlen(relpath[index]);

  if (OPTION_MASK & FILE_LIST_MASK) {

    if (tmp_file) {
      size = (strlen(tmp_file)*2)-chop;
      sprintf(current, "('%s','%s','%s',%d),", tmp_file, tmp_file+chop, getFileType(tmp_file+chop, ftype), (index+1));
      strcat(buff, current);
      current[0] = '\0';
      size += 15;
      count++;

      free (tmp_file);
      tmp_file = NULL;
    }

    char fn_buff[PATH_MAX];
    char fn_res[PATH_MAX];

    void *ret = filelist[index].getline(fn_buff,PATH_MAX);

    while (size<bsize && ret) {
      if (strlen(fn_buff)) {
        realpath(fn_buff,fn_res);
        size += (strlen(fn_res)*2)-chop;
        size += 15;

        if (size<bsize) {
          sprintf(current, "('%s','%s','%s',%d),", fn_res, fn_res+chop, getFileType(fn_res+chop, ftype), (index+1));
          strcat(buff, current);
          current[0] = '\0';
          fn_buff[0] = '\0';

          ret = filelist[index].getline(fn_buff,PATH_MAX);
        } else {
          ret = NULL;
        }
      }
    }

    if (strlen(fn_buff)) {
      realpath(fn_buff,fn_res);
      tmp_file = strdup(fn_res);
    }

    if (buff) buff[strlen(buff)-1] = '\0';
    return size>0;
  }

  return false;
}

bool createDatabase(string serverName, string userName, string password,
                    string databaseName, int projects) {
  char sql[PATH_MAX*4];
  bool recreate = (projects > 0);

  // Create the Database
  projDb.connect(serverName, userName, password);
  if (!projDb.connected()) return false;

  if (recreate) {
    strcpy(sql, "drop database if exists `");
    strcat(sql, databaseName.c_str());
    strcat(sql, "`");
    projDb.executeResultlessQuery(sql);
    strcpy(sql, "create database `");
    strcat(sql, databaseName.c_str());
    strcat(sql, "`");
    projDb.executeResultlessQuery(sql);
    projDb.disconnect();
  }

  // Connect to the Database and create tables
  projDb.connect(serverName, userName, password, databaseName);
  metDb.connect(projDb.getHost(), userName, password, projDb.getDB());
  if (!projDb.connected()) return false;

  if (!recreate) return true;

  projDb.executeResultlessQuery("CREATE TABLE IF NOT exists metric (mid int not null, m_name varchar(10) not null, m_desc varchar(255) NOT NULL, primary key (mid))");
  projDb.executeResultlessQuery("INSERT INTO metric VALUES (100,'LOC','Lines of Code'),(101,'SLOC','Source Lines of Code'),(106,'LLOC','Number of Logical Lines of Code (terminated by semi-colons)'),(107,'N1','Total No. of Operators'),(108,'N2','Total No. of Operands'),(109,'n1','No. of unique or distinct Operators'),(110,'n2','No. of unique or distinct Operands'),(111,'N','Halstead program Length (calculated as N1 + N2)'),(112,'n','Halstead program Vocabulary (calculated as n1 + n2)'),(113,'V','Halstead Volume (calculated as V = Nlog2n)'),(114,'D','Halstead program Difficulty'),(115,'E','Halstead program Effort (calculated as D * V)'),(116,'B','Halstead Bug Prediction'),(117,'J_COM','Java-style Comment Lines'),(118,'C_COM','C-style Comment Lines'),(119,'EOL_COM','To End Of Line Comment Lines'),(120,'COM_LOC','Total Comment Lines'),(121,'BYTES','File size in bytes'),(122,'NFILE','Number of Files')");
  projDb.executeResultlessQuery("INSERT INTO metric VALUES (102,'SLOC_NAT','Native Source Lines of Code'),(103,'SLOC_TAG','Tag Source Lines of Code'),(104,'SLOC_HTM','HTML Source Lines of Code'),(105,'SLOC_SCR','Script Source Lines of Code')");
  projDb.executeResultlessQuery("INSERT INTO metric VALUES (123,'CHG_SLOC','Changed Source Lines of Code'),(124,'DEL_SLOC','Deleted Source Lines of Code'),(125,'ADD_SLOC','Added Source Lines of Code'),(126,'CHG_LLOC','Changed Logical Lines of Code'),(127,'DEL_LLOC','Deleted Logical Lines of Code'),(128,'ADD_LLOC','Added Logical Lines of Code'),(129,'CHG_FILE','Changed Files'),(130,'DEL_FILE','Deleted Files'),(131,'ADD_FILE','Added Files')");

  projDb.executeResultlessQuery("CREATE TABLE IF NOT EXISTS project (projid int not null, pr_name varchar(255) binary not null, snap_date varchar(255) binary, base_dir varchar(255) NOT NULL, external_type char(3) NULL, external_source varchar(255) NULL, PRIMARY KEY (projid))");

  projDb.executeResultlessQuery("CREATE TABLE IF NOT EXISTS sourcefile (sfid int AUTO_INCREMENT not null, projid int not null, sf_name varchar(255) binary not null, sf_shortname varchar(255) NOT NULL, sf_type varchar(20) NOT NULL, sf_last_mod int unsigned not null, PRIMARY KEY (sfid), KEY PROJECT (projid), KEY SHORTNAME (sf_shortname))");
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

        CAM_STRNCPY(external_type, fn_res+1, 3);
        realpath(fn_res+5,source_list);
        validateSQL(source_list);

        cout << "Project " << i << " external " << external_type << " " << source_list << endl;

        strcpy(relpath[i], source_list);
        for (int s=strlen(relpath[i])-2; s>=0; s--) {
          if (relpath[i][s] == '/') {
            relpath[i][s+1] = '\0';
            s=-1;
          }
        }

        sprintf(sql, "INSERT INTO project (projid, pr_name, snap_date, base_dir, external_type, external_source) values ('%d','%s','%s','%s','%s','%s')", (i+1), proj_name, snapshot_date, relpath[i], external_type, source_list);
        projDb.executeResultlessQuery(sql);

      } else {
        realpath(fn_res,relpath[i]);
        validateSQL(relpath[i]);

        sprintf(sql, "INSERT INTO project (projid, pr_name, snap_date, base_dir) values ('%d','%s','%s','%s')", (i+1), proj_name, snapshot_date, relpath[i]);
        projDb.executeResultlessQuery(sql);

        cout << "Project " << i << " path " << relpath[i] << endl;
      }
    }

    int val_index = 68; // the index of the start of the values
    char *qry = (char*) malloc((val_index+QUERY_MAX)*sizeof(char)) ;
    char buffer[QUERY_MAX] ;
    strcpy(qry,"insert into sourcefile (sf_name,sf_shortname,sf_type,projid) values ");

    if (fileListRead) {
      // Read the rest of the lines in the Project file as sourcefiles for the EPM project.
      getNextFiles(buffer,QUERY_MAX,i);
      do {
        validateSQL(buffer);
        qry[val_index] = '\0';
        strcat(qry,buffer);

        projDb.executeResultlessQuery(qry);
      } while (getNextFiles(buffer,QUERY_MAX,i));

      free(qry);

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

      strcpy(projpath, relpath[i]);
      win32Realpath(projpath);

      while (ret) {
        if (strlen(buffer)) {
          strcpy(ltype, buffer);
          ltype[7]='\0';

          if (!strcmp(ltype, "SOURCE=")) {
            strcpy(tmp, relpath[i]);
            strcat(tmp, buffer+7);
            realpath(tmp, fn_res);

            sprintf(current, "('%s','%s','%s',%d)", fn_res, fn_res, getFileType(fn_res, ftype), (i+1));
            validateSQL(current);
            strcpy(sql, qry);
            strcat(sql, current);
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
      sprintf(sql, "SELECT MIN(LENGTH(sf_shortname)) FROM sourcefile WHERE projid=%d", (i+1));
      if (projDb.executeQuery(sql)) {
        minlen = projDb.longCell(0,0);
      }

      // Group by successively longer parts of the short filename until more than one occurence shows up
      while ((t<minlen) && (rows<2)) {
        sprintf(sql, "SELECT COUNT(DISTINCT(SUBSTR(sf_shortname,1,%d))) FROM sourcefile WHERE projid=%d", t, (i+1));
        if (projDb.executeQuery(sql)) {
          rows = projDb.longCell(0,0);
        }
        t++;
      }

      if (rows>1) {
        // If more than one row, chop off the number of chars prior to the count that made more than one
        sprintf(sql, "UPDATE sourcefile SET sf_shortname = SUBSTR(sf_shortname, %d) WHERE projid=%d", (t-1), (i+1));
        projDb.executeQuery(sql);
      }
    }
  }

  strcpy(sql, "INSERT INTO comparefile(sfid, sfid2, status) ");
  strcat(sql, "SELECT sf1.sfid,sf2.sfid sfid2, 'C' status ");
  strcat(sql, "FROM sourcefile sf1 ");
  strcat(sql, "LEFT OUTER JOIN sourcefile sf2 ON sf1.sf_shortname = sf2.sf_shortname AND sf1.projid <> sf2.projid ");
  strcat(sql, "WHERE sf1.projid = 1 AND sf2.projid IS NOT NULL ");
  strcat(sql, "UNION SELECT sf1.sfid,NULL,'A' status ");
  strcat(sql, "FROM sourcefile sf1 ");
  strcat(sql, "LEFT OUTER JOIN sourcefile sf2 ON sf1.sf_shortname = sf2.sf_shortname AND sf1.projid <> sf2.projid ");
  strcat(sql, "WHERE sf1.projid = 1 AND sf2.projid IS NULL ");
  strcat(sql, "UNION SELECT sf2.sfid,NULL,'D' status ");
  strcat(sql, "FROM sourcefile sf1 ");
  strcat(sql, "RIGHT OUTER JOIN sourcefile sf2 ON sf1.sf_shortname = sf2.sf_shortname AND sf1.projid <> sf2.projid ");
  strcat(sql, "WHERE sf1.projid IS NULL AND sf2.projid = 2 ");
  projDb.executeResultlessQuery(sql);
  return true;
}

void saveDb(int sfid, Metrics& met, int start, int end) {
  char sql[1024];
  char tmp[256];
  int id;
  int i;

  strcpy(sql, "INSERT INTO sourcemetric (sfid,mid,mvalue) VALUES ");

  for (i=start; i<end; i++) {
    id = i + 100;
    sprintf(tmp, "('%d','%d','%f'),", sfid, id, met.get(i,0));
    strcat(sql, tmp);
  }
  id = i + 100;
  sprintf(tmp, "('%d','%d','%f')", sfid, id, met.get(i,0));
  strcat(sql, tmp);

  metDb.executeResultlessQuery(sql);
}

void closeDatabase() {
  projDb.disconnect();
  metDb.disconnect();
}
