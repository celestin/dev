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
  public class EWorkEventQuery : Query
  {
    public EWorkEventQuery()
    {
      _tableName = "EworkEvent";

      _columns = "cast(efolderid as integer) efolderid, eeventtime, eusername ";

      _query =
        "from metastorm.eevent eworkevent " +
        "where ( " +
        "   etostage in ('Major P12 Closed', 'Minor P12 Closed', 'P1 Form Complete','P2 Form Complete', 'P3 Form Complete') " +
        "or eactionname in ('TLM MMS Admin Confirm Complete', 'Confirm MMS Updated') " +
        ") " +
        "and eusername is not null";
    }
  }
}
