/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software Hephaestus License Technology
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  01-Oct-2011  11035 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;

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


    public LicenseFile(FileInfo _file)
    {
      File = _file;
    }

    public void Save()
    {
      XmlDocument doc = new XmlDocument();
      XmlDeclaration dec = doc.CreateXmlDeclaration("1.0", null, null);
      doc.AppendChild(dec);// Create the root element
      XmlElement root = doc.CreateElement("PowerSoftwareLicense");
      doc.AppendChild(root);
      root.SetAttribute("Type", LicenseTypes.LicenseTypeString(this.LicenseType));

      if (LicenseType == LicenseType.TimedExpiry)
      {
        root.SetAttribute("ExpiryDate", this.ExpiryDate.ToString("dd-MMM-yyyy"));
      }
      else if (LicenseType == LicenseType.HostLocked)
      {
        root.SetAttribute("HostName", this.HostName);
      }

      XmlElement featureElement;
      Algorithm alg = new Algorithm(this);

      foreach (Feature feature in Features)
      {
        featureElement = doc.CreateElement("Feature");
        featureElement.SetAttribute("Code", feature.Code);
        featureElement.SetAttribute("Sign", alg.Sign(feature));
        root.AppendChild(featureElement);
      }

      doc.Save(File.FullName);
    }
  }
}
