/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Java Parser (JPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-Mar-08  346 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifdef WIN32
#include <windows.h>
#include <stdlib.h>
#include <process.h>
#else
#include <stl.h>
#include <unistd.h>
#include <sys/wait.h>
#endif
#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <signal.h>
#include "codefn.h"
#include "lexical_analysis.h"
#include "jil.h"

void show_jil();
int parse_Goal(char*);
int java_filename_to_jil_filename(char*);
void init_jil();

extern lexeme *jil_lexemes;
extern int n_lexemes;
extern int lex_index;

char *infile,*outfile ;


void parserdone(int x) {
  exit(0);
};


void harness(void *param) {
#ifdef WIN32
  Sleep(60000);
#else
  usleep(60000);
#endif
  _exit(0);
}




#ifdef WIN32

unsigned long _stdcall winThread(void *in) {
  (void)parse_Goal(infile);
  n_jil_lexemes=jil_index-1;
  return 0 ;
}

#ifdef CONSOLE_RELEASE
int main(int argc, char* argv[]) {
#else
int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
  int argc = 1 ;
  char* argv[20] ;

  char* i=lpCmdLine ;
  char* argStart=i ;
  int length = strlen(lpCmdLine) ;

  for (int k=0  ; k<=length ; i++,k++ ) {

    if ( ((*i) == ' ') || (k==length) ){

      (*i) = '\0';
      argv[argc] = (char*) malloc (1024 * sizeof(char*));
      sprintf_s(argv[argc],MAX_PATH,"%s",argStart);

      argc++ ;

      argStart = i ;
      argStart++ ;
    }

  }
#endif
#else
int main(int argc, char* argv[]) {
#endif

  FILE* pipefile;
  infile=(char*)malloc(1000);
  outfile=(char*)malloc(1000);
  int writeToParentFD/*, readFromParentFD*/ ;
  FILE *output ;


  bool singleFile = false ;

  if (argc==2) {
    decodefn(argv[1]);
    if ((pipefile=fopen(argv[1],"r"))==NULL)
    {
      fprintf(stderr,"%s %s","CANNOT OPEN PARSE INFO FILE\n",argv[1]);
      fflush(stderr);
      exit(0);
    }
    else
    {
      fgets(infile,1000,pipefile);
      fgets(outfile,1000,pipefile);
      *(strchr(infile,'\0')-1)='\0';
      *(strchr(outfile,'\0')-1)='\0';
    }

    decodefn(outfile);
    output = fopen(outfile,"w") ;
  }
  else if (argc==4)
  {
    singleFile = true ;
    infile = _strdup(argv[2]) ;
    writeToParentFD=atoi(argv[3]);

    if( (output = fdopen(writeToParentFD,"w")) == NULL )
      exit( 1 );
  }

  decodefn(infile);
  lexical_analysis(infile);
  init_jil();

#ifdef WIN32
  DWORD id ;
  HANDLE harnessHandle = CreateThread(NULL,0,winThread,NULL,0,&id) ;
  //SetThreadPriority(winThread,THREAD_PRIORITY_ABOVE_NORMAL) ;

  if ( WaitForSingleObject(harnessHandle, 60000) != WAIT_TIMEOUT )
    output_jil_to_file(output);
  else
    errorFile(output);

  fclose(output) ;
  _exit(0) ;

#else
  signal(SIGCHLD,parserdone);

  // on UNIX platforms, harness works by fork()ing
  pid_t pid;

  if (pid=fork()==0) {
    (void)parse_Goal(infile);
    n_jil_lexemes=jil_index-1;
    output_jil_to_file(output);
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
      exit(0) ;
    }
  }

  // If this is reached then the child did not return within a minute so
  // print out the error to the file
  errorFile(output) ;

#endif

  return 0;
}
