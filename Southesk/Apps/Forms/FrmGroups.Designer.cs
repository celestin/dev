namespace Southesk.Apps.EmitScore.Forms
{
  partial class FrmGroups
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmGroups));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this._dgvGroups = new System.Windows.Forms.DataGridView();
      this.bdsCategory = new System.Windows.Forms.BindingSource(this.components);
      this.emitScoreDataSet = new Southesk.Apps.EmitScore.Data.EmitScoreDataSet();
      this.bdsGroup = new System.Windows.Forms.BindingSource(this.components);
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this.groupTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter();
      this.categoryTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter();
      this._tsbExit = new System.Windows.Forms.ToolStripButton();
      this.groupIdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.groupNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.categoryIdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewComboBoxColumn();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this._dgvGroups)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.bdsCategory)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.emitScoreDataSet)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.bdsGroup)).BeginInit();
      this._tspMain.SuspendLayout();
      this.SuspendLayout();
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this._dgvGroups);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(598, 251);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(598, 306);
      this.toolStripContainer1.TabIndex = 0;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this._tspMain);
      // 
      // _dgvGroups
      // 
      this._dgvGroups.AllowUserToAddRows = false;
      this._dgvGroups.AutoGenerateColumns = false;
      this._dgvGroups.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this._dgvGroups.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.groupIdDataGridViewTextBoxColumn,
            this.groupNameDataGridViewTextBoxColumn,
            this.categoryIdDataGridViewTextBoxColumn});
      this._dgvGroups.DataSource = this.bdsGroup;
      this._dgvGroups.Dock = System.Windows.Forms.DockStyle.Fill;
      this._dgvGroups.Location = new System.Drawing.Point(0, 0);
      this._dgvGroups.Name = "_dgvGroups";
      this._dgvGroups.Size = new System.Drawing.Size(598, 251);
      this._dgvGroups.TabIndex = 0;
      // 
      // bdsCategory
      // 
      this.bdsCategory.DataMember = "Category";
      this.bdsCategory.DataSource = this.emitScoreDataSet;
      // 
      // emitScoreDataSet
      // 
      this.emitScoreDataSet.DataSetName = "EmitScoreDataSet";
      this.emitScoreDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // bdsGroup
      // 
      this.bdsGroup.DataMember = "Group";
      this.bdsGroup.DataSource = this.emitScoreDataSet;
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
      // groupTableAdapter
      // 
      this.groupTableAdapter.ClearBeforeFill = true;
      // 
      // categoryTableAdapter
      // 
      this.categoryTableAdapter.ClearBeforeFill = true;
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
      // groupIdDataGridViewTextBoxColumn
      // 
      this.groupIdDataGridViewTextBoxColumn.DataPropertyName = "GroupId";
      this.groupIdDataGridViewTextBoxColumn.HeaderText = "Group";
      this.groupIdDataGridViewTextBoxColumn.Name = "groupIdDataGridViewTextBoxColumn";
      // 
      // groupNameDataGridViewTextBoxColumn
      // 
      this.groupNameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
      this.groupNameDataGridViewTextBoxColumn.DataPropertyName = "GroupName";
      this.groupNameDataGridViewTextBoxColumn.HeaderText = "Group Name";
      this.groupNameDataGridViewTextBoxColumn.Name = "groupNameDataGridViewTextBoxColumn";
      // 
      // categoryIdDataGridViewTextBoxColumn
      // 
      this.categoryIdDataGridViewTextBoxColumn.DataPropertyName = "CategoryId";
      this.categoryIdDataGridViewTextBoxColumn.DataSource = this.bdsCategory;
      this.categoryIdDataGridViewTextBoxColumn.DisplayMember = "CategoryName";
      this.categoryIdDataGridViewTextBoxColumn.HeaderText = "Category";
      this.categoryIdDataGridViewTextBoxColumn.Name = "categoryIdDataGridViewTextBoxColumn";
      this.categoryIdDataGridViewTextBoxColumn.Resizable = System.Windows.Forms.DataGridViewTriState.True;
      this.categoryIdDataGridViewTextBoxColumn.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
      this.categoryIdDataGridViewTextBoxColumn.ValueMember = "CategoryId";
      // 
      // FrmGroups
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(598, 306);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "FrmGroups";
      this.Text = "Groups";
      this.Load += new System.EventHandler(this.FrmGroups_Load);
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmGroups_FormClosing);
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this._dgvGroups)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.bdsCategory)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.emitScoreDataSet)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.bdsGroup)).EndInit();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.ToolStrip _tspMain;
    private System.Windows.Forms.BindingSource bdsGroup;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSet emitScoreDataSet;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter groupTableAdapter;
    private System.Windows.Forms.DataGridView _dgvGroups;
    private System.Windows.Forms.BindingSource bdsCategory;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter categoryTableAdapter;
    private System.Windows.Forms.ToolStripButton _tsbExit;
    private System.Windows.Forms.DataGridViewTextBoxColumn groupIdDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn groupNameDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewComboBoxColumn categoryIdDataGridViewTextBoxColumn;
  }
}