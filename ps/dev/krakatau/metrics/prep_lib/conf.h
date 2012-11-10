#ifndef CONF_READER_HEADER
#define CONF_READER_HEADER

#include "replace.h"
#include <vector>

extern bool loadReplacements(const char*filename, std::vector<Replacement*>&) ;

#endif