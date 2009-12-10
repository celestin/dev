/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * SCM License Generator
 * Copyright (c) 2006,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  27-Sep-08  1000 : Upgraded to include Classic licensing options.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace PowerSoftware.Tools.LicGen
{
  class LicGen
  {
    /// <summary>
    /// The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main()
    {
      Application.Run(new FormLicGen());
    }
  }
}
