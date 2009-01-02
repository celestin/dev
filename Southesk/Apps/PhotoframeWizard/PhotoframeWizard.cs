/* * * * * * * * * * * * * * * * * * * * * * * *
 * Photoframe Wizard
 * Copyright (c) 2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  02-Jan-2009  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Fb.Apps.PhotoframeWizard
{
    static class PhotoframeWizard
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new FrmPhotoframeWizard());
        }
    }
}
