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
using System.Text;
using System.Security.Cryptography;

namespace PowerSoftware.Tools.Licensing.Hephaestus
{
  public class Algorithm
  {
    private LicenseFile _licenseFile;
    private MD5 _encryper;

    public LicenseFile LicenseFile
    {
      get { return _licenseFile; }
      set { _licenseFile = value; }
    }

    public Algorithm(LicenseFile licenseFile)
    {
      LicenseFile = licenseFile;
      _encryper = new MD5CryptoServiceProvider();
    }

    public string Sign(Feature feature)
    {
      string rval = "";

      if (LicenseFile.LicenseType == LicenseType.TimedExpiry)
      {
        rval = Sign(feature, LicenseFile.ExpiryDate);
      }
      else
      {
        rval = Sign(feature, LicenseFile.HostName);
      }

      return rval;
    }

    public string Sign(Feature feature, DateTime expiryDate)
    {
      return Encrypt(feature, String.Format("{0:dd-MMM-yyyy}", expiryDate));
    }

    public string Sign(Feature feature, string hostName)
    {
      return Encrypt(feature, hostName.Trim().ToUpper());
    }

    protected string Encrypt(Feature feature, string value)
    {
      byte[] stream = Encoding.UTF8.GetBytes(string.Format("{1}|{0:000000000000}|{2}", feature.Key, feature.Code, value));
      return Convert.ToBase64String(_encryper.ComputeHash(stream));
    }
  }
}
