/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Feb-2010  10583 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;

namespace PowerSoftware.Krakatau.Kepm.Results
{
  public enum ChurnStatus
  {
    Added,
    Deleted,
    Changed,
    Unchanged
  }

  public static class ChurnStatuses
  {
    public static readonly Color Added = Color.FromArgb(51, 204, 51);
    public static readonly Color Deleted = Color.FromArgb(51, 51, 221);
    public static readonly Color Changed = Color.FromArgb(255, 102, 102);

    public static ChurnStatus GetStatus(string code)
    {
      code = code.Trim().Substring(0,1).ToUpper();
      if (code.Equals("A")) return ChurnStatus.Added;
      else if (code.Equals("D")) return ChurnStatus.Deleted;
      else if (code.Equals("C")) return ChurnStatus.Changed;
      
      return ChurnStatus.Unchanged;      
    }

    public static ChurnStatus GetStatus(object code)
    {
      return GetStatus(code.ToString());
    }

    public static string GetShortCode(ChurnStatus status)
    {
      switch (status)
      {
        case ChurnStatus.Added: return "Add";
        case ChurnStatus.Deleted: return "Del";
        case ChurnStatus.Changed: return "Ch";
      }

      return "Un";
    }

    public static string GetShortCode(string code)
    {
      return GetShortCode(GetStatus(code));
    }

    public static string GetToolTipText(ChurnStatus status)
    {
      if (status == ChurnStatus.Unchanged)
      {
        return "This file has not changed.";
      }
      return String.Format("This file has been {0}", status.ToString());
    }
  }
}
