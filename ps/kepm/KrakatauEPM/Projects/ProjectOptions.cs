/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: XMLConfig.cs 968 2009-04-28 23:07:00Z craig $
 *
 * Who  When         Why
 * CAM  11-Nov-2009  10502 : File created to support KEPM options in creating the EPM filelist.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;
using System.Windows.Forms;
using System.Collections;

using SourceCodeMetrics.Krakatau.Kepm.Config;
using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm.Projects
{
  /// <summary>
  /// Utility class to read and write Project Files.
  /// </summary>
  public class ProjectOptions
  {
    public static readonly string ProjectOptionsExtension = ".kepm";

    private Project _project;
    private FileInfo _optionsFile;
    private Hashtable _config;
    private SortedList _list;
    private XmlDocument _doc;
    private Hashtable _sets;
    private ExtList _extensions;

    public FileInfo OptionsFile
    {
      get { return _optionsFile; }
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

    public ProjectOptions(Project project)
    {
      _project = project;

      string projectFile = _project.ProjectFile.FullName;

      _optionsFile = new FileInfo(_project.ProjectFile.FullName + ProjectOptions.ProjectOptionsExtension);

      _config = new Hashtable();
      _list = new SortedList();
      _doc = new XmlDocument();
      _sets = new Hashtable();
    }

    public void ReadOptions()
    {
      if (!_optionsFile.Exists) return;

      XmlTextReader txtreader = null;
      XmlReader reader = null;
      IEnumerator el, ef = null;

      // Load the reader with the data file and ignore all whitespace nodes.
      txtreader = new XmlTextReader(_optionsFile.FullName);
      txtreader.WhitespaceHandling = WhitespaceHandling.None;

      // Implement the validating reader over the text reader.
      reader = XmlReader.Create(txtreader.GetRemainder());

      _doc.Load(reader);

      XmlNode root = _doc.DocumentElement;
      XmlNode child;
      XmlNode extNode;
      XmlNode a;

      Extensions.Clear();

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
      }
      if (reader != null) reader.Close();

      MessageBox.Show(Extensions.Count.ToString());
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

      return doc;
    }

    public void SaveOptions()
    {
      XmlTextWriter txtwriter = null;
      TextWriter tw = null;
      XmlDocument upd = CreateXml();
      if (upd == null) return;

      try
      {
        tw = new StreamWriter(_optionsFile.FullName, false);
        txtwriter = new XmlTextWriter(tw);
        txtwriter.Formatting = Formatting.Indented;

        if (upd != null)
        {
          upd.Save(txtwriter);
        }
      }
      finally
      {
        if (tw != null) tw.Close();
      }
    }

    //public st[] Extensions()
    //{
    //  object[] list = new object[_list.Count];
    //  int i = 0;
    //  IEnumerator e = _list.Values.GetEnumerator();
    //  while (e.MoveNext())
    //  {
    //    list[i++] = e.Current;
    //  }
    //  return list;
    //}
  }
}
