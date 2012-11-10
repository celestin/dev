#ifndef PREP_HEADER
#define PREP_HEADER

#include "replace.h"

#define TOKEN 10

#define DEFAULT 0
#define IGNORE_SEEK 1
#define APPEND_SEEK 2

#include <windows.h>
#include <winbase.h>

class Prep {

public:
	
	Prep() ;
	Prep(const char *) ;
	~Prep() ;

	void loadCfg(const char*) ;

	int prepFile(const char*) ;
	bool prepFD(int,int) ;

} ;


#endif