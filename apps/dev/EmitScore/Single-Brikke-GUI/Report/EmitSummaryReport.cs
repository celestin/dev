/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-May-2012  11095 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.Windows.Forms;

using FrontBurner.Apps.EmitScore.Data;
using FrontBurner.Apps.EmitScore.Emit;
using Southesk.Library.Xls;

namespace FrontBurner.Apps.EmitScore.Report
{
  class EmitSummaryReport : XlsReport
  {
    private EmitScoreDataSet _dataSet;
    XF _fmtHeaderCell;
    XF _fmtText;
    XF _fmtTimestamp;
    XF _fmtData;

    public EmitSummaryReport(EmitScoreDataSet dataSet)
    {
      _dataSet = dataSet;

      SetDocumentProperties();

      FileName = String.Format("{0:yyyy-MM-dd_HH-mm-ss}_EmitSummary.xls", ReportCreated);

      Create();
    }

    public override void SetDocumentProperties()
    {
      base.SetDocumentProperties();

      ReportTitle = "EmitScore Summary";
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
    }

    protected void SummaryTab()
    {


      Worksheet sht = Workbook.Worksheets.AddNamed("Summary");

      sht.Cells.AddValueCell(1, 1, "Group No", _fmtHeaderCell);
      sht.Cells.AddValueCell(1, 2, "Group Name", _fmtHeaderCell);
      sht.Cells.AddValueCell(1, 3, "Category", _fmtHeaderCell);

      sht.Cells.AddValueCell(1, 4, "Total Points", _fmtHeaderCell);
      sht.Cells.AddValueCell(1, 5, "Total Time", _fmtHeaderCell);
      sht.Cells.AddValueCell(1, 6, "Time Disqualified", _fmtHeaderCell);
      sht.Cells.AddValueCell(1, 7, "Nett Points", _fmtHeaderCell);

      for (int r = 0; r < _dataSet.ReportGroup.Rows.Count; r++)
      {
        EmitScoreDataSet.ReportGroupRow g = _dataSet.ReportGroup[r];
        EmitScoreDataSet.CategoryRow category = _dataSet.Category.FindByCategoryId(g.CategoryId);

        sht.Cells.AddValueCell(r + 2, 1, g.GroupId, _fmtText);
        sht.Cells.AddValueCell(r + 2, 2, g.GroupName, _fmtText);
        sht.Cells.AddValueCell(r + 2, 3, category.CategoryName, _fmtText);

        EmitScoreDataSet.ReportGroupResultRow[] gr =
          (EmitScoreDataSet.ReportGroupResultRow[])
          _dataSet.ReportGroupResult.Select(String.Format("GroupId='{0}'", g.GroupId));

        if (!g.IsTotalPointsNull()) sht.Cells.AddValueCell(r + 2, 4, g.TotalPoints, _fmtData);

        if (!g.IsTotalTimeSecondsNull())
        {
          DateTime totalTime = Swipe.CreateBaseDate();
          totalTime = totalTime.AddSeconds(g.TotalTimeSeconds);
          sht.Cells.AddValueCell(r + 2, 5, totalTime.ToString("HH:mm:ss"), _fmtTimestamp);
        }
        if (!g.IsTimeDisqualifiedNull())
        {
          if (g.TimeDisqualified == 1)
          {
            sht.Cells.AddValueCell(r + 2, 6, "Yes", _fmtText);
          }
        }
        if (!g.IsNettPointsNull()) sht.Cells.AddValueCell(r + 2, 7, g.NettPoints, _fmtData);
      }
    }

    protected string ValidSheetName(string sheetName)
    {
      return sheetName.Replace("/", "_");
    }
  }
}
