namespace FrontBurner.Apps.EmitScore.MultiBrikke.Forms
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
      System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
      System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmGroups));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this._dgvGroups = new System.Windows.Forms.DataGridView();
      this._bdsTeam = new System.Windows.Forms.BindingSource(this.components);
      this._dataSet = new FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSet();
      this._bdsCategory = new System.Windows.Forms.BindingSource(this.components);
      this._bdsGroup = new System.Windows.Forms.BindingSource(this.components);
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this._tsbExit = new System.Windows.Forms.ToolStripButton();
      this.groupTableAdapter = new FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter();
      this.categoryTableAdapter = new FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter();
      this.teamTableAdapter = new FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSetTableAdapters.TeamTableAdapter();
      this.groupIdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.TeamId = new System.Windows.Forms.DataGridViewComboBoxColumn();
      this.groupNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this._dgvGroups)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsTeam)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsCategory)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsGroup)).BeginInit();
      this._tspMain.SuspendLayout();
      this.SuspendLayout();
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this._dgvGroups);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(728, 379);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(728, 434);
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
      dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
      dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
      dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
      dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
      dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
      dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
      this._dgvGroups.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
      this._dgvGroups.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this._dgvGroups.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.groupIdDataGridViewTextBoxColumn,
            this.TeamId,
            this.groupNameDataGridViewTextBoxColumn});
      this._dgvGroups.DataSource = this._bdsGroup;
      dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
      dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
      dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
      dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
      dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
      dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
      this._dgvGroups.DefaultCellStyle = dataGridViewCellStyle2;
      this._dgvGroups.Dock = System.Windows.Forms.DockStyle.Fill;
      this._dgvGroups.Location = new System.Drawing.Point(0, 0);
      this._dgvGroups.Name = "_dgvGroups";
      this._dgvGroups.RowTemplate.Height = 26;
      this._dgvGroups.Size = new System.Drawing.Size(728, 379);
      this._dgvGroups.TabIndex = 0;
      // 
      // _bdsTeam
      // 
      this._bdsTeam.DataMember = "Team";
      this._bdsTeam.DataSource = this._dataSet;
      // 
      // _dataSet
      // 
      this._dataSet.DataSetName = "EmitScoreDataSet";
      this._dataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // _bdsCategory
      // 
      this._bdsCategory.DataMember = "Category";
      this._bdsCategory.DataSource = this._dataSet;
      // 
      // _bdsGroup
      // 
      this._bdsGroup.DataMember = "Group";
      this._bdsGroup.DataSource = this._dataSet;
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
      // _tsbExit
      // 
      this._tsbExit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbExit.Image = global::FrontBurner.Apps.EmitScore.MultiBrikke.Properties.Resources.ExitLarge;
      this._tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbExit.Name = "_tsbExit";
      this._tsbExit.Size = new System.Drawing.Size(52, 52);
      this._tsbExit.Text = "toolStripButton1";
      this._tsbExit.Click += new System.EventHandler(this._tsbExit_Click);
      // 
      // groupTableAdapter
      // 
      this.groupTableAdapter.ClearBeforeFill = true;
      // 
      // categoryTableAdapter
      // 
      this.categoryTableAdapter.ClearBeforeFill = true;
      // 
      // teamTableAdapter
      // 
      this.teamTableAdapter.ClearBeforeFill = true;
      // 
      // groupIdDataGridViewTextBoxColumn
      // 
      this.groupIdDataGridViewTextBoxColumn.DataPropertyName = "GroupId";
      this.groupIdDataGridViewTextBoxColumn.HeaderText = "Group";
      this.groupIdDataGridViewTextBoxColumn.Name = "groupIdDataGridViewTextBoxColumn";
      // 
      // TeamId
      // 
      this.TeamId.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
      this.TeamId.DataPropertyName = "TeamId";
      this.TeamId.DataSource = this._bdsTeam;
      this.TeamId.DisplayMember = "TeamName";
      this.TeamId.HeaderText = "Team";
      this.TeamId.MaxDropDownItems = 20;
      this.TeamId.Name = "TeamId";
      this.TeamId.ValueMember = "TeamId";
      this.TeamId.Width = 54;
      // 
      // groupNameDataGridViewTextBoxColumn
      // 
      this.groupNameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
      this.groupNameDataGridViewTextBoxColumn.DataPropertyName = "GroupName";
      this.groupNameDataGridViewTextBoxColumn.HeaderText = "Group Name";
      this.groupNameDataGridViewTextBoxColumn.Name = "groupNameDataGridViewTextBoxColumn";
      // 
      // FrmGroups
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(728, 434);
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
      ((System.ComponentModel.ISupportInitialize)(this._bdsTeam)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsCategory)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsGroup)).EndInit();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.ToolStrip _tspMain;
    private System.Windows.Forms.BindingSource _bdsGroup;
    private FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSet _dataSet;
    private FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter groupTableAdapter;
    private System.Windows.Forms.DataGridView _dgvGroups;
    private System.Windows.Forms.BindingSource _bdsCategory;
    private FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter categoryTableAdapter;
    private System.Windows.Forms.ToolStripButton _tsbExit;
    private System.Windows.Forms.BindingSource _bdsTeam;
    private FrontBurner.Apps.EmitScore.MultiBrikke.Data.EmitScoreDataSetTableAdapters.TeamTableAdapter teamTableAdapter;
    private System.Windows.Forms.DataGridViewTextBoxColumn groupIdDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewComboBoxColumn TeamId;
    private System.Windows.Forms.DataGridViewTextBoxColumn groupNameDataGridViewTextBoxColumn;
  }
}