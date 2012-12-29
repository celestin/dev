/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software Hephaestus License Technology
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  01-Oct-2011  11035 : File created.
 * CAM  25-Oct-2011  11037 : File Changed Key to int, added Sum.
 * CAM  10-Nov-2012  11147 : Remove duplication in GetFullFeatureList.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.Generic;

namespace PowerSoftware.Tools.Licensing.Hephaestus
{
  public class Feature
  {
    public static readonly Feature FeatureEpmkr = new Feature("epmkr", "Krakatau EPM", 128);
    public static readonly Feature FeatureEpmad = new Feature("epmad", "ADA", 32);
    public static readonly Feature FeatureEpmas = new Feature("epmas", "ASP", 256);
    public static readonly Feature FeatureEpmay = new Feature("epmay", "Assembler", 16384);
    public static readonly Feature FeatureEpmcp = new Feature("epmcp", "C/C++", 2);
    public static readonly Feature FeatureEpmcs = new Feature("epmcs", "C# (C Sharp)", 1);
    public static readonly Feature FeatureEpmht = new Feature("epmht", "HTML", 32768);
    public static readonly Feature FeatureEpmjv = new Feature("epmjv", "Java", 4);
    public static readonly Feature FeatureEpmjt = new Feature("epmjt", "JavaScript", 65536);
    public static readonly Feature FeatureEpms1 = new Feature("epms1", "Oracle PL/SQL", 16);
    public static readonly Feature FeatureEpmpl = new Feature("epmpl", "Perl", 64);
    public static readonly Feature FeatureEpmph = new Feature("epmph", "PHP", 512);
    public static readonly Feature FeatureEpmpy = new Feature("epmpy", "Python", 131072);
    public static readonly Feature FeatureEpmvb = new Feature("epmvb", "Visual Basic", 8);
    public static readonly Feature FeatureEpmid = new Feature("epmid", "IDL", 1024);
    public static readonly Feature FeatureEpmvh = new Feature("epmvh", "VHDL", 2048);
    public static readonly Feature FeatureEpmjs = new Feature("epmjs", "JSP", 4096);
    public static readonly Feature FeatureEpmxm = new Feature("epmxm", "XML", 8192);
    public static readonly Feature FeatureEpmss = new Feature("epmss", "CSS Stylesheet", 262144);
    public static readonly Feature FeatureEpmft = new Feature("epmft", "Fortran", 524288);
    public static readonly Feature FeatureEpmrb = new Feature("epmrb", "Ruby", 1048576);
    public static readonly Feature FeatureEpmsh = new Feature("epmsh", "Shell Script", 2097152);
    public static readonly Feature FeatureEpmtx = new Feature("epmtx", "Text", 4194304);
    public static readonly Feature FeatureEpmwb = new Feature("epmwb", "Windows Batch File", 8388608);
    public static readonly Feature FeatureEpmpb = new Feature("epmpb", "PowerBuilder", 16777216);
    public static readonly Feature FeatureEpmuc = new Feature("epmuc", "Intel UC", 33554432);
    public static readonly Feature FeatureEpmmp = new Feature("epmmp", "Intel MMC", 67108864);

    public static readonly Feature FeatureKrakatau = new Feature("krakatau", "Krakatau GUI", true);
    public static readonly Feature FeatureCpppm = new Feature("cpppm", "Krakatau PM C++", true);
    public static readonly Feature FeatureJavapm = new Feature("javapm", "Krakatau PM Java", true);
    public static readonly Feature FeatureCpppro = new Feature("cpppro", "Krakatau Pro C++", true);
    public static readonly Feature FeatureJavapro = new Feature("javapro", "Krakatau Pro Java", true);
    public static readonly Feature FeatureCppem = new Feature("cppem", "EM C++", true);
    public static readonly Feature FeatureJavaem = new Feature("javaem", "EM Java", true);
    public static readonly Feature FeatureJavavz = new Feature("javavz", "VizualiseIt! Java", true);

    private string _code;
    private string _name;
    private bool _legacy;
    private int _key;

    public string Code
    {
      get { return _code; }
      set { _code = value; }
    }

    public string Name
    {
      get { return _name; }
      set { _name = value; }
    }

    public Boolean Legacy
    {
      get { return _legacy; }
      set { _legacy = value; }
    }

    public int Key
    {
      get { return _key; }
      set { _key = value; }
    }

    public Feature(string code, string name, bool legacy)
    {
      Code = code;
      Name = name;
      Legacy = legacy;
    }

    public Feature(string code, string name, int key)
      : this(code, name, false)
    {
      Key = key;
    }
  }

  public class FeatureList : List<Feature>
  {
    public FeatureList()
      : base()
    {
    }

    public int Sum()
    {
      int rval = 0;

      foreach (Feature feature in this)
      {
        rval += feature.Key;
      }

      return rval;
    }

    public bool LicensedFor(Feature feature)
    {
      foreach (Feature f in this)
      {
        if (f.Code.Equals(feature.Code)) return true;
      }
      return false;
    }

    public static FeatureList GetFullFeatureList()
    {
      FeatureList rval = new FeatureList();

      rval.Add(Feature.FeatureEpmkr);
      rval.Add(Feature.FeatureEpmad);
      rval.Add(Feature.FeatureEpmas);
      rval.Add(Feature.FeatureEpmay);
      rval.Add(Feature.FeatureEpmcp);
      rval.Add(Feature.FeatureEpmcs);
      rval.Add(Feature.FeatureEpmht);
      rval.Add(Feature.FeatureEpmjv);
      rval.Add(Feature.FeatureEpmjt);
      rval.Add(Feature.FeatureEpms1);
      rval.Add(Feature.FeatureEpmpl);
      rval.Add(Feature.FeatureEpmph);
      rval.Add(Feature.FeatureEpmpy);
      rval.Add(Feature.FeatureEpmvb);
      rval.Add(Feature.FeatureEpmid);
      rval.Add(Feature.FeatureEpmvh);
      rval.Add(Feature.FeatureEpmjs);
      rval.Add(Feature.FeatureEpmxm);
      rval.Add(Feature.FeatureEpmss);
      rval.Add(Feature.FeatureEpmft);
      rval.Add(Feature.FeatureEpmrb);
      rval.Add(Feature.FeatureEpmsh);
      rval.Add(Feature.FeatureEpmtx);
      rval.Add(Feature.FeatureEpmwb);
      rval.Add(Feature.FeatureEpmpb);
      rval.Add(Feature.FeatureEpmuc);
      rval.Add(Feature.FeatureEpmmp);

      rval.Add(Feature.FeatureKrakatau);
      rval.Add(Feature.FeatureCpppm);
      rval.Add(Feature.FeatureJavapm);
      rval.Add(Feature.FeatureCpppro);
      rval.Add(Feature.FeatureJavapro);
      rval.Add(Feature.FeatureCppem);
      rval.Add(Feature.FeatureJavaem);
      rval.Add(Feature.FeatureJavavz);

      return rval;
    }
  }
}
