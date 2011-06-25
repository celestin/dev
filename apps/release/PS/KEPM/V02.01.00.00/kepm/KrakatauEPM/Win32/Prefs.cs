/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2008,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Oct-05    152 : Added to Source Safe.
 * CAM  09-Feb-06    185 : Save/Restore open Projects to Windows Registry.
 * CAM  26-Mar-06    213 : Remove Analysis options from Windows Registry (now parse epm.cmd file).
 * CAM  22-Jul-06    291 : Increase remembered projects from 20 to 50.
 * CAM  29-May-08    363 : Completed toolbar buttons.
 * CAM  29-May-08    364 : Added MySql default options.
 * CAM  18-Jun-2009  10447 : Added MySql default options.
 * CAM  15-Feb-2010  10565 : Remove InstallDir and related properties.
 * CAM  13-Mar-2010  10597 : Added setting/getting of PopupTips.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Collections;
using Microsoft.Win32;

using SourceCodeMetrics.Krakatau.Kepm.Controls;
using SourceCodeMetrics.Krakatau.Kepm.Projects;

namespace SourceCodeMetrics.Krakatau.Kepm.Win32
{
  /// <summary>
  /// KEPM Preferences - stored in the Windows Registry
  /// <remarks>Singleton for KEPM Preferences.</remarks>
  /// </summary>
  public class Prefs
  {
    private static Prefs _prefs = null;
    private const string PROJECT_LIST = "project";
    private const string PROJECT_NEW = "project_new";
    private const string PROJECT_OLD = "project_old";

    private const string KeyPopupTips = "Popup Tips";

    private const string KeyMySqlServer = "Server";
    private const string KeyMySqlUsername = "Username";
    private const string KeyMySqlPassword = "Password";
    private const string KeyMySqlUse = "Use as default";
    private const int MAX_PROJECTS = 50;
    private ArrayList _projects = null;
    private string _mySqlServer;
    private string _mySqlUsername;
    private string _mySqlPassword;
    private bool _mySqlUse;
    private PopupTipList _popupTipList;

    public string MySqlServer
    {
      set
      {
        _mySqlServer = value;
      }
      get
      {
        return _mySqlServer;
      }
    }
    public string MySqlUsername
    {
      set
      {
        _mySqlUsername = value;
      }
      get
      {
        return _mySqlUsername;
      }
    }
    public string MySqlPassword
    {
      set
      {
        _mySqlPassword = value;
      }
      get
      {
        return _mySqlPassword;
      }
    }
    public bool MySqlUse
    {
      set
      {
        _mySqlUse = value;
      }
      get
      {
        return _mySqlUse;
      }
    }
    public PopupTipList PopupTipList
    {
      get
      {
        if (_popupTipList == null)
        {
          _popupTipList = new PopupTipList();
        }
        return _popupTipList;
      }
    }


    private Prefs()
    {
      // Singleton - cannot publically instanstiate
    }

    public static Prefs Preferences
    {
      get
      {
        if (_prefs == null)
        {
          _prefs = new Prefs();
          _prefs.GetSettings();
        }
        return _prefs;
      }
    }

    public void SaveSettings()
    {
      SaveSettings(null);
    }

    public void SaveSettings(ProjectsView pv)
    {
      RegistryKey rk = Registry.CurrentUser;
      rk = rk.OpenSubKey("Software", true);
      RegistryKey keyKepm = getKey(rk, "Power Software");
      keyKepm = getKey(keyKepm, "KEPM");
      bool noNew = true;
      bool noOld = true;

      if (pv != null)
      {
        IEnumerator eproj = pv.Items.GetEnumerator();
        int i = 0;
        while (eproj.MoveNext())
        {
          ProjectItem proj = (ProjectItem)eproj.Current;
          keyKepm.SetValue(PROJECT_LIST + i, proj.Project.ProjectFile.FullName);

          if (proj.Project.NewProject)
          {
            keyKepm.SetValue(PROJECT_NEW, i);
            noNew = false;
          }
          else if (proj.Project.OldProject)
          {
            keyKepm.SetValue(PROJECT_OLD, i);
            noOld = false;
          }

          i++;
        }
        while (i < MAX_PROJECTS)
        {
          // Remove unrequired keys
          if (keyKepm.GetValue(PROJECT_LIST + i) != null) keyKepm.DeleteValue(PROJECT_LIST + i);
          i++;
        }
        if (keyKepm.GetValue(PROJECT_NEW) != null && noNew) keyKepm.DeleteValue(PROJECT_NEW);
        if (keyKepm.GetValue(PROJECT_OLD) != null && noOld) keyKepm.DeleteValue(PROJECT_OLD);
      }

      // MySQL Settings
      RegistryKey keyMySql = getKey(keyKepm, "MySQL");
      keyMySql.SetValue(KeyMySqlServer, _mySqlServer);
      keyMySql.SetValue(KeyMySqlUsername, _mySqlUsername);
      keyMySql.SetValue(KeyMySqlPassword, _mySqlPassword);
      keyMySql.SetValue(KeyMySqlUse, (_mySqlUse) ? 1 : 0);

      // Popup Tips
      RegistryKey popupTips = getKey(keyKepm, KeyPopupTips);
      foreach (string valuename in popupTips.GetValueNames())
      {
        popupTips.DeleteValue(valuename);
      }

      foreach (PopupTip tip in PopupTipList.Keys)
      {
        popupTips.SetValue(tip.ToString(), "hide");
      }
    }

