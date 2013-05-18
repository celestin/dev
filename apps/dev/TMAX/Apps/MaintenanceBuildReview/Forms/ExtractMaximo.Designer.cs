/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-May-2013  11172 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Forms
{
  partial class ExtractMaximo
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ExtractMaximo));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this.label1 = new System.Windows.Forms.Label();
      this.txtValidateDb = new System.Windows.Forms.TextBox();
      this.toolStrip1 = new System.Windows.Forms.ToolStrip();
      this.tsbExtract = new System.Windows.Forms.ToolStripButton();
      this.tsbSetValidateDb = new System.Windows.Forms.ToolStripButton();
      this.tsbClose = new System.Windows.Forms.ToolStripButton();
      this.ofdValidateDb = new System.Windows.Forms.OpenFileDialog();
      this.toolStrip2 = new System.Windows.Forms.ToolStrip();
      this.tslStatus = new System.Windows.Forms.ToolStripLabel();
      this.tspExtract = new System.Windows.Forms.ToolStripProgressBar();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      this.toolStrip1.SuspendLayout();
      this.toolStrip2.SuspendLayout();
      this.SuspendLayout();
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.BottomToolStripPanel
      // 
      this.toolStripContainer1.BottomToolStripPanel.Controls.Add(this.toolStrip2);
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this.tableLayoutPanel1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(763, 304);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(763, 354);
      this.toolStripContainer1.TabIndex = 0;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
      // 
      // tableLayoutPanel1
      // 
      this.tableLayoutPanel1.ColumnCount = 2;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 18.21756F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 81.78244F));
      this.tableLayoutPanel1.Controls.Add(this.label1, 0, 0);
      this.tableLayoutPanel1.Controls.Add(this.txtValidateDb, 1, 0);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 2;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 9.422492F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 90.57751F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(763, 304);
      this.tableLayoutPanel1.TabIndex = 0;
      // 
      // label1
      // 
      this.label1.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.label1.AutoSize = true;
      this.label1.Location = new System.Drawing.Point(3, 7);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(94, 13);
      this.label1.TabIndex = 0;
      this.label1.Text = "Validate Database";
      // 
      // txtValidateDb
      // 
      this.txtValidateDb.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.txtValidateDb.Location = new System.Drawing.Point(141, 4);
      this.txtValidateDb.Name = "txtValidateDb";
      this.txtValidateDb.ReadOnly = true;
      this.txtValidateDb.Size = new System.Drawing.Size(431, 20);
      this.txtValidateDb.TabIndex = 1;
      // 
      // toolStrip1
      // 
      this.toolStrip1.Anchor = System.Windows.Forms.AnchorStyles.None;
      this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbExtract,
            this.tsbSetValidateDb,
            this.tsbClose});
      this.toolStrip1.Location = new System.Drawing.Point(3, 0);
      this.toolStrip1.Name = "toolStrip1";
      this.toolStrip1.Size = new System.Drawing.Size(221, 25);
      this.toolStrip1.TabIndex = 0;
      // 
      // tsbExtract
      // 
      this.tsbExtract.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
      this.tsbExtract.Image = ((System.Drawing.Image)(resources.GetObject("tsbExtract.Image")));
      this.tsbExtract.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbExtract.Name = "tsbExtract";
      this.tsbExtract.Size = new System.Drawing.Size(46, 22);
      this.tsbExtract.Text = "Extract";
      this.tsbExtract.Click += new System.EventHandler(this.ExtractData);
      // 
      // tsbSetValidateDb
      // 
      this.tsbSetValidateDb.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
      this.tsbSetValidateDb.Image = ((System.Drawing.Image)(resources.GetObject("tsbSetValidateDb.Image")));
      this.tsbSetValidateDb.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbSetValidateDb.Name = "tsbSetValidateDb";
      this.tsbSetValidateDb.Size = new System.Drawing.Size(123, 22);
      this.tsbSetValidateDb.Text = "Set Validate Database";
      this.tsbSetValidateDb.Click += new System.EventHandler(this.SetValidateDatabase);
      // 
      // tsbClose
      // 
      this.tsbClose.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
      this.tsbClose.Image = ((System.Drawing.Image)(resources.GetObject("tsbClose.Image")));
      this.tsbClose.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbClose.Name = "tsbClose";
      this.tsbClose.Size = new System.Drawing.Size(40, 22);
      this.tsbClose.Text = "Close";
      this.tsbClose.Click += new System.EventHandler(this.CloseWindow);
      // 
      // ofdValidateDb
      // 
      this.ofdValidateDb.Filter = "Microsoft Access Databases|*.mdb";
      // 
      // toolStrip2
      // 
      this.toolStrip2.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip2.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tspExtract,
            this.tslStatus});
      this.toolStrip2.Location = new System.Drawing.Point(3, 0);
      this.toolStrip2.Name = "toolStrip2";
      this.toolStrip2.Size = new System.Drawing.Size(487, 25);
      this.toolStrip2.TabIndex = 0;
      // 
      // tslStatus
      // 
      this.tslStatus.Name = "tslStatus";
      this.tslStatus.Size = new System.Drawing.Size(42, 22);
      this.tslStatus.Text = "Ready.";
      // 
      // tspExtract
      // 
      this.tspExtract.Name = "tspExtract";
      this.tspExtract.Size = new System.Drawing.Size(400, 22);
      // 
      // ExtractMaximo
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(763, 354);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "ExtractMaximo";
      this.Text = "Extract Maximo Data";
      this.toolStripContainer1.BottomToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.BottomToolStripPanel.PerformLayout();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this.tableLayoutPanel1.ResumeLayout(false);
      this.tableLayoutPanel1.PerformLayout();
      this.toolStrip1.ResumeLayout(false);
      this.toolStrip1.PerformLayout();
      this.toolStrip2.ResumeLayout(false);
      this.toolStrip2.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.ToolStrip toolStrip1;
    private System.Windows.Forms.ToolStripButton tsbClose;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.ToolStripButton tsbExtract;
    private System.Windows.Forms.ToolStripButton tsbSetValidateDb;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.TextBox txtValidateDb;
    private System.Windows.Forms.OpenFileDialog ofdValidateDb;
    private System.Windows.Forms.ToolStrip toolStrip2;
    private System.Windows.Forms.ToolStripLabel tslStatus;
    private System.Windows.Forms.ToolStripProgressBar tspExtract;
  }
}