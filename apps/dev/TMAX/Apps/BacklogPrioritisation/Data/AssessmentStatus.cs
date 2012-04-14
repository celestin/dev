﻿/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Backlog Prioritisation
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  01-Apr-2012  11104 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FrontBurner.Tmax.Apps.BacklogPrioritisation.Data
{
  public enum AssessmentStatus
  {
    New,
    Completed,
    Cancelled
  }

  public static class AssessmentStatuses
  {
    public static readonly string NewStatus = "NEW";
    public static readonly string CompletedStatus = "COMP";
    public static readonly string CancelledStatus = "CAN";

    public static AssessmentStatus GetStatus(string text)
    {
      if (text == CompletedStatus) return AssessmentStatus.Completed;
      else if (text == CancelledStatus) return AssessmentStatus.Cancelled;

      return AssessmentStatus.New;
    }
  }
}