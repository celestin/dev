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
using Southesk.Library.Xls;

namespace Southesk.Apps.EmitScore.Report
{
  /// <summary>
  /// Base class for all JCAMS Excel reports.
  /// </summary>
  public abstract class XlsReport : XlsDocument
  {
    /// <summary>
    /// Maximum number of Rows per Worksheet.
    /// <remarks>It's actually 65504 for this library, not the usual 65536,
    /// and we have taken the precaution of rounding down to 65500.</remarks>
    /// </summary>
    public static int MaxRowsPerSheet = 65500;

    public string ReportTitle
    {
      get { return SummaryInformation.Title; }
      set { SummaryInformation.Title = value; }
    }
    public string ReportSubject
    {
      get { return SummaryInformation.Subject; }
      set { SummaryInformation.Subject = value; }
    }
    public string ReportAuthor
    {
      get { return SummaryInformation.Author; }
      set { SummaryInformation.Author = value; }
    }
    public string ReportCreator
    {
      get { return SummaryInformation.NameOfCreatingApplication; }
      set { SummaryInformation.NameOfCreatingApplication = value; }
    }
    public string ReportKeywords
    {
      get { return SummaryInformation.Keywords; }
      set { SummaryInformation.Keywords = value; }
    }
    public string ReportComments
    {
      get { return SummaryInformation.Comments; }
      set { SummaryInformation.Comments = value; }
    }
    public DateTime ReportCreated
    {
      get { return SummaryInformation.CreateTimeDate.Value; }
      set { SummaryInformation.CreateTimeDate = value; }
    }
    public DateTime ReportModified
    {
      get { return SummaryInformation.LastSavedTimeDate.Value; }
      set { SummaryInformation.LastSavedTimeDate = value; }
    }

    public XlsReport()
      : base()
    {
    }

    /// <summary>
    /// Set the Properties of the PDF document.
    /// </summary>
    public virtual void SetDocumentProperties()
    {
      ReportAuthor = "Craig McKay";
      ReportCreator = "EmitScore";
      ReportModified = ReportCreated = DateTime.Now;
    }

    protected abstract void Create();
  }
}
