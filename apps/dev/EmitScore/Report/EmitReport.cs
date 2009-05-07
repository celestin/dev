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
using FrontBurner.Apps.EmitScore.Emit;
using Southesk.Library.Xls;

namespace FrontBurner.Apps.EmitScore.Report
{
  class EmitReport : XlsReport
  {
    private EmitScoreDataSet _dataSet;
    XF _fmtHeaderCell;
    XF _fmtText;
    XF _fmtTimestamp;
    XF _fmtData;

    public EmitReport(EmitScoreDataSet dataSet)
    {
      _dataSet = dataSet;

      SetDocumentProperties();

      FileName = String.Format("{0:yyyy-MM-dd_HH-mm-ss}_EmitScore.xls", ReportCreated);

      Create();
    }

    public override void SetDocumentProperties()
    {
      base.SetDocumentProperties();

      ReportTitle = "EmitScore Results";
      ReportSubject = "Full Details";
    }

    protected override void Create()
    {
      _fmtHeaderCell = NewXF();
      _fmtHeaderCell.Font.Bold = true;

      _fmtText = NewXF();

      _fmtTimestamp = NewXF();
      _fmtTimestamp.Format = "hh:mm:ss";

      _fmtData = NewXF();
      _fmtData.Format = "#,##0";

      SummaryTab();
      GroupTabs();
      GroupResultTabs();
    }

    protected void SummaryTab()
    {
      EmitScoreDataSet.LocationRow[] lr =
        (EmitScoreDataSet.LocationRow[])_dataSet.Location.Select();
      int lastLocCol = lr.Length + 3;

      Worksheet sht = Workbook.Worksheets.AddNamed("Summary");

      sht.Cells.AddValueCell(2, 1, "Group No", _fmtHeaderCell);
      sht.Cells.AddValueCell(2, 2, "Group Name", _fmtHeaderCell);
      sht.Cells.AddValueCell(2, 3, "Category", _fmtHeaderCell);

      for (int c = 0; c < lr.Length; c++)
      {
        sht.Cells.AddValueCell(1, c+4, lr[c].LocationId, _fmtHeaderCell);
        if (!lr[c].IsLocationNameNull())
        {
          // Output the name if there is one
          sht.Cells.AddValueCell(2, c + 4, lr[c].LocationName, _fmtHeaderCell);
        }
        else
        {
          // Or simply the index otherwise
          sht.Cells.AddValueCell(2, c + 4, c + 1, _fmtHeaderCell);
        }
      }

      sht.Cells.AddValueCell(2, lastLocCol + 1, "Total Points", _fmtHeaderCell);
      sht.Cells.AddValueCell(2, lastLocCol + 2, "Nett Points", _fmtHeaderCell);
      sht.Cells.AddValueCell(2, lastLocCol + 3, "Total Time", _fmtHeaderCell);
      sht.Cells.AddValueCell(2, lastLocCol + 4, "Time Disqualified", _fmtHeaderCell);

      for (int r = 0; r < _dataSet.ReportGroup.Rows.Count; r++)
      {
        EmitScoreDataSet.ReportGroupRow g = _dataSet.ReportGroup[r];
        EmitScoreDataSet.CategoryRow category = _dataSet.Category.FindByCategoryId(g.CategoryId);

        sht.Cells.AddValueCell(r + 3, 1, g.GroupId, _fmtText);
        sht.Cells.AddValueCell(r + 3, 2, g.GroupName, _fmtText);
        sht.Cells.AddValueCell(r + 3, 3, category.CategoryName, _fmtText);

        EmitScoreDataSet.ReportGroupResultRow[] gr =
          (EmitScoreDataSet.ReportGroupResultRow[])
          _dataSet.ReportGroupResult.Select(String.Format("GroupId='{0}'", g.GroupId));

        // Now export the points for each Location
        for (int c = 0; c < lr.Length; c++)
        {
          for (int p = 0; p < gr.Length; p++)
          {
            if (gr[p].LocationId == lr[c].LocationId)
            {
              // Found the Location
              sht.Cells.AddValueCell(r+3, c + 4, gr[p].Points, _fmtData);
            }
          }
        }

        if (!g.IsTotalPointsNull())
        {
          sht.Cells.AddValueCell(r + 3, lastLocCol + 1, g.TotalPoints, _fmtData);
        }
        if (!g.IsNettPointsNull())
        {
          sht.Cells.AddValueCell(r + 3, lastLocCol + 2, g.NettPoints, _fmtData);
        }
        if (!g.IsTotalTimeSecondsNull())
        {
          DateTime totalTime = Swipe.CreateBaseDate();
          totalTime = totalTime.AddSeconds(g.TotalTimeSeconds);
          sht.Cells.AddValueCell(r + 3, lastLocCol + 3, totalTime.ToString("HH:mm:ss"), _fmtTimestamp);
        }
        if (!g.IsTimeDisqualifiedNull())
        {
          if (g.TimeDisqualified == 1)
          {
            sht.Cells.AddValueCell(r + 3, lastLocCol + 4, "Yes", _fmtText);
          }
        }
      }
    }

