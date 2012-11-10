/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Nov-2009  10502 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

namespace PowerSoftware.Krakatau.Kepm.Forms
{
  partial class FormDirectoryTreeSelector
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormDirectoryTreeSelector));
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
      this.cmdCancel = new System.Windows.Forms.Button();
      this.cmdOk = new System.Windows.Forms.Button();
      this._trvDirs = new System.Windows.Forms.TreeView();
      this.tableLayoutPanel1.SuspendLayout();
      this.flowLayoutPanel1.SuspendLayout();
      this.SuspendLayout();
      //
      // tableLayoutPanel1
      //
      this.tableLayoutPanel1.ColumnCount = 1;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.Controls.Add(this.flowLayoutPanel1, 0, 1);
      this.tableLayoutPanel1.Controls.Add(this._trvDirs, 0, 0);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 2;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 35F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(620, 411);
      this.tableLayoutPanel1.TabIndex = 0;
      //
      // flowLayoutPanel1
      //
      this.flowLayoutPanel1.Controls.Add(this.cmdCancel);
      this.flowLayoutPanel1.Controls.Add(this.cmdOk);
      this.flowLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.flowLayoutPanel1.FlowDirection = System.Windows.Forms.FlowDirection.RightToLeft;
      this.flowLayoutPanel1.Location = new System.Drawing.Point(3, 379);
      this.flowLayoutPanel1.Name = "flowLayoutPanel1";
      this.flowLayoutPanel1.Size = new System.Drawing.Size(614, 29);
      this.flowLayoutPanel1.TabIndex = 1;
      //
      // cmdCancel
      //
      this.cmdCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.cmdCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdCancel.Location = new System.Drawing.Point(536, 3);
      this.cmdCancel.Name = "cmdCancel";
      this.cmdCancel.Size = new System.Drawing.Size(75, 23);
      this.cmdCancel.TabIndex = 0;
      this.cmdCancel.Text = "&Cancel";
      this.cmdCancel.UseVisualStyleBackColor = true;
      //
      // cmdOk
      //
      this.cmdOk.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.cmdOk.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdOk.Location = new System.Drawing.Point(455, 3);
      this.cmdOk.Name = "cmdOk";
      this.cmdOk.Size = new System.Drawing.Size(75, 23);
      this.cmdOk.TabIndex = 1;
      this.cmdOk.Text = "&OK";
      this.cmdOk.UseVisualStyleBackColor = true;
      this.cmdOk.Click += new System.EventHandler(this.SaveExcludedDirectories);
      //
      // _trvDirs
      //
      this._trvDirs.CheckBoxes = true;
      this._trvDirs.Dock = System.Windows.Forms.DockStyle.Fill;
      this._trvDirs.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._trvDirs.Location = new System.Drawing.Point(3, 3);
      this._trvDirs.Name = "_trvDirs";
      this._trvDirs.Size = new System.Drawing.Size(614, 370);
      this._trvDirs.TabIndex = 2;
      //
      // FormDirectoryTreeSelector
      //
      this.AcceptButton = this.cmdOk;
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.CancelButton = this.cmdCancel;
      this.ClientSize = new System.Drawing.Size(620, 411);
      this.Controls.Add(this.tableLayoutPanel1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "FormDirectoryTreeSelector";
      this.Text = "Directory Selector";
      this.Load += new System.EventHandler(this.FormDirectoryTreeSelector_Load);
      this.tableLayoutPanel1.ResumeLayout(false);
      this.flowLayoutPanel1.ResumeLayout(false);
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
    private System.Windows.Forms.Button cmdCancel;
    private System.Windows.Forms.Button cmdOk;
    private System.Windows.Forms.TreeView _trvDirs;
  }
}