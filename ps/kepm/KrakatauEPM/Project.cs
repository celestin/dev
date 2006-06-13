/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Model of a KEPM Project
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  24-Jan-06   179 : Ensure spaces in Project Titles are converted to underscores.
 * CAM  24-Jan-06   185 : Added New/Old awareness for saving/restoring projects.
 * CAM  26-Mar-06   213 : Remove Analysis options from Windows Registry (now parse epm.cmd file).
 * CAM  08-Jun-06   243 : Remember selected file types.
 * CAM  14-Jun-06   268 : Better error handling on files.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Collections;
using System.Windows.Forms;
using System.Diagnostics;

namespace KrakatauEPM
{
	/// <summary>
	/// Representation of an EPM Project.
	/// </summary>
	public class Project
	{
    private FileInfo _ProjectFile = null;
    private FileInfo _fBuildFile = null;
    private FileInfo _fAnalysisFile = null;
    private String _sProjectTitle = null;
    private DateTime _dSnapshot;
    private String _sBasedir = null;
    private bool _bIsNew = false;
    private bool _bIsOld = false;

		public Project()
		{
      _sProjectTitle = "";
      _dSnapshot = System.DateTime.Today;
      _sBasedir = "";
      _bIsNew = false;
      _bIsOld = false;
		}
  
    public Project(String sProjectFile)
    {
      _ProjectFile = new FileInfo(sProjectFile);      
    }

    public bool BuildFile(CheckedListBox.CheckedItemCollection checkedItems) 
    {
      string extList = "";
      Ext e;
      int nChecked=0;
      foreach (object fileExt in checkedItems) {
        if (fileExt is Ext)
        {
          e = (Ext) fileExt;
          extList += (" *." + e.Extension);
          nChecked++;
        }
      }

      if ((_ProjectFile == null) || "".Equals(_sProjectTitle) || 
          "".Equals(_sBasedir) || nChecked==0) 
      {
        return false;
      }

      // Create a Project Command file
      TextWriter tw = new StreamWriter(this.ProjectBuildFile.FullName, false);
      tw.WriteLine("@echo off");
      tw.WriteLine("set FILELIST=\"" + _ProjectFile.FullName + "\"");
      tw.WriteLine("set PATH=" + _sBasedir);
      tw.WriteLine("");
      tw.WriteLine("echo " + _sProjectTitle + ">%FILELIST%");
      tw.WriteLine("echo " + _dSnapshot.ToShortDateString() + ">>%FILELIST%");
      tw.WriteLine("echo %PATH%>>%FILELIST%");
      tw.WriteLine("");
      tw.WriteLine(_sBasedir.Substring(0,1) + ":");
      tw.WriteLine("cd \"%PATH%\"");
      tw.WriteLine("dir " + extList + " /s /b>>%FILELIST%");
      tw.Close();

      // Execute the Command file to create our Project text file
      Process p = new Process();
      p.StartInfo.RedirectStandardOutput = false;
      p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
      p.StartInfo.UseShellExecute = true;
      p.StartInfo.FileName = this.ProjectBuildFile.FullName;
      p.Start();
      p.WaitForExit();

      return true;
    }

    private string GetExtensions() 
    {
      TextReader tr = null;
      if (_ProjectFile == null || !this.ProjectBuildFile.Exists) 
      {
        return null;
      }
      try 
      {
        tr = new StreamReader(this.ProjectBuildFile.FullName, false);
      } 
      catch 
      {
        return null;
      }

      string line = null;
      int p;
      while ((line = tr.ReadLine()) != null) 
      {
        line = line.Trim();        
        if (line.StartsWith("dir")) 
        {
          tr.Close();
          line = line.Substring(3, line.Length-3);
          if ((p = line.IndexOf("/s"))>=0) 
          {
            line = line.Substring(0, p);
          }          
          return line;
        }        
      }
      tr.Close();
      return null;
    }

    public void ReadExtensions(CheckedListBox clbFileTypes) 
    {
      string extList = this.GetExtensions();
      if (extList == null) return;
      char[] splitter  = {' '};
      string[] exts = extList.Trim().Split(splitter);
      Ext ex;
      int i;

      for (i=0; i<clbFileTypes.Items.Count; i++)
      {
        clbFileTypes.SetItemChecked(i, false);
      }
      
      for(int n=0; n<exts.Length; n++)
      {
        string e = exts[n].Substring(2, exts[n].Length-2);                
        for (i=0; i<clbFileTypes.Items.Count; i++)
        {
          if (clbFileTypes.Items[i] is Ext)
          {
            ex = (Ext) clbFileTypes.Items[i];
            if (ex.Extension == e) 
            {
              clbFileTypes.SetItemChecked(i, true);
            }
          }          
        }
      }
    }

