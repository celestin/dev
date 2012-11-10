/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  16-Mar-2010  10597 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

namespace PowerSoftware.Krakatau.Kepm.Forms
{
  partial class FormPopupTip
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormPopupTip));
      this.label1 = new System.Windows.Forms.Label();
      this.btnOk = new System.Windows.Forms.Button();
      this.btnCancel = new System.Windows.Forms.Button();
      this.chkDontShowThisTip = new System.Windows.Forms.CheckBox();
      this.chkNeverShowAnyTips = new System.Windows.Forms.CheckBox();
      this.txtTip = new System.Windows.Forms.TextBox();
      this.SuspendLayout();
      // 
      // label1
      // 
      this.label1.AutoSize = true;
      this.label1.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(12, 9);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(170, 23);
      this.label1.TabIndex = 0;
      this.label1.Text = "Did you know...?";
      // 
      // btnOk
      // 
      this.btnOk.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.btnOk.Location = new System.Drawing.Point(283, 211);
      this.btnOk.Name = "btnOk";
      this.btnOk.Size = new System.Drawing.Size(75, 23);
      this.btnOk.TabIndex = 2;
      this.btnOk.Text = "&OK";
      this.btnOk.UseVisualStyleBackColor = true;
      this.btnOk.Click += new System.EventHandler(this.OkClicked);
      // 
      // btnCancel
      // 
      this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.btnCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.btnCancel.Location = new System.Drawing.Point(368, 211);
      this.btnCancel.Name = "btnCancel";
      this.btnCancel.Size = new System.Drawing.Size(75, 23);
      this.btnCancel.TabIndex = 3;
      this.btnCancel.Text = "&Cancel";
      this.btnCancel.UseVisualStyleBackColor = true;
      // 
      // chkDontShowThisTip
      // 
      this.chkDontShowThisTip.AutoSize = true;
      this.chkDontShowThisTip.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkDontShowThisTip.Location = new System.Drawing.Point(283, 16);
      this.chkDontShowThisTip.Name = "chkDontShowThisTip";
      this.chkDontShowThisTip.Size = new System.Drawing.Size(160, 17);
      this.chkDontShowThisTip.TabIndex = 4;
      this.chkDontShowThisTip.Text = "Don\'t show me this tip again";
      this.chkDontShowThisTip.UseVisualStyleBackColor = true;
      // 
      // chkNeverShowAnyTips
      // 
      this.chkNeverShowAnyTips.AutoSize = true;
      this.chkNeverShowAnyTips.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkNeverShowAnyTips.Location = new System.Drawing.Point(16, 215);
      this.chkNeverShowAnyTips.Name = "chkNeverShowAnyTips";
      this.chkNeverShowAnyTips.Size = new System.Drawing.Size(170, 17);
      this.chkNeverShowAnyTips.TabIndex = 5;
      this.chkNeverShowAnyTips.Text = "Never show me any tips again";
      this.chkNeverShowAnyTips.UseVisualStyleBackColor = true;
      // 
      // txtTip
      // 
      this.txtTip.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtTip.Location = new System.Drawing.Point(16, 39);
      this.txtTip.Multiline = true;
      this.txtTip.Name = "txtTip";
      this.txtTip.ReadOnly = true;
      this.txtTip.Size = new System.Drawing.Size(427, 145);
      this.txtTip.TabIndex = 6;
      this.txtTip.Text = resources.GetString("txtTip.Text");
      // 
      // FormPopupTip
      // 
      this.AcceptButton = this.btnOk;
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.CancelButton = this.btnCancel;
      this.ClientSize = new System.Drawing.Size(459, 248);
      this.Controls.Add(this.txtTip);
      this.Controls.Add(this.chkNeverShowAnyTips);
      this.Controls.Add(this.chkDontShowThisTip);
      this.Controls.Add(this.btnCancel);
      this.Controls.Add(this.btnOk);
      this.Controls.Add(this.label1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.MinimizeBox = false;
      this.Name = "FormPopupTip";
      this.Text = "Krakatau EPM Popup Tip";
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.Button btnOk;
    private System.Windows.Forms.Button btnCancel;
    private System.Windows.Forms.CheckBox chkDontShowThisTip;
    private System.Windows.Forms.CheckBox chkNeverShowAnyTips;
    private System.Windows.Forms.TextBox txtTip;
  }
}