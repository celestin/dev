/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  13-Mar-2010  10597 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;

namespace SourceCodeMetrics.Krakatau.Kepm.Win32
{
  public enum PopupTip
  {
    NeverShow,
    ResultsBrowserAfterParse,
    FilterResultsBrowserUsingMetricSet
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
