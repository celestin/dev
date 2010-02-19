/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  19-Feb-2010  10558 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;

using SourceCodeMetrics.Krakatau.Kepm.Projects;

namespace SourceCodeMetrics.Krakatau.Kepm.Results
{
  public class RefreshViewArgs : EventArgs
  {
    private Project _project;

    public Project Project
    {
      get { return _project; }
      set { _project = value; }
    }

    public RefreshViewArgs(Project project)
    {
      _project = project;
    }
  }

  public delegate void RefreshViewRequested(object sender, RefreshViewArgs e);
}
