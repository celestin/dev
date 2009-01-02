/* * * * * * * * * * * * * * * * * * * * * * * *
 * Photoframe Wizard
 * Copyright (c) 2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  02-Jan-2009  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace Fb.Apps.PhotoframeWizard
{
    partial class FrmPhotoframeWizard
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
          System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmPhotoframeWizard));
          this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
          this.statusStrip1 = new System.Windows.Forms.StatusStrip();
          this.tslStatus = new System.Windows.Forms.ToolStripStatusLabel();
          this.tspbProgress = new System.Windows.Forms.ToolStripProgressBar();
          this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
          this.flowLayoutPanel2 = new System.Windows.Forms.FlowLayoutPanel();
          this.txtOutput = new System.Windows.Forms.TextBox();
          this.btnSetOutputDir = new System.Windows.Forms.Button();
          this.label2 = new System.Windows.Forms.Label();
          this.label1 = new System.Windows.Forms.Label();
          this.label3 = new System.Windows.Forms.Label();
          this.txtWidth = new System.Windows.Forms.TextBox();
          this.txtHeight = new System.Windows.Forms.TextBox();
          this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
          this.txtInput = new System.Windows.Forms.TextBox();
          this.btnSetInputDir = new System.Windows.Forms.Button();
          this.menuStrip1 = new System.Windows.Forms.MenuStrip();
          this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
          this.tsmCopy = new System.Windows.Forms.ToolStripMenuItem();
          this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
          this.tsmExit = new System.Windows.Forms.ToolStripMenuItem();
          this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
          this.tsmHelpAbout = new System.Windows.Forms.ToolStripMenuItem();
          this.toolStrip1 = new System.Windows.Forms.ToolStrip();
          this.tsbExit = new System.Windows.Forms.ToolStripButton();
          this.tsbCopy = new System.Windows.Forms.ToolStripButton();
          this.timer1 = new System.Windows.Forms.Timer(this.components);
          this.fbdSave = new System.Windows.Forms.FolderBrowserDialog();
          this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
          this.toolStripContainer1.ContentPanel.SuspendLayout();
          this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
          this.toolStripContainer1.SuspendLayout();
          this.statusStrip1.SuspendLayout();
          this.tableLayoutPanel1.SuspendLayout();
          this.flowLayoutPanel2.SuspendLayout();
          this.flowLayoutPanel1.SuspendLayout();
          this.menuStrip1.SuspendLayout();
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
          this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(644, 302);
          this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
          this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
          this.toolStripContainer1.Name = "toolStripContainer1";
          this.toolStripContainer1.Size = new System.Drawing.Size(644, 403);
          this.toolStripContainer1.TabIndex = 0;
          this.toolStripContainer1.Text = "toolStripContainer1";
          //
          // toolStripContainer1.TopToolStripPanel
          //
          this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.menuStrip1);
          this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
          //
          // statusStrip1
          //
          this.statusStrip1.Dock = System.Windows.Forms.DockStyle.None;
          this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tslStatus,
            this.tspbProgress});
          this.statusStrip1.Location = new System.Drawing.Point(0, 0);
          this.statusStrip1.Name = "statusStrip1";
          this.statusStrip1.Size = new System.Drawing.Size(644, 22);
          this.statusStrip1.TabIndex = 0;
          //
          // tslStatus
          //
          this.tslStatus.Name = "tslStatus";
          this.tslStatus.Size = new System.Drawing.Size(42, 17);
          this.tslStatus.Text = "Ready.";
          //
          // tspbProgress
          //
          this.tspbProgress.Name = "tspbProgress";
          this.tspbProgress.Size = new System.Drawing.Size(300, 16);
          //
          // tableLayoutPanel1
          //
          this.tableLayoutPanel1.ColumnCount = 3;
          this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
          this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 70F));
          this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
          this.tableLayoutPanel1.Controls.Add(this.flowLayoutPanel2, 1, 1);
          this.tableLayoutPanel1.Controls.Add(this.label2, 0, 1);
          this.tableLayoutPanel1.Controls.Add(this.label1, 0, 0);
          this.tableLayoutPanel1.Controls.Add(this.label3, 0, 2);
          this.tableLayoutPanel1.Controls.Add(this.txtWidth, 1, 2);
          this.tableLayoutPanel1.Controls.Add(this.txtHeight, 2, 2);
          this.tableLayoutPanel1.Controls.Add(this.flowLayoutPanel1, 1, 0);
          this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
          this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
          this.tableLayoutPanel1.Name = "tableLayoutPanel1";
          this.tableLayoutPanel1.RowCount = 5;
          this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
          this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
          this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
          this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
          this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle());
          this.tableLayoutPanel1.Size = new System.Drawing.Size(644, 302);
          this.tableLayoutPanel1.TabIndex = 0;
          //
          // flowLayoutPanel2
          //
          this.tableLayoutPanel1.SetColumnSpan(this.flowLayoutPanel2, 2);
          this.flowLayoutPanel2.Controls.Add(this.txtOutput);
          this.flowLayoutPanel2.Controls.Add(this.btnSetOutputDir);
          this.flowLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
          this.flowLayoutPanel2.Location = new System.Drawing.Point(100, 30);
          this.flowLayoutPanel2.Margin = new System.Windows.Forms.Padding(0);
          this.flowLayoutPanel2.Name = "flowLayoutPanel2";
          this.flowLayoutPanel2.Size = new System.Drawing.Size(544, 30);
          this.flowLayoutPanel2.TabIndex = 8;
          //
          // txtOutput
          //
          this.txtOutput.Anchor = System.Windows.Forms.AnchorStyles.Left;
          this.txtOutput.Location = new System.Drawing.Point(3, 4);
          this.txtOutput.Name = "txtOutput";
          this.txtOutput.Size = new System.Drawing.Size(355, 20);
          this.txtOutput.TabIndex = 4;
          this.txtOutput.Text = "I:\\";
          //
          // btnSetOutputDir
          //
          this.btnSetOutputDir.Location = new System.Drawing.Point(364, 3);
          this.btnSetOutputDir.Name = "btnSetOutputDir";
          this.btnSetOutputDir.Size = new System.Drawing.Size(28, 23);
          this.btnSetOutputDir.TabIndex = 5;
          this.btnSetOutputDir.Text = "...";
          this.btnSetOutputDir.UseVisualStyleBackColor = true;
          this.btnSetOutputDir.Click += new System.EventHandler(this.btnSetOutputDir_Click);
          //
          // label2
          //
          this.label2.Anchor = System.Windows.Forms.AnchorStyles.Left;
          this.label2.AutoSize = true;
          this.label2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
          this.label2.Location = new System.Drawing.Point(3, 38);
          this.label2.Name = "label2";
          this.label2.Size = new System.Drawing.Size(21, 13);
          this.label2.TabIndex = 3;
          this.label2.Text = "To";
          //
          // label1
          //
          this.label1.Anchor = System.Windows.Forms.AnchorStyles.Left;
          this.label1.AutoSize = true;
          this.label1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
          this.label1.Location = new System.Drawing.Point(3, 8);
          this.label1.Name = "label1";
          this.label1.Size = new System.Drawing.Size(67, 13);
          this.label1.TabIndex = 0;
          this.label1.Text = "Copy From";
          //
          // label3
          //
          this.label3.Anchor = System.Windows.Forms.AnchorStyles.Left;
          this.label3.AutoSize = true;
          this.label3.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
          this.label3.Location = new System.Drawing.Point(3, 68);
          this.label3.Name = "label3";
          this.label3.Size = new System.Drawing.Size(70, 13);
          this.label3.TabIndex = 6;
          this.label3.Text = "Image Size";
          //
          // txtWidth
          //
          this.txtWidth.Anchor = System.Windows.Forms.AnchorStyles.Left;
          this.txtWidth.Location = new System.Drawing.Point(103, 65);
          this.txtWidth.Name = "txtWidth";
          this.txtWidth.Size = new System.Drawing.Size(48, 20);
          this.txtWidth.TabIndex = 7;
          this.txtWidth.Text = "480";
          this.txtWidth.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
          //
          // txtHeight
          //
          this.txtHeight.Anchor = System.Windows.Forms.AnchorStyles.Left;
          this.txtHeight.Location = new System.Drawing.Point(173, 65);
          this.txtHeight.Name = "txtHeight";
          this.txtHeight.Size = new System.Drawing.Size(48, 20);
          this.txtHeight.TabIndex = 8;
          this.txtHeight.Text = "232";
          this.txtHeight.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
          //
          // flowLayoutPanel1
          //
          this.tableLayoutPanel1.SetColumnSpan(this.flowLayoutPanel1, 2);
          this.flowLayoutPanel1.Controls.Add(this.txtInput);
          this.flowLayoutPanel1.Controls.Add(this.btnSetInputDir);
          this.flowLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
          this.flowLayoutPanel1.Location = new System.Drawing.Point(100, 0);
          this.flowLayoutPanel1.Margin = new System.Windows.Forms.Padding(0);
          this.flowLayoutPanel1.Name = "flowLayoutPanel1";
          this.flowLayoutPanel1.Size = new System.Drawing.Size(544, 30);
          this.flowLayoutPanel1.TabIndex = 7;
          //
          // txtInput
          //
          this.txtInput.Anchor = System.Windows.Forms.AnchorStyles.Left;
          this.txtInput.Location = new System.Drawing.Point(3, 4);
          this.txtInput.Name = "txtInput";
          this.txtInput.Size = new System.Drawing.Size(355, 20);
          this.txtInput.TabIndex = 1;
          this.txtInput.Text = "C:\\tmp\\photos\\mum\\photoframe";
          //
          // btnSetInputDir
          //
          this.btnSetInputDir.Location = new System.Drawing.Point(364, 3);
          this.btnSetInputDir.Name = "btnSetInputDir";
          this.btnSetInputDir.Size = new System.Drawing.Size(28, 23);
          this.btnSetInputDir.TabIndex = 2;
          this.btnSetInputDir.Text = "...";
          this.btnSetInputDir.UseVisualStyleBackColor = true;
          this.btnSetInputDir.Click += new System.EventHandler(this.btnSetInputDir_Click);
          //
          // menuStrip1
          //
          this.menuStrip1.Dock = System.Windows.Forms.DockStyle.None;
          this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.helpToolStripMenuItem});
          this.menuStrip1.Location = new System.Drawing.Point(0, 0);
          this.menuStrip1.Name = "menuStrip1";
          this.menuStrip1.Size = new System.Drawing.Size(644, 24);
          this.menuStrip1.TabIndex = 0;
          this.menuStrip1.Text = "menuStrip1";
          //
          // fileToolStripMenuItem
          //
          this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsmCopy,
            this.toolStripSeparator1,
            this.tsmExit});
          this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
          this.fileToolStripMenuItem.Size = new System.Drawing.Size(35, 20);
          this.fileToolStripMenuItem.Text = "&File";
          //
          // tsmCopy
          //
          this.tsmCopy.Image = ((System.Drawing.Image)(resources.GetObject("tsmCopy.Image")));
          this.tsmCopy.Name = "tsmCopy";
          this.tsmCopy.Size = new System.Drawing.Size(114, 22);
          this.tsmCopy.Text = "&Copy!";
          this.tsmCopy.Click += new System.EventHandler(this.tsmCopy_Click);
          //
          // toolStripSeparator1
          //
          this.toolStripSeparator1.Name = "toolStripSeparator1";
          this.toolStripSeparator1.Size = new System.Drawing.Size(111, 6);
          //
          // tsmExit
          //
          this.tsmExit.Image = global::Fb.Apps.PhotoframeWizard.Properties.Resources.ExitMenu;
          this.tsmExit.Name = "tsmExit";
          this.tsmExit.Size = new System.Drawing.Size(114, 22);
          this.tsmExit.Text = "E&xit";
          this.tsmExit.Click += new System.EventHandler(this.tsmExit_Click);
          //
          // helpToolStripMenuItem
          //
          this.helpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsmHelpAbout});
          this.helpToolStripMenuItem.Name = "helpToolStripMenuItem";
          this.helpToolStripMenuItem.Size = new System.Drawing.Size(40, 20);
          this.helpToolStripMenuItem.Text = "&Help";
          //
          // tsmHelpAbout
          //
          this.tsmHelpAbout.Image = global::Fb.Apps.PhotoframeWizard.Properties.Resources.AboutMenu;
          this.tsmHelpAbout.Name = "tsmHelpAbout";
          this.tsmHelpAbout.Size = new System.Drawing.Size(209, 22);
          this.tsmHelpAbout.Text = "&About Photoframe Wizard";
          this.tsmHelpAbout.Click += new System.EventHandler(this.tsmHelpAbout_Click);
          //
          // toolStrip1
          //
          this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
          this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbExit,
            this.tsbCopy});
          this.toolStrip1.Location = new System.Drawing.Point(3, 24);
          this.toolStrip1.Name = "toolStrip1";
          this.toolStrip1.Size = new System.Drawing.Size(208, 55);
          this.toolStrip1.TabIndex = 1;
          //
          // tsbExit
          //
          this.tsbExit.Image = global::Fb.Apps.PhotoframeWizard.Properties.Resources.ExitToolbar;
          this.tsbExit.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
          this.tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
          this.tsbExit.Name = "tsbExit";
          this.tsbExit.Size = new System.Drawing.Size(77, 52);
          this.tsbExit.Text = "Exit";
          this.tsbExit.Click += new System.EventHandler(this.tsbExit_Click);
          //
          // tsbCopy
          //
          this.tsbCopy.Image = global::Fb.Apps.PhotoframeWizard.Properties.Resources.CopyToolbar;
          this.tsbCopy.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
          this.tsbCopy.ImageTransparentColor = System.Drawing.Color.Magenta;
          this.tsbCopy.Name = "tsbCopy";
          this.tsbCopy.Size = new System.Drawing.Size(88, 52);
          this.tsbCopy.Text = "Copy!";
          this.tsbCopy.Click += new System.EventHandler(this.tsbCopy_Click);
          //
          // timer1
          //
          this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
          //
          // FrmPhotoframeWizard
          //
          this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
          this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
          this.ClientSize = new System.Drawing.Size(644, 403);
          this.Controls.Add(this.toolStripContainer1);
          this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
          this.MainMenuStrip = this.menuStrip1;
          this.Name = "FrmPhotoframeWizard";
          this.Text = "Photoframe Wizard";
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
          this.flowLayoutPanel2.ResumeLayout(false);
          this.flowLayoutPanel2.PerformLayout();
          this.flowLayoutPanel1.ResumeLayout(false);
          this.flowLayoutPanel1.PerformLayout();
          this.menuStrip1.ResumeLayout(false);
          this.menuStrip1.PerformLayout();
          this.toolStrip1.ResumeLayout(false);
          this.toolStrip1.PerformLayout();
          this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ToolStripContainer toolStripContainer1;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtInput;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem tsmExit;
        private System.Windows.Forms.ToolStripButton tsbCopy;
        private System.Windows.Forms.ToolStripProgressBar tspbProgress;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.ToolStripStatusLabel tslStatus;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtWidth;
        private System.Windows.Forms.TextBox txtHeight;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private System.Windows.Forms.Button btnSetInputDir;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel2;
        private System.Windows.Forms.TextBox txtOutput;
        private System.Windows.Forms.Button btnSetOutputDir;
        private System.Windows.Forms.FolderBrowserDialog fbdSave;
        private System.Windows.Forms.ToolStripButton tsbExit;
        private System.Windows.Forms.ToolStripMenuItem tsmCopy;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem helpToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem tsmHelpAbout;
    }
}
