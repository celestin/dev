/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PParse - XML Configuration File Parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  16-Aug-05  File added.
 * CAM  28-Jan-06   168 : Added include for MetricSet.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#if defined(XERCES_NEW_IOSTREAMS)
#include <iostream>
#else
#include <iostream.h>
#endif
#include <string.h>
#include <stdlib.h>
#include "PParseHandlers.hpp"
#include "Extension.h"
#include "MetricSet.h"
#include "XMLConfig.h"


