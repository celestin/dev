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

namespace FrontBurner.Ministry.MseBuilder
{
  public partial class MseBuilder : Form
  {
    public MseBuilder()
    {
      InitializeComponent();
      DatabaseLayer.Instance.Open();
    }

    private void btnBuild_Click(object sender, EventArgs e)
    {
      btnBuild.Enabled = false;
      grdArticle.Rows = 1;

      Thread process = new Thread(new ThreadStart(Build));
      process.Start();

      process.Join();
      btnBuild.Enabled = true;
    }

    private void Build()
    {
      MseEngine engine = new MseEngine();

      if ((cmbAuthor.Text.Length > 0) && (txtVol.Text.Length > 0))
      {
        //try
        //{
        engine.Build(cmbAuthor.SelectedValue.ToString(), Int32.Parse(txtVol.Text), this);
        //}
        //catch (Exception ex)
        //{
        //MessageBox.Show("That Volume does not exist for Author \n\n" + cmbAuthor.Text + ex.ToString());          
        //}
      }
      else
      {
        engine.Build();
      }

    }

    private void MseBuilder_Load(object sender, EventArgs e)
    {
      DataSet ds = DatabaseLayer.Instance.GetAuthors();
      cmbAuthor.DataSource = ds;
      cmbAuthor.DisplayMember = "Author.name";
      cmbAuthor.ValueMember = "Author.author";

      // Article Grid
      grdArticle.Cols = 4;
      grdArticle.ExtendLastCol = true;
      grdArticle.Column(0).Visible = false;
      grdArticle.Rows = 1;

      grdArticle.Cell(0, 1).Text = "Page No";
      grdArticle.Cell(0, 2).Text = "Row";
      grdArticle.Cell(0, 3).Text = "Article";

      grdArticle.Column(1).Width = 65;
      grdArticle.Column(2).Width = 40;
      grdArticle.Column(3).Width = 100;
    }

    public void AddArticle(int pageNo, int row, string article)
    {
      grdArticle.Rows++;

      grdArticle.Cell(grdArticle.Rows - 1, 1).Text = pageNo.ToString();
      grdArticle.Cell(grdArticle.Rows - 1, 2).Text = row.ToString();
      grdArticle.Cell(grdArticle.Rows - 1, 3).Text = article;
    }
  }
}