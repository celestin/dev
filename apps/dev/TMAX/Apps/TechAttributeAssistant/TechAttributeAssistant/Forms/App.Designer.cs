/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Technical Attribute Assistant
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Apr-2012  11113 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Tmax.Apps.TechAttributeAssistant.Forms
{
  partial class App
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(App));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.statusStrip1 = new System.Windows.Forms.StatusStrip();
      this.statusLabel = new System.Windows.Forms.ToolStripStatusLabel();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this.label3 = new System.Windows.Forms.Label();
      this.label1 = new System.Windows.Forms.Label();
      this.label2 = new System.Windows.Forms.Label();
      this.txtLocation = new System.Windows.Forms.TextBox();
      this.dataGridView1 = new System.Windows.Forms.DataGridView();
      this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
      this.lblEqClassCode = new System.Windows.Forms.Label();
      this.lblEqClassDesc = new System.Windows.Forms.Label();
      this.lblSpecCode = new System.Windows.Forms.Label();
      this.lblSpecDesc = new System.Windows.Forms.Label();
      this.lblLocationDesc = new System.Windows.Forms.Label();
      this.toolStrip1 = new System.Windows.Forms.ToolStrip();
      this.tsbCount = new System.Windows.Forms.ToolStripButton();
      this.tsbRetrieve = new System.Windows.Forms.ToolStripButton();
      this.Column1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.Column2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.Column3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.tsbExit = new System.Windows.Forms.ToolStripButton();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.statusStrip1.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).BeginInit();
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
      this.toolStripContainer1.ContentPanel.Controls.Add(this.tableLayoutPanel1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(826, 671);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(826, 718);
      this.toolStripContainer1.TabIndex = 5;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
      // 
      // statusStrip1
      // 
      this.statusStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.statusLabel});
      this.statusStrip1.Location = new System.Drawing.Point(0, 0);
      this.statusStrip1.Name = "statusStrip1";
      this.statusStrip1.Size = new System.Drawing.Size(826, 22);
      this.statusStrip1.TabIndex = 0;
      // 
      // statusLabel
      // 
      this.statusLabel.Name = "statusLabel";
      this.statusLabel.Size = new System.Drawing.Size(42, 17);
      this.statusLabel.Text = "Ready.";
      // 
      // tableLayoutPanel1
      // 
      this.tableLayoutPanel1.ColumnCount = 5;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
      this.tableLayoutPanel1.Controls.Add(this.label3, 0, 2);
      this.tableLayoutPanel1.Controls.Add(this.label1, 0, 0);
      this.tableLayoutPanel1.Controls.Add(this.label2, 0, 1);
      this.tableLayoutPanel1.Controls.Add(this.txtLocation, 1, 0);
      this.tableLayoutPanel1.Controls.Add(this.dataGridView1, 1, 2);
      this.tableLayoutPanel1.Controls.Add(this.lblEqClassCode, 1, 1);
      this.tableLayoutPanel1.Controls.Add(this.lblEqClassDesc, 2, 1);
      this.tableLayoutPanel1.Controls.Add(this.lblSpecCode, 3, 1);
      this.tableLayoutPanel1.Controls.Add(this.lblSpecDesc, 4, 1);
      this.tableLayoutPanel1.Controls.Add(this.lblLocationDesc, 3, 0);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 3;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(826, 671);
      this.tableLayoutPanel1.TabIndex = 0;
      // 
      // label3
      // 
      this.label3.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.label3.AutoSize = true;
      this.label3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label3.Location = new System.Drawing.Point(3, 356);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(80, 38);
      this.label3.TabIndex = 5;
      this.label3.Text = "Technical Attributes";
      // 
      // label1
      // 
      this.label1.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.label1.AutoSize = true;
      this.label1.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(3, 10);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(68, 19);
      this.label1.TabIndex = 0;
      this.label1.Text = "Location";
      // 
      // label2
      // 
      this.label2.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.label2.AutoSize = true;
      this.label2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label2.Location = new System.Drawing.Point(3, 50);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(99, 19);
      this.label2.TabIndex = 1;
      this.label2.Text = "Class && Spec";
      // 
      // txtLocation
      // 
      this.txtLocation.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.tableLayoutPanel1.SetColumnSpan(this.txtLocation, 2);
      this.txtLocation.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtLocation.Location = new System.Drawing.Point(123, 6);
      this.txtLocation.Name = "txtLocation";
      this.txtLocation.Size = new System.Drawing.Size(204, 27);
      this.txtLocation.TabIndex = 2;
      // 
      // dataGridView1
      // 
      this.dataGridView1.AllowUserToAddRows = false;
      this.dataGridView1.AllowUserToDeleteRows = false;
      this.dataGridView1.AutoGenerateColumns = false;
      this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Column1,
            this.Column2,
            this.Column3});
      this.tableLayoutPanel1.SetColumnSpan(this.dataGridView1, 4);
      this.dataGridView1.DataSource = this.bindingSource1;
      this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.dataGridView1.Location = new System.Drawing.Point(123, 83);
      this.dataGridView1.Name = "dataGridView1";
      this.dataGridView1.ReadOnly = true;
      this.dataGridView1.Size = new System.Drawing.Size(700, 585);
      this.dataGridView1.TabIndex = 4;
      // 
      // bindingSource1
      // 
      this.bindingSource1.AllowNew = false;
      // 
      // lblEqClassCode
      // 
      this.lblEqClassCode.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.lblEqClassCode.AutoSize = true;
      this.lblEqClassCode.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblEqClassCode.Location = new System.Drawing.Point(123, 50);
      this.lblEqClassCode.Name = "lblEqClassCode";
      this.lblEqClassCode.Size = new System.Drawing.Size(103, 19);
      this.lblEqClassCode.TabIndex = 6;
      this.lblEqClassCode.Text = "CLASS CODE";
      // 
      // lblEqClassDesc
      // 
      this.lblEqClassDesc.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.lblEqClassDesc.AutoSize = true;
      this.lblEqClassDesc.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblEqClassDesc.Location = new System.Drawing.Point(243, 50);
      this.lblEqClassDesc.Name = "lblEqClassDesc";
      this.lblEqClassDesc.Size = new System.Drawing.Size(100, 19);
      this.lblEqClassDesc.TabIndex = 7;
      this.lblEqClassDesc.Text = "CLASS DESC";
      // 
      // lblSpecCode
      // 
      this.lblSpecCode.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.lblSpecCode.AutoSize = true;
      this.lblSpecCode.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblSpecCode.Location = new System.Drawing.Point(476, 50);
      this.lblSpecCode.Name = "lblSpecCode";
      this.lblSpecCode.Size = new System.Drawing.Size(93, 19);
      this.lblSpecCode.TabIndex = 8;
      this.lblSpecCode.Text = "SPEC CODE";
      // 
      // lblSpecDesc
      // 
      this.lblSpecDesc.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.lblSpecDesc.AutoSize = true;
      this.lblSpecDesc.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblSpecDesc.Location = new System.Drawing.Point(596, 50);
      this.lblSpecDesc.Name = "lblSpecDesc";
      this.lblSpecDesc.Size = new System.Drawing.Size(90, 19);
      this.lblSpecDesc.TabIndex = 9;
      this.lblSpecDesc.Text = "SPEC DESC";
      // 
      // lblLocationDesc
      // 
      this.lblLocationDesc.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.lblLocationDesc.AutoSize = true;
      this.tableLayoutPanel1.SetColumnSpan(this.lblLocationDesc, 2);
      this.lblLocationDesc.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblLocationDesc.Location = new System.Drawing.Point(476, 1);
      this.lblLocationDesc.Name = "lblLocationDesc";
      this.lblLocationDesc.Size = new System.Drawing.Size(344, 38);
      this.lblLocationDesc.TabIndex = 10;
      this.lblLocationDesc.Text = "LOCATION DESCRIPTION AS LONG AS NEED BE";
      // 
      // toolStrip1
      // 
      this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbRetrieve,
            this.tsbCount,
            this.tsbExit});
      this.toolStrip1.Location = new System.Drawing.Point(3, 0);
      this.toolStrip1.Name = "toolStrip1";
      this.toolStrip1.Size = new System.Drawing.Size(186, 25);
      this.toolStrip1.TabIndex = 1;
      // 
      // tsbCount
      // 
      this.tsbCount.Image = ((System.Drawing.Image)(resources.GetObject("tsbCount.Image")));
      this.tsbCount.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbCount.Name = "tsbCount";
      this.tsbCount.Size = new System.Drawing.Size(60, 22);
      this.tsbCount.Text = "Count";
      this.tsbCount.Click += new System.EventHandler(this.tsbCount_Click);
      // 
      // tsbRetrieve
      // 
      this.tsbRetrieve.Image = ((System.Drawing.Image)(resources.GetObject("tsbRetrieve.Image")));
      this.tsbRetrieve.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbRetrieve.Name = "tsbRetrieve";
      this.tsbRetrieve.Size = new System.Drawing.Size(69, 22);
      this.tsbRetrieve.Text = "Retrieve";
      this.tsbRetrieve.Click += new System.EventHandler(this.tsbRetrieve_Click);
      // 
      // Column1
      // 
      this.Column1.DataPropertyName = "assetattrid";
      this.Column1.HeaderText = "AttrId";
      this.Column1.Name = "Column1";
      this.Column1.ReadOnly = true;
      // 
      // Column2
      // 
      this.Column2.DataPropertyName = "description";
      this.Column2.HeaderText = "Attribute";
      this.Column2.Name = "Column2";
      this.Column2.ReadOnly = true;
      // 
      // Column3
      // 
      this.Column3.DataPropertyName = "attrvalue";
      this.Column3.HeaderText = "Value";
      this.Column3.Name = "Column3";
      this.Column3.ReadOnly = true;
      // 
      // tsbExit
      // 
      this.tsbExit.Image = ((System.Drawing.Image)(resources.GetObject("tsbExit.Image")));
      this.tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbExit.Name = "tsbExit";
      this.tsbExit.Size = new System.Drawing.Size(45, 22);
      this.tsbExit.Text = "Exit";
      this.tsbExit.Click += new System.EventHandler(this.tsbExit_Click);
      // 
      // App
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(826, 718);
      this.Controls.Add(this.toolStripContainer1);
      this.Name = "App";
      this.Text = "Tech Attribute Assistant";
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
      ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).EndInit();
      this.toolStrip1.ResumeLayout(false);
      this.toolStrip1.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.StatusStrip statusStrip1;
    private System.Windows.Forms.ToolStripStatusLabel statusLabel;
    private System.Windows.Forms.ToolStrip toolStrip1;
    private System.Windows.Forms.ToolStripButton tsbCount;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.DataGridView dataGridView1;
    private System.Windows.Forms.BindingSource bindingSource1;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.TextBox txtLocation;
    private System.Windows.Forms.Label label3;
    private System.Windows.Forms.Label lblEqClassCode;
    private System.Windows.Forms.Label lblEqClassDesc;
    private System.Windows.Forms.Label lblSpecCode;
    private System.Windows.Forms.Label lblSpecDesc;
    private System.Windows.Forms.Label lblLocationDesc;
    private System.Windows.Forms.ToolStripButton tsbRetrieve;
    private System.Windows.Forms.DataGridViewTextBoxColumn Column1;
    private System.Windows.Forms.DataGridViewTextBoxColumn Column2;
    private System.Windows.Forms.DataGridViewTextBoxColumn Column3;
    private System.Windows.Forms.ToolStripButton tsbExit;
  }
}

