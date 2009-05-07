namespace Southesk.Apps.EmitScore.Forms
{
  partial class FrmTeams
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmTeams));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this._dgvTeams = new System.Windows.Forms.DataGridView();
      this._bdsCategory = new System.Windows.Forms.BindingSource(this.components);
      this._dataSet = new Southesk.Apps.EmitScore.Data.EmitScoreDataSet();
      this._bdsTeam = new System.Windows.Forms.BindingSource(this.components);
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this._tsbExit = new System.Windows.Forms.ToolStripButton();
      this.teamTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.TeamTableAdapter();
      this.categoryTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter();
      this.teamIdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.teamNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.categoryIdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewComboBoxColumn();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this._dgvTeams)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsCategory)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsTeam)).BeginInit();
      this._tspMain.SuspendLayout();
      this.SuspendLayout();
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this._dgvTeams);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(559, 557);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(559, 612);
      this.toolStripContainer1.TabIndex = 0;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this._tspMain);
      // 
      // _dgvTeams
      // 
      this._dgvTeams.AutoGenerateColumns = false;
      dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
      dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
      dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
      dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
      dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
      dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
      this._dgvTeams.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
      this._dgvTeams.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this._dgvTeams.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.teamIdDataGridViewTextBoxColumn,
            this.teamNameDataGridViewTextBoxColumn,
            this.categoryIdDataGridViewTextBoxColumn});
      this._dgvTeams.DataSource = this._bdsTeam;
      dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
      dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
      dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
      dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
      dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
      dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
      this._dgvTeams.DefaultCellStyle = dataGridViewCellStyle2;
      this._dgvTeams.Dock = System.Windows.Forms.DockStyle.Fill;
      this._dgvTeams.Location = new System.Drawing.Point(0, 0);
      this._dgvTeams.Name = "_dgvTeams";
      this._dgvTeams.RowTemplate.Height = 26;
      this._dgvTeams.Size = new System.Drawing.Size(559, 557);
      this._dgvTeams.TabIndex = 0;
      // 
      // _bdsCategory
      // 
      this._bdsCategory.AllowNew = false;
      this._bdsCategory.DataMember = "Category";
      this._bdsCategory.DataSource = this._dataSet;
      // 
      // _dataSet
      // 
      this._dataSet.DataSetName = "EmitScoreDataSet";
      this._dataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // _bdsTeam
      // 
      this._bdsTeam.DataMember = "Team";
      this._bdsTeam.DataSource = this._dataSet;
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
      this._tsbExit.Image = global::Southesk.Apps.EmitScore.Properties.Resources.ExitLarge;
      this._tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbExit.Name = "_tsbExit";
      this._tsbExit.Size = new System.Drawing.Size(52, 52);
      this._tsbExit.Text = "toolStripButton1";
      this._tsbExit.Click += new System.EventHandler(this._tsbExit_Click);
      // 
      // teamTableAdapter
      // 
      this.teamTableAdapter.ClearBeforeFill = true;
      // 
      // categoryTableAdapter
      // 
      this.categoryTableAdapter.ClearBeforeFill = true;
      // 
      // teamIdDataGridViewTextBoxColumn
      // 
      this.teamIdDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
      this.teamIdDataGridViewTextBoxColumn.DataPropertyName = "TeamId";
      this.teamIdDataGridViewTextBoxColumn.HeaderText = "Team Id";
      this.teamIdDataGridViewTextBoxColumn.Name = "teamIdDataGridViewTextBoxColumn";
      this.teamIdDataGridViewTextBoxColumn.ReadOnly = true;
      this.teamIdDataGridViewTextBoxColumn.Width = 92;
      // 
      // teamNameDataGridViewTextBoxColumn
      // 
      this.teamNameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
      this.teamNameDataGridViewTextBoxColumn.DataPropertyName = "TeamName";
      this.teamNameDataGridViewTextBoxColumn.HeaderText = "Team Name";
      this.teamNameDataGridViewTextBoxColumn.Name = "teamNameDataGridViewTextBoxColumn";
      // 
      // categoryIdDataGridViewTextBoxColumn
      // 
      this.categoryIdDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
      this.categoryIdDataGridViewTextBoxColumn.DataPropertyName = "CategoryId";
      this.categoryIdDataGridViewTextBoxColumn.DataSource = this._bdsCategory;
      this.categoryIdDataGridViewTextBoxColumn.DisplayMember = "CategoryName";
      this.categoryIdDataGridViewTextBoxColumn.HeaderText = "Category";
      this.categoryIdDataGridViewTextBoxColumn.Name = "categoryIdDataGridViewTextBoxColumn";
      this.categoryIdDataGridViewTextBoxColumn.Resizable = System.Windows.Forms.DataGridViewTriState.True;
      this.categoryIdDataGridViewTextBoxColumn.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
      this.categoryIdDataGridViewTextBoxColumn.ValueMember = "CategoryId";
      this.categoryIdDataGridViewTextBoxColumn.Width = 93;
      // 
      // FrmTeams
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(559, 612);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "FrmTeams";
      this.Text = "Teams";
      this.Load += new System.EventHandler(this.FrmTeams_Load);
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmTeams_FormClosing);
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this._dgvTeams)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsCategory)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsTeam)).EndInit();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.ToolStrip _tspMain;
    private System.Windows.Forms.ToolStripButton _tsbExit;
    private System.Windows.Forms.BindingSource _bdsTeam;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSet _dataSet;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.TeamTableAdapter teamTableAdapter;
    private System.Windows.Forms.DataGridView _dgvTeams;
    private System.Windows.Forms.BindingSource _bdsCategory;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter categoryTableAdapter;
    private System.Windows.Forms.DataGridViewTextBoxColumn teamIdDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn teamNameDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewComboBoxColumn categoryIdDataGridViewTextBoxColumn;
  }
}