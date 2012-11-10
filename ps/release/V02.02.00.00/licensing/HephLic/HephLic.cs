/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software Hephaestus License Technology
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  25-Oct-2011  11037 : File created.
 * CAM  29-Oct-2011  11037 : Added error handling and moved the helper class to Hephaestus library.
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
    static int Main(string[] args)
    {
      LicFileHelper helper = new LicFileHelper();

      if (helper.FindFile())
      {
        try
        {
          helper.LicenseFile.Load();
        }
        catch
        {
          return -1; // Error - not a Hephaestus License
        }

        return helper.LicenseFile.Features.Sum();  // Licensed features
      }

      return 0; // Couldn't find a License file
    }
  }
}
