namespace Southesk.Apps.EmitScore.Forms
{
  partial class FrmNewGroup
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmNewGroup));
      this._dataSet = new Southesk.Apps.EmitScore.Data.EmitScoreDataSet();
      this._cmbCategory = new System.Windows.Forms.ComboBox();
      this._bdsGroup = new System.Windows.Forms.BindingSource(this.components);
      this._bdsCategory = new System.Windows.Forms.BindingSource(this.components);
      this.categoryTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter();
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this._txtGroupName = new System.Windows.Forms.TextBox();
      this._txtGroupId = new System.Windows.Forms.TextBox();
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this._tsbExit = new System.Windows.Forms.ToolStripButton();
      this.groupTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter();
      this._bdsTeam = new System.Windows.Forms.BindingSource(this.components);
      this.teamTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.TeamTableAdapter();
      this._cmbTeam = new System.Windows.Forms.ComboBox();
      this.label1 = new System.Windows.Forms.Label();
      this.label2 = new System.Windows.Forms.Label();
      this.label3 = new System.Windows.Forms.Label();
      this.label4 = new System.Windows.Forms.Label();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsGroup)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsCategory)).BeginInit();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this._tspMain.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this._bdsTeam)).BeginInit();
      this.SuspendLayout();
      // 
      // _dataSet
      // 
      this._dataSet.DataSetName = "EmitScoreDataSet";
      this._dataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // _cmbCategory
      // 
      this._cmbCategory.DataBindings.Add(new System.Windows.Forms.Binding("SelectedValue", this._bdsGroup, "CategoryId", true, System.Windows.Forms.DataSourceUpdateMode.OnPropertyChanged));
      this._cmbCategory.DataSource = this._bdsCategory;
      this._cmbCategory.DisplayMember = "CategoryName";
      this._cmbCategory.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._cmbCategory.FormattingEnabled = true;
      this._cmbCategory.Location = new System.Drawing.Point(125, 92);
      this._cmbCategory.Name = "_cmbCategory";
      this._cmbCategory.Size = new System.Drawing.Size(160, 21);
      this._cmbCategory.TabIndex = 3;
      this._cmbCategory.ValueMember = "CategoryId";
      // 
      // _bdsGroup
      // 
      this._bdsGroup.DataMember = "Group";
      this._bdsGroup.DataSource = this._dataSet;
      // 
      // _bdsCategory
      // 
      this._bdsCategory.DataMember = "Category";
      this._bdsCategory.DataSource = this._dataSet;
      // 
      // categoryTableAdapter
      // 
      this.categoryTableAdapter.ClearBeforeFill = true;
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this.label4);
      this.toolStripContainer1.ContentPanel.Controls.Add(this.label3);
      this.toolStripContainer1.ContentPanel.Controls.Add(this.label2);
      this.toolStripContainer1.ContentPanel.Controls.Add(this.label1);
      this.toolStripContainer1.ContentPanel.Controls.Add(this._cmbTeam);
      this.toolStripContainer1.ContentPanel.Controls.Add(this._txtGroupName);
      this.toolStripContainer1.ContentPanel.Controls.Add(this._txtGroupId);
      this.toolStripContainer1.ContentPanel.Controls.Add(this._cmbCategory);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(462, 129);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(462, 184);
      this.toolStripContainer1.TabIndex = 1;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this._tspMain);
      // 
      // _txtGroupName
      // 
      this._txtGroupName.DataBindings.Add(new System.Windows.Forms.Binding("Text", this._bdsGroup, "GroupName", true, System.Windows.Forms.DataSourceUpdateMode.OnPropertyChanged));
      this._txtGroupName.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._txtGroupName.Location = new System.Drawing.Point(125, 65);
      this._txtGroupName.Name = "_txtGroupName";
      this._txtGroupName.Size = new System.Drawing.Size(239, 21);
      this._txtGroupName.TabIndex = 2;
      // 
      // _txtGroupId
      // 
      this._txtGroupId.DataBindings.Add(new System.Windows.Forms.Binding("Text", this._bdsGroup, "GroupId", true));
      this._txtGroupId.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._txtGroupId.Location = new System.Drawing.Point(125, 11);
      this._txtGroupId.Name = "_txtGroupId";
      this._txtGroupId.ReadOnly = true;
      this._txtGroupId.Size = new System.Drawing.Size(100, 21);
      this._txtGroupId.TabIndex = 1;
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
      this._tsbExit.Text = "Save & Exit";
      this._tsbExit.ToolTipText = "Save & Exit";
      this._tsbExit.Click += new System.EventHandler(this._tsbExit_Click);
      // 
      // groupTableAdapter
      // 
      this.groupTableAdapter.ClearBeforeFill = true;
      // 
      // _bdsTeam
      // 
      this._bdsTeam.DataMember = "Team";
      this._bdsTeam.DataSource = this._dataSet;
      // 
      // teamTableAdapter
      // 
      this.teamTableAdapter.ClearBeforeFill = true;
      // 
      // _cmbTeam
      // 
      this._cmbTeam.DataBindings.Add(new System.Windows.Forms.Binding("SelectedValue", this._bdsGroup, "TeamId", true, System.Windows.Forms.DataSourceUpdateMode.OnPropertyChanged));
      this._cmbTeam.DataSource = this._bdsTeam;
      this._cmbTeam.DisplayMember = "TeamName";
      this._cmbTeam.FormattingEnabled = true;
      this._cmbTeam.Location = new System.Drawing.Point(125, 38);
      this._cmbTeam.Name = "_cmbTeam";
      this._cmbTeam.Size = new System.Drawing.Size(160, 21);
      this._cmbTeam.TabIndex = 4;
      this._cmbTeam.ValueMember = "TeamId";
      // 
      // label1
      // 
      this.label1.AutoSize = true;
      this.label1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(12, 14);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(61, 13);
      this.label1.TabIndex = 5;
      this.label1.Text = "Group No.";
      // 
      // label2
      // 
      this.label2.AutoSize = true;
      this.label2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label2.Location = new System.Drawing.Point(12, 41);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(39, 13);
      this.label2.TabIndex = 6;
      this.label2.Text = "Team";
      // 
      // label3
      // 
      this.label3.AutoSize = true;
      this.label3.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label3.Location = new System.Drawing.Point(12, 68);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(76, 13);
      this.label3.TabIndex = 7;
      this.label3.Text = "Group Name";
      // 
      // label4
      // 
      this.label4.AutoSize = true;
      this.label4.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label4.Location = new System.Drawing.Point(12, 95);
      this.label4.Name = "label4";
      this.label4.Size = new System.Drawing.Size(59, 13);
      this.label4.TabIndex = 8;
      this.label4.Text = "Category";
      // 
      // FrmNewGroup
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(462, 184);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "FrmNewGroup";
      this.Text = "New Group";
      this.Load += new System.EventHandler(this.FrmNewGroup_Load);
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmNewGroup_FormClosing);
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsGroup)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsCategory)).EndInit();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.ContentPanel.PerformLayout();
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this._bdsTeam)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private Southesk.Apps.EmitScore.Data.EmitScoreDataSet _dataSet;
    private System.Windows.Forms.ComboBox _cmbCategory;
    private System.Windows.Forms.BindingSource _bdsCategory;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter categoryTableAdapter;
    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.ToolStrip _tspMain;
    private System.Windows.Forms.ToolStripButton _tsbExit;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter groupTableAdapter;
    private System.Windows.Forms.TextBox _txtGroupName;
    private System.Windows.Forms.TextBox _txtGroupId;
    private System.Windows.Forms.BindingSource _bdsGroup;
    private System.Windows.Forms.BindingSource _bdsTeam;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.TeamTableAdapter teamTableAdapter;
    private System.Windows.Forms.Label label4;
    private System.Windows.Forms.Label label3;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.ComboBox _cmbTeam;
  }
}