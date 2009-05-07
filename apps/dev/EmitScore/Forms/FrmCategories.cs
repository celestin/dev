/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  07-May-2009  10444 : Changed to Front Burner.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace FrontBurner.Apps.EmitScore.Forms
{
  public partial class FrmCategories : Form
  {
    public FrmCategories()
    {
      InitializeComponent();
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmCategories_Load(object sender, EventArgs e)
    {
      this.categoryTableAdapter.Fill(emitScoreDataSet.Category);
    }

    private void FrmCategories_FormClosing(object sender, FormClosingEventArgs e)
    {
      categoryTableAdapter.Update(emitScoreDataSet.Category);
    }
  }
}
