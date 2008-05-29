/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-May-08   364 : Added Preferences.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

namespace KrakatauEPM
{
  partial class FormPreferences
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormPreferences));
      this._tlpPrefs = new System.Windows.Forms.TableLayoutPanel();
      this._lblHeadingMySQL = new System.Windows.Forms.Label();
      this._lblServer = new System.Windows.Forms.Label();
      this._lblUsername = new System.Windows.Forms.Label();
      this._lblPassword = new System.Windows.Forms.Label();
      this._flpButtons = new System.Windows.Forms.FlowLayoutPanel();
      this._btnCancel = new System.Windows.Forms.Button();
      this._btnOK = new System.Windows.Forms.Button();
      this._txtServer = new System.Windows.Forms.TextBox();
      this._txtUsername = new System.Windows.Forms.TextBox();
      this._txtPassword = new System.Windows.Forms.TextBox();
      this._chkUse = new System.Windows.Forms.CheckBox();
      this._tlpPrefs.SuspendLayout();
      this._flpButtons.SuspendLayout();
      this.SuspendLayout();
      //
      // _tlpPrefs
      //
      this._tlpPrefs.ColumnCount = 2;
      this._tlpPrefs.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 80F));
      this._tlpPrefs.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this._tlpPrefs.Controls.Add(this._lblHeadingMySQL, 0, 0);
      this._tlpPrefs.Controls.Add(this._lblServer, 0, 1);
      this._tlpPrefs.Controls.Add(this._lblUsername, 0, 2);
      this._tlpPrefs.Controls.Add(this._lblPassword, 0, 3);
      this._tlpPrefs.Controls.Add(this._flpButtons, 1, 6);
      this._tlpPrefs.Controls.Add(this._txtServer, 1, 1);
      this._tlpPrefs.Controls.Add(this._txtUsername, 1, 2);
      this._tlpPrefs.Controls.Add(this._txtPassword, 1, 3);
      this._tlpPrefs.Controls.Add(this._chkUse, 1, 4);
      this._tlpPrefs.Dock = System.Windows.Forms.DockStyle.Fill;
      this._tlpPrefs.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._tlpPrefs.Location = new System.Drawing.Point(0, 0);
      this._tlpPrefs.Name = "_tlpPrefs";
      this._tlpPrefs.RowCount = 7;
      this._tlpPrefs.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this._tlpPrefs.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this._tlpPrefs.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this._tlpPrefs.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this._tlpPrefs.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this._tlpPrefs.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this._tlpPrefs.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 33F));
      this._tlpPrefs.Size = new System.Drawing.Size(444, 232);
      this._tlpPrefs.TabIndex = 0;
      //
      // _lblHeadingMySQL
      //
      this._lblHeadingMySQL.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this._lblHeadingMySQL.AutoSize = true;
      this._lblHeadingMySQL.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._lblHeadingMySQL.Location = new System.Drawing.Point(3, 7);
      this._lblHeadingMySQL.Name = "_lblHeadingMySQL";
      this._lblHeadingMySQL.Size = new System.Drawing.Size(51, 16);
      this._lblHeadingMySQL.TabIndex = 0;
      this._lblHeadingMySQL.Text = "MySQL";
      //
      // _lblServer
      //
      this._lblServer.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this._lblServer.AutoSize = true;
      this._lblServer.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._lblServer.Location = new System.Drawing.Point(3, 38);
      this._lblServer.Name = "_lblServer";
      this._lblServer.Size = new System.Drawing.Size(45, 13);
      this._lblServer.TabIndex = 1;
      this._lblServer.Text = "Server";
      //
      // _lblUsername
      //
      this._lblUsername.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this._lblUsername.AutoSize = true;
      this._lblUsername.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._lblUsername.Location = new System.Drawing.Point(3, 68);
      this._lblUsername.Name = "_lblUsername";
      this._lblUsername.Size = new System.Drawing.Size(65, 13);
      this._lblUsername.TabIndex = 2;
      this._lblUsername.Text = "Username";
      //
      // _lblPassword
      //
      this._lblPassword.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this._lblPassword.AutoSize = true;
      this._lblPassword.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._lblPassword.Location = new System.Drawing.Point(3, 98);
      this._lblPassword.Name = "_lblPassword";
      this._lblPassword.Size = new System.Drawing.Size(61, 13);
      this._lblPassword.TabIndex = 3;
      this._lblPassword.Text = "Password";
      //
      // _flpButtons
      //
      this._flpButtons.Controls.Add(this._btnCancel);
      this._flpButtons.Controls.Add(this._btnOK);
      this._flpButtons.Dock = System.Windows.Forms.DockStyle.Fill;
      this._flpButtons.FlowDirection = System.Windows.Forms.FlowDirection.RightToLeft;
      this._flpButtons.Location = new System.Drawing.Point(83, 202);
      this._flpButtons.Name = "_flpButtons";
      this._flpButtons.Size = new System.Drawing.Size(358, 27);
      this._flpButtons.TabIndex = 4;
      //
      // _btnCancel
      //
      this._btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this._btnCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._btnCancel.Location = new System.Drawing.Point(280, 3);
      this._btnCancel.Name = "_btnCancel";
      this._btnCancel.Size = new System.Drawing.Size(75, 23);
      this._btnCancel.TabIndex = 0;
      this._btnCancel.Text = "&Cancel";
      this._btnCancel.UseVisualStyleBackColor = true;
      //
      // _btnOK
      //
      this._btnOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this._btnOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._btnOK.Location = new System.Drawing.Point(199, 3);
      this._btnOK.Name = "_btnOK";
      this._btnOK.Size = new System.Drawing.Size(75, 23);
      this._btnOK.TabIndex = 1;
      this._btnOK.Text = "&OK";
      this._btnOK.UseVisualStyleBackColor = true;
      //
      // _txtServer
      //
      this._txtServer.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this._txtServer.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._txtServer.Location = new System.Drawing.Point(83, 34);
      this._txtServer.Name = "_txtServer";
      this._txtServer.Size = new System.Drawing.Size(78, 21);
      this._txtServer.TabIndex = 5;
      this._txtServer.Text = "localhost";
      //
      // _txtUsername
      //
      this._txtUsername.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this._txtUsername.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._txtUsername.Location = new System.Drawing.Point(83, 64);
      this._txtUsername.Name = "_txtUsername";
      this._txtUsername.Size = new System.Drawing.Size(78, 21);
      this._txtUsername.TabIndex = 6;
      this._txtUsername.Text = "root";
      //
      // _txtPassword
      //
      this._txtPassword.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this._txtPassword.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._txtPassword.Location = new System.Drawing.Point(83, 94);
      this._txtPassword.Name = "_txtPassword";
      this._txtPassword.PasswordChar = '*';
      this._txtPassword.Size = new System.Drawing.Size(110, 21);
      this._txtPassword.TabIndex = 7;
      this._txtPassword.UseSystemPasswordChar = true;
      //
      // _chkUse
      //
      this._chkUse.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this._chkUse.AutoSize = true;
      this._chkUse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._chkUse.Location = new System.Drawing.Point(83, 126);
      this._chkUse.Name = "_chkUse";
      this._chkUse.Size = new System.Drawing.Size(217, 17);
      this._chkUse.TabIndex = 9;
      this._chkUse.Text = "Use these as defaults for new projects?";
      this._chkUse.UseVisualStyleBackColor = true;
      //
      // FormPreferences
      //
      this.AcceptButton = this._btnOK;
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.CancelButton = this._btnCancel;
      this.ClientSize = new System.Drawing.Size(444, 232);
      this.Controls.Add(this._tlpPrefs);
      this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.MinimizeBox = false;
      this.Name = "FormPreferences";
      this.Text = "Preferences";
      this.Load += new System.EventHandler(this.FormPreferences_Load);
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FormPreferences_FormClosing);
      this._tlpPrefs.ResumeLayout(false);
      this._tlpPrefs.PerformLayout();
      this._flpButtons.ResumeLayout(false);
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.TableLayoutPanel _tlpPrefs;
    private System.Windows.Forms.Label _lblHeadingMySQL;
    private System.Windows.Forms.Label _lblServer;
    private System.Windows.Forms.Label _lblUsername;
    private System.Windows.Forms.Label _lblPassword;
    private System.Windows.Forms.FlowLayoutPanel _flpButtons;
    private System.Windows.Forms.Button _btnCancel;
    private System.Windows.Forms.Button _btnOK;
    private System.Windows.Forms.TextBox _txtServer;
    private System.Windows.Forms.TextBox _txtUsername;
    private System.Windows.Forms.TextBox _txtPassword;
    private System.Windows.Forms.CheckBox _chkUse;
  }
}