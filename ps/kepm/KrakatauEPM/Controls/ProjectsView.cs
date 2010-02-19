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
 * CAM  19-Feb-2010  10558 : Added RefreshResults, general tidy including separting Designer code.
 * CAM  19-Feb-2010  10558 : Added Event plumbing.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.ComponentModel;
using System.Windows.Forms;
using System.Drawing;

using SourceCodeMetrics.Krakatau.Kepm.Forms;
using SourceCodeMetrics.Krakatau.Kepm.Projects;
using SourceCodeMetrics.Krakatau.Kepm.Results;

namespace SourceCodeMetrics.Krakatau.Kepm.Controls
{
  /// <summary>
  /// ProjectsView is a ListView to display ProjectItems.
  /// </summary>
  public partial class ProjectsView : ListView
  {
    private ContextMenu _popUpMenu;

    public event RefreshViewRequested RefreshView;

    public ProjectsView()
      : base()
    {
      _popUpMenu = new ContextMenu();
      _popUpMenu.MenuItems.Add("Set as &Old", new EventHandler(PopUpMenuSetAsOld));
      _popUpMenu.MenuItems.Add("Set as &New", new EventHandler(PopUpMenuSetAsNew));
      _popUpMenu.MenuItems.Add("-");

      MenuItem refresh = new MenuItem("Re&fresh Results", new EventHandler(PopUpMenuRefreshResults));
      refresh.Shortcut = Shortcut.F5;
      _popUpMenu.MenuItems.Add(refresh);

      _popUpMenu.MenuItems.Add("-");
      _popUpMenu.MenuItems.Add("&Deselect", new EventHandler(PopUpMenuDeselect));
      _popUpMenu.MenuItems.Add("&Remove", new EventHandler(PopUpMenuRemove));
      ContextMenu = _popUpMenu;

      ShowItemToolTips = true;
    }

    protected virtual void OnRefreshView(RefreshViewArgs e)
    {
      RefreshView(this, e);
    }

    public void AddProject(Project p)
    {
      ProjectItem pi = new ProjectItem(p);
      Items.Add(pi);
    }

    public void SetAsOld()
    {
      ProjectItem pi = (ProjectItem)FocusedItem;
      if (pi != null)
      {
        foreach (ProjectItem cpi in Items)
        {
          if (cpi.Project.OldProject) cpi.ClearStatus();
        }

        pi.SetOld();
      }
    }

    public void SetAsNew()
    {
      ProjectItem pi = (ProjectItem)FocusedItem;
      if (pi != null)
      {
        foreach (ProjectItem cpi in Items)
        {
          if (cpi.Project.NewProject) cpi.ClearStatus();
        }

        pi.SetNew();
      }
    }

    /// <summary>
    /// Attempt to find the project marked as new.  If none, return the focused item (which may be null).
    /// </summary>
    /// <returns></returns>
    protected ProjectItem FindNew()
    {
      foreach (ProjectItem pi in Items)
      {
        if (pi.Project.NewProject) return pi;
      }
      return (ProjectItem)FocusedItem;
    }

    public void RefreshResults()
    {
      ProjectItem pi = FindNew();
      if (pi != null)
      {
        RefreshViewArgs e = new RefreshViewArgs(pi.Project);
        OnRefreshView(e);
      }
    }

    public void SetAsDeselected()
    {
      ProjectItem pi = (ProjectItem)FocusedItem;
      if (pi != null)
      {
        pi.ClearStatus();
      }
    }

    public void CloseProject()
    {
      ProjectItem pi = (ProjectItem)FocusedItem;
      if (pi != null) Items.Remove(pi);
    }

    private void PopUpMenuSetAsOld(object sender, EventArgs e)
    {
      SetAsOld();
    }
    private void PopUpMenuSetAsNew(object sender, EventArgs e)
    {
      SetAsNew();
    }
    private void PopUpMenuRefreshResults(object sender, EventArgs e)
    {
      RefreshResults();
    }
    private void PopUpMenuDeselect(object sender, EventArgs e)
    {
      SetAsDeselected();
    }
    private void PopUpMenuRemove(object sender, EventArgs e)
    {
      CloseProject();
    }
  }
}
