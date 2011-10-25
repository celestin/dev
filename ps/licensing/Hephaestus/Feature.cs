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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.Generic;

namespace PowerSoftware.Tools.Licensing.Hephaestus
{
  public class Feature
  {
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

    public static FeatureList GetFullFeatureList()
    {
      FeatureList rval = new FeatureList();

      rval.Add(new Feature("epmkr", "Krakatau EPM", 128));
      rval.Add(new Feature("epmad", "ADA", 32));
      rval.Add(new Feature("epmas", "ASP", 256));
      rval.Add(new Feature("epmay", "Assembler", 16384));
      rval.Add(new Feature("epmcp", "C/C++", 2));
      rval.Add(new Feature("epmcs", "C# (C Sharp)", 1));
      rval.Add(new Feature("epmht", "HTML", 32768));
      rval.Add(new Feature("epmjv", "Java", 4));
      rval.Add(new Feature("epmjt", "JavaScript", 65536));
      rval.Add(new Feature("epms1", "Oracle PL/SQL", 16));
      rval.Add(new Feature("epmpl", "Perl", 64));
      rval.Add(new Feature("epmph", "PHP", 512));
      rval.Add(new Feature("epmpy", "Python", 131072));
      rval.Add(new Feature("epmvb", "Visual Basic", 8));
      rval.Add(new Feature("epmid", "IDL", 1024));
      rval.Add(new Feature("epmvh", "VHDL", 2048));
      rval.Add(new Feature("epmjs", "JSP", 4096));
      rval.Add(new Feature("epmxm", "XML", 8192));
      rval.Add(new Feature("epmss", "CSS Stylesheet", 262144));
      rval.Add(new Feature("epmft", "Fortran", 524288));
      rval.Add(new Feature("epmrb", "Ruby", 1048576));
      rval.Add(new Feature("epmsh", "Shell Script", 2097152));
      rval.Add(new Feature("epmtx", "Text", 4194304));
      rval.Add(new Feature("epmwb", "Windows Batch File", 8388608));
      rval.Add(new Feature("epmpb", "PowerBuilder", 16777216));
      rval.Add(new Feature("epmuc", "Intel UC", 33554432));
      rval.Add(new Feature("epmmp", "Intel MMC", 67108864));

      rval.Add(new Feature("krakatau", "Krakatau GUI", true));
      rval.Add(new Feature("cpppm", "Krakatau PM C++", true));
      rval.Add(new Feature("javapm", "Krakatau PM Java", true));
      rval.Add(new Feature("cpppro", "Krakatau Pro C++", true));
      rval.Add(new Feature("javapro", "Krakatau Pro Java", true));
      rval.Add(new Feature("cppem", "EM C++", true));
      rval.Add(new Feature("javaem", "EM Java", true));
      rval.Add(new Feature("javavz", "VizualiseIt! Java", true));

      return rval;
    }
  }
}
