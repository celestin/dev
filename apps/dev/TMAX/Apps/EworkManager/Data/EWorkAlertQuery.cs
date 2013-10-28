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
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Tmax.Apps.EworkManager.Data
{
  public class EWorkAlertQuery : Query
  {
    public EWorkAlertQuery()
    {
      _tableName = "EworkAlert";

      _columns = "cast(efolderid as integer) efolderid, ealerttime, edeadline, upper(eusername) eusername";

      _query = "from metastorm.ealert eworkalert";
    }
  }
}
