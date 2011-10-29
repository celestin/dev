/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software Hephaestus License Technology
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Oct-2011  11037 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.IO;

namespace PowerSoftware.Tools.Licensing.Hephaestus
{
  public class LicFileHelper
  {
    private Stack<DirectoryInfo> _dirs;
    private LicenseFile _licenseFile;

    public Stack<DirectoryInfo> Dirs
    {
      get
      {
        if (_dirs == null) _dirs = new Stack<DirectoryInfo>();
        return _dirs;
      }
    }

    public LicenseFile LicenseFile
    {
      get { return _licenseFile; }
      set { _licenseFile = value; }
    }

    public LicFileHelper()
    {
      // Look in lic.exe's directory (i.e. installed directory)
      Dirs.Push(new FileInfo(System.Reflection.Assembly.GetExecutingAssembly().Location).Directory);

      // Look in user's home directory
      Dirs.Push(new DirectoryInfo(Path.Combine(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "PowerSoftware.com"), "EPM")));
    }

    public bool FindFile()
    {
      FileInfo file;

      while (Dirs.Count > 0)
      {
        file = new FileInfo(Path.Combine(Dirs.Pop().FullName, "license.dat"));
        if (file.Exists)
        {
          LicenseFile = new LicenseFile( file);
          return true;
        }
      }

      return false;
    }
  }
}
