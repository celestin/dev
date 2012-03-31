/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Backlog Prioritisation
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  31-MAr-2012  11104 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;
using System.Drawing;

using FrontBurner.Tmax.Apps.BacklogPrioritisation.Data;

namespace FrontBurner.Tmax.Apps.BacklogPrioritisation.Forms
{
  public partial class StartCentre : Form
  {
    public StartCentre()
    {
      InitializeComponent();

      Datalayer dl = new Datalayer();
      dl.TestConnection();

      priorityChart.Series[0].Points[0].Color = Color.Blue;
      priorityChart.Series[0].Points[1].Color = Color.Green;
      priorityChart.Series[0].Points[2].Color = Color.Orange;
      priorityChart.Series[0].Points[3].Color = Color.RosyBrown;
    }

    private void ProgressStatusSelected(object sender, MouseEventArgs e)
    {
      HitTestResult hit = ((Chart)sender).HitTest(e.X, e.Y);
      double x = hit.ChartArea.AxisX.PixelPositionToValue(e.X);
      double y = hit.ChartArea.AxisY.PixelPositionToValue(e.Y);
      DataPoint dataPoint = new DataPoint(x, y);

      if (hit.PointIndex > -1)
      {
        string status = progressPie.Series[0].Points[hit.PointIndex].AxisLabel;
        priorityChart.Titles[0].Text = String.Format("{0} Workorders by Priority", status);

        priorityChart.Visible = true;
        Random random = new Random();
        foreach (DataPoint dp in priorityChart.Series[0].Points)
        {
          dp.YValues[0] = random.Next(10, 500);
        }
        priorityChart.Invalidate();
        priorityChart.Update();
      }
    }

    private void PrioritySelected(object sender, MouseEventArgs e)
    {
      HitTestResult hit = ((Chart)sender).HitTest(e.X, e.Y);
      MessageBox.Show(hit.PointIndex.ToString());

    }

    private void chart2_Click(object sender, EventArgs e) { }

    private void chart1_Click(object sender, EventArgs e) { }


    private void mnuExit_Click(object sender, EventArgs e)
    {
      this.Close();
    }

  }
}
