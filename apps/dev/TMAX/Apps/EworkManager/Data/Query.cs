/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Ework Manager
 * Copyright (c) 2013 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2013  11181 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;

namespace FrontBurner.Tmax.Apps.EworkManager.Data
{
  public abstract class Query
  {
    protected string _tableName;
    protected string _columns;
    protected string _query;

    public string TableName
    {
      get { return _tableName; }
    }

    public string CountSql
    {
      get { return "SELECT count(*) " + _query; }
    }

    public string DataSql
    {
      get { return "SELECT " + _columns + " " + _query; }
    }

    public string TruncateSql
    {
      get { return "DELETE FROM " + _tableName; }
    }
  }

  public class Queries : List<Query>
  {
  }
}
