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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define LOG2 0.693147

#define METS    25
#define METFILE 22

#define LOC     100
#define SLOC    101
#define NSC     102
#define N1      103
#define N2      104
#define N1S     105
#define N2S     106
#define N       107
#define NS      108
#define V       109
#define D       110
#define E       111
#define B       112
#define J_COM   113
#define C_COM   114
#define CPP_COM 115
#define COM_LOC 116
#define BYTES   117
#define NFILE   118

#define CLOC    119
#define DLOC    120
#define ALOC    121

#define CFILE   122
#define DFILE   123
#define AFILE   124

#define MET(X)   (X-100)
#define METID(X) (X+100)

