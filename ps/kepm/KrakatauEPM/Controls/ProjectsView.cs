/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * A ListView for displaying ProjectItems
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Nov-05    160 : Class created.
 * CAM  20-Dec-05    170 : Added Remove Project to the right-click menu.
 * CAM  09-Feb-06    185 : Added addProject.
 * CAM  18-Mar-06    210 : Added Deselect to the right-click menu.
 * CAM  24-May-08    362 : Updated for VS2008.
 * CAM  29-May-08    363 : Completed toolbar buttons.
 * CAM  18-Feb-2010  10574 : Renamed event handlers for consistency.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.ComponentModel;
using System.Windows.Forms;
using System.Drawing;

using SourceCodeMetrics.Krakatau.Kepm.Projects;

namespace SourceCodeMetrics.Krakatau.Kepm.Controls
{
  /// <summary>
  /// ProjectsView is a ListView to display ProjectItems.
  /// </summary>
  public class ProjectsView : System.Windows.Forms.ListView
  {
    private ContextMenu popUpMenu;
    private ToolTip hoverTip;
    private ProjectItem lastPi;
    private Timer hoverTimer;

    public ProjectsView()
      : base()
    {
      popUpMenu = new ContextMenu();
      popUpMenu.MenuItems.Add("Set as &Old", new EventHandler(PopUpMenuSetAsOld));
      popUpMenu.MenuItems.Add("Set as &New", new EventHandler(PopUpMenuSetAsNew));
      popUpMenu.MenuItems.Add("&Deselect", new EventHandler(PopUpMenuDeselect));
      popUpMenu.MenuItems.Add("&Remove", new EventHandler(PopUpMenuRemove));
      this.ContextMenu = popUpMenu;

      this.hoverTip = new ToolTip();
      this.lastPi = null;
      this.hoverTimer = new Timer();
      this.MouseMove += new System.Windows.Forms.MouseEventHandler(this.projectView_MouseMove);
    }

    public void AddProject(Project p)
    {
      ProjectItem pi = new ProjectItem(p);
      this.Items.Add(pi);
    }

    public void SetAsOld()
    {
      ProjectItem pi = (ProjectItem)this.FocusedItem;
      if (pi != null)
      {
        for (int i = 0; i < this.Items.Count; i++)
        {
          ProjectItem cpi = (ProjectItem)this.Items[i];
          if (cpi.Project.OldProject) cpi.clearStatus();
        }

        pi.setOld();
      }
    }

    public void SetAsNew()
    {
      ProjectItem pi = (ProjectItem)this.FocusedItem;
      if (pi != null)
      {
        for (int i = 0; i < this.Items.Count; i++)
        {
          ProjectItem cpi = (ProjectItem)this.Items[i];
          if (cpi.Project.NewProject) cpi.clearStatus();
        }

        pi.setNew();
      }
    }

    public void SetAsDeselected()
    {
      ProjectItem pi = (ProjectItem)this.FocusedItem;
      if (pi != null)
      {
        pi.clearStatus();
      }
    }

    public void CloseProject()
    {
      ProjectItem pi = (ProjectItem)this.FocusedItem;
      if (pi != null) this.Items.Remove(pi);
    }

    private void PopUpMenuSetAsOld(object sender, EventArgs e)
    {
      SetAsOld();
    }
    private void PopUpMenuSetAsNew(object sender, EventArgs e)
    {
      SetAsNew();
    }
    private void PopUpMenuDeselect(object sender, EventArgs e)
    {
      SetAsDeselected();
    }
    private void PopUpMenuRemove(object sender, EventArgs e)
    {
      CloseProject();
    }

    private void projectView_MouseMove(object sender, System.Windows.Forms.MouseEventArgs e)
    {
      ProjectItem item = (ProjectItem)this.GetItemAt(e.X, e.Y);
      if (item == null)
      {
        // The mouse isn't over any item -- hide the tooltip
        this.hoverTip.Active = false;
        this.hoverTimer.Enabled = false;
      }
      else if (item != this.lastPi)
      {
        // The item has changed, hide the tooltip and restart the timer.
        this.hoverTip.Active = false;
        this.hoverTimer.Tick += new EventHandler(hoverTimer_Tick);
        this.hoverTimer.Enabled = true;
      }

      this.lastPi = item;
    }

    private void hoverTimer_Tick(object sender, EventArgs e)
    {
      // The timer has gone off, show the tooltip and disable the timer.
      this.hoverTip.Active = true;

      if (this.lastPi.ImageIndex == 3)
      {
        this.hoverTip.SetToolTip(this, "New Project");
      }
      else if (this.lastPi.ImageIndex == 2)
      {
        this.hoverTip.SetToolTip(this, "Old Project");
      }

      hoverTimer.Enabled = false;
    }

    private void InitializeComponent()
    {
      this.SuspendLayout();
      //
      // ProjectsView
      //
      this.Tag = "";
      this.ResumeLayout(false);

    }
  }
}
