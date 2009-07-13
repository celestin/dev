/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id: FrmCategories.cs 872 2008-08-11 23:42:36Z craig $
 *
 * Who  When         Why
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace Southesk.Apps.EmitScore.Forms
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
