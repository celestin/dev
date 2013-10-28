/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Dec-2012  11149 : Created.
 * CAM  28-Oct-2013  11172 : Added Site Code.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data
{
  public class Config
  {
    #region Singleton Members
    private static Config _config;
    public static Config Instance
    {
      get
      {
        if (_config == null) _config = new Config();
        return _config;
      }
    }
    #endregion

    #region Config Members
    private bool _reviewDataActive;
    private string _rootCode;
    private string _rootDescription;
    private string _siteCode;

    public bool ReviewDataActive
    {
      get { return _reviewDataActive; }
      set { _reviewDataActive = value; }
    }

    public string RootCode
    {
      get { return _rootCode; }
      set { _rootCode = value; }
    }

    public string RootDescription
    {
      get { return _rootDescription; }
      set { _rootDescription = value; }
    }

    public string SiteCode
    {
      get { return _siteCode; }
      set { _siteCode = value; }
    }

    private Config()
    {
    }
    #endregion
  }
}
