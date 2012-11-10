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

void initialise();
void declaration_seq();
void show_tree();
void errorFile(FILE*) ;
void statistics(FILE*) ;
extern char* filename;
extern void append_sloc_information();
token nexttok();
void advance();
void unadvance();
int the_end();
void set_command (int com,int param,char* str,int line, int startcol, int endcol);
char* sym_text(int,int);
int thisline();
int thiscol();
int lastcol();
halstead compute_halstead(int min,int max);
void panic();
void tidyup() ;

class control_exec {
public:
  int control;
  int executable;

  control_exec() : control(0), executable(0) {}
};

#include <stack>
using namespace std;
extern stack< class control_exec*> density;
