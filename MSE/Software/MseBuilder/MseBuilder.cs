/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10186 : Added Zip! (export).
 * CAM  11-May-2008  10264 : Replaced FlexCell with DataGridView.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Threading;
using System.Windows.Forms;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder
{
  public partial class MseBuilder : Form
  {
    protected string _author;
    protected int _vol;
    protected bool _specificVolume;
    protected BuilderThread _builder;
    protected ZipperThread _zipper;

    public MseBuilder()
    {
      InitializeComponent();
      DatabaseLayer.Instance.Open();
    }

    private void btnBuild_Click(object sender, EventArgs e)
    {
      _btnZip.Enabled = _btnBuild.Enabled = false;

      grdArticle.Rows.Clear();

      ClearArticles();

      if (_specificVolume = ((txtVol.Text.Length > 0) && (int.Parse(txtVol.Text) > 0)))
      {
        _author = cmbAuthor.SelectedValue.ToString();
        _vol = int.Parse(txtVol.Text);
      }

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.GetVolumes().Count;

      _builder = new BuilderThread(_author, _vol, _specificVolume);
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void _btnZip_Click(object sender, EventArgs e)
    {
      _btnZip.Enabled = _btnBuild.Enabled = false;

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.GetVolumes().Count;

      _zipper = new ZipperThread();
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void tmrRefresh_Tick(object sender, EventArgs e)
    {
      if (_builder != null)
      {
        if (_builder.Process.IsAlive)
        {
          if (_builder.Engine != null) pgbVol.Value = _builder.Engine.Current;
          this.Refresh();
          this.Update();
        }
        else
        {
          tmrRefresh.Enabled = false;

          if (_specificVolume) ShowArticles();
          _builder = null;

          _btnZip.Enabled = _btnBuild.Enabled = true;
        }
      }
      else if (_zipper != null)
      {
        if (_zipper.Process.IsAlive)
        {
          if (_zipper.Engine != null) pgbVol.Value = _zipper.Engine.Current;
          this.Refresh();
          this.Update();
        }
        else
        {
          tmrRefresh.Enabled = false;
          _zipper = null;

          _btnZip.Enabled = _btnBuild.Enabled = true;
        }
      }
    }

    private void MseBuilder_Load(object sender, EventArgs e)
    {
      DataSet ds = DatabaseLayer.Instance.GetAuthors();
      cmbAuthor.DataSource = ds;
      cmbAuthor.DisplayMember = "Author.name";
      cmbAuthor.ValueMember = "Author.author";

      // Article Grid
      grdArticle.Columns.Add("PageNo", "Page No");
      grdArticle.Columns[0].Width = 65;

      grdArticle.Columns.Add("Row", "Row");
      grdArticle.Columns[1].Width = 40;

      grdArticle.Columns.Add("Article", "Article");
      grdArticle.Columns[2].Width = 320;

      grdArticle.Columns.Add("Scriptures", "Scriptures");
      grdArticle.Columns[3].Width = 300;
    }

    protected void ClearArticles()
    {
      BusinessLayer.Instance.Articles.Clear();
      grdArticle.Rows.Clear();
    }

    protected void ShowArticles()
    {
      foreach (Article art in BusinessLayer.Instance.Articles)
      {
        AddArticle(art);
      }

      grdArticle.Refresh();
    }

    protected void AddArticle(Article art)
    {
      DataGridViewRow row = grdArticle.Rows[grdArticle.Rows.Add()];

      row.Cells[0].Value = art.PageNo.ToString();
      row.Cells[1].Value = art.LocalRow.ToString();
      row.Cells[2].Value = art.Title;
      row.Cells[3].Value = art.Scriptures;
    }

    public class BuilderThread
    {
      protected Thread _process;
      protected string _author;
      protected int _vol;
      protected bool _specificVolume;
      protected MseEngine _engine;

      public Thread Process
      {
        get
        {
          return _process;
        }
      }
      public MseEngine Engine
      {
        get
        {
          return _engine;
        }
      }

      public BuilderThread(string author, int vol, bool specificVolume)
      {
        _author = author;
        _vol = vol;
        _specificVolume = specificVolume;

        _process = new Thread(new ThreadStart(Build));
        _process.IsBackground = true;
        _process.Start();
      }

      private void Build()
      {
        _engine = new MseEngine();

        if (_specificVolume)
        {
          _engine.Build(_author, _vol);
        }
        else
        {
          _engine.Build();
        }
      }
    }

    public class ZipperThread
    {
      protected Thread _process;
      protected MseEngine _engine;

      public Thread Process
      {
        get
        {
          return _process;
        }
      }
      public MseEngine Engine
      {
        get
        {
          return _engine;
        }
      }

      public ZipperThread()
      {
        _process = new Thread(new ThreadStart(Zip));
        _process.IsBackground = true;
        _process.Start();
      }

      private void Zip()
      {
        _engine = new MseEngine();
        _engine.Zip();
      }
    }
  }
}