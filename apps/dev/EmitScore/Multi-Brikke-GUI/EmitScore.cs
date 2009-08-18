/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Changed copyright text.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Windows.Forms;

using FrontBurner.Apps.EmitScore.MultiBrikke.Forms;

namespace FrontBurner.Apps.EmitScore.MultiBrikke
{
  static class EmitScore
  {
    /// <summary>
    /// The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main()
    {
      try
      {
        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);
        Application.Run(new FrmMain());
      }
      catch (Exception e)
      {
        MessageBox.Show(String.Format("{0}\n\n{1}",
          e.Message, e.StackTrace), "Error during EmitScore",
          MessageBoxButtons.OK, MessageBoxIcon.Error);
      }
    }
  }
}
