/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Forms
{
  partial class FrmCourses
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
      this.components = new System.ComponentModel.Container();
      System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
      System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmCourses));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.statusStrip1 = new System.Windows.Forms.StatusStrip();
      this.dataGridView1 = new System.Windows.Forms.DataGridView();
      this.CourseId = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.courseNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.courseBindingSource = new System.Windows.Forms.BindingSource(this.components);
      this.emitScoreDataSet = new FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSet();
      this.toolStrip1 = new System.Windows.Forms.ToolStrip();
      this._tsbExit = new System.Windows.Forms.ToolStripButton();
      this.courseTableAdapter = new FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSetTableAdapters.CourseTableAdapter();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.courseBindingSource)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.emitScoreDataSet)).BeginInit();
      this.toolStrip1.SuspendLayout();
      this.SuspendLayout();
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
      this.toolStripContainer1.ContentPanel.Controls.Add(this.dataGridView1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(499, 233);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(499, 310);
      this.toolStripContainer1.TabIndex = 0;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
      // 
      // statusStrip1
      // 
      this.statusStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.statusStrip1.Location = new System.Drawing.Point(0, 0);
      this.statusStrip1.Name = "statusStrip1";
      this.statusStrip1.Size = new System.Drawing.Size(499, 22);
      this.statusStrip1.TabIndex = 0;
      // 
      // dataGridView1
      // 
      this.dataGridView1.AutoGenerateColumns = false;
      dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
      dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
      dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
      dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
      dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
      dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
      this.dataGridView1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
      this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.CourseId,
            this.courseNameDataGridViewTextBoxColumn});
      this.dataGridView1.DataSource = this.courseBindingSource;
      dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
      dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
      dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
      dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
      dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
      dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
      this.dataGridView1.DefaultCellStyle = dataGridViewCellStyle2;
      this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.dataGridView1.Location = new System.Drawing.Point(0, 0);
      this.dataGridView1.Name = "dataGridView1";
      this.dataGridView1.Size = new System.Drawing.Size(499, 233);
      this.dataGridView1.TabIndex = 0;
      // 
      // CourseId
      // 
      this.CourseId.DataPropertyName = "CourseId";
      this.CourseId.HeaderText = "Id";
      this.CourseId.Name = "CourseId";
      this.CourseId.ReadOnly = true;
      // 
      // courseNameDataGridViewTextBoxColumn
      // 
      this.courseNameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
      this.courseNameDataGridViewTextBoxColumn.DataPropertyName = "CourseName";
      this.courseNameDataGridViewTextBoxColumn.HeaderText = "Course Name";
      this.courseNameDataGridViewTextBoxColumn.Name = "courseNameDataGridViewTextBoxColumn";
      this.courseNameDataGridViewTextBoxColumn.Width = 123;
      // 
      // courseBindingSource
      // 
      this.courseBindingSource.DataMember = "Course";
      this.courseBindingSource.DataSource = this.emitScoreDataSet;
      // 
      // emitScoreDataSet
      // 
      this.emitScoreDataSet.DataSetName = "EmitScoreDataSet";
      this.emitScoreDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // toolStrip1
      // 
      this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._tsbExit});
      this.toolStrip1.Location = new System.Drawing.Point(3, 0);
      this.toolStrip1.Name = "toolStrip1";
      this.toolStrip1.Size = new System.Drawing.Size(64, 55);
      this.toolStrip1.TabIndex = 0;
      // 
      // _tsbExit
      // 
      this._tsbExit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbExit.Image = global::FrontBurner.Apps.EmitScore.MultiBrikke.Properties.Resources.ExitLarge;
      this._tsbExit.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbExit.Name = "_tsbExit";
      this._tsbExit.Size = new System.Drawing.Size(52, 52);
      this._tsbExit.Text = "toolStripButton1";
      this._tsbExit.Click += new System.EventHandler(this._tsbExit_Click);
      // 
      // courseTableAdapter
      // 
      this.courseTableAdapter.ClearBeforeFill = true;
      // 
      // FrmCourses
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(499, 310);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "FrmCourses";
      this.Text = "Courses";
      this.Load += new System.EventHandler(this.FrmCourses_Load);
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmCourses_FormClosing);
      this.toolStripContainer1.BottomToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.BottomToolStripPanel.PerformLayout();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.courseBindingSource)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.emitScoreDataSet)).EndInit();
      this.toolStrip1.ResumeLayout(false);
      this.toolStrip1.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.StatusStrip statusStrip1;
    private System.Windows.Forms.ToolStrip toolStrip1;
    private System.Windows.Forms.ToolStripButton _tsbExit;
    private System.Windows.Forms.DataGridView dataGridView1;
    private FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSet emitScoreDataSet;
    private System.Windows.Forms.BindingSource courseBindingSource;
    private FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSetTableAdapters.CourseTableAdapter courseTableAdapter;
    private System.Windows.Forms.DataGridViewTextBoxColumn CourseId;
    private System.Windows.Forms.DataGridViewTextBoxColumn courseNameDataGridViewTextBoxColumn;
  }
}