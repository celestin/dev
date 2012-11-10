/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Nov-2009  10502 : File created to support KEPM options in creating the EPM filelist.
 * CAM  17-Nov-2009  10502 : Added ExcludedDirectories.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;
using System.Windows.Forms;
using System.Collections;

using PowerSoftware.Krakatau.Kepm.Config;
using PowerSoftware.Krakatau.Kepm.Win32;

namespace PowerSoftware.Krakatau.Kepm.Projects
{
  /// <summary>
  /// Utility class to read and write Project Files.
  /// </summary>
  public class ProjectOptions
  {
    public static readonly string ProjectOptionsExtension = ".kepm";

    private Project _project;
    private Hashtable _config;
    private SortedList _list;
    private XmlDocument _doc;
    private Hashtable _sets;
    private ExtList _extensions;
    private DirectoryMap _excludedDirectories;

    public FileInfo OptionsFile
    {
      get
      {
        if (_project.ProjectFile != null)
        {
          return new FileInfo(_project.ProjectFile.FullName + ProjectOptions.ProjectOptionsExtension);
        }
        return null;
      }
    }
    public ExtList Extensions
    {
      get
      {
        if (_extensions == null)
        {
          _extensions = new ExtList();
        }
        return _extensions;
      }
      set
      {
        _extensions = value;
      }
    }
    public DirectoryMap ExcludedDirectories
    {
      get
      {
        if (_excludedDirectories == null)
        {
          _excludedDirectories = new DirectoryMap();
        }
        return _excludedDirectories;
      }
      set
      {
        _excludedDirectories = value;
      }
    }

    public ProjectOptions(Project project)
    {
      _project = project;

      _config = new Hashtable();
      _list = new SortedList();
      _doc = new XmlDocument();
      _sets = new Hashtable();
    }

    public void ReadOptions()
    {
      if (!OptionsFile.Exists) return;

      XmlTextReader txtreader = null;
      XmlReader reader = null;
      IEnumerator el, ef = null;

      // Load the reader with the data file and ignore all whitespace nodes.
      txtreader = new XmlTextReader(OptionsFile.FullName);
      txtreader.WhitespaceHandling = WhitespaceHandling.None;

      // Implement the validating reader over the text reader.
      reader = XmlReader.Create(txtreader.GetRemainder());

      _doc.Load(reader);

      XmlNode root = _doc.DocumentElement;
      XmlNode child;
      XmlNode extNode;
      XmlNode a;

      Extensions.Clear();
      ExcludedDirectories.Clear();

      if (((a = root.Attributes.GetNamedItem("projectFile")) != null) && !"".Equals(a.Value)) _project.ProjectFile = new FileInfo(a.Value);

      el = root.ChildNodes.GetEnumerator();
      while (el.MoveNext())
      {
        child = (XmlNode)el.Current;

        if (child.Name.Equals("include"))
        {
          ef = child.ChildNodes.GetEnumerator();
          while (ef.MoveNext())
          {
            extNode = (XmlNode)ef.Current;
            if (extNode.Name.Equals("ext"))
            {
              if (((a = extNode.Attributes.GetNamedItem("value")) != null) && !"".Equals(a.Value))
              {
                Extensions.Add(new Ext(a.Value, "*." + a.Value, "", ""));
              }
            }
          }
        }
        else if (child.Name.Equals("exclude"))
        {
          ef = child.ChildNodes.GetEnumerator();
          while (ef.MoveNext())
          {
            extNode = (XmlNode)ef.Current;
            if (extNode.Name.Equals("dir"))
            {
              if (((a = extNode.Attributes.GetNamedItem("value")) != null) && !"".Equals(a.Value))
              {
                ExcludedDirectories.Add(new DirectoryInfo(a.Value));
              }
            }
          }
        }

      }
      if (reader != null) reader.Close();
      if (txtreader != null) txtreader.Close();
    }

    private XmlDocument CreateXml()
    {
      XmlDocument doc = new XmlDocument();

      XmlNode projectNode = doc.AppendChild(doc.CreateElement("project"));
      XmlAttribute projectFile = projectNode.Attributes.Append(doc.CreateAttribute("projectFile"));
      projectFile.Value = _project.ProjectFile.FullName;

      XmlNode includeNode = projectNode.AppendChild(doc.CreateElement("include"));
      XmlNode excludeNode = projectNode.AppendChild(doc.CreateElement("exclude"));

      foreach (Ext e in Extensions)
      {
        XmlNode extNode = includeNode.AppendChild(doc.CreateElement("ext"));
        XmlAttribute valueAttr = extNode.Attributes.Append(doc.CreateAttribute("value"));
        valueAttr.Value = e.Extension;
      }

      foreach (DirectoryInfo dir in ExcludedDirectories)
      {
        XmlNode dirNode = excludeNode.AppendChild(doc.CreateElement("dir"));
        XmlAttribute valueAttr = dirNode.Attributes.Append(doc.CreateAttribute("value"));
        valueAttr.Value = dir.FullName;
      }

      return doc;
    }

    public void SaveOptions()
    {
      XmlTextWriter txtwriter = null;
      TextWriter tw = null;
      XmlDocument upd = CreateXml();
      if (upd == null) return;

      tw = new StreamWriter(OptionsFile.FullName, false);
      txtwriter = new XmlTextWriter(tw);
      txtwriter.Formatting = Formatting.Indented;

      if (upd != null)
      {
        upd.Save(txtwriter);
      }
      if (tw != null) tw.Close();
    }
  }
}
