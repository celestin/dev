// msedw.cpp : Defines the entry point for the console application.
//

#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char* argv[]) {

  string sf = "C:\\Craig\\Scriptures\\MSE\\data\\data3.sql";
  string od = "C:\\Craig\\Scriptures\\MSE\\data\\upload\\";
  string of;

  ifstream src;
  ofstream trg;
  char ofn[256];
  int lines=0, fileid=0;

  src.open(sf.c_str());
  sprintf(ofn, "%d", ++fileid);
  of = od.c_str();
  of += "data_";
  of += ofn;
  of += ".sql";
  trg.open(of.c_str());

  cout << of.c_str() << endl;

  char s[4096];
  int i=0,j=0;
  bool first = true;

  while (!src.eof()) {
    src.getline(s, 4096);

    trg << s << endl;

    if (lines++ > 3500) {
      lines = 0;
      trg.flush();
      trg.close();

      sprintf(ofn, "%d", ++fileid);
      of = od.c_str();
      of += "data_";
      of += ofn;
      of += ".sql";
      trg.open(of.c_str());
      cout << of.c_str() << endl;
    }
  }

  src.close();
  trg.close();
  return 0;
}

