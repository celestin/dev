/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id$
 *
 * Who  When         Why
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Windows.Forms;

using Southesk.Apps.EmitScore.Forms;

namespace Southesk.Apps.EmitScore
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
