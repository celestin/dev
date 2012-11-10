/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software Hephaestus License Technology
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  01-Oct-2011  11035 : File created.
 * CAM  25-Oct-2011  11037 : Added Valid and Load methods.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Net;

namespace PowerSoftware.Tools.Licensing.Hephaestus
{
  public enum LicenseType
  {
    TimedExpiry,
    HostLocked
  }

  public static class LicenseTypes
  {
    public static string LicenseTypeString(LicenseType type)
    {
      return type.ToString();
    }
    public static LicenseType DetermineLicenseType(string type)
    {
      if (type.Equals("TimedExpiry")) return LicenseType.TimedExpiry;
      return LicenseType.HostLocked;
    }
  }

  public class LicenseFile
  {
    protected static readonly string NodePowerSoftwareLicense = "PowerSoftwareLicense";
    protected static readonly string AttrType = "Type";
    protected static readonly string AttrExpiryDate = "ExpiryDate";
    protected static readonly string AttrHostName = "HostName";
    protected static readonly string NodeFeature = "Feature";
    protected static readonly string AttrCode = "Code";
    protected static readonly string AttrSign = "Sign";

    private FileInfo _file;
    private LicenseType _licenseType;
    private string _hostName;
    private DateTime _expiryDate;
    private FeatureList _features;

    public FileInfo File
    {
      get { return _file; }
      set { _file = value; }
    }

    public LicenseType LicenseType
    {
      get { return _licenseType; }
      set { _licenseType = value; }
    }

    public string HostName
    {
      get { return _hostName; }
      set
      {
        _hostName = value;
        LicenseType = LicenseType.HostLocked;
      }
    }

    public DateTime ExpiryDate
    {
      get { return _expiryDate; }
      set
      {
        _expiryDate = value;
        LicenseType = LicenseType.TimedExpiry;
      }
    }

    public FeatureList Features
    {
      get
      {
        if (_features == null) _features = new FeatureList();
        return _features;
      }
      set { _features = value; }
    }

    public bool Valid()
    {
      switch (this.LicenseType)
      {
        case LicenseType.TimedExpiry:
          return (ExpiryDate > DateTime.Now);

        case LicenseType.HostLocked:
          return (HostName.ToUpper() == Dns.GetHostName().ToUpper());
      }

      return false;
    }

    public LicenseFile(FileInfo _file)
    {
      File = _file;
    }

    public void Load()
    {
      XmlDocument doc = new XmlDocument();
      doc.Load(File.FullName);

      Algorithm alg = new Algorithm(this);
      FeatureList fullList = FeatureList.GetFullFeatureList();

      XmlAttribute attr = null;
      string code = String.Empty;
      string sign = String.Empty;

      foreach (XmlNode node in doc.ChildNodes)
      {
        if (node.Name == NodePowerSoftwareLicense)
        {
          attr = node.Attributes[AttrType];
          if (attr != null)
          {
            this.LicenseType = LicenseTypes.DetermineLicenseType(attr.Value);

            switch (this.LicenseType)
            {
              case LicenseType.TimedExpiry:
                attr = node.Attributes[AttrExpiryDate];
                if (attr != null) this.ExpiryDate = DateTime.Parse(attr.Value);
                break;

              case LicenseType.HostLocked:
                attr = node.Attributes[AttrHostName];
                if (attr != null) this.HostName = attr.Value.Trim();
                break;
            }
          }

          foreach (XmlNode featureNode in node.ChildNodes)
          {
            if (featureNode.Name.Equals(NodeFeature))
            {
              attr = featureNode.Attributes[AttrCode];
              if (attr != null) code = attr.Value;
              attr = featureNode.Attributes[AttrSign];
              if (attr != null) sign = attr.Value;

              Feature masterFeature = fullList.Find(delegate(Feature f) { return f.Code == code; });
              if (masterFeature != null)
              {
                if (alg.Sign(masterFeature) == sign)
                {
                  Features.Add(masterFeature);
                }
              }
            }
          }
        }
      }
    }

    public void Save()
    {
      XmlDocument doc = new XmlDocument();
      XmlDeclaration dec = doc.CreateXmlDeclaration("1.0", null, null);
      doc.AppendChild(dec);// Create the root element
      XmlElement root = doc.CreateElement(NodePowerSoftwareLicense);
      doc.AppendChild(root);
      root.SetAttribute(AttrType, LicenseTypes.LicenseTypeString(this.LicenseType));

      if (LicenseType == LicenseType.TimedExpiry)
      {
        root.SetAttribute(AttrExpiryDate, this.ExpiryDate.ToString("dd-MMM-yyyy"));
      }
      else if (LicenseType == LicenseType.HostLocked)
      {
        root.SetAttribute(AttrHostName, this.HostName);
      }

      XmlElement featureElement;
      Algorithm alg = new Algorithm(this);

      foreach (Feature feature in Features)
      {
        featureElement = doc.CreateElement(NodeFeature);
        featureElement.SetAttribute(AttrCode, feature.Code);
        featureElement.SetAttribute(AttrSign, alg.Sign(feature));
        root.AppendChild(featureElement);
      }

      doc.Save(File.FullName);
    }
  }
}
