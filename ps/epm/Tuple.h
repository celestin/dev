/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Tuple class
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  06-Jan-06  168 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef TUPLE_H
#define TUPLE_H

#include <iostream>

class Tuple {
  public:
    char *fId, *fDesc;
    Tuple() {}

    void set(const char *id, const char *desc) {
      fId = strdup(id);
      fDesc = strdup(desc);
    }

    friend ostream& operator << (ostream& os, const Tuple& t) {
      os << t.fId << " (" << t.fDesc << ")";
      return os;
    }

};

#endif