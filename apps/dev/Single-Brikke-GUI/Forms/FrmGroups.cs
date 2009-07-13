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
using System.Data;
using System.Windows.Forms;

using FrontBurner.Apps.EmitScore.Data;

namespace FrontBurner.Apps.EmitScore.Forms
{
  public partial class FrmGroups : Form
  {
    public FrmGroups()
    {
      InitializeComponent();
    }

    private void FrmGroups_Load(object sender, EventArgs e)
    {
      this.categoryTableAdapter.Fill(this._dataSet.Category);
      this.groupTableAdapter.Fill(this._dataSet.Group);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmGroups_FormClosing(object sender, FormClosingEventArgs e)
    {
      groupTableAdapter.Update(_dataSet.Group);
    }
  }
}
