/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  13-Jun-06   258 : File created.
 * CAM  19-Feb-2010  10558 : Removed Hashtable and extended KeyedCollection.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System.Collections.ObjectModel;

using SourceCodeMetrics.Krakatau.Kepm.Metrics;

namespace SourceCodeMetrics.Krakatau.Kepm.Config
{
  /// <summary>
  /// Collection of Metric Definitions.
  /// </summary>
  public class MetricSet : KeyedCollection<long, MetricDef>
  {
    private string _name;

    public string Name
    {
      get { return _name; }
      set { _name = value; }
    }

    public MetricSet(string name)
    {
      _name = name;
    }

    public MetricDef Get(Metric metric)
    {
      foreach (MetricDef def in this)
      {
        if (def.Metric.Equals(metric)) return def;
      }
      return null;
    }

    public bool Contains(Metric metric)
    {
      foreach (MetricDef def in this)
      {
        if (def.Metric.Equals(metric)) return true;
      }
      return false;
    }

    protected override long GetKeyForItem(MetricDef item)
    {
      return item.Id;
    }

    public override string ToString()
    {
      return _name;
    }
  }
}
