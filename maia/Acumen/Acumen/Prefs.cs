/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Preferences
 *
 * $Id: AcumenNode.cs 116 2006-05-19 22:10:25Z craig $
 * 
 * Who  When       Why
 * CAM  19-Aug-06   152 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Collections;
using System.Windows.Forms;
using Microsoft.Win32;

namespace frontburner.maia.Acumen
{
  /// <summary>
  /// KEPM Preferences - stored in the Windows Registry
  /// </summary>
  public class Prefs
  {
    private static Prefs _prefs = null;
    private const string CONNECTION_STRING = "ConnectionString";
    private string _connectionString;

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

    public void GetSettings()
    {
      // User Preferences
      RegistryKey rk = Registry.LocalMachine;
      rk = rk.OpenSubKey("SOFTWARE", true);
      RegistryKey key = getKey(rk, "Maia Systems");
      key = getKey(key, "Acumen");

      _connectionString = getStringValue(key, CONNECTION_STRING);
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

    public string ConnectionString
    {
      get
      {
        return this._connectionString;
      }
    }
  }
}
