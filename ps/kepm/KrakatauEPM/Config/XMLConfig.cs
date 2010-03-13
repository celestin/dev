/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Oct-05    152 : Added to Source Safe.
 * CAM  13-Jun-06    258 : Added reading/writing of Metric Sets.
 * CAM  12-Jul-06    282 : Ensure renames to Sets are reflected in the _sets hashtable.
 * CAM  02-Nov-06    117 : No real change.
 * CAM  11-Nov-2009  10502 : Corrected obselete calls.
 * CAM  15-Feb-2010  10565 : Added ConfigFile and utilise KrakatauSettings.
 * CAM  19-Feb-2010  10558 : Changed MetricSets to property.
 * CAM  19-Feb-2010  10558 : Create MetricDefs using Metric objects.
 * CAM  13-Mar-2010  10581 : Renamed ConfigFile to ApplicationConfigFile and added UserConfigFile.  Refer to User Home dir for EPM.XML (to ensure Vista/7 compatibility).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;
using System.Windows.Forms;
using System.Collections;

using SourceCodeMetrics.Krakatau.Kepm.Metrics;
using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm.Config
{
  /// <summary>
  /// EPM.XML Configuration Parser.
  /// </summary>
  public class XmlConfig
  {
    public static readonly string EpmConfig = "epm.xml";

    private static XmlConfig _xmlConfig = null;
    private Hashtable _config;
    private SortedList _list;
    private XmlDocument _doc;
    private Hashtable _sets;
    private FileInfo _appConfigFile;
    private FileInfo _userConfigFile;

    protected FileInfo ApplicationConfigFile
    {
      get
      {
        if (_appConfigFile == null)
        {
          _appConfigFile = new FileInfo(String.Format(@"{0}\{1}", KrakatauSettings.Settings.InstallDir.FullName, EpmConfig));
        }
        return _appConfigFile;
      }
    }

    protected FileInfo UserConfigFile
    {
      get
      {
        if (_userConfigFile == null)
        {
          _userConfigFile = new FileInfo(String.Format(@"{0}\{1}", KrakatauSettings.Settings.UserHomeDir.FullName, EpmConfig));

          if (!_userConfigFile.Exists) ApplicationConfigFile.CopyTo(_userConfigFile.FullName);
        }

        return _userConfigFile;
      }
    }

    public IEnumerator MetricSets
    {
      get
      {
        return _sets.Values.GetEnumerator();
      }
    }

    private XmlConfig()
    {
      _config = new Hashtable();
      _list = new SortedList();
      _doc = new XmlDocument();
      _sets = new Hashtable();
    }

    public static XmlConfig Config
    {
      get
      {
        if (_xmlConfig == null)
        {
          _xmlConfig = new XmlConfig();
        }
        return _xmlConfig;
      }
    }

    public void ParseFile()
    {
      XmlTextReader txtreader = null;
      XmlReader reader = null;
      IEnumerator el, ef, ee = null;

      try
      {
        // Load the reader with the data file and ignore all whitespace nodes.
        txtreader = new XmlTextReader(UserConfigFile.FullName);
        txtreader.WhitespaceHandling = WhitespaceHandling.None;
        reader = XmlReader.Create(txtreader.GetRemainder());

        _doc.Load(reader);

        XmlNode root = _doc.DocumentElement;
        XmlNode lang;
        XmlNode ftype;
        XmlNode ext;
        XmlNode a, a2, au, al;
        Hashtable ftypes;
        Hashtable exts;
        string sLang, sFiletype;
        MetricCollection metrics = KrakatauSettings.Settings.Metrics;

        el = root.ChildNodes.GetEnumerator();
        while (el.MoveNext())
        {
          lang = (XmlNode)el.Current;
          if (lang.Name.Equals("lang"))
          {
            a = lang.Attributes.GetNamedItem("name");
            if (a != null && !"".Equals(a.Value))
            {
              sLang = a.Value;
              ftypes = new Hashtable();
              _config.Add(sLang, ftypes);

              ef = lang.ChildNodes.GetEnumerator();
              while (ef.MoveNext())
              {
                ftype = (XmlNode)ef.Current;
                if (ftype.Name.Equals("filetype"))
                {
                  a = ftype.Attributes.GetNamedItem("name");
                  if (a != null && !"".Equals(a.Value))
                  {
                    sFiletype = a.Value;
                    exts = new Hashtable();
                    ftypes.Add(sFiletype, exts);

                    ee = ftype.ChildNodes.GetEnumerator();
                    while (ee.MoveNext())
                    {
                      ext = (XmlNode)ee.Current;
                      a = ext.Attributes.GetNamedItem("name");
                      a2 = ext.Attributes.GetNamedItem("value");

                      if (a != null && !"".Equals(a.Value) && a2 != null && !"".Equals(a2.Value))
                      {
                        Ext e = new Ext(a.Value, a2.Value, sFiletype, sLang);
                        exts.Add(e.Extension, e);
                        _list.Add(e.ToString(), e);
                      }
                    }
                  }
                }
              }
            }
          }
          else if (lang.Name.Equals("sets"))
          {
            ef = lang.ChildNodes.GetEnumerator();
            while (ef.MoveNext())
            {
              ftype = (XmlNode)ef.Current;
              if (ftype.Name.Equals("set"))
              {
                a = ftype.Attributes.GetNamedItem("name");
                if (a != null && !"".Equals(a.Value))
                {
                  MetricSet ms = new MetricSet(a.Value);
                  _sets.Add(ms.Name, ms);
                  ee = ftype.ChildNodes.GetEnumerator();
                  while (ee.MoveNext())
                  {
                    ext = (XmlNode)ee.Current;
                    a = ext.Attributes.GetNamedItem("id");
                    au = ext.Attributes.GetNamedItem("upper");
                    al = ext.Attributes.GetNamedItem("lower");

                    if (a != null && !"".Equals(a.Value))
                    {
                      MetricDef md = new MetricDef(metrics[long.Parse(a.Value)]);
                      if (au != null && !"".Equals(au.Value))
                      {
                        md.Upper(long.Parse(au.Value));
                      }
                      if (al != null && !"".Equals(al.Value))
                      {
                        md.Lower(long.Parse(al.Value));
                      }
                      ms.Add(md);
                    }
                  }
                }
              }
            }
            // Now remove the Metric Sets as they will be rebuilt during application execution.
            root.RemoveChild(lang);
          }
        }
      }

      finally
      {
        if (reader != null) reader.Close();
      }
    }

    private XmlDocument AppendMetricSets()
    {
      XmlNode setsNode = null;
      XmlNode setNode = null;
      XmlNode metNode = null;
      XmlAttribute setName, metId, metBound;
      XmlDocument upd = (XmlDocument)_doc.Clone();
      Hashtable renamed = new Hashtable();

      if (_sets.Count > 0)
      {
        setsNode = upd.CreateElement("sets");
        upd.DocumentElement.AppendChild(setsNode);
      }

      if (setsNode == null) return null;

      IEnumerator e = _sets.Values.GetEnumerator();
      while (e.MoveNext())
      {
        MetricSet ms = (MetricSet)e.Current;
        renamed[ms.Name] = ms;
        setNode = upd.CreateElement("set");
        setName = upd.CreateAttribute("name");
        setName.Value = ms.Name;
        setNode.Attributes.Append(setName);

        IEnumerator ed = ms.GetEnumerator();
        while (ed.MoveNext())
        {
          MetricDef md = (MetricDef)ed.Current;
          metNode = upd.CreateElement("met");
          metId = upd.CreateAttribute("id");
          metId.Value = md.Id.ToString();
          metNode.Attributes.Append(metId);

          if (md.LowerBound)
          {
            metBound = upd.CreateAttribute("lower");
            metBound.Value = md.LowerValue.ToString();
            metNode.Attributes.Append(metBound);
          }

          if (md.UpperBound)
          {
            metBound = upd.CreateAttribute("upper");
            metBound.Value = md.UpperValue.ToString();
            metNode.Attributes.Append(metBound);
          }

          setNode.AppendChild(metNode);
        }

        setsNode.AppendChild(setNode);
      }

      _sets = renamed;
      return upd;
    }

    public void SaveConfig()
    {
      XmlTextWriter txtwriter = null;
      TextWriter tw = null;
      XmlDocument upd = AppendMetricSets();
      if (upd == null) return;

      try
      {
        tw = new StreamWriter(UserConfigFile.FullName, false);
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

    public object[] Extensions()
    {
      object[] list = new object[_list.Count];
      int i = 0;
      IEnumerator e = _list.Values.GetEnumerator();
      while (e.MoveNext())
      {
        list[i++] = e.Current;
      }
      return list;
    }

    public void AddMetricSet(MetricSet ms)
    {
      _sets.Add(ms.Name, ms);
    }

    public void RemoveMetricSet(MetricSet ms)
    {
      _sets.Remove(ms.Name);
    }

    public MetricSet GetMetricSet(string name)
    {
      return (MetricSet)_sets[name];
    }
  }
}
