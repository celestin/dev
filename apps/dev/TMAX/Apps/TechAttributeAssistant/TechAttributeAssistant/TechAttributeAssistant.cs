/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Technical Attribute Assistant
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Apr-2012  11113 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Windows.Forms;

using FrontBurner.Tmax.Apps.TechAttributeAssistant.Forms;

namespace FrontBurner.Tmax.Apps.TechAttributeAssistant
{
  static class TechAttributeAssistant
  {
    /// <summary>
    /// The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main()
    {
      Application.EnableVisualStyles();
      Application.SetCompatibleTextRenderingDefault(false);
      Application.Run(new App());
    }
  }
}
