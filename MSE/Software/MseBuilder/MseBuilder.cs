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

    public MseBuilder()
    {
      InitializeComponent();
      DatabaseLayer.Instance.Open();
    }

    private void btnBuild_Click(object sender, EventArgs e)
    {
      btnBuild.Enabled = false;

      grdArticle.Rows = 1;

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

    private void tmrRefresh_Tick(object sender, EventArgs e)
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

        btnBuild.Enabled = true;
      }
    }

    private void MseBuilder_Load(object sender, EventArgs e)
    {
      DataSet ds = DatabaseLayer.Instance.GetAuthors();
      cmbAuthor.DataSource = ds;
      cmbAuthor.DisplayMember = "Author.name";
      cmbAuthor.ValueMember = "Author.author";

      // Article Grid
      grdArticle.Cols = 5;
      grdArticle.ExtendLastCol = true;
      grdArticle.Column(0).Visible = false;
      grdArticle.Rows = 1;

      grdArticle.Cell(0, 1).Text = "Page No";
      grdArticle.Cell(0, 2).Text = "Row";
      grdArticle.Cell(0, 3).Text = "Article";
      grdArticle.Cell(0, 4).Text = "Scriptures";

      grdArticle.Column(1).Width = 65;
      grdArticle.Column(2).Width = 40;
      grdArticle.Column(3).Width = 320;
    }

    protected void ClearArticles()
    {
      BusinessLayer.Instance.Articles.Clear();
      grdArticle.Rows = 1;
    }

    protected void ShowArticles()
    {
      grdArticle.AutoRedraw = false;

      foreach (Article art in BusinessLayer.Instance.Articles)
      {
        AddArticle(art);
      }

      grdArticle.AutoRedraw = true;
      grdArticle.Refresh();
    }

    protected void AddArticle(Article art)
    {
      grdArticle.Rows++;

      grdArticle.Cell(grdArticle.Rows - 1, 1).Text = art.PageNo.ToString();
      grdArticle.Cell(grdArticle.Rows - 1, 2).Text = art.LocalRow.ToString();
      grdArticle.Cell(grdArticle.Rows - 1, 3).Text = art.Title;
      grdArticle.Cell(grdArticle.Rows - 1, 4).Text = art.Scriptures;
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
  }
}