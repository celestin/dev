/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau C/C++ Parser (CPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  27-Mar-08  345 : File added to source control.
 * CAM  27-Mar-08  345 : Corrected carriage-returns, POSIX naming and removed old commented-out code.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>

#ifdef WIN32
#include <io.h>
#include <windows.h>
#include <winbase.h>
#include <process.h>
#elif sun
#include <unistd.h>
#include <sys/wait.h>
#endif

#include <stack>

#include "codefn.h"
#include "types.h"
#include "parser.h"

#include <fstream>
using namespace std ;

extern char* yytext;
extern code_type code;
int maxtree=100000;
FILE *output, *myInput ;
char *input_filename, *original_filename;
int infile ;

bool singleFile ;

/* ******************************************* */

void parserdone(int x) {
  exit(0);
}

/* ******************************************* */

extern FILE *yyin ;

void parse()
{
  initialise();
  declaration_seq();
  append_sloc_information();
  fclose(yyin) ;
}

#ifdef WIN32

unsigned long _stdcall winThread(void *in)
{
  parse() ;
  return 0 ;
}

#ifndef _DEBUG

int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{

  int argc = 1;
  char* argv[20];

  char* i=lpCmdLine;
  char* argStart=i;
  int length = strlen(lpCmdLine);

  for (int k=0  ; k<=length ; i++,k++ ) {

    if ( ((*i) == ' ') || (k==length) ){

      (*i) = '\0';
      argv[argc] = (char*) malloc (1024 * sizeof(char*));
      sprintf_s(argv[argc], MAX_PATH, "%s",argStart);

      argc++;

      argStart = i;
      argStart++;
    }

  }

#else
int main(int argc, char *argv[])
{
#endif
#else
int main(int argc, char *argv[])
{
#endif
  int writeToParentFD ;

  // initialise yytext (the lexer text field)
    yytext=(char*)malloc(10240) ;

  if (argc==3) {
    // Accept code directly from a source file
    // 19/11/2001 CAM
    singleFile = true ;

    input_filename = _strdup(argv[1]) ;
    writeToParentFD=atoi(argv[2]) ;
    struct stat buf ;

    decodefn(input_filename) ;

    // Check for the existance of the file to be parsed
    if (stat(input_filename,&buf)!=0) {
      exit(1) ;
    }

    // Point lexer input to this source file
    if ((yyin = fopen(input_filename, "r")) == NULL) {
      exit(1) ;
    }

    // Set write descriptor back to the analyser
    if( (output = fdopen(writeToParentFD, "w")) == NULL )
      exit(1) ;

  } else if (argc==4) {
    // Accept preprocessed code

    singleFile = true ;

    //Changed from filename to FD
    //15-11-01 SJW

    infile = atoi(argv[2]) ;
    writeToParentFD=atoi(argv[3]) ;

    // Point the lexer to the output from the Preprocessor
    if ((yyin = fdopen(infile, "r")) == NULL) {
      exit(1) ;
    }

    // Set write descriptor back to the analyser
    if( (output = fdopen(writeToParentFD, "w")) == NULL ) {
      exit(1) ;
    }

  } else {
    // Command line - no longer used
    gets(input_filename) ;
    gets(original_filename) ;
  }

  original_filename = _strdup(input_filename) ;

#ifdef WIN32
  // on WIN32, the harness runs as a thread

  if (singleFile)
  {
    DWORD id ;
    HANDLE harnessHandle = CreateThread(NULL,0,winThread,NULL,0,&id) ;

    if ( WaitForSingleObject(harnessHandle, 60000) != WAIT_TIMEOUT )
    {
      statistics(output) ;
    }
    else
    {
      errorFile(output) ;
    }

    fclose(output) ;
    _exit(0) ;
  } else {
  }
#elif sun
  // on UNIX platforms, harness works by fork()ing
  pid_t pid;
  // quit gracefully when complete
  signal(SIGCHLD,parserdone);

  if (pid=fork()==0) {

    decodefn(input_filename); decodefn(original_filename);

    parse() ;

    statistics(output);
    fclose(output) ;
    exit(0) ;
  }

  int i,status ;
  for (i=0 ; i<60 ; i++)
  {
    sleep(1) ;
    waitpid(pid,&status,WNOHANG) ;
    if (status!=0)
    {
      // Child Successfully completed so exit
      exit(0) ;
    }
  }

  // If this is reached then the child did not return within a minute so
  // print out the error to the file

  errorFile(output) ;

#endif

  return 0 ;
}
