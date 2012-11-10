/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * KEPM Visual ListViewItem component
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  24-Jan-06   185 : Added New/Old awareness for saving/restoring projects.
 * CAM  19-Feb-2010  10558 : Added Tooltips.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace PowerSoftware.Krakatau.Kepm.Projects
{
  /// <summary>
  /// UI Project Item.
  /// </summary>
  public class ProjectItem : ListViewItem
  {
    private Project _project = null;

    public ProjectItem(): base()
    {
      _project = new Project();
    }
    public ProjectItem(Project project): base(project.Title)
    {
      _project = project;

      if (_project.NewProject)
      {
        this.SetNew();
      }
      else if (_project.OldProject)
      {
        this.SetOld();
      }
      else
      {
        this.ClearStatus();
      }
    }

    public void RefreshProject()
    {
      base.Text = _project.Title;
    }

    public Project Project
    {
      get
      {
        return _project;
      }
      set
      {
        _project = value;
      }
    }

    public void ClearStatus()
    {
      _project.NewProject = false;
      _project.OldProject = false;
      ToolTipText = String.Empty;

      if (this.ImageIndex != 1)
      {
        this.ImageIndex = 1;
      }
    }

    public void SetNew()
    {
      _project.NewProject = true;
      ToolTipText = "New Project";

      if (this.ImageIndex != 3)
      {
        this.ImageIndex = 3;
      }
    }

    public void SetOld()
    {
      _project.OldProject = true;
      ToolTipText = "Old Project";

      if (this.ImageIndex != 2)
      {
        this.ImageIndex = 2;
      }
    }
  }
}
