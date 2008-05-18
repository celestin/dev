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
 * CAM  11-May-2008  10265 : Allow Zipping of single Volume.
 * CAM  17-May-2008  10266 : Show Errors on completion of Build.
 * CAM  18-May-2008  10267 : Moved buttons to new toolbar, created CopyToMySQL.
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

    private bool SpecificVolume()
    {
      if (_specificVolume = ((txtVol.Text.Length > 0) && (int.Parse(txtVol.Text) > 0)))
      {
        _author = cmbAuthor.SelectedValue.ToString();
        _vol = int.Parse(txtVol.Text);
      }

      return _specificVolume;
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

          if (_builder.AnyErrors)
          {
            BuildErrors formErrors = new BuildErrors();
            formErrors.ShowDialog();
          }

          _builder = null;

          _tspMain.Enabled = true;
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

          _tspMain.Enabled = true;
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

      row.Cells[0].Value = art.PageNo;
      row.Cells[1].Value = art.LocalRow;
      row.Cells[2].Value = art.Title;
      row.Cells[3].Value = art.Scriptures;
    }

    private void _tsbBuild_Click(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      grdArticle.Rows.Clear();

      ClearArticles();

      SpecificVolume();

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.GetVolumes().Count;

      _builder = new BuilderThread(_author, _vol, _specificVolume);
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void _tsbZip_Click(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.GetVolumes().Count;

      SpecificVolume();

      _zipper = new ZipperThread(_author, _vol, _specificVolume);
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void _tsbVersionHistory_Click(object sender, EventArgs e)
    {
      mpowerCompletedJobsTableAdapter.CopyToMySQL();
    }
  }
}