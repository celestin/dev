/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id$
 *
 * Who  When         Why
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.Windows.Forms;

using Southesk.Apps.EmitScore.Data;
using Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters;
using Southesk.Apps.EmitScore.Emit;
using Southesk.Apps.EmitScore.Report;

namespace Southesk.Apps.EmitScore.Forms
{
  public partial class FrmMain : Form
  {
    private LocationMap _locationMap;
    private object _semaphore = new object();

    public FrmMain()
    {
      InitializeComponent();
    }

    private void EmitReader_GetNextBadge(object sender, AxEmitEpt.__EptReading_GetNextBadgeEvent e)
    {
      _sslRegister.Text = String.Format("Data received at {0}", DateTime.Now);

      lock (_semaphore)
      {
        try
        {
          ProcessBadgeData(e.badgeData);
        }
        catch (Exception ex)
        {
          MessageBox.Show(String.Format("{0}\n\n{1}",
            ex.Message, ex.StackTrace), "Error processing Badge",
            MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
      }
    }

    protected void ProcessBadgeData(string data)
    {
      BadgeData badge = null;

      try
      {
        badge = new BadgeData(_locationMap, data);
      }
      catch (Exception e)
      {
        MessageBox.Show(String.Format("{0}\n\n{1}",
          e.Message, e.StackTrace), "Error processing Badge",
          MessageBoxButtons.OK, MessageBoxIcon.Error);
      }

      if (badge.IsValidBadge)
      {
        if (RegisterMode)
        {
          try
          {
            EmitScoreDataSet.GroupDataTable groupTable = new EmitScoreDataSet.GroupDataTable();
            EmitScoreDataSet.GroupRow groupRow = groupTable.NewGroupRow();
            groupRow.GroupId = badge.BadgeNo;
            EmitScoreDataSet.CategoryRow defaultCat = (EmitScoreDataSet.CategoryRow)_dataSet.Category.Rows[0];
            groupRow.CategoryId = defaultCat.CategoryId;

            groupTable.AddGroupRow(groupRow);
            groupTableAdapter.Update(groupTable);
          }
          catch (Exception)
          {
          }

          FrmNewGroup newGroup = new FrmNewGroup(badge.BadgeNo);
          newGroup.ShowDialog();
        }
        else
        {
          // Retrieve the Group row
          EmitScoreDataSet.GroupDataTable groupTable = new EmitScoreDataSet.GroupDataTable();
          groupTableAdapter.Fill(groupTable);
          EmitScoreDataSet.GroupRow groupRow = groupTable.FindByGroupId(badge.BadgeNo);

          // Reset Group points to zero (they will be accumulated below)
          badge.SwipeList.TotalPoints = 0;

          // Delete any existing result rows for this badge
          EmitScoreDataSet.GroupResultDataTable resultTable = new EmitScoreDataSet.GroupResultDataTable();
          groupResultTableAdapter.Fill(resultTable);
          foreach (DataRow delRow in resultTable.Select(String.Format("GroupId='{0}'", badge.BadgeNo)))
          {
            delRow.Delete();
          }
          groupResultTableAdapter.Update(resultTable);
          resultTable.Clear();
          groupResultTableAdapter.Fill(resultTable);

          // Get the Team Results - to check if any other teams have visited these points
          EmitScoreDataSet.TeamResultsDataTable teamResTable = new EmitScoreDataSet.TeamResultsDataTable();
          teamResultsTableAdapter.Fill(teamResTable);

          foreach (Swipe swipe in badge.SwipeList)
          {
            bool existingLocation = false;

            if (!groupRow.IsTeamIdNull())
            {
              DataRow[] dr = teamResTable.Select(
                String.Format("TeamId='{0}' AND LocationId='{1}'",
                groupRow.TeamId, swipe.Location.Id));

              existingLocation = (dr.Length > 0);
            }

            EmitScoreDataSet.GroupResultRow resultRow = resultTable.NewGroupResultRow();
            resultRow.GroupId = badge.BadgeNo;
            resultRow.LocationId = swipe.Location.Id;

            if (existingLocation)
            {
              // Someone else in the team has collected this Location's points
              swipe.Points = 0;
            }

            resultRow.Points = swipe.Points;
            badge.SwipeList.TotalPoints += swipe.Points;            
            resultRow.Time = swipe.LocationTime;
            resultRow.CumTime = swipe.CummulativeTime;
            resultRow.EndEdit();
            resultTable.AddGroupResultRow(resultRow);
          }
          groupResultTableAdapter.Update(resultTable);

          badge.SwipeList.AdjustPoints();  // After points deductions, adjust for time

          // Now populate the parent record
          groupRow.BeginEdit();
          groupRow.TotalPoints = badge.SwipeList.TotalPoints;
          groupRow.NettPoints = badge.SwipeList.NettPoints;
          groupRow.TotalTime = badge.SwipeList.TotalTime;
          groupRow.TimeDisqualified = badge.SwipeList.TimeDisqualified;
          groupRow.EndEdit();
          groupTableAdapter.Update(groupRow);
          groupRow.AcceptChanges();

          if (!groupRow.IsTeamIdNull())
          {
            // Check to see if this group, or any others in the team
            // have been time disqualified, and disqualify them all
            groupTable = new EmitScoreDataSet.GroupDataTable();
            groupTableAdapter.Fill(groupTable);
            bool anyDisqualified = false;
            foreach (EmitScoreDataSet.GroupRow gr1 in groupTable)
            {
              if (!gr1.IsTeamIdNull() && (gr1.TeamId == groupRow.TeamId))
              {
                if (!gr1.IsTimeDisqualifiedNull() && (gr1.TimeDisqualified == 1))
                {
                  anyDisqualified = true;
                }
              }
            }
            if (anyDisqualified)
            {
              foreach (EmitScoreDataSet.GroupRow gr1 in groupTable)
              {
                if (!gr1.IsTeamIdNull() && (gr1.TeamId == groupRow.TeamId))
                {
                  gr1.BeginEdit();
                  gr1.NettPoints = 0;
                  gr1.TimeDisqualified = 1;
                  gr1.EndEdit();
                  groupTableAdapter.Update(gr1);
                  gr1.AcceptChanges();
                }
              }
            }
          }
        }
      }
    }

    private void FrmMain_Load(object sender, EventArgs e)
    {
      teamResultsTableAdapter.Fill(_dataSet.TeamResults);
      groupResultTableAdapter.Fill(_dataSet.GroupResult);
      locationTableAdapter.Fill(_dataSet.Location);
      categoryTableAdapter.Fill(_dataSet.Category);
      configTableAdapter.Fill(_dataSet.Config);
      groupTableAdapter.Fill(_dataSet.Group);
      ToggleButtons(false);

      EmitScoreDataSet.LocationDataTable location = _dataSet.Location;
      _locationMap = location.BuildLocationMap();

      EmitScoreDataSet.ConfigDataTable config = _dataSet.Config;
      _emitReader.ComPrt = short.Parse(config.Rows[0][config.ComPortColumn].ToString());
      _emitReader.Unit = short.Parse(config.Rows[0][config.EmitUnitColumn].ToString());
      _emitReader.StartComm();
    }

    protected void ToggleButtons(bool showRegister)
    {
      _btnRace.Enabled = !(_btnRegister.Enabled = showRegister);
    }

    protected bool RegisterMode
    {
      get
      {
        return (!_btnRegister.Enabled);
      }
    }

    protected void ShowConfig()
    {
      FrmConfig config = new FrmConfig();
      config.ShowDialog();
    }

    protected void ShowLocations()
    {
      FrmLocations locations = new FrmLocations();
      locations.ShowDialog();
    }

    protected void ShowCategories()
    {
      FrmCategories cats = new FrmCategories();
      cats.ShowDialog();
    }

    protected void ShowTeams()
    {
      FrmTeams teams = new FrmTeams();
      teams.ShowDialog();
    }

    protected void ShowGroups()
    {
      FrmGroups groups = new FrmGroups();
      groups.ShowDialog();
    }

    protected void ClearResultData()
    {
      if (MessageBox.Show("This will remove all Groups and Race results.\n" +
        "COM Port, Locations and Categories will be left alone.\n\n" +
        "Are you sure you want to delete Groups and Race results?", "New Race",
        MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question) == DialogResult.Yes)
      {
        GroupTableAdapter groupTableAdapter = new GroupTableAdapter();
        groupTableAdapter.Fill(_dataSet.Group);
        groupResultTableAdapter.Fill(_dataSet.GroupResult);

        foreach (DataRow row in _dataSet.Group)
        {
          row.Delete();
        }
        foreach (DataRow row in _dataSet.GroupResult)
        {
          row.Delete();
        }

        groupTableAdapter.Update(_dataSet.Group);
        groupResultTableAdapter.Update(_dataSet.GroupResult);
      }
    }
    protected void ExportReport()
    {
      ReportTeamResultTableAdapter reportTeamResultTableAdapter = new ReportTeamResultTableAdapter();
      ReportGroupResultTableAdapter reportGroupResultTableAdapter = new ReportGroupResultTableAdapter();      

      reportGroupResultTableAdapter.Fill(_dataSet.ReportGroupResult);
      reportTeamResultTableAdapter.Fill(_dataSet.ReportTeamResult);
      categoryTableAdapter.Fill(_dataSet.Category);

      try
      {
        EmitReport report = new EmitReport(_dataSet);
        report.Save(true);
        report.Launch();
      }
      catch (Exception e)
      {
        MessageBox.Show(e.StackTrace.ToString(), e.Message, MessageBoxButtons.OK);
      }
    }

    private void mniExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void tsbGroups_Click(object sender, EventArgs e)
    {
      ShowGroups();
    }

    private void mniGroups_Click(object sender, EventArgs e)
    {
      ShowGroups();
    }

    private void _btnRegister_Click(object sender, EventArgs e)
    {
      ToggleButtons(false);
    }

    private void _btnRace_Click(object sender, EventArgs e)
    {
      ToggleButtons(true);
    }

    private void _tmrStatus_Tick(object sender, EventArgs e)
    {
      lock (_semaphore)
      {
        groupTableAdapter.Fill(_dataSet.Group);
        _sslRegister.Text = String.Format("{0} groups registered.",
          _dataSet.Group.Rows.Count);
      }
    }

    private void mniCategories_Click(object sender, EventArgs e)
    {
      ShowCategories();
    }

    private void tsbCategories_Click(object sender, EventArgs e)
    {
      ShowCategories();
    }

    private void _tsbLocations_Click(object sender, EventArgs e)
    {
      ShowLocations();
    }

    private void mniLocations_Click(object sender, EventArgs e)
    {
      ShowLocations();
    }

    private void mniComPort_Click(object sender, EventArgs e)
    {
      ShowConfig();
    }

    private void mniTeams_Click(object sender, EventArgs e)
    {
      ShowTeams();
    }

    private void _tsbTeams_Click(object sender, EventArgs e)
    {
      ShowTeams();
    }

    private void mniFileNew_Click(object sender, EventArgs e)
    {
      ClearResultData();
    }

    private void mniFileSave_Click(object sender, EventArgs e)
    {
      ExportReport();
    }

    private void _tsbSave_Click(object sender, EventArgs e)
    {
      ExportReport();
    }

    private void mniHelpAbout_Click(object sender, EventArgs e)
    {
      FrmHelpAbout helpAbout = new FrmHelpAbout();
      helpAbout.ShowDialog();
    }

    private void button1_Click(object sender, EventArgs e)
    {
      SwipeList list = new SwipeList();
      DateTime time = Swipe.CreateBaseDate();
      time = time.AddHours(5);
      time = time.AddMinutes(31);
      list.TotalPoints = 1000;
      list.TotalTime = time;
      list.AdjustPoints();
      MessageBox.Show(String.Format("{0:HH:mm} {1}", time, list.NettPoints));
    }
  }
}
