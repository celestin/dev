/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  24-Feb-2010  10558 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;

namespace PowerSoftware.Krakatau.Kepm.Metrics
{
  public class Metric : IEquatable<Metric>
  {
    private long _id;
    private MetricType _type;
    private MetricLevel _level;
    private string _code;
    private string _description;

    public long Id
    {
      get { return _id; }
      set { _id = value; }
    }
    public MetricType Type
    {
      get { return _type; }
      set { _type = value; }
    }
    public MetricLevel Level
    {
      get { return _level; }
      set { _level = value; }
    }
    public string Code
    {
      get { return _code; }
      set { _code = value; }
    }
    public string Description
    {
      get { return _description; }
      set { _description = value; }
    }

    public Metric(long id, MetricType type, string code)
      : this(id, type, code, MetricLevel.File)
    {
    }

    public Metric(long id, MetricType type, string code, MetricLevel level)
    {
      Id = id;
      Type = type;
      Code = code;
      Level = level;
    }

    public bool Equals(Metric other)
    {
      return (Id.Equals(other.Id));
    }
  }

  public class MetricCollection : KeyedCollection<long, Metric>
  {
    public MetricCollection()
      : base()
    {
    }

    protected override long GetKeyForItem(Metric item)
    {
      return item.Id;
    }
  }
}
