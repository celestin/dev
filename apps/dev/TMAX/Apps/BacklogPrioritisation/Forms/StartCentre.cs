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
using System.Data;  
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

      Datalayer dl = Datalayer.Instance;
      dl.Open();

      lblSite.Text = String.Format("{0} Workorder Backlog Prioritisation", dl.Site);

      DataPointCollection pc = progressPie.Series[0].Points;
      DataPoint p = null;
      Button b = null;

      DataSet prog = dl.GetProgressSummary();
      foreach (DataRow row in prog.Tables["Progress"].Rows)
      {
        switch (AssessmentStatuses.GetStatus(row["AssessmentStatus"].ToString()))
        {            
          case AssessmentStatus.New:
            p = pc[0];
            p.Color = Color.Orange;
            b = btnNew;
            break;
          case AssessmentStatus.Completed:
            p = pc[1];
            p.Color = Color.SeaGreen;
            b = btnComp;
            break;
          case AssessmentStatus.Cancelled:
            p = pc[2];
            p.Color = Color.Crimson;
            b = btnCan;
            break;
        }
        p.AxisLabel = row["Description"].ToString();
        p.YValues[0] = double.Parse(row["WoCount"].ToString());
        b.Text = p.AxisLabel;
        b.BackColor = p.Color;
      }

      progressPie.Invalidate();
      progressPie.Update();

      priorityChart.Series[0].Points[0].Color = Color.PaleTurquoise;
      priorityChart.Series[0].Points[1].Color = Color.MediumAquamarine;
      priorityChart.Series[0].Points[2].Color = Color.Teal;
      priorityChart.Series[0].Points[3].Color = Color.DarkSlateGray;
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

    private void btnNew_Click(object sender, EventArgs e)
    {

    }

    private void btnComp_Click(object sender, EventArgs e)
    {

    }

    private void btnCan_Click(object sender, EventArgs e)
    {

    }

  }
}
