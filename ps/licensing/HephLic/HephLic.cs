/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software Hephaestus License Technology
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  25-Oct-2011  11037 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.IO;

using PowerSoftware.Tools.Licensing.Hephaestus;

namespace PowerSoftware.Tools.Licensing.HephLic
{
  public class HephLic
  {
    private Stack<DirectoryInfo> _dirs;
    private FileInfo _licenseFile;

    public Stack<DirectoryInfo> Dirs
    {
      get
      {
        if (_dirs == null) _dirs = new Stack<DirectoryInfo>();
        return _dirs;
      }
    }

    public FileInfo LicenseFile
    {
      get { return _licenseFile; }
      set { _licenseFile = value; }
    }

    public HephLic()
    {
    }

    public bool FindFile()
    {
      FileInfo file;

      while (Dirs.Count > 0)
      {
        file = new FileInfo(Path.Combine(Dirs.Pop().FullName, "license.dat"));
        if (file.Exists)
        {
          LicenseFile = file;
          return true;
        }
      }

      return false;
    }

    static int Main(string[] args)
    {
      HephLic lic = new HephLic();

      // Look in lic.exe's directory (i.e. installed directory)
      lic.Dirs.Push(new FileInfo(System.Reflection.Assembly.GetExecutingAssembly().Location).Directory);

      // Look in user's home directory
      lic.Dirs.Push(new DirectoryInfo(Path.Combine(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "PowerSoftware.com"), "EPM")));

      if (lic.FindFile())
      {
        LicenseFile licFile = new LicenseFile(lic.LicenseFile);
        licFile.Load();
        //Console.WriteLine(licFile.Features.Sum());
        return licFile.Features.Sum();
      }

      return 0;
    }
  }
}