    private bool getBoolValue(RegistryKey key, string name)
    {
      bool rval = false;
      if (key.GetValue(name) != null)
      {
        rval = key.GetValue(name).ToString().ToLower().Equals("true");
      }
      return rval;
    }

    private string getStringValue(RegistryKey key, string name)
    {
      return getStringValue(key, name, String.Empty);
    }

    private string getStringValue(RegistryKey key, string name, string defaultValue)
    {
      string rval = defaultValue;
      if (key.GetValue(name) != null)
      {
        rval = key.GetValue(name).ToString();
      }
      if (rval.Equals(String.Empty)) return defaultValue;
      return rval;
    }

    private long getLongValue(RegistryKey key, string name)
    {
      long rval = -1;
      if (key.GetValue(name) != null)
      {
        rval = long.Parse(key.GetValue(name).ToString());
      }
      return rval;
    }

    public void GetSettings(ProjectsView pv)
    {
      GetSettings();

      IEnumerator eproj = _projects.GetEnumerator();
      pv.Items.Clear();
      while (eproj.MoveNext())
      {
        Project proj = (Project)eproj.Current;
        if (proj.ProjectFile.Exists)
        {
          if (proj.ReadFile()) pv.AddProject(proj);
        }
      }
    }

    public void GetSettings()
    {
      // User Preferences
      RegistryKey rk = Registry.CurrentUser;
      rk = rk.OpenSubKey("Software", true);
      RegistryKey keyKepm = getKey(rk, "Power Software");
      keyKepm = getKey(keyKepm, "KEPM");

      long lNew = getLongValue(keyKepm, PROJECT_NEW);
      long lOld = getLongValue(keyKepm, PROJECT_OLD);

      _projects = new System.Collections.ArrayList();
      for (int i = 0; i < MAX_PROJECTS; i++)
      {
        if (keyKepm.GetValue(PROJECT_LIST + i) != null)
        {
          Project proj = new Project(keyKepm.GetValue(PROJECT_LIST + i).ToString());
          if (proj.ProjectFile.Exists)
          {
            if (i == lNew)
            {
              proj.NewProject = true;
            }
            else if (i == lOld)
            {
              proj.OldProject = true;
            }

            if (proj.ReadFile()) _projects.Add(proj);
          }
        }
      }

      // MySQL Settings
      RegistryKey keyMySql = getKey(keyKepm, "MySQL");
      _mySqlServer = getStringValue(keyMySql, KeyMySqlServer, "localhost");
      _mySqlUsername = getStringValue(keyMySql, KeyMySqlUsername, "root");
      _mySqlPassword = getStringValue(keyMySql, KeyMySqlPassword, "");
      _mySqlUse = getStringValue(keyMySql, KeyMySqlUse, "0").ToString().Equals("1");

      // Popup Tips
      RegistryKey popupTips = getKey(keyKepm, KeyPopupTips);
      AddPopupTip(popupTips, PopupTip.NeverShow);
      AddPopupTip(popupTips, PopupTip.ResultsBrowserAfterParse);
      AddPopupTip(popupTips, PopupTip.FilterResultsBrowserUsingMetricSet);
    }

    private void AddPopupTip(RegistryKey key, PopupTip tip)
    {
      if (key.GetValue(tip.ToString()) != null)
      {
        PopupTipList.IgnorePopupTip(tip);
      }
    }

    private RegistryKey getKey(RegistryKey rk, string name)
    {
      RegistryKey key = rk.OpenSubKey(name, true);
      if (key == null)
      {
        key = rk.CreateSubKey(name);
      }
      return key;
    }
  }
}
