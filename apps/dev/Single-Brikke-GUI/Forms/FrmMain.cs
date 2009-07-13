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
using FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters;
using FrontBurner.Apps.EmitScore.Emit;
using FrontBurner.Apps.EmitScore.Report;

namespace FrontBurner.Apps.EmitScore.Forms
{
  public partial class FrmMain : Form
  {
    private LocationMap _locationMap;
    private object _semaphore = new object();
    private bool _processing;

    public FrmMain()
    {
      InitializeComponent();
      _processing = false;
    }

    private void EmitReader_GetNextBadge(object sender, AxEmitEpt.__EptReading_GetNextBadgeEvent e)
    {
      if (_processing) return;      

      lock (_semaphore)
      {
        _processing = true;
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
        _processing = false;
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
        _sslRegister.Text = String.Format("Data received at {0}", DateTime.Now);

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

          foreach (Swipe swipe in badge.SwipeList)
          {
            EmitScoreDataSet.GroupResultRow resultRow = resultTable.NewGroupResultRow();
            resultRow.GroupId = badge.BadgeNo;
            resultRow.LocationId = swipe.Location.Id;

            resultRow.Points = swipe.Points;
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

          MessageBox.Show(String.Format("Group {0} - {1} results received.",
            groupRow.GroupId, groupRow.GroupName), "Results Received",
            MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
      }
    }

    private void FrmMain_Load(object sender, EventArgs e)
    {
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
      ReportGroupTableAdapter reportGroupTableAdapter = new ReportGroupTableAdapter();
      ReportGroupResultTableAdapter reportGroupResultTableAdapter = new ReportGroupResultTableAdapter();

      reportGroupTableAdapter.Fill(_dataSet.ReportGroup);
      reportGroupResultTableAdapter.Fill(_dataSet.ReportGroupResult);
      categoryTableAdapter.Fill(_dataSet.Category);
      locationTableAdapter.Fill(_dataSet.Location);

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

        ReportGroupTableAdapter.Fill(_dataSet.ReportGroup);
        _dgvResults.Refresh();
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

    private void btnTest_Click(object sender, EventArgs e)
    {
      //SwipeList list = new SwipeList();
      //DateTime time = Swipe.CreateBaseDate();
      //time = time.AddHours(5);
      //time = time.AddMinutes(31);
      //list.TotalPoints = 1000;
      //list.TotalTime = time;
      //list.AdjustPoints();
      //MessageBox.Show(String.Format("{0:HH:mm} {1}", time, list.NettPoints));

      FrmNewGroup newGroup = new FrmNewGroup(484356);
      newGroup.ShowDialog();
    }

    private void _dgvResults_DataError(object sender, DataGridViewDataErrorEventArgs e)
    {

    }
  }
}
