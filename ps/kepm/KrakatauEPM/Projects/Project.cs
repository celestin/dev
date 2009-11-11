/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Oct-05    152 : Added to Source Safe.
 * CAM  24-Jan-06    179 : Ensure spaces in Project Titles are converted to underscores.
 * CAM  24-Jan-06    185 : Added New/Old awareness for saving/restoring projects.
 * CAM  26-Mar-06    213 : Remove Analysis options from Windows Registry (now parse epm.cmd file).
 * CAM  08-Jun-06    243 : Remember selected file types.
 * CAM  14-Jun-06    268 : Better error handling on files.
 * CAM  11-Dec-07    327 : Added MaxProjectDbName and parse DbName more selectively in Databasename property.
 * CAM  22-Aug-2009  10461 : Added Check/Uncheck All box.
 * CAM  11-Nov-2009  10502 : Removed use of CMD file to create filelist (if the file still exists, we read it for smooth migration).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Config;

namespace SourceCodeMetrics.Krakatau.Kepm.Projects
{
  /// <summary>
  /// Representation of an EPM Project.
  /// </summary>
  public class Project
  {
    public static readonly int MaxProjectDbName = 30;

    #region Member vars
    private FileInfo _projectFile = null;
    private ProjectOptions _projectOptions = null;
    private FileInfo _fBuildFile = null;
    private FileInfo _fAnalysisFile = null;
    private String _projectTitle = null;
    private DateTime _snapshotDate;
    private String _basedir = null;
    private bool _isNew = false;
    private bool _isOld = false;
    #endregion

    #region Properties
    public FileInfo ProjectFile
    {
      get
      {
        return _projectFile;
      }
      set
      {
        _projectFile = value;
      }
    }
    public FileInfo ProjectBuildFile
    {
      get
      {
        if (_projectFile == null)
        {
          return null;
        }
        if (_fBuildFile == null)
        {
          _fBuildFile = new FileInfo(_projectFile.FullName + ".cmd");
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
          _fAnalysisFile = new FileInfo(_projectFile.FullName + ".epm.cmd");
        }
        return _fAnalysisFile;
      }
    }

    public string Title
    {
      get
      {
        return _projectTitle;
      }
      set
      {
        _projectTitle = value.Trim();
      }
    }

    public bool NewProject
    {
      get
      {
        return this._isNew;
      }
      set
      {
        this._isNew = value;
        this._isOld = false;
      }
    }
    public bool OldProject
    {
      get
      {
        return this._isOld;
      }
      set
      {
        this._isOld = value;
        this._isNew = false;
      }
    }

    public string Basedir
    {
      get
      {
        return _basedir;
      }
      set
      {
        _basedir = value.Trim();
        if (!_basedir.Substring(_basedir.Length - 1, 1).Equals("\\"))
        {
          _basedir += "\\";
        }
      }
    }

    public string Databasename
    {
      get
      {
        char[] name = this.Title.Trim().ToLower().ToCharArray();
        string rval = "epm_";

        for (int i = 0; i < name.Length && i < MaxProjectDbName; i++)
        {
          if ((name[i] >= 'a') && (name[i] <= 'z'))
          {
            rval += name[i];
          }
          else if ((name[i] >= '0') && (name[i] <= '9'))
          {
            rval += name[i];
          }
          else if (name[i] == ' ')
          {
            rval += "_";
          }
        }

        while (rval.IndexOf("__") >= 0)
        {
          rval = rval.Replace("__", "_");
        }

        return rval;
      }
    }

    public DateTime Snapshot
    {
      get
      {
        return _snapshotDate;
      }
      set
      {
        _snapshotDate = value;
      }
    }
    #endregion

    #region Methods
    public Project()
    {
      _projectTitle = "";
      _snapshotDate = System.DateTime.Today;
      _basedir = "";
      _isNew = false;
      _isOld = false;

      _projectOptions = new ProjectOptions(this);

    }

    public Project(String sProjectFile)
    {
      _projectFile = new FileInfo(sProjectFile);
      _projectOptions = new ProjectOptions(this);

      _projectOptions.ReadOptions();
    }

    public bool BuildFile(CheckedListBox.CheckedItemCollection checkedItems)
    {
      ExtList list = new ExtList();
      foreach (Ext fileExt in checkedItems)
      {
        list.Add(fileExt);
      }

      if ((_projectFile == null) || "".Equals(_projectTitle) ||
          "".Equals(_basedir) || list.Count == 0)
      {
        return false;
      }

      _projectOptions.Extensions = list;

      _projectOptions.SaveOptions();
      // TODO - Write the actual project filelist!

      return true;
    }

    private string[] GetExtensions()
    {
      if (_projectFile == null) return null;

      // Preferably, use new Options File
      if (_projectOptions.OptionsFile.Exists)
      {
        _projectOptions.ReadOptions();
        return _projectOptions.Extensions.ConvertToArray();
      }

      // If old Build File exists, read from this
      if (ProjectBuildFile.Exists) return GetBuildFileExtensions();

      return null;
    }

    private string[] GetBuildFileExtensions()
    {
      TextReader tr = null;

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
          line = line.Substring(3, line.Length - 3);
          if ((p = line.IndexOf("/s")) >= 0)
          {
            line = line.Substring(0, p);
          }

          char[] splitter = { ' ' };
          string[] exts = line.Trim().Split(splitter);
          return exts;
        }
      }
      tr.Close();
      return null;
    }

    public CheckState ReadExtensions(CheckedListBox clbFileTypes)
    {
      string[] exts = GetExtensions();
      if (exts == null) return CheckState.Unchecked;

      Ext ex;
      int i;
      string e;

      for (i = 0; i < clbFileTypes.Items.Count; i++)
      {
        clbFileTypes.SetItemChecked(i, false);
      }

      for (int n = 0; n < exts.Length; n++)
      {
        if (exts[n].Length <= 2)
        {
          e = " ";
        }
        else
        {
          e = exts[n].Substring(2, exts[n].Length - 2);
        }

        for (i = 0; i < clbFileTypes.Items.Count; i++)
        {
          if (clbFileTypes.Items[i] is Ext)
          {
            ex = (Ext)clbFileTypes.Items[i];
            if (ex.Extension == e)
            {
              clbFileTypes.SetItemChecked(i, true);
            }
          }
        }
      }

      // Now count the number of checked items to return a meaningful value for the "check all" box
      int checkCount = 0;
      for (i = 0; i < clbFileTypes.Items.Count; i++)
      {
        if (clbFileTypes.GetItemChecked(i)) checkCount++;
      }

      if (checkCount == 0) return CheckState.Unchecked;
      if (checkCount == clbFileTypes.Items.Count) return CheckState.Checked;
      return CheckState.Indeterminate;
    }

    public Arguments GetAnalysisOptions()
    {
      this.ProjectAnalysisFile.Refresh();
      if (_projectFile == null || !this.ProjectAnalysisFile.Exists)
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
      if (_projectFile != null)
      {
        TextReader re = null;
        try
        {
          re = new StreamReader(_projectFile.FullName);
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
      return "Project {" + _projectTitle +
        "} SnapshotDate {" + _snapshotDate.ToShortDateString() +
        "} Basedir {" + _basedir + "}";
    }

    public void ParseSnapshot(string value)
    {
      try
      {
        _snapshotDate = DateTime.Parse(value).Date;
      }
      catch (System.FormatException)
      {
        _snapshotDate = DateTime.Today.Date;
      }
    }

    #endregion
  }
}