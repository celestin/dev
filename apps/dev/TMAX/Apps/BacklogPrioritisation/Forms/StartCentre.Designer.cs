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

namespace FrontBurner.Tmax.Apps.BacklogPrioritisation.Forms
{
  partial class StartCentre
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea3 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
      System.Windows.Forms.DataVisualization.Charting.Series series3 = new System.Windows.Forms.DataVisualization.Charting.Series();
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint8 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(0, "3000,0");
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint9 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(0, "120,0");
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint10 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(0, "1,0");
      System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea4 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
      System.Windows.Forms.DataVisualization.Charting.Series series4 = new System.Windows.Forms.DataVisualization.Charting.Series();
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint11 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(1, 100);
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint12 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(2, 250);
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint13 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(3, 400);
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint14 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(4, 350);
      System.Windows.Forms.DataVisualization.Charting.Title title2 = new System.Windows.Forms.DataVisualization.Charting.Title();
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(StartCentre));
      this.progressPie = new System.Windows.Forms.DataVisualization.Charting.Chart();
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.statusStrip1 = new System.Windows.Forms.StatusStrip();
      this.splitContainer1 = new System.Windows.Forms.SplitContainer();
      this.priorityChart = new System.Windows.Forms.DataVisualization.Charting.Chart();
      this.menuStrip1 = new System.Windows.Forms.MenuStrip();
      this.mnuFile = new System.Windows.Forms.ToolStripMenuItem();
      this.mnuExit = new System.Windows.Forms.ToolStripMenuItem();
      this.statusLabel = new System.Windows.Forms.ToolStripStatusLabel();
      ((System.ComponentModel.ISupportInitialize)(this.progressPie)).BeginInit();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.statusStrip1.SuspendLayout();
      this.splitContainer1.Panel1.SuspendLayout();
      this.splitContainer1.Panel2.SuspendLayout();
      this.splitContainer1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.priorityChart)).BeginInit();
      this.menuStrip1.SuspendLayout();
      this.SuspendLayout();
      // 
      // progressPie
      // 
      chartArea3.AlignmentOrientation = System.Windows.Forms.DataVisualization.Charting.AreaAlignmentOrientations.Horizontal;
      chartArea3.AlignmentStyle = System.Windows.Forms.DataVisualization.Charting.AreaAlignmentStyles.PlotPosition;
      chartArea3.AlignWithChartArea = "Progress";
      chartArea3.AxisX.Title = "Status";
      chartArea3.AxisY.Title = "Workorder Count";
      chartArea3.Name = "Progress";
      this.progressPie.ChartAreas.Add(chartArea3);
      this.progressPie.Dock = System.Windows.Forms.DockStyle.Fill;
      this.progressPie.Location = new System.Drawing.Point(0, 0);
      this.progressPie.Name = "progressPie";
      this.progressPie.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.None;
      this.progressPie.PaletteCustomColors = new System.Drawing.Color[] {
        System.Drawing.Color.LimeGreen,
        System.Drawing.Color.Orange,
        System.Drawing.Color.Crimson};
      series3.ChartArea = "Progress";
      series3.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Doughnut;
      series3.Name = "Series1";
      dataPoint8.AxisLabel = "Completed";
      dataPoint9.AxisLabel = "New";
      dataPoint9.BorderColor = System.Drawing.Color.Empty;
      dataPoint10.AxisLabel = "Cancelled";
      dataPoint10.Label = "";
      series3.Points.Add(dataPoint8);
      series3.Points.Add(dataPoint9);
      series3.Points.Add(dataPoint10);
      series3.YValuesPerPoint = 2;
      this.progressPie.Series.Add(series3);
      this.progressPie.Size = new System.Drawing.Size(303, 376);
      this.progressPie.TabIndex = 0;
      this.progressPie.Text = "progressPie";
      this.progressPie.MouseUp += new System.Windows.Forms.MouseEventHandler(this.ProgressStatusSelected);
      this.progressPie.Click += new System.EventHandler(this.chart1_Click);
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.BottomToolStripPanel
      // 
      this.toolStripContainer1.BottomToolStripPanel.Controls.Add(this.statusStrip1);
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this.splitContainer1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(752, 376);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(752, 422);
      this.toolStripContainer1.TabIndex = 1;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.menuStrip1);
      // 
      // statusStrip1
      // 
      this.statusStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.statusLabel});
      this.statusStrip1.Location = new System.Drawing.Point(0, 0);
      this.statusStrip1.Name = "statusStrip1";
      this.statusStrip1.Size = new System.Drawing.Size(752, 22);
      this.statusStrip1.TabIndex = 0;
      // 
      // splitContainer1
      // 
      this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.splitContainer1.Location = new System.Drawing.Point(0, 0);
      this.splitContainer1.Name = "splitContainer1";
      // 
      // splitContainer1.Panel1
      // 
      this.splitContainer1.Panel1.Controls.Add(this.progressPie);
      // 
      // splitContainer1.Panel2
      // 
      this.splitContainer1.Panel2.Controls.Add(this.priorityChart);
      this.splitContainer1.Size = new System.Drawing.Size(752, 376);
      this.splitContainer1.SplitterDistance = 303;
      this.splitContainer1.TabIndex = 1;
      // 
      // priorityChart
      // 
      chartArea4.AxisX.Title = "Priority";
      chartArea4.AxisX.TitleForeColor = System.Drawing.Color.DarkSlateGray;
      chartArea4.AxisY.Title = "Workorder Count";
      chartArea4.AxisY.TitleForeColor = System.Drawing.Color.DarkSlateGray;
      chartArea4.Name = "ChartArea1";
      this.priorityChart.ChartAreas.Add(chartArea4);
      this.priorityChart.Dock = System.Windows.Forms.DockStyle.Fill;
      this.priorityChart.Location = new System.Drawing.Point(0, 0);
      this.priorityChart.Name = "priorityChart";
      this.priorityChart.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Bright;
      series4.ChartArea = "ChartArea1";
      series4.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      series4.IsXValueIndexed = true;
      series4.Name = "Priority";
      dataPoint11.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataPoint11.IsValueShownAsLabel = false;
      dataPoint11.Label = "";
      series4.Points.Add(dataPoint11);
      series4.Points.Add(dataPoint12);
      series4.Points.Add(dataPoint13);
      series4.Points.Add(dataPoint14);
      this.priorityChart.Series.Add(series4);
      this.priorityChart.Size = new System.Drawing.Size(445, 376);
      this.priorityChart.TabIndex = 0;
      this.priorityChart.Text = "priorityChart";
      title2.Alignment = System.Drawing.ContentAlignment.TopCenter;
      title2.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      title2.ForeColor = System.Drawing.Color.DarkSlateGray;
      title2.Name = "PriorityTitle";
      title2.Text = "Completed Workorders by Priority";
      this.priorityChart.Titles.Add(title2);
      this.priorityChart.Visible = false;
      this.priorityChart.MouseUp += new System.Windows.Forms.MouseEventHandler(this.PrioritySelected);
      this.priorityChart.Click += new System.EventHandler(this.chart2_Click);
      // 
      // menuStrip1
      // 
      this.menuStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuFile});
      this.menuStrip1.Location = new System.Drawing.Point(0, 0);
      this.menuStrip1.Name = "menuStrip1";
      this.menuStrip1.Size = new System.Drawing.Size(752, 24);
      this.menuStrip1.TabIndex = 0;
      this.menuStrip1.Text = "menuStrip1";
      // 
      // mnuFile
      // 
      this.mnuFile.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuExit});
      this.mnuFile.Name = "mnuFile";
      this.mnuFile.Size = new System.Drawing.Size(37, 20);
      this.mnuFile.Text = "&File";
      // 
      // mnuExit
      // 
      this.mnuExit.Name = "mnuExit";
      this.mnuExit.Size = new System.Drawing.Size(92, 22);
      this.mnuExit.Text = "E&xit";
      this.mnuExit.Click += new System.EventHandler(this.mnuExit_Click);
      // 
      // statusLabel
      // 
      this.statusLabel.Name = "statusLabel";
      this.statusLabel.Size = new System.Drawing.Size(39, 17);
      this.statusLabel.Text = "Ready";
      // 
      // StartCentre
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(752, 422);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MainMenuStrip = this.menuStrip1;
      this.Name = "StartCentre";
      this.Text = "Start Centre";
      ((System.ComponentModel.ISupportInitialize)(this.progressPie)).EndInit();
      this.toolStripContainer1.BottomToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.BottomToolStripPanel.PerformLayout();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this.statusStrip1.ResumeLayout(false);
      this.statusStrip1.PerformLayout();
      this.splitContainer1.Panel1.ResumeLayout(false);
      this.splitContainer1.Panel2.ResumeLayout(false);
      this.splitContainer1.ResumeLayout(false);
      ((System.ComponentModel.ISupportInitialize)(this.priorityChart)).EndInit();
      this.menuStrip1.ResumeLayout(false);
      this.menuStrip1.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.DataVisualization.Charting.Chart progressPie;
    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.StatusStrip statusStrip1;
    private System.Windows.Forms.MenuStrip menuStrip1;
    private System.Windows.Forms.ToolStripMenuItem mnuFile;
    private System.Windows.Forms.ToolStripMenuItem mnuExit;
    private System.Windows.Forms.SplitContainer splitContainer1;
    private System.Windows.Forms.DataVisualization.Charting.Chart priorityChart;
    private System.Windows.Forms.ToolStripStatusLabel statusLabel;
  }
}
