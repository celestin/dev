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

using Southesk.Library.Xls;

namespace Southesk.Apps.EmitScore.Report
{
  class EmitReport : XlsReport
  {
    public EmitReport()
    {
      SetDocumentProperties();

      FileName = String.Format("{0:yyyy-MM-dd_HH-mm-ss}_SystemExport.xls", ReportCreated);

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

      XF fmtTimestamp = NewXF();
      fmtTimestamp.Format = "dd-mmm-yyyy hh:mm:ss";

      XF fmtData = NewXF();
      fmtData.Format = "#,##0.000";

      DataSet set = new DataSet();
      foreach (DataTable table in set.Tables)
      {
        Worksheet sht = Workbook.Worksheets.AddNamed(table.TableName.Substring(4));

        for (int i = 0; i < table.Columns.Count; i++)
        {
          sht.Cells.AddValueCell(1, i + 1, table.Columns[i].ColumnName, fmtHeaderCell);
        }

        for (int r = 0; r < Math.Min(table.Rows.Count, MaxRowsPerSheet); r++)
        {
          for (int c = 0; c < table.Columns.Count; c++)
          {
            DataColumn col = table.Columns[c];

            Type type = col.DataType;

            if (table.Rows[r][c] == DBNull.Value)
            {
              // Don't add null values
            }
            else if (type.Equals(Single.MaxValue.GetType()) ||
              type.Equals(Double.MaxValue.GetType()))
            {
              double dValue = Convert.ToDouble(table.Rows[r][c].ToString());
              sht.Cells.AddValueCell(r + 2, c + 1, dValue, fmtData);
            }
            else if (type.Equals(Int16.MaxValue.GetType()) ||
              type.Equals(Int32.MaxValue.GetType()) ||
              type.Equals(Byte.MaxValue.GetType()))
            {
              int iValue = Convert.ToInt32(table.Rows[r][c].ToString());
              sht.Cells.AddValueCell(r + 2, c + 1, iValue);
            }
            else if (type.Equals(DateTime.MaxValue.GetType()))
            {
              sht.Cells.AddValueCell(r + 2, c + 1, table.Rows[r][c], fmtTimestamp);
            }
            else
            {
              // Strings & Guids
              sht.Cells.AddValueCell(r + 2, c + 1, table.Rows[r][c].ToString());
            }
          }
        }

        if (table.Rows.Count > MaxRowsPerSheet)
        {
          ReportComments += String.Format("{0} {1}\n",
            table.TableName, table.Rows.Count);
        }
      }
    }
  }
}
