/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * A ListView for displaying ProjectItems
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-Nov-05   160 : Class created.
 * CAM  20-Dec-05   170 : Added Remove Project to the right-click menu.
 * CAM  09-Feb-06   185 : Added addProject.
 * CAM  18-Mar-06   210 : Added Deselect to the right-click menu.
 * CAM  24-May-08   362 : Updated for VS2008.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.ComponentModel;
using System.Windows.Forms;
using System.Drawing;

namespace KrakatauEPM
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
      popUpMenu.MenuItems.Add("Set as &Old", new EventHandler(popUpMenu_Old_clicked));
      popUpMenu.MenuItems.Add("Set as &New", new EventHandler(popUpMenu_New_clicked));
      popUpMenu.MenuItems.Add("&Deselect", new EventHandler(popUpMenu_Deselect_clicked));
      popUpMenu.MenuItems.Add("&Remove", new EventHandler(popUpMenu_Remove_clicked));
      this.ContextMenu = popUpMenu;

      this.hoverTip = new ToolTip();
      this.lastPi = null;
      this.hoverTimer = new Timer();
      this.MouseMove += new System.Windows.Forms.MouseEventHandler(this.projectView_MouseMove);
    }

    public void addProject(Project p)
    {
      ProjectItem pi = new ProjectItem(p);
      this.Items.Add(pi);
    }

    public void setAsOld()
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

    public void setAsNew()
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

    public void setAsDeselected()
    {
      ProjectItem pi = (ProjectItem)this.FocusedItem;
      if (pi != null)
      {
        pi.clearStatus();
      }
    }

    public void closeProject()
    {
      ProjectItem pi = (ProjectItem)this.FocusedItem;
      if (pi != null) this.Items.Remove(pi);
    }

    private void popUpMenu_Old_clicked(object sender, EventArgs e)
    {
      setAsOld();
    }
    private void popUpMenu_New_clicked(object sender, EventArgs e)
    {
      setAsNew();
    }
    private void popUpMenu_Deselect_clicked(object sender, EventArgs e)
    {
      setAsDeselected();
    }
    private void popUpMenu_Remove_clicked(object sender, EventArgs e)
    {
      closeProject();
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