    public Arguments getAnalysisOptions() 
    {
      this.ProjectAnalysisFile.Refresh();
      if (_ProjectFile == null || !this.ProjectAnalysisFile.Exists) 
      {
        return null;
      }
      TextReader tr = null;
      try 
      {
        tr = new StreamReader(this.ProjectAnalysisFile.FullName);      
      } 
      catch 
      {
        return null;
      }

      string line = null;
      while ((line = tr.ReadLine()) != null) 
      {
        line = line.Trim();        
        if (line.StartsWith("epm")) 
        {
          tr.Close();
          return new Arguments(line);
        }        
      }

      tr.Close();
      return null;
    }

    public bool ReadFile() 
    {
      if (_ProjectFile != null) 
      {        
        TextReader re = null;
        try 
        {
          re = new StreamReader(_ProjectFile.FullName);
        } 
        catch 
        {
          return false;
        }

        string input = null;
        if ((input = re.ReadLine()) != null) 
        {
          this.Title = input;      
        } 
        else 
        {
          re.Close();
          return false;
        }
        if ((input = re.ReadLine()) != null) 
        {
          this.ParseSnapshot(input);
        }
        else 
        {
          re.Close();
          return false;
        }
        if ((input = re.ReadLine()) != null) 
        {
          this.Basedir = input;        
        } 
        else 
        {
          re.Close();
          return false;
        }
        re.Close();
        return true;
      }
      return false;
    }

    public override String ToString() 
    {
      return "Project {" + _sProjectTitle + 
        "} SnapshotDate {" + _dSnapshot.ToShortDateString() +
        "} Basedir {" + _sBasedir + "}";
    }

    public FileInfo ProjectFile
    {
      get
      {
        return _ProjectFile;
      }
      set
      {
        _ProjectFile = value;
      }
    }

    public FileInfo ProjectBuildFile 
    {
      get 
      {
        if (_ProjectFile == null) 
        {
          return null;
        }
        if (_fBuildFile == null)
        {
          _fBuildFile = new FileInfo(_ProjectFile.FullName + ".cmd");
        }
        return _fBuildFile;
      }
    }

    public FileInfo ProjectAnalysisFile 
    {
      get 
      {
        if (_fAnalysisFile == null)
        {
          _fAnalysisFile = new FileInfo(_ProjectFile.FullName + ".epm.cmd");
        }
        return _fAnalysisFile;
      }
    }

    public string Title
    {
      get
      {
        return _sProjectTitle;
      }
      set
      {
        _sProjectTitle = value.Trim();
      }
    }

    public void ParseSnapshot(string value)
    {
      try
      {
        _dSnapshot = DateTime.Parse(value).Date;
      } 
      catch (System.FormatException) 
      {
        _dSnapshot = DateTime.Today.Date;
      }
    }

    public DateTime Snapshot
    {
      get
      {
        return _dSnapshot;
      }
      set
      {
        _dSnapshot = value;
      }
    }

    public string Basedir
    {
      get
      {
        return _sBasedir;
      }
      set
      {
        _sBasedir = value.Trim();
        if (!_sBasedir.Substring(_sBasedir.Length-1,1).Equals("\\")) 
        {
          _sBasedir += "\\";
        }
      }
    }

    public string Databasename 
    {
      get 
      {
        string projectDbName = this.Title.Replace(" ", "_").ToLower();
        projectDbName = projectDbName.Replace("'", "");
        projectDbName = projectDbName.Replace(".", "_");
        projectDbName = projectDbName.Replace("_", "");

        return projectDbName;
      }
    }

    public bool NewProject
    {
      get 
      {
        return this._bIsNew;
      }
      set 
      {
        this._bIsNew = value;
        this._bIsOld = false;
      }
    }
    public bool OldProject
    {
      get 
      {
        return this._bIsOld;
      }
      set 
      {
        this._bIsOld = value;
        this._bIsNew = false;
      }
    }
  }
}
