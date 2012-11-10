/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Power Software Hashing Functions
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2010  10648 : Added.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef FUNCTIONS_POWERHASH
#define FUNCTIONS_POWERHASH

#include <stdio.h>

unsigned int RSHash  (char* str, unsigned int len);
unsigned int JSHash  (char* str, unsigned int len);
unsigned int PJWHash (char* str, unsigned int len);
unsigned int ELFHash (char* str, unsigned int len);
unsigned int BKDRHash(char* str, unsigned int len);
unsigned int SDBMHash(char* str, unsigned int len);
unsigned int DJBHash (char* str, unsigned int len);
unsigned int DEKHash (char* str, unsigned int len);
unsigned int BPHash  (char* str, unsigned int len);
unsigned int FNVHash (char* str, unsigned int len);
unsigned int APHash  (char* str, unsigned int len);

unsigned int PowerHash(char* str);

#endif
