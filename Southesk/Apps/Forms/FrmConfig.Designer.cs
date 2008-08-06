﻿namespace Southesk.Apps.EmitScore.Forms
{
  partial class FrmConfig
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmConfig));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this._bdsConfig = new System.Windows.Forms.BindingSource(this.components);
      this.emitScoreDataSet = new Southesk.Apps.EmitScore.Data.EmitScoreDataSet();
      this.configTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ConfigTableAdapter();
      this._dgvConfig = new System.Windows.Forms.DataGridView();
      this.comPortDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.emitUnitDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this._tsbExit = new System.Windows.Forms.ToolStripButton();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this._tspMain.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this._bdsConfig)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.emitScoreDataSet)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._dgvConfig)).BeginInit();
      this.SuspendLayout();
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this._dgvConfig);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(433, 240);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(433, 295);
      this.toolStripContainer1.TabIndex = 0;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this._tspMain);
      // 
      // _tspMain
      // 
      this._tspMain.Dock = System.Windows.Forms.DockStyle.None;
      this._tspMain.ImageScalingSize = new System.Drawing.Size(48, 48);
      this._tspMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._tsbExit});
      this._tspMain.Location = new System.Drawing.Point(3, 0);
      this._tspMain.Name = "_tspMain";
      this._tspMain.Size = new System.Drawing.Size(64, 55);
      this._tspMain.TabIndex = 0;
      // 
      // _bdsConfig
      // 
      this._bdsConfig.DataMember = "Config";
      this._bdsConfig.DataSource = this.emitScoreDataSet;
      // 
      // emitScoreDataSet
      // 
      this.emitScoreDataSet.DataSetName = "EmitScoreDataSet";
      this.emitScoreDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // configTableAdapter
      // 
      this.configTableAdapter.ClearBeforeFill = true;
      // 
      // _dgvConfig
      // 
      this._dgvConfig.AllowUserToAddRows = false;
      this._dgvConfig.AllowUserToDeleteRows = false;
      this._dgvConfig.AutoGenerateColumns = false;
      this._dgvConfig.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this._dgvConfig.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.comPortDataGridViewTextBoxColumn,
            this.emitUnitDataGridViewTextBoxColumn});
      this._dgvConfig.DataSource = this._bdsConfig;
      this._dgvConfig.Dock = System.Windows.Forms.DockStyle.Fill;
      this._dgvConfig.Location = new System.Drawing.Point(0, 0);
      this._dgvConfig.Name = "_dgvConfig";
      this._dgvConfig.Size = new System.Drawing.Size(433, 240);
      this._dgvConfig.TabIndex = 0;
      // 
      // comPortDataGridViewTextBoxColumn
      // 
      this.comPortDataGridViewTextBoxColumn.DataPropertyName = "ComPort";
      this.comPortDataGridViewTextBoxColumn.HeaderText = "ComPort";
      this.comPortDataGridViewTextBoxColumn.Name = "comPortDataGridViewTextBoxColumn";
      // 
      // emitUnitDataGridViewTextBoxColumn
      // 
      this.emitUnitDataGridViewTextBoxColumn.DataPropertyName = "EmitUnit";
      this.emitUnitDataGridViewTextBoxColumn.HeaderText = "EmitUnit";
      this.emitUnitDataGridViewTextBoxColumn.Name = "emitUnitDataGridViewTextBoxColumn";
      // 
      // _tsbExit
      // 
      this._tsbExit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbExit.Image = global::Southesk.Apps.EmitScore.Properties.Resources.ExitLarge;
      this._tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbExit.Name = "_tsbExit";
      this._tsbExit.Size = new System.Drawing.Size(52, 52);
      this._tsbExit.Text = "toolStripButton1";
      this._tsbExit.Click += new System.EventHandler(this._tsbExit_Click);
      // 
      // FrmConfig
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(433, 295);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "FrmConfig";
      this.Text = "Configuration";
      this.Load += new System.EventHandler(this.FrmConfig_Load);
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmConfig_FormClosing);
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this._bdsConfig)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.emitScoreDataSet)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._dgvConfig)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.ToolStrip _tspMain;
    private System.Windows.Forms.ToolStripButton _tsbExit;
    private System.Windows.Forms.BindingSource _bdsConfig;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSet emitScoreDataSet;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ConfigTableAdapter configTableAdapter;
    private System.Windows.Forms.DataGridView _dgvConfig;
    private System.Windows.Forms.DataGridViewTextBoxColumn comPortDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn emitUnitDataGridViewTextBoxColumn;
  }
}