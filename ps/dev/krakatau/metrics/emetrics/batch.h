/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential Metrics (EMETRICS.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  28-Mar-08  348 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "OurSQL.h"
#include "report.h"

#ifndef BATCH_HEADER
#define BATCH_HEADER

#include <stack>

#ifdef WIN32
	#include <windows.h>
	#include <windef.h>
	#include <process.h>
	#include <io.h>
	#include <direct.h>
#else
	#include <unistd.h>
#endif

#include <iostream>
#include <fstream>

#ifdef LANGUAGE_CPP
	#define FEATURE "cppem"
#elif LANGUAGE_JAVA
	#define FEATURE "javaem"
#endif


#include "lmpolicy.h"
#include <limits.h>
#include <fcntl.h>


#ifndef PATH_MAX
	#ifdef MAX_PATH
		#define PATH_MAX MAX_PATH
	#endif
#endif

#define QUERY_MAX 4096
#define PROJECT_MAX 2


#ifdef WIN32
	#define realpath(X,Y) _fullpath( Y, X, PATH_MAX )

	HANDLE createProcess(std::string cmdLine)
	{
		STARTUPINFO si ;
		PROCESS_INFORMATION pi ;

		memset(&pi, 0, sizeof(pi)) ;
		memset(&si, 0, sizeof(si)) ;

		si.cb = sizeof(si) ;
		si.dwFlags |= STARTF_USESHOWWINDOW ;
		si.wShowWindow |= SW_SHOWMINIMIZED ;

		char mpath[256] ;
		strcpy(mpath, cmdLine.c_str()) ;

		if (!CreateProcess(0,mpath, 0, 0, 0, 0, 0, 0, &si,&pi))
		{
			return NULL ;
		}

		return pi.hProcess ;
	}

	#define MkDir(X) mkdir(X)
#else
	#define MkDir(X) mkdir(X,755)
#endif

#include <sys/types.h>
#include <sys/stat.h>

#ifndef WIN32
	#include <sys/wait.h>
#endif

#define RECURSIVE_MASK 0x0000001
#define DIR_MASK 0x0000002
#define SINGLE_GRID_MASK 0x0000004
#define MULTIPLE_GRID_MASK 0x0000008
#define SINGLE_SYMB_MASK 0x0000010
#define MULTIPLE_SYMB_MASK 0x0000020
#define CSV_MASK 0x0000040
#define FILE_LIST_MASK 0x0000080
#define XML_MASK 0x0000100
#define OEM_MASK 0x0000200

#endif


/*
0x0000001
0x0000002
0x0000004
0x0000008
0x0000010
0x0000020
0x0000040
0x0000080
0x0000100
0x0000200
0x0000400
0x0000800
0x0001000
0x0002000
0x0004000
0x0008000
0x0010000
0x0020000
0x0040000
0x0080000
0x0100000
0x0200000
0x0400000
0x0800000
0x1000000
0x2000000
0x4000000
0x8000000
*/
