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
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Forms
{
  public partial class App : Form
  {
    public App()
    {
      InitializeComponent();
      AlignHorizontalSplits();
      SetColors();
    }

    private void SetColors()
    {
      Color resultsGreen = Color.FromArgb(166, 206, 57);
      lblHierarchy.BackColor = lblLocation.BackColor = lblMaintenance.BackColor = lblWorkorders.BackColor = resultsGreen;      
    }

    private void exitToolStripMenuItem_Click(object sender, EventArgs e)
    {
      Application.Exit();
    }

    private void tsbCount_Click(object sender, EventArgs e)
    {
    }

    private void tsbRetrieve_Click(object sender, EventArgs e)
    {
    }

    private void tsbExit_Click(object sender, EventArgs e)
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
      ActiveControl = treeView1;
    }

    private void splitContainer2_SplitterMoved(object sender, SplitterEventArgs e)
    {
      AlignHorizontalSplits();
      ActiveControl = treeView1;
    }

    private void splitContainer3_SplitterMoved(object sender, SplitterEventArgs e)
    {
      splitContainer2.SplitterDistance = splitContainer3.SplitterDistance;
      ActiveControl = treeView1;
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
  }
}
