/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Ministry.MseBuilder
{
  partial class MseBuilder
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MseBuilder));
      this._btnBuild = new System.Windows.Forms.Button();
      this.cmbAuthor = new System.Windows.Forms.ComboBox();
      this.label1 = new System.Windows.Forms.Label();
      this.label2 = new System.Windows.Forms.Label();
      this.txtVol = new System.Windows.Forms.TextBox();
      this.pgbVol = new System.Windows.Forms.ProgressBar();
      this.grdArticle = new FlexCell.Grid();
      this.tmrRefresh = new System.Windows.Forms.Timer(this.components);
      this._btnZip = new System.Windows.Forms.Button();
      this.SuspendLayout();
      // 
      // _btnBuild
      // 
      this._btnBuild.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._btnBuild.Location = new System.Drawing.Point(556, 21);
      this._btnBuild.Name = "_btnBuild";
      this._btnBuild.Size = new System.Drawing.Size(142, 53);
      this._btnBuild.TabIndex = 0;
      this._btnBuild.Text = "Build!";
      this._btnBuild.UseVisualStyleBackColor = true;
      this._btnBuild.Click += new System.EventHandler(this.btnBuild_Click);
      // 
      // cmbAuthor
      // 
      this.cmbAuthor.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmbAuthor.FormattingEnabled = true;
      this.cmbAuthor.Location = new System.Drawing.Point(94, 21);
      this.cmbAuthor.Name = "cmbAuthor";
      this.cmbAuthor.Size = new System.Drawing.Size(193, 24);
      this.cmbAuthor.TabIndex = 1;
      // 
      // label1
      // 
      this.label1.AutoSize = true;
      this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(16, 24);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(54, 16);
      this.label1.TabIndex = 2;
      this.label1.Text = "Author";
      // 
      // label2
      // 
      this.label2.AutoSize = true;
      this.label2.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label2.Location = new System.Drawing.Point(16, 54);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(55, 16);
      this.label2.TabIndex = 3;
      this.label2.Text = "Volume";
      // 
      // txtVol
      // 
      this.txtVol.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtVol.Location = new System.Drawing.Point(94, 51);
      this.txtVol.Name = "txtVol";
      this.txtVol.Size = new System.Drawing.Size(64, 23);
      this.txtVol.TabIndex = 4;
      // 
      // pgbVol
      // 
      this.pgbVol.Location = new System.Drawing.Point(12, 96);
      this.pgbVol.Name = "pgbVol";
      this.pgbVol.Size = new System.Drawing.Size(834, 23);
      this.pgbVol.TabIndex = 5;
      // 
      // grdArticle
      // 
      this.grdArticle.CheckedImage = ((System.Drawing.Bitmap)(resources.GetObject("grdArticle.CheckedImage")));
      this.grdArticle.Location = new System.Drawing.Point(12, 136);
      this.grdArticle.Name = "grdArticle";
      this.grdArticle.Size = new System.Drawing.Size(834, 467);
      this.grdArticle.TabIndex = 6;
      this.grdArticle.UncheckedImage = ((System.Drawing.Bitmap)(resources.GetObject("grdArticle.UncheckedImage")));
      // 
      // tmrRefresh
      // 
      this.tmrRefresh.Tick += new System.EventHandler(this.tmrRefresh_Tick);
      // 
      // _btnZip
      // 
      this._btnZip.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._btnZip.Location = new System.Drawing.Point(704, 21);
      this._btnZip.Name = "_btnZip";
      this._btnZip.Size = new System.Drawing.Size(142, 53);
      this._btnZip.TabIndex = 7;
      this._btnZip.Text = "Zip!";
      this._btnZip.UseVisualStyleBackColor = true;
      this._btnZip.Click += new System.EventHandler(this._btnZip_Click);
      // 
      // MseBuilder
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(858, 621);
      this.Controls.Add(this._btnZip);
      this.Controls.Add(this.grdArticle);
      this.Controls.Add(this.pgbVol);
      this.Controls.Add(this.txtVol);
      this.Controls.Add(this.label2);
      this.Controls.Add(this.label1);
      this.Controls.Add(this.cmbAuthor);
      this.Controls.Add(this._btnBuild);
      this.Name = "MseBuilder";
      this.Text = "Ministry Search Engine Data Builder";
      this.Load += new System.EventHandler(this.MseBuilder_Load);
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.Button _btnBuild;
    private System.Windows.Forms.ComboBox cmbAuthor;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.TextBox txtVol;
    private System.Windows.Forms.ProgressBar pgbVol;
    private FlexCell.Grid grdArticle;
    private System.Windows.Forms.Timer tmrRefresh;
    private System.Windows.Forms.Button _btnZip;
  }
}

