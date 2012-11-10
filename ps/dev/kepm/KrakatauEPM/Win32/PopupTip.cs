/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Mar-2010  10597 : File created.
 * CAM  16-Mar-2010  10597 : Added PopupTips with GetMessage.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;

namespace PowerSoftware.Krakatau.Kepm.Win32
{
  public enum PopupTip
  {
    NeverShow,
    ResultsBrowserAfterParse,
    FilterResultsBrowserUsingMetricSet
  }

  public static class PopupTips
  {
    public static string GetMessage(PopupTip tip)
    {
      switch (tip)
      {
        case PopupTip.FilterResultsBrowserUsingMetricSet:
          return "Now that you have some results, did you know that you can " +
            "restrict the results you see to specific metrics using a Metric Set? " +
            "Create a Metric Set, and select it from the dropdown list on the toolbar, " +
            "then refresh your results again.";
        case PopupTip.ResultsBrowserAfterParse:
          return "Now that you have parsed your project, did you know that you can " +
            "view the results in the main Krakatau EPM window by right-clicking on your "+
            "project and selecting Results Browser (or by pushing F5 on the keyboard). " +
            "You can sort the results by clicking on the column headings.";
      }

      return "Never show Popup Tips";
    }
  }

  public class PopupTipList : Dictionary<PopupTip, bool>
  {
    public PopupTipList()
      : base()
    {
    }

    public void IgnorePopupTip(PopupTip tip)
    {
      IgnorePopupTip(tip, true);
    }

    public void IgnorePopupTip(PopupTip tip, bool ignore)
    {
      if (ignore && !ContainsKey(tip))
      {
        Add(tip, true);
      }
      else if (!ignore && ContainsKey(tip))
      {
        Remove(tip);
      }
    }

    public bool IsIgnorePopupTip(PopupTip tip)
    {
      return (ContainsKey(tip) || ContainsKey(PopupTip.NeverShow));
    }
  }

}
