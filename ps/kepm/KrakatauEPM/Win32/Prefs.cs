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
      RegistryKey key = getKey(rk, "Power Software");
      key = getKey(key, "KEPM");
      bool noNew = true;
      bool noOld = true;

      if (pv != null)
      {
        IEnumerator eproj = pv.Items.GetEnumerator();
        int i=0;
        while (eproj.MoveNext())
        {
          ProjectItem proj = (ProjectItem) eproj.Current;
          key.SetValue(PROJECT_LIST + i, proj.Project.ProjectFile.FullName);

          if (proj.Project.NewProject)
          {
            key.SetValue(PROJECT_NEW, i);
            noNew = false;
          }
          else if (proj.Project.OldProject)
          {
            key.SetValue(PROJECT_OLD, i);
            noOld = false;
          }

          i++;
        }
        while (i<MAX_PROJECTS)
        {
          // Remove unrequired keys
          if (key.GetValue(PROJECT_LIST+i) != null) key.DeleteValue(PROJECT_LIST+i);
          i++;
        }
        if (key.GetValue(PROJECT_NEW) != null && noNew) key.DeleteValue(PROJECT_NEW);
        if (key.GetValue(PROJECT_OLD) != null && noOld) key.DeleteValue(PROJECT_OLD);
      }

      // MySQL Settings
      key = getKey(key, "MySQL");
      key.SetValue(KeyMySqlServer, _mySqlServer);
      key.SetValue(KeyMySqlUsername, _mySqlUsername);
      key.SetValue(KeyMySqlPassword, _mySqlPassword);
      key.SetValue(KeyMySqlUse, (_mySqlUse) ? 1 : 0);
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
        Project proj = (Project) eproj.Current;
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
      RegistryKey key = getKey(rk, "Power Software");
      key = getKey(key, "KEPM");

      long lNew = getLongValue(key, PROJECT_NEW);
      long lOld = getLongValue(key, PROJECT_OLD);

      _projects = new System.Collections.ArrayList();
      for (int i=0; i<MAX_PROJECTS; i++)
      {
        if (key.GetValue(PROJECT_LIST + i) != null)
        {
          Project proj = new Project(key.GetValue(PROJECT_LIST + i).ToString());
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
      key = getKey(key, "MySQL");
      _mySqlServer = getStringValue(key, KeyMySqlServer, "localhost");
      _mySqlUsername = getStringValue(key, KeyMySqlUsername, "root");
      _mySqlPassword = getStringValue(key, KeyMySqlPassword, "");
      _mySqlUse = getStringValue(key, KeyMySqlUse, "0").ToString().Equals("1");
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