    protected void GroupTabs()
    {
      foreach (EmitScoreDataSet.CategoryRow category in _dataSet.Category)
      {
        Worksheet sht = Workbook.Worksheets.AddNamed(ValidSheetName(category.CategoryCode));

        sht.Cells.AddValueCell(1, 1, "Group Name", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 2, "Total Points", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 3, "Total Time", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 4, "Nett Points", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 5, "Time Disqualified", _fmtHeaderCell);

        EmitScoreDataSet.ReportGroupRow[] tr =
          (EmitScoreDataSet.ReportGroupRow[])
          _dataSet.ReportGroup.Select(String.Format("CategoryId='{0}'", category.CategoryId));

        for (int r = 0; r < tr.Length; r++)
        {
          sht.Cells.AddValueCell(r + 2, 1, tr[r].GroupName, _fmtText);

          if (!tr[r].IsTotalPointsNull())
          {
            sht.Cells.AddValueCell(r + 2, 2, tr[r].TotalPoints, _fmtData);
          }
          if (!tr[r].IsTotalTimeSecondsNull())
          {
            DateTime totalTime = Swipe.CreateBaseDate();
            totalTime = totalTime.AddSeconds(tr[r].TotalTimeSeconds);
            sht.Cells.AddValueCell(r + 2, 3, totalTime.ToString("HH:mm:ss"), _fmtTimestamp);
          }
          if (!tr[r].IsNettPointsNull())
          {
            sht.Cells.AddValueCell(r + 2, 4, tr[r].NettPoints, _fmtData);
          }
          if (!tr[r].IsTimeDisqualifiedNull())
          {
            if (tr[r].TimeDisqualified == 1)
            {
              sht.Cells.AddValueCell(r + 2, 5, "Yes", _fmtText);
            }
          }
        }
      }
    }

    protected void GroupResultTabs()
    {
      foreach (EmitScoreDataSet.CategoryRow category in _dataSet.Category)
      {
        Worksheet sht = Workbook.Worksheets.AddNamed(String.Format("{0}+", ValidSheetName(category.CategoryCode)));

        sht.Cells.AddValueCell(1, 1, "Group", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 2, "Group Id", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 3, "Location Id", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 4, "Points", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 5, "Time", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 6, "Cum.Time", _fmtHeaderCell);
        sht.Cells.AddValueCell(1, 7, "Sequence", _fmtHeaderCell);

        EmitScoreDataSet.ReportGroupResultRow[] tr =
          (EmitScoreDataSet.ReportGroupResultRow[])
          _dataSet.ReportGroupResult.Select(String.Format("CategoryId='{0}'", category.CategoryId));

        for (int r = 0; r < tr.Length; r++)
        {
          sht.Cells.AddValueCell(r + 2, 1, tr[r].GroupName, _fmtText);
          sht.Cells.AddValueCell(r + 2, 2, tr[r].GroupId, _fmtText);
          sht.Cells.AddValueCell(r + 2, 3, tr[r].LocationId, _fmtText);

          if (!tr[r].IsPointsNull())
          {
            sht.Cells.AddValueCell(r + 2, 4, tr[r].Points, _fmtData);
          }
          if (!tr[r].IsTimeNull())
          {
            sht.Cells.AddValueCell(r + 2, 5, tr[r].Time.ToString("HH:mm:ss"), _fmtTimestamp);
          }
          if (!tr[r].IsCumTimeNull())
          {
            sht.Cells.AddValueCell(r + 2, 6, tr[r].CumTime.ToString("HH:mm:ss"), _fmtTimestamp);
          }

          sht.Cells.AddValueCell(r + 2, 7, tr[r].ResultId, _fmtData);
        }
      }
    }

    protected string ValidSheetName(string sheetName)
    {
      return sheetName.Replace("/", "_");
    }
  }
}
