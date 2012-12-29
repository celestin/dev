/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Backlog Prioritisation
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  31-MAr-2012  11104 : Created.
 * CAM  29-Dec-2012  11104 : Started to make the Start Centre more dynamic to demonstrate potential.
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
      System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
      System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint1 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(0, "3000,0");
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint2 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(0, "120,0");
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint3 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(0, "1,0");
      System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea2 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
      System.Windows.Forms.DataVisualization.Charting.Series series2 = new System.Windows.Forms.DataVisualization.Charting.Series();
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint4 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(1, 100);
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint5 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(2, 250);
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint6 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(3, 400);
      System.Windows.Forms.DataVisualization.Charting.DataPoint dataPoint7 = new System.Windows.Forms.DataVisualization.Charting.DataPoint(4, 350);
      System.Windows.Forms.DataVisualization.Charting.Title title1 = new System.Windows.Forms.DataVisualization.Charting.Title();
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(StartCentre));
      this.progressPie = new System.Windows.Forms.DataVisualization.Charting.Chart();
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.statusStrip1 = new System.Windows.Forms.StatusStrip();
      this.statusLabel = new System.Windows.Forms.ToolStripStatusLabel();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this.splitContainer1 = new System.Windows.Forms.SplitContainer();
      this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
      this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
      this.btnNew = new System.Windows.Forms.Button();
      this.btnComp = new System.Windows.Forms.Button();
      this.btnCan = new System.Windows.Forms.Button();
      this.priorityChart = new System.Windows.Forms.DataVisualization.Charting.Chart();
      this.lblSite = new System.Windows.Forms.Label();
      this.menuStrip1 = new System.Windows.Forms.MenuStrip();
      this.mnuFile = new System.Windows.Forms.ToolStripMenuItem();
      this.mnuExit = new System.Windows.Forms.ToolStripMenuItem();
      ((System.ComponentModel.ISupportInitialize)(this.progressPie)).BeginInit();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.statusStrip1.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      this.splitContainer1.Panel1.SuspendLayout();
      this.splitContainer1.Panel2.SuspendLayout();
      this.splitContainer1.SuspendLayout();
      this.tableLayoutPanel2.SuspendLayout();
      this.flowLayoutPanel1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.priorityChart)).BeginInit();
      this.menuStrip1.SuspendLayout();
      this.SuspendLayout();
      //
      // progressPie
      //
      this.progressPie.BackColor = System.Drawing.Color.Transparent;
      chartArea1.AlignmentOrientation = System.Windows.Forms.DataVisualization.Charting.AreaAlignmentOrientations.Horizontal;
      chartArea1.AlignmentStyle = System.Windows.Forms.DataVisualization.Charting.AreaAlignmentStyles.PlotPosition;
      chartArea1.AlignWithChartArea = "Progress";
      chartArea1.AxisX.Title = "Status";
      chartArea1.AxisY.Title = "Workorder Count";
      chartArea1.Name = "Progress";
      this.progressPie.ChartAreas.Add(chartArea1);
      this.progressPie.Dock = System.Windows.Forms.DockStyle.Fill;
      this.progressPie.Location = new System.Drawing.Point(3, 3);
      this.progressPie.Name = "progressPie";
      this.progressPie.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.None;
      this.progressPie.PaletteCustomColors = new System.Drawing.Color[] {
        System.Drawing.Color.SeaGreen,
        System.Drawing.Color.Orange,
        System.Drawing.Color.Crimson};
      series1.ChartArea = "Progress";
      series1.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Doughnut;
      series1.Name = "Series1";
      dataPoint1.AxisLabel = "Completed";
      dataPoint2.AxisLabel = "New";
      dataPoint2.BorderColor = System.Drawing.Color.Empty;
      dataPoint3.AxisLabel = "Cancelled";
      dataPoint3.Label = "";
      series1.Points.Add(dataPoint1);
      series1.Points.Add(dataPoint2);
      series1.Points.Add(dataPoint3);
      series1.YValuesPerPoint = 2;
      this.progressPie.Series.Add(series1);
      this.progressPie.Size = new System.Drawing.Size(287, 283);
      this.progressPie.TabIndex = 0;
      this.progressPie.Text = "progressPie";
      this.progressPie.MouseUp += new System.Windows.Forms.MouseEventHandler(this.ProgressStatusSelected);
      this.progressPie.Click += new System.EventHandler(this.progressPieClicked);
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
      this.toolStripContainer1.ContentPanel.Controls.Add(this.tableLayoutPanel1);
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
      // statusLabel
      //
      this.statusLabel.Name = "statusLabel";
      this.statusLabel.Size = new System.Drawing.Size(39, 17);
      this.statusLabel.Text = "Ready";
      //
      // tableLayoutPanel1
      //
      this.tableLayoutPanel1.ColumnCount = 1;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
      this.tableLayoutPanel1.Controls.Add(this.splitContainer1, 0, 1);
      this.tableLayoutPanel1.Controls.Add(this.lblSite, 0, 0);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 2;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 9.308511F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 90.69149F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(752, 376);
      this.tableLayoutPanel1.TabIndex = 2;
      //
      // splitContainer1
      //
      this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.splitContainer1.Location = new System.Drawing.Point(3, 38);
      this.splitContainer1.Name = "splitContainer1";
      //
      // splitContainer1.Panel1
      //
      this.splitContainer1.Panel1.Controls.Add(this.tableLayoutPanel2);
      //
      // splitContainer1.Panel2
      //
      this.splitContainer1.Panel2.Controls.Add(this.priorityChart);
      this.splitContainer1.Size = new System.Drawing.Size(746, 335);
      this.splitContainer1.SplitterDistance = 293;
      this.splitContainer1.TabIndex = 1;
      //
      // tableLayoutPanel2
      //
      this.tableLayoutPanel2.ColumnCount = 1;
      this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
      this.tableLayoutPanel2.Controls.Add(this.progressPie, 0, 0);
      this.tableLayoutPanel2.Controls.Add(this.flowLayoutPanel1, 0, 1);
      this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel2.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel2.Name = "tableLayoutPanel2";
      this.tableLayoutPanel2.RowCount = 2;
      this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 86.56716F));
      this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 13.43284F));
      this.tableLayoutPanel2.Size = new System.Drawing.Size(293, 335);
      this.tableLayoutPanel2.TabIndex = 1;
      //
      // flowLayoutPanel1
      //
      this.flowLayoutPanel1.Anchor = System.Windows.Forms.AnchorStyles.None;
      this.flowLayoutPanel1.Controls.Add(this.btnNew);
      this.flowLayoutPanel1.Controls.Add(this.btnComp);
      this.flowLayoutPanel1.Controls.Add(this.btnCan);
      this.flowLayoutPanel1.Location = new System.Drawing.Point(32, 297);
      this.flowLayoutPanel1.Name = "flowLayoutPanel1";
      this.flowLayoutPanel1.Size = new System.Drawing.Size(228, 30);
      this.flowLayoutPanel1.TabIndex = 1;
      //
      // btnNew
      //
      this.btnNew.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
      this.btnNew.Location = new System.Drawing.Point(3, 3);
      this.btnNew.Name = "btnNew";
      this.btnNew.Size = new System.Drawing.Size(70, 23);
      this.btnNew.TabIndex = 0;
      this.btnNew.Text = "button1";
      this.btnNew.UseVisualStyleBackColor = true;
      this.btnNew.Click += new System.EventHandler(this.btnNew_Click);
      //
      // btnComp
      //
      this.btnComp.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
      this.btnComp.Location = new System.Drawing.Point(79, 3);
      this.btnComp.Name = "btnComp";
      this.btnComp.Size = new System.Drawing.Size(70, 23);
      this.btnComp.TabIndex = 1;
      this.btnComp.Text = "Completed";
      this.btnComp.UseVisualStyleBackColor = true;
      this.btnComp.Click += new System.EventHandler(this.btnComp_Click);
      //
      // btnCan
      //
      this.btnCan.BackColor = System.Drawing.Color.DarkOliveGreen;
      this.btnCan.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
      this.btnCan.Location = new System.Drawing.Point(155, 3);
      this.btnCan.Name = "btnCan";
      this.btnCan.Size = new System.Drawing.Size(70, 23);
      this.btnCan.TabIndex = 2;
      this.btnCan.Text = "button3";
      this.btnCan.UseVisualStyleBackColor = false;
      this.btnCan.Click += new System.EventHandler(this.btnCan_Click);
      //
      // priorityChart
      //
      this.priorityChart.BackColor = System.Drawing.Color.Transparent;
      chartArea2.AxisX.Title = "Priority";
      chartArea2.AxisX.TitleForeColor = System.Drawing.Color.DarkSlateGray;
      chartArea2.AxisY.Title = "Workorder Count";
      chartArea2.AxisY.TitleForeColor = System.Drawing.Color.DarkSlateGray;
      chartArea2.Name = "ChartArea1";
      this.priorityChart.ChartAreas.Add(chartArea2);
      this.priorityChart.Dock = System.Windows.Forms.DockStyle.Fill;
      this.priorityChart.Location = new System.Drawing.Point(0, 0);
      this.priorityChart.Name = "priorityChart";
      this.priorityChart.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Bright;
      series2.ChartArea = "ChartArea1";
      series2.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      series2.IsXValueIndexed = true;
      series2.Name = "Priority";
      dataPoint4.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataPoint4.IsValueShownAsLabel = false;
      dataPoint4.Label = "";
      series2.Points.Add(dataPoint4);
      series2.Points.Add(dataPoint5);
      series2.Points.Add(dataPoint6);
      series2.Points.Add(dataPoint7);
      this.priorityChart.Series.Add(series2);
      this.priorityChart.Size = new System.Drawing.Size(449, 335);
      this.priorityChart.TabIndex = 0;
      this.priorityChart.Text = "priorityChart";
      title1.Alignment = System.Drawing.ContentAlignment.TopCenter;
      title1.Font = new System.Drawing.Font("Calibri", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      title1.ForeColor = System.Drawing.Color.DarkSlateGray;
      title1.Name = "PriorityTitle";
      title1.Text = "Completed Workorders by Priority";
      this.priorityChart.Titles.Add(title1);
      this.priorityChart.Visible = false;
      this.priorityChart.MouseUp += new System.Windows.Forms.MouseEventHandler(this.PrioritySelected);
      this.priorityChart.Click += new System.EventHandler(this.priorityChartClicked);
      //
      // lblSite
      //
      this.lblSite.Anchor = System.Windows.Forms.AnchorStyles.None;
      this.lblSite.AutoSize = true;
      this.lblSite.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblSite.ForeColor = System.Drawing.Color.DarkSlateGray;
      this.lblSite.Location = new System.Drawing.Point(350, 8);
      this.lblSite.Name = "lblSite";
      this.lblSite.Size = new System.Drawing.Size(51, 19);
      this.lblSite.TabIndex = 2;
      this.lblSite.Text = "label1";
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
      // StartCentre
      //
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(752, 422);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MainMenuStrip = this.menuStrip1;
      this.Name = "StartCentre";
      this.Text = "Backlog Prioritisation - Start Centre";
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
      this.tableLayoutPanel1.ResumeLayout(false);
      this.tableLayoutPanel1.PerformLayout();
      this.splitContainer1.Panel1.ResumeLayout(false);
      this.splitContainer1.Panel2.ResumeLayout(false);
      this.splitContainer1.ResumeLayout(false);
      this.tableLayoutPanel2.ResumeLayout(false);
      this.flowLayoutPanel1.ResumeLayout(false);
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
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.Label lblSite;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
    private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
    private System.Windows.Forms.Button btnNew;
    private System.Windows.Forms.Button btnComp;
    private System.Windows.Forms.Button btnCan;
  }
}
