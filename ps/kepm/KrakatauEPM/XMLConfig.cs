/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright 2005 Craig McKay <craig@southesk.com>
 *
 * XML Configuration Parser
 *
 * $Log: /kepm/KrakatauEPM.root/KrakatauEPM/KrakatauEPM/XMLConfig.cs $
 * 
 * 2     11/10/05 23:20 Craig
 * 152
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;
using System.Windows.Forms;
using System.Collections;

namespace KrakatauEPM
{
	/// <summary>
	/// Summary description for XMLConfig.
	/// </summary>
  public class XMLConfig
  {
    private Hashtable _config;
    private SortedList _list;

    public XMLConfig()
    {
      _config = new Hashtable();
      _list = new SortedList();
    }

    public void ParseFile() 
    {
      XmlTextReader txtreader = null;
      XmlValidatingReader reader = null;
      IEnumerator el, ef, ee = null;     

      try
      {  
        // Load the reader with the data file and ignore all whitespace nodes.
        txtreader = new XmlTextReader("epm.xml");
        txtreader.WhitespaceHandling = WhitespaceHandling.None;

        // Implement the validating reader over the text reader. 
        reader = new XmlValidatingReader(txtreader);
        reader.ValidationType = ValidationType.None;

        XmlDocument doc = new XmlDocument();
        doc.Load(reader);

        XmlNode root = doc.DocumentElement;
        XmlNode lang;
        XmlNode ftype;
        XmlNode ext;
        XmlNode a,a2;
        Hashtable ftypes;
        Hashtable exts;
        string sLang,sFiletype;

        el = root.ChildNodes.GetEnumerator();
        while (el.MoveNext()) 
        {
          lang = (XmlNode) el.Current;
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
                ftype = (XmlNode) ef.Current;
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
                      ext = (XmlNode) ee.Current;
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
        }
      }

      finally
      {
        if (reader!=null)
          reader.Close();
      }
    }
    
    public object[] Extensions() 
    {
      object[] list = new object[_list.Count];
      int i=0;
      IEnumerator e = _list.Values.GetEnumerator();
      while (e.MoveNext())
      {
        list[i++] = e.Current;
      }
      return list;
    }
  }
}
