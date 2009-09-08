/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Metrics Constants
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  03-Jan-05    File added.
 * CAM  24-Jan-05    Added Halstead metrics.
 * CAM  03-Feb-05    40 : Added Changed FILE metrics
 * CAM  25-Nov-05    164 : Added NFILE metric.
 * CAM  28-Jan-06    168 : Added METID.
 * CAM  18-Jul-06    272 : Added CHG,DEL,ADD LLOC.
 * CAM  19-Sep-06    117 : Added SLOC* metrics for html-generating languages.
 * CAM  17-Apr-2009  10430 : Added Churn metrics.
 * CAM  09-Sep-2009  10479 : Add PLOC.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define LOG2 0.693147

#define METS      36
#define METFILE   32

#define LOC       100
#define SLOC      101
#define SLOC_NAT  102
#define SLOC_TAG  103
#define SLOC_HTM  104
#define SLOC_SCR  105
#define PLOC      106
#define LLOC      107
#define N1        108
#define N2        109
#define N1S       110
#define N2S       111
#define N         112
#define NS        113
#define V         114
#define D         115
#define E         116
#define B         117
#define J_COM     118
#define C_COM     119
#define CPP_COM   120
#define COM_LOC   121
#define BYTES     122
#define NFILE     123

#define CLOC      124
#define DLOC      125
#define ALOC      126
#define XLOC      127

#define CLLOC     128
#define DLLOC     129
#define ALLOC     130
#define XLLOC     131

#define CFILE     132
#define DFILE     133
#define AFILE     134
#define XFILE     135

#define MET(X)    (X-100)
#define METID(X)  (X+100)























