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

namespace PowerSoftware.Tools.Licensing.Hephaestus
{
  public class Product
  {
    private string _code;
    private string _name;
    private bool _legacy;
    private long _key;

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

    public long Key
    {
      get { return _key; }
      set { _key = value; }
    }

    public Product(string code, string name, bool legacy)
    {
      Code = code;
      Name = name;
      Legacy = legacy;
    }

    public Product(string code, string name, long key)
      : this(code, name, false)
    {
      Key = key;
    }
  }

  public class ProductList : List<Product>
  {
    public ProductList()
      : base()
    {
    }

    public static ProductList GetFullProductList()
    {
      ProductList rval = new ProductList();

      rval.Add(new Product("epmkr", "Krakatau EPM", 128));
      rval.Add(new Product("epmad", "ADA", 32));
      rval.Add(new Product("epmas", "ASP", 256));
      rval.Add(new Product("epmay", "Assembler", 16384));
      rval.Add(new Product("epmcp", "C/C++", 2));
      rval.Add(new Product("epmcs", "C# (C Sharp)", 1));
      rval.Add(new Product("epmht", "HTML", 32768));
      rval.Add(new Product("epmjv", "Java", 4));
      rval.Add(new Product("epmjt", "JavaScript", 65536));
      rval.Add(new Product("epms1", "Oracle PL/SQL", 16));
      rval.Add(new Product("epmpl", "Perl", 64));
      rval.Add(new Product("epmph", "PHP", 512));
      rval.Add(new Product("epmpy", "Python", 131072));
      rval.Add(new Product("epmvb", "Visual Basic", 8));
      rval.Add(new Product("epmid", "IDL", 1024));
      rval.Add(new Product("epmvh", "VHDL", 2048));
      rval.Add(new Product("epmjs", "JSP", 4096));
      rval.Add(new Product("epmxm", "XML", 8192));
      rval.Add(new Product("epmss", "CSS Stylesheet", 262144));
      rval.Add(new Product("epmft", "Fortran", 524288));
      rval.Add(new Product("epmrb", "Ruby", 1048576));
      rval.Add(new Product("epmsh", "Shell Script", 2097152));
      rval.Add(new Product("epmtx", "Text", 4194304));
      rval.Add(new Product("epmwb", "Windows Batch File", 8388608));
      rval.Add(new Product("epmpb", "PowerBuilder", 16777216));
      rval.Add(new Product("epmuc", "Intel UC", 33554432));
      rval.Add(new Product("epmmp", "Intel MMC", 67108864));

      rval.Add(new Product("krakatau", "Krakatau GUI", true));
      rval.Add(new Product("cpppm", "Krakatau PM C++", true));
      rval.Add(new Product("javapm", "Krakatau PM Java", true));
      rval.Add(new Product("cpppro", "Krakatau Pro C++", true));
      rval.Add(new Product("javapro", "Krakatau Pro Java", true));
      rval.Add(new Product("cppem", "EM C++", true));
      rval.Add(new Product("javaem", "EM Java", true));
      rval.Add(new Product("javavz", "VizualiseIt! Java", true));

      return rval;
    }
  }
}
