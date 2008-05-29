/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Singleton for KEPM Preferences
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  09-Feb-06   185 : Save/Restore open Projects to Windows Registry.
 * CAM  26-Mar-06   213 : Remove Analysis options from Windows Registry (now parse epm.cmd file).
 * CAM  22-Jul-06   291 : Increase remembered projects from 20 to 50.
 * CAM  29-May-08   363 : Completed toolbar buttons.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Collections;
using System.Windows.Forms;
using Microsoft.Win32;

namespace KrakatauEPM
{
  /// <summary>
  /// KEPM Preferences - stored in the Windows Registry
  /// </summary>
  public class Prefs
  {
    private static Prefs _prefs = null;
    private const string PROJECT_LIST = "project";
    private const string PROJECT_NEW = "project_new";
    private const string PROJECT_OLD = "project_old";
    private const int MAX_PROJECTS = 50;
    private ArrayList _projects = null;
    private DirectoryInfo _installDir;

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
      string rval = "";
      if (key.GetValue(name) != null)
      {
        rval = key.GetValue(name).ToString();
      }
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

      // Now retrieve general Software settings
      rk = Registry.LocalMachine;
      rk = rk.OpenSubKey("Software", true);
      key = getKey(rk, "SOFTWARE");
      key = getKey(key, "Power Software");
      key = getKey(key, "Krakatau EPM");

      if (key.GetValue("InstallDir") == null)
      {
        SetInstallDir("C:\\Program Files\\Power Software\\Krakatau EPM\\");
      }
      else
      {
        SetInstallDir(key.GetValue("InstallDir").ToString());
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

    public DirectoryInfo InstallDir
    {
      get
      {
        return this._installDir;
      }
    }

    protected void SetInstallDir(string path)
    {
      string p = path;
      if (!p.EndsWith("\\"))
      {
        p += "\\";
      }
      this._installDir = new DirectoryInfo(p);
    }

    public string InstallDrive
    {
      get
      {
        return InstallDir.FullName.Substring(0,2);
      }
    }
  }
}
