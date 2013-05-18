/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Dec-2012  11149 : Created.
 * CAM  18-May-2013  11172 : Added call to ExtractMaximo form.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.IO;  
using System.Windows.Forms;

using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data;
using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Tree;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Forms
{
  public partial class App : Form
  {
    private HierarchyTree _hierarchyTree;

    public HierarchyTree HierarchyTree
    {
      get { return _hierarchyTree; }
      set { _hierarchyTree = value; }
    }

    public App()
    {
      InitializeComponent();
      AlignHorizontalSplits();
      SetColors();

      HierarchyTree = new HierarchyTree(trvHierarchy, cmsHierarchy);
    }

    private void SetColors()
    {
      Color resultsGreen = Color.FromArgb(166, 206, 57);
      lblHierarchy.BackColor = lblLocation.BackColor = lblMaintenance.BackColor = lblWorkorders.BackColor = resultsGreen;      
    }

    private void OpenAccessDatabase(object sender, EventArgs e)
    {
      ofdAccessDb.Title = "Select Access Database containing Maintenance Build Review";

      if (ofdAccessDb.ShowDialog() == DialogResult.OK)
      {
        FileInfo db = new FileInfo(ofdAccessDb.FileName);
        if (db.Exists)
        {
          if (!AccessDatalayer.Instance.Open(db))
          {
            MessageBox.Show("Could not open Database!");
            return;
          }

          this.Text = "Maintenance Build Review - " + Config.Instance.RootDescription;
          HierarchyTree.Populate();
        }
      }
    }

    private void ExtractMaximoData(object sender, EventArgs e)
    {
      ExtractMaximo em = new ExtractMaximo();
      em.Show();
    }

    private void ExitApplication(object sender, EventArgs e)
    {
      Application.Exit();
    }

    private void AlignHorizontalSplits()
    {
      splitContainer3.SplitterDistance = splitContainer2.SplitterDistance;
    }

    private void App_SizeChanged(object sender, EventArgs e)
    {
      AlignHorizontalSplits();
    }

    private void splitContainer1_SplitterMoved(object sender, SplitterEventArgs e)
    {
      ActiveControl = trvHierarchy;
    }

    private void splitContainer2_SplitterMoved(object sender, SplitterEventArgs e)
    {
      AlignHorizontalSplits();
      ActiveControl = trvHierarchy;
    }

    private void splitContainer3_SplitterMoved(object sender, SplitterEventArgs e)
    {
      splitContainer2.SplitterDistance = splitContainer3.SplitterDistance;
      ActiveControl = trvHierarchy;
    }

    private void splitContainer1_Paint(object sender, PaintEventArgs e)
    {
      PaintGrabHandle((SplitContainer)sender, e);
    }

    private void splitContainer2_Paint(object sender, PaintEventArgs e)
    {
      PaintGrabHandle((SplitContainer)sender, e);
    }

    private void splitContainer3_Paint(object sender, PaintEventArgs e)
    {
      PaintGrabHandle((SplitContainer)sender, e);
    }

    private void PaintGrabHandle(SplitContainer control, PaintEventArgs e)
    {
      //paint the three dots
      Point[] points = new Point[3];
      var w = control.Width;
      var h = control.Height;
      var d = control.SplitterDistance;
      var sW = control.SplitterWidth;

      //calculate the position of the points'
      if (control.Orientation == Orientation.Horizontal)
      {
        points[0] = new Point((w / 2), d + (sW / 2));
        points[1] = new Point(points[0].X - 10, points[0].Y);
        points[2] = new Point(points[0].X + 10, points[0].Y);
      }
      else
      {
        points[0] = new Point(d + (sW / 2), (h / 2));
        points[1] = new Point(points[0].X, points[0].Y - 10);
        points[2] = new Point(points[0].X, points[0].Y + 10);
      }

      foreach (Point p in points)
      {
        p.Offset(-2, -2);
        e.Graphics.FillEllipse(SystemBrushes.ControlDark,
            new Rectangle(p, new Size(3, 3)));

        p.Offset(1, 1);
        e.Graphics.FillEllipse(SystemBrushes.ControlLight,
            new Rectangle(p, new Size(3, 3)));
      }
    }

    private void HierarchyTreeExpandAll(object sender, EventArgs e)
    {
      trvHierarchy.Nodes[0].ExpandAll();
    }

    private void HierarchyTreeCollapseAll(object sender, EventArgs e)
    {
      trvHierarchy.Nodes[0].Collapse();
    }

    private void FindLocation(object sender, EventArgs e)
    {
      FindLocation();
    }

    private void tstFindLocation_KeyPress(object sender, KeyPressEventArgs e)
    {
      if (e.KeyChar == (char)Keys.Return) FindLocation();
    }

    private void FindLocation()
    {      
      if (trvHierarchy.Nodes.Count < 1) return;
      if (tstFindLocation.Text.Length < 1) return;

      LocNode startNode = (LocNode)trvHierarchy.SelectedNode;
      if (startNode == null) startNode = (LocNode)trvHierarchy.Nodes[0];

      FindLocation(startNode, tstFindLocation.Text);
    }

    private bool FindLocation(LocNode node, string findText)
    {
      if (node.Location.Match(findText))
      {
        trvHierarchy.SelectedNode = node;
        return true;
      }

      foreach (LocNode child in node.Nodes)
      {
        if (FindLocation(child, findText)) return true;
      }

      return false;
    }

    private void LocationNodeSelected(object sender, TreeViewEventArgs e)
    {
      tabLocation.SelectedIndex = 0;
      LocNode node = (LocNode)e.Node;
      Location loc = node.Location;

      txtLocation.Text = loc.Code;
      txtStatus.Text = ActionStatuses.ToString(loc.ActionStatus);
      ShowChangeableValue(loc.Description, txtDescriptionNew, txtDescriptionCurr);
      ShowChangeableValue(loc.Parent, txtParentNew, txtParentCurr);
    }

    private void ShowChangeableValue(Changeable c, TextBox txtNew, TextBox txtCurr)
    {
      txtNew.Text = c.NewValue;
      txtCurr.Text = c.CurrentValue;
    }

    private void HierarchyMouseClick(object sender, MouseEventArgs e)
    {
      if (e.Button == MouseButtons.Right)
      {
        Point pt = new Point(e.X, e.Y);
        trvHierarchy.PointToClient(pt);

        TreeNode Node = trvHierarchy.GetNodeAt(pt);
        if (Node != null)
        {
          if (Node.Bounds.Contains(pt))
          {
            trvHierarchy.SelectedNode = Node;
          }
        }
      }
    }

    private void CopyLocationValue(object sender, EventArgs e)
    {
      LocNode node = (LocNode)trvHierarchy.SelectedNode;
      Clipboard.Clear();
      Clipboard.SetText(node.Location.Code);
    }

    private void HelpAbout(object sender, EventArgs e)
    {
      AboutMbr about = new AboutMbr();
      about.ShowDialog();
    }
  }
}
