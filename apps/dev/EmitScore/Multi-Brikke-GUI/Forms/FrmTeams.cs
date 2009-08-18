/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Added datatable for Courses.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Forms
{
  public partial class FrmTeams : Form
  {
    public FrmTeams()
    {
      InitializeComponent();
    }

    private void FrmTeams_Load(object sender, EventArgs e)
    {
      courseTableAdapter.Fill(_dataSet.Course);
      categoryTableAdapter.Fill(_dataSet.Category);
      teamTableAdapter.Fill(_dataSet.Team);

      _dataSet.Team.DefaultView.Sort = "CategoryId, TeamName";
      _bdsTeam.DataSource = _dataSet.Team;
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmTeams_FormClosing(object sender, FormClosingEventArgs e)
    {
      teamTableAdapter.Update(_dataSet.Team);
    }
  }
}
