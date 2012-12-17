/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Dec-2012  11149 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Tree
{
  public class HierarchyTree
  {
    private TreeView _tree;
    private ContextMenuStrip _contextMenuStrip;

    public TreeView Tree
    {
      get { return _tree; }
      set { _tree = value; }
    }
    public ContextMenuStrip ContextMenuStrip
    {
      get { return _contextMenuStrip; }
      set { _contextMenuStrip = value; }
    }


    public HierarchyTree(TreeView treeView, ContextMenuStrip contextMenuStrip)
    {
      Tree = treeView;
      ContextMenuStrip = contextMenuStrip;
    }

    public void Populate()
    {
      Config cfg = Config.Instance;
      Tree.Nodes.Clear();

      if (!cfg.ReviewDataActive) return;

      LocationCollection locs = AccessDatalayer.Instance.GetLocations();

      LocNode root = null;
      foreach (Location loc in locs)
      {
        if (loc.Code.Equals(cfg.RootCode))
        {
          root = new LocNode(loc);
          root.ContextMenuStrip = ContextMenuStrip;
        }
      }

      if (root != null)
      {
        GetChildren(root, locs);

        root.Expand();

        Tree.Nodes.Add(root);
      }
    }

    public void GetChildren(LocNode locNode, LocationCollection locs)
    {
      foreach (Location loc in locs)
      {
        if (loc.Parent.NewValue.Equals(locNode.Code))
        {
          LocNode child = new LocNode(loc);
          child.ContextMenuStrip = ContextMenuStrip;

          locNode.Nodes.Add(child);
          GetChildren(child, locs);
        }
      }
    }
  }
}
