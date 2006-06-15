/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * KEPM Visual ListViewItem component
 *
 * $Id: MetricSetItem.cs 147 2006-06-06 23:06:48Z craig $
 * 
 * Who  When       Why
 * CAM  15-Jun-06   258 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace KrakatauEPM
{
  /// <summary>
  /// UI Project Item.
  /// </summary>
  public class MetricSetItem : System.Windows.Forms.ListViewItem
  {
    private MetricSet _mset = null;

    public MetricSetItem(): base()
    {
      _mset = new MetricSet("New");
      this.ImageIndex = 0;
    }
    public MetricSetItem(MetricSet mset): base(mset.Name)
    {
      _mset = mset;
      this.ImageIndex = 0;
    }

    public void RefreshSet() 
    {
      base.Text = _mset.Name;
    }

    public MetricSet MetricSet 
    {
      get 
      {
        return this._mset;
      }
      set 
      {
        this._mset = value;
      }
    }
  }
}
