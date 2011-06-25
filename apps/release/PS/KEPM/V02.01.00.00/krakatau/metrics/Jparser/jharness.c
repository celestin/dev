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

// Safety harness for parser
//
// 1. Launch parser subprocess
// can we open a pipe to a parser process
// 2. Setup signal handler to exit if parser exits
// 3. Wait 25 seconds
// 4. Exit

#include <stdio.h>
#ifdef WIN32
  #include <io.h>
  #include <process.h>
  #include <string.h>
  #include <fcntl.h>
#else
  #include <unistd.h>
#endif
#include <malloc.h>
#include <signal.h>

// *****************************************

void parserdone(int x) {

printf("CHILD DONE\n");
exit(0);

};

// *****************************************

void main(int argc, char** argv) {

//hThread = CreateThread(NULL,0,(LPTHREAD_START_ROUTINE)Validate,NULL,0,&iID);
//long WINAPI Validate(long lParam)
//{

//}
int i,pid;
char *input_filename,*output_filename,*original_filename;
int this_to_parser[2];

signal(SIGCHLD,parserdone);
input_filename=(char*)malloc(1000);
original_filename=(char*)malloc(1000);
output_filename=(char*)malloc(1000);

if (argc>1) {
#ifdef WIN32
  _execlp("jparser_internal","jparser_internal",argv[1],NULL);
} else {
  _pipe(this_to_parser,512,_O_BINARY);
  if (pid=fork()==0) {
  _close(this_to_parser[1]);
  _dup2(this_to_parser[0],0);
    _execlp("jparser_internal","jparser_internal",NULL);
    perror("ERROR: \n");
  };
  _close(this_to_parser[0]);
#else
  execlp("jparser_internal","jparser_internal",argv[1],NULL);
} else {
  pipe(this_to_parser);
  if (pid=fork()==0) {
    close(this_to_parser[1]);
    dup2(this_to_parser[0],0);
    execlp("jparser_internal","jparser_internal",NULL);
    perror("ERROR: \n");
  };
  close(this_to_parser[0]);
#endif
  gets(input_filename);strcat(input_filename,"\n");
  gets(original_filename);strcat(original_filename,"\n");
  gets(output_filename);strcat(output_filename,"\n");
#ifdef WIN32
  _write(this_to_parser[1],input_filename,strlen(input_filename));
  _write(this_to_parser[1],original_filename,strlen(original_filename));
  _write(this_to_parser[1],output_filename,strlen(output_filename));
#else
  write(this_to_parser[1],input_filename,strlen(input_filename));
  write(this_to_parser[1],original_filename,strlen(original_filename));
  write(this_to_parser[1],output_filename,strlen(output_filename));
#endif
};

for (i=0;i<60;i++) { printf("WAIT\n");sleep(1); };
printf("TIMED OUT.  COMMITING INFANTICIDE ON PROCESS: %d.\n",pid);
kill(9,pid);
return;

};

// ****************************************
