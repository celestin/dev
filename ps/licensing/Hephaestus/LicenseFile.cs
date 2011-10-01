/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software License Technology
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

  public class LicenseFile
  {
    private FileInfo _file;
    private LicenseType _licenseType;
    private string _hostName;
    private DateTime _expiryDate;
    private ProductList _products;

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
      set { _hostName = value; }
    }

    public DateTime ExpiryDate
    {
      get { return _expiryDate; }
      set { _expiryDate = value; }
    }

    public ProductList Products
    {
      get { return _products; }
      set { _products = value; }
    }


    public LicenseFile(FileInfo _file)
    {
      File = _file;
    }

    public LicenseFile(FileInfo _file, string hostName)
    {
      File = _file;
      LicenseType = LicenseType.HostLocked;
      HostName = hostName;
    }

    public LicenseFile(FileInfo _file, DateTime expiryDate)
    {
      File = _file;
      LicenseType = LicenseType.TimedExpiry;
      ExpiryDate = expiryDate;
    }

    public void Save()
    {
      XmlDocument doc = new XmlDocument();
      XmlDeclaration dec = doc.CreateXmlDeclaration("1.0", null, null);
      doc.AppendChild(dec);// Create the root element
      XmlElement root = doc.CreateElement("Library");
      doc.AppendChild(root);
    }
  }
}
