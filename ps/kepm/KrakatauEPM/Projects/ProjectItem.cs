/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * KEPM Visual ListViewItem component
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  24-Jan-06   185 : Added New/Old awareness for saving/restoring projects.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace SourceCodeMetrics.Krakatau.Kepm.Projects
{
	/// <summary>
	/// UI Project Item.
	/// </summary>
	public class ProjectItem : System.Windows.Forms.ListViewItem
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
        this.setNew();
      } 
      else if (_project.OldProject) 
      {
        this.setOld();
      }
      else 
      {
        this.clearStatus();
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

    public void clearStatus() 
    {
      _project.NewProject = false;
      _project.OldProject = false;

      if (this.ImageIndex != 1)
      {
        this.ImageIndex = 1;
      }
    }

    public void setNew() 
    {
      _project.NewProject = true;

      if (this.ImageIndex != 3)
      {
        this.ImageIndex = 3;
      }
    }

    public void setOld() 
    {
      _project.OldProject = true;

      if (this.ImageIndex != 2)
      {
        this.ImageIndex = 2;
      }
    }
  }
}
