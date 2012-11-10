/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Jun-06    258 : File created.
 * CAM  19-Feb-2010  10558 : Tidy.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace PowerSoftware.Krakatau.Kepm.Config
{
  /// <summary>
  /// KEPM Visual ListViewItem component.
  /// </summary>
  public class MetricSetItem : ListViewItem
  {
    private MetricSet _mset = null;

    public new string Text
    {
      get { return _mset.Name; }
      set { base.Text = _mset.Name = value; }
    }

    public MetricSet MetricSet
    {
      get { return _mset; }
      set { _mset = value; }
    }

    public MetricSetItem()
      : this(new MetricSet(KrakatauSettings.Settings.NewMetricSetName()))
    {
    }

    public MetricSetItem(MetricSet mset)
      : base(mset.Name)
    {
      _mset = mset;
      ImageIndex = 0;
    }
  }
}
