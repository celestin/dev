/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Event History
 *
 * $Id: DbService.cs 116 2006-05-19 22:10:25Z craig $
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.IO;
using FlexCell;

namespace frontburner.maia.Acumen
{
	/// <summary>
	/// Summary description for EventHistory.
	/// </summary>
  public class EventHistory : System.Windows.Forms.Form
  {
    private System.Windows.Forms.StatusBar stbEvents;
    private FlexCell.Grid fgdEvents;
    private System.Windows.Forms.ImageList imlIcons;
    private System.ComponentModel.IContainer components;

    public EventHistory()
    {
      //
      // Required for Windows Form Designer support
      //
      InitializeComponent();
    }

    public void AddEvent(Event e) 
    {
      fgdEvents.Rows++;
      int r = (fgdEvents.Rows-1);
      fgdEvents.Cell(r, 1).SetImage(e.EventType);

      fgdEvents.Cell(r, 2).Text = DataLayer.getDataLayer().DartComponent(e.Dart).Name;
      fgdEvents.Cell(r, 3).Text = e.ResultTime;
      fgdEvents.Cell(r, 4).Text = "Speed overrun";
      fgdEvents.Cell(r, 5).Text = e.Speed.ToString();
      fgdEvents.Cell(r, 6).Text = e.Temp.ToString();
      fgdEvents.Cell(r, 7).Text = e.Vb1.ToString();
      fgdEvents.Cell(r, 8).Text = e.Vb2.ToString();
      fgdEvents.Cell(r, 9).Text = e.Vb3.ToString();
    }

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    protected override void Dispose( bool disposing )
    {
      if( disposing )
      {
        if(components != null)
        {
          components.Dispose();
        }
      }
      base.Dispose( disposing );
    }

    #region Windows Form Designer generated code
    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      this.components = new System.ComponentModel.Container();
      System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(EventHistory));
      this.fgdEvents = new FlexCell.Grid();
      this.stbEvents = new System.Windows.Forms.StatusBar();
      this.imlIcons = new System.Windows.Forms.ImageList(this.components);
      this.SuspendLayout();
      // 
      // fgdEvents
      // 
      this.fgdEvents.CheckedImage = ((System.Drawing.Bitmap)(resources.GetObject("fgdEvents.CheckedImage")));
      this.fgdEvents.Dock = System.Windows.Forms.DockStyle.Fill;
      this.fgdEvents.Location = new System.Drawing.Point(0, 0);
      this.fgdEvents.Name = "fgdEvents";
      this.fgdEvents.Size = new System.Drawing.Size(864, 493);
      this.fgdEvents.TabIndex = 0;
      this.fgdEvents.UncheckedImage = ((System.Drawing.Bitmap)(resources.GetObject("fgdEvents.UncheckedImage")));
      this.fgdEvents.Load += new System.EventHandler(this.fgdEvents_Load);
      // 
      // stbEvents
      // 
      this.stbEvents.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.stbEvents.Location = new System.Drawing.Point(0, 471);
      this.stbEvents.Name = "stbEvents";
      this.stbEvents.Size = new System.Drawing.Size(864, 22);
      this.stbEvents.TabIndex = 1;
      this.stbEvents.Text = "Ready";
      // 
      // imlIcons
      // 
      this.imlIcons.ColorDepth = System.Windows.Forms.ColorDepth.Depth24Bit;
      this.imlIcons.ImageSize = new System.Drawing.Size(16, 16);
      this.imlIcons.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlIcons.ImageStream")));
      this.imlIcons.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // EventHistory
      // 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(864, 493);
      this.Controls.Add(this.stbEvents);
      this.Controls.Add(this.fgdEvents);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "EventHistory";
      this.Text = "Event Log";
      this.ResumeLayout(false);

    }
    #endregion

    private void fgdEvents_Load(object sender, System.EventArgs e)
    {
      fgdEvents.Cols = 10;
      fgdEvents.ExtendLastCol = true;
      fgdEvents.FixedRowColStyle = FixedRowColStyleEnum.Flat;
      fgdEvents.DefaultFont = new Font("Tahoma", 8);
      fgdEvents.BorderStyle = BorderStyleEnum.FixedSingle; 

      fgdEvents.BackColorFixed = Color.FromArgb(90, 158, 214);
      fgdEvents.BackColorFixedSel = Color.FromArgb(110, 180, 230);
      fgdEvents.BackColorBkg = Color.WhiteSmoke;
      fgdEvents.BackColor1 = Color.FromArgb(231, 235, 247);
      fgdEvents.BackColor2 = Color.FromArgb(239, 243, 255);
      fgdEvents.CellBorderColorFixed = Color.Black;
      fgdEvents.GridColor = Color.FromArgb(148, 190, 231);

      fgdEvents.Cell(0, 1).Text = "";
      fgdEvents.Cell(0, 2).Text = "Dart";
      fgdEvents.Cell(0, 3).Text = "Time";
      fgdEvents.Cell(0, 4).Text = "Description";
      fgdEvents.Cell(0, 5).Text = "Speed RPM x 1000";
      fgdEvents.Cell(0, 6).Text = "Temp oC";
      fgdEvents.Cell(0, 7).Text = "Radial (X) mm/s2";
      fgdEvents.Cell(0, 8).Text = "Radial (Y) mm/s2";
      fgdEvents.Cell(0, 9).Text = "Axial mm/s2";

      fgdEvents.Column(1).Width = 16;
      fgdEvents.Column(2).Width = 100;
      fgdEvents.Column(3).Width = 60;
      fgdEvents.Column(4).Width = 150;
      fgdEvents.Column(5).Width = 100;
      fgdEvents.Column(6).Width = 100;
      fgdEvents.Column(7).Width = 100;
      fgdEvents.Column(8).Width = 100;
      fgdEvents.Column(9).Width = 100;

      fgdEvents.Column(0).Visible = false;

      fgdEvents.Rows = 1;

      FileInfo fi = new FileInfo(Application.StartupPath + "\\img\\events\\warning.png");
      if (fi.Exists) fgdEvents.Images.Add(fi.FullName, "W");
      fi = new FileInfo(Application.StartupPath + "\\img\\events\\error.png");
      if (fi.Exists) fgdEvents.Images.Add(fi.FullName, "D");

      ArrayList events = DataLayer.getDataLayer().GetEvents();
      IEnumerator ev = events.GetEnumerator();
      while (ev.MoveNext()) 
      {
        AddEvent((Event)ev.Current);
      }

    }
  }
}
