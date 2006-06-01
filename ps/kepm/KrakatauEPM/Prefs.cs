/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright 2005-2006 Craig McKay <craig@frontburner.co.uk>
 *
 * Singleton for KEPM Preferences
 *
 * $Log: /kepm/KrakatauEPM.root/KrakatauEPM/KrakatauEPM/Prefs.cs $
 * 
 * 4     26/03/06 19:48 Craig
 * 213
 * 
 * 3     14/02/06 0:00 Craig
 * 185
 * 
 * 2     11/10/05 23:20 Craig
 * 152
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  09-Feb-06   185 : Save/Restore open Projects to Windows Registry.
 * CAM  26-Mar-06   213 : Remove Analysis options from Windows Registry (now parse epm.cmd file).
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
    private ArrayList _projects = null;
    public FileInfo InstallDir;

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
        while (i<20) 
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
          if (proj.ReadFile()) pv.addProject(proj);
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
      for (int i=0; i<20; i++) 
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
        InstallDir = new FileInfo("C:\\Program Files\\Power Software\\Krakatau EPM\\");
      } 
      else 
      {
        InstallDir = new FileInfo(key.GetValue("InstallDir").ToString());
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

    public string InstallDrive
    {
      get
      {
        return InstallDir.DirectoryName.Substring(0,2);
      }
    }
  }
}
