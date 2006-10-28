/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Metrics Constants
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  03-Jan-05  File added.
 * CAM  24-Jan-05  Added Halstead metrics.
 * CAM  03-Feb-05    40 : Added Changed FILE metrics
 * CAM  25-Nov-05   164 : Added NFILE metric.
 * CAM  28-Jan-06   168 : Added METID.
 * CAM  18-Jul-06   272 : Added CHG,DEL,ADD LLOC.
 * CAM  19-Sep-06   117 : Added SLOC* metrics for html-generating languages.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define LOG2 0.693147

#define METS      32
#define METFILE   29

#define LOC       100
#define SLOC      101
#define SLOC_NAT  102
#define SLOC_TAG  103
#define SLOC_HTM  104
#define SLOC_SCR  105
#define NSC       106
#define N1        107
#define N2        108
#define N1S       109
#define N2S       110
#define N         111
#define NS        112
#define V         113
#define D         114
#define E         115
#define B         116
#define J_COM     117
#define C_COM     118
#define CPP_COM   119
#define COM_LOC   120
#define BYTES     121
#define NFILE     122

#define CLOC      123
#define DLOC      124
#define ALOC      125

#define CLLOC     126
#define DLLOC     127
#define ALLOC     128

#define CFILE     129
#define DFILE     130
#define AFILE     131

#define MET(X)    (X-100)
#define METID(X)  (X+100)























