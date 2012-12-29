/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Backlog Prioritisation
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  31-Mar-2012  11104 : Created.
 * CAM  29-Dec-2012  11104 : Started to make the Start Centre more dynamic to demonstrate potential.
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
    private AssessmentStatus _status;

    public AssessmentStatus Status
    {
      get { return _status; }
      set { _status = value; }
    }

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
        AssessmentStatus status = AssessmentStatuses.GetStatus(row["AssessmentStatus"].ToString());
        switch (status)
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
        p.AxisLabel = AssessmentStatuses.GetStatusDescription(status);
        p.YValues[0] = double.Parse(row["WoCount"].ToString());
        b.Text = p.AxisLabel;
        b.BackColor = p.Color;
        b.Tag = p.Tag = status;
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
        object s = progressPie.Series[0].Points[hit.PointIndex].Tag;
        if (s is AssessmentStatus)
        {
          UpdateProgressStatus((AssessmentStatus)s);
        }
      }
    }

    protected void UpdateProgressStatus(AssessmentStatus status)
    {
      Status = status;

      priorityChart.Titles[0].Text = String.Format("{0} Workorders by Priority", AssessmentStatuses.GetStatusDescription(status));

      priorityChart.Visible = true;
      DataSet prio = Datalayer.Instance.GetPrioritySummary(status);

      foreach (DataPoint dp in priorityChart.Series[0].Points)
      {
        // Reset all points first
        dp.YValues[0] = 0;
      }

      foreach (DataRow row in prio.Tables["Priority"].Rows)
      {
        int woPriority = int.Parse(row["WoPriority"].ToString());
        DataPoint dp = priorityChart.Series[0].Points[woPriority - 1];
        dp.YValues[0] = int.Parse(row["WoCount"].ToString());
      }

      priorityChart.ChartAreas[0].RecalculateAxesScale();

      priorityChart.Invalidate();
      priorityChart.Update();
    }

    private void PrioritySelected(object sender, MouseEventArgs e)
    {
      HitTestResult hit = ((Chart)sender).HitTest(e.X, e.Y);

      if (hit.PointIndex > -1)
      {
        int woPriority = hit.PointIndex + 1;

        MessageBox.Show(Status + " - " + woPriority.ToString());
      }
    }

    private void priorityChartClicked(object sender, EventArgs e) { }

    private void progressPieClicked(object sender, EventArgs e) { }


    private void mnuExit_Click(object sender, EventArgs e)
    {
      this.Close();
    }

    private void btnNew_Click(object sender, EventArgs e)
    {
      UpdateProgressStatus(AssessmentStatus.New);
    }

    private void btnComp_Click(object sender, EventArgs e)
    {
      UpdateProgressStatus(AssessmentStatus.Completed);
    }

    private void btnCan_Click(object sender, EventArgs e)
    {
      UpdateProgressStatus(AssessmentStatus.Cancelled);
    }

  }
}
