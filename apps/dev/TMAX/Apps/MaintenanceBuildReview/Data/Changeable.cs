/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Dec-2012  11149 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data
{
  public class Changeable
  {
    private string _currentValue;
    private string _newValue;

    public string CurrentValue
    {
      get { return _currentValue; }
      set { _currentValue = value; }
    }

    public string NewValue
    {
      get { return _newValue; }
      set { _newValue = value; }
    }

    public Changeable(string currentValue, string newValue)
    {
      CurrentValue = currentValue;
      NewValue = newValue;
    }

    public bool HasChanged()
    {
      return (!CurrentValue.Equals(NewValue));
    }
  }
}
