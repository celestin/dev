/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Changed copyright text.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.Windows.Forms;

using FrontBurner.Apps.EmitScore.MultiBrikke.Data;
using FrontBurner.Apps.EmitScore.MultiBrikke.Emit;
using Southesk.Library.Xls;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Report
{
  class EmitReport : XlsReport
  {
    private EmitScoreDataSet _dataSet;

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
      XF fmtHeaderCell = NewXF();
      fmtHeaderCell.Font.Bold = true;

      XF fmtText = NewXF();

      XF fmtTimestamp = NewXF();
      fmtTimestamp.Format = "hh:mm:ss";

      XF fmtData = NewXF();
      fmtData.Format = "#,##0";

      foreach (EmitScoreDataSet.CategoryRow category in _dataSet.Category)
      {
        Worksheet sht = Workbook.Worksheets.AddNamed(category.CategoryName);

        sht.Cells.AddValueCell(1, 1, "Team", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 2, "Total Points", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 3, "Total Time", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 4, "Nett Points", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 5, "Time Disqualified", fmtHeaderCell);

        EmitScoreDataSet.ReportTeamResultRow[] tr = 
          (EmitScoreDataSet.ReportTeamResultRow[])
          _dataSet.ReportTeamResult.Select(String.Format("CategoryId='{0}'", category.CategoryId));

        for (int r = 0; r < tr.Length; r++)
        {
          sht.Cells.AddValueCell(r + 2, 1, tr[r].TeamName, fmtText);

          if (!tr[r].IsTotalPointsNull())
          {
            sht.Cells.AddValueCell(r + 2, 2, tr[r].TotalPoints, fmtData);
          }
          if (!tr[r].IsTotalTimeSecondsNull())
          {
            DateTime totalTime = Swipe.CreateBaseDate();
            totalTime = totalTime.AddSeconds(tr[r].TotalTimeSeconds);
            sht.Cells.AddValueCell(r + 2, 3, totalTime.ToString("HH:mm:ss"), fmtTimestamp);
          }
          if (!tr[r].IsNettPointsNull())
          {
            sht.Cells.AddValueCell(r + 2, 4, tr[r].NettPoints, fmtData);
          }
          if (!tr[r].IsTimeDisqualifiedNull())
          {
            if (tr[r].TimeDisqualified == 1)
            {
              sht.Cells.AddValueCell(r + 2, 5, "Yes", fmtText);
            }            
          }
        }
      }

      foreach (EmitScoreDataSet.CategoryRow category in _dataSet.Category)
      {
        Worksheet sht = Workbook.Worksheets.AddNamed(String.Format("{0} Detail", category.CategoryName));

        sht.Cells.AddValueCell(1, 1, "Team", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 2, "Group", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 3, "Group Id", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 4, "Location Id", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 5, "Points", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 6, "Time", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 7, "Cum.Time", fmtHeaderCell);
        sht.Cells.AddValueCell(1, 8, "Sequence", fmtHeaderCell);

        EmitScoreDataSet.ReportGroupResultRow[] tr =
          (EmitScoreDataSet.ReportGroupResultRow[])
          _dataSet.ReportGroupResult.Select(String.Format("CategoryId='{0}'", category.CategoryId));

        for (int r = 0; r < tr.Length; r++)
        {
          if (!tr[r].IsTeamNameNull())
          {
            sht.Cells.AddValueCell(r + 2, 1, tr[r].TeamName, fmtText);
          }

          sht.Cells.AddValueCell(r + 2, 2, tr[r].GroupName, fmtText);
          sht.Cells.AddValueCell(r + 2, 3, tr[r].GroupId, fmtText);
          sht.Cells.AddValueCell(r + 2, 4, tr[r].LocationId, fmtText);

          if (!tr[r].IsPointsNull())
          {
            sht.Cells.AddValueCell(r + 2, 5, tr[r].Points, fmtData);
          }
          if (!tr[r].IsTimeNull())
          {
            sht.Cells.AddValueCell(r + 2, 6, tr[r].Time.ToString("HH:mm:ss"), fmtTimestamp);
          }
          if (!tr[r].IsCumTimeNull())
          {
            sht.Cells.AddValueCell(r + 2, 7, tr[r].CumTime.ToString("HH:mm:ss"), fmtTimestamp);
          }

          sht.Cells.AddValueCell(r + 2, 8, tr[r].ResultId, fmtData);
        }
      }
    }
  }
}
