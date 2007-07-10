/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * XML Configuration Parser Constants
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  23-Aug-05  115 : File added.
 * CAM  06-Jan-06  168 : Added ERR_NEW_SET, ERR_NEW_MET.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef XMLCONFIG_H
#define XMLCONFIG_H

#define ERR_NEW_LANG 1
#define ERR_NEW_FTYPE 2
#define ERR_NEW_EXTN 4
#define ERR_TYPE_ERROR 8
#define ERR_TYPE_FATAL 16
#define ERR_TYPE_WARN 32
#define ERR_GEN_FAIL 64
#define ERR_GEN_MEM 128
#define ERR_GEN_XML 256
#define ERR_GEN_INIT 512

#define ERR_NEW_SET 1
#define ERR_NEW_MET 2

#endif