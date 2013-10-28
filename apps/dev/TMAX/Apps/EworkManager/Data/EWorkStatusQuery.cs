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
  public class EWorkStatusQuery : Query
  {
    public EWorkStatusQuery()
    {
      _tableName = "EworkStatus";

      _columns = "process_id, efolderid, cast(NVL(Site, 'UKCS') as varchar2(100)) Site, Foldername, Description, Originator, CreateDate, Status, OrigStatus, Subject, EnteredStageDate";

      _query = 
        "from ( " +
        "select OrigStatus, process_id, efolderid, Site, Foldername, Description, Originator, CreateDate, Subject, EnteredStageDate, " +
        "decode(OrigStatus,  " +
        "'Initiator', '01 Initiated', " +
        "'Originator', '02 Originator', " +
        "'Originator Queried', '03 MIRQ', " +
        "'Originator Query', '03 MIRQ', " +
        "'P12 Withdrawn', '04 Cancelled', " +
        "'P1 Form Withdrawn', '04 Cancelled', " +
        "'P2 Form Withdrawn', '04 Cancelled', " +
        "'P3 Form Withdrawn', '04 Cancelled', " +
        "'P6 Form Withdrawn', '04 Cancelled', " +
        "'P10 Form Withdrawn', '04 Cancelled', " +
        "'Assign Maintenance to P2', '05 Awaiting Tech Approval', " +
        "'Assurance Manager', '05 Awaiting Tech Approval', " +
        "'Close Out Coordinator', '05 Awaiting Tech Approval', " +
        "'Discipline Comments', '05 Awaiting Tech Approval', " +
        "'Disciplines', '05 Awaiting Tech Approval', " +
        "'IIA Lead Engineer', '05 Awaiting Tech Approval', " +
        "'Implementor of Major Change', '05 Awaiting Tech Approval', " +
        "'Implementor of Minor Change', '05 Awaiting Tech Approval', " +
        "'Lead Inst Engineer', '05 Awaiting Tech Approval', " +
        "'Lead Instrument Engineer', '05 Awaiting Tech Approval', " +
        "'Maintenance Coordinator', '05 Awaiting Tech Approval', " +
        "'OI Engineer', '05 Awaiting Tech Approval', " +
        "'OI Manager', '05 Awaiting Tech Approval', " +
        "'OIM - OTL Review', '05 Awaiting Tech Approval', " +
        "'OTL   or Site Superintendent', '05 Awaiting Tech Approval', " +
        "'OTL Approval', '05 Awaiting Tech Approval', " +
        "'OTL Confirmation', '05 Awaiting Tech Approval', " +
        "'OTL Endorsement', '05 Awaiting Tech Approval', " +
        "'OTL or Site Superintendent', '05 Awaiting Tech Approval', " +
        "'P2 Maintenance Coordinator', '05 Awaiting Tech Approval', " +
        "'Responsible Person', '05 Awaiting Tech Approval', " +
        "'Site Inspection Engineer', '05 Awaiting Tech Approval', " +
        "'MMS Admin', '06 WMS Team for Action', " +
        "'MMS UpdateTag', '06 WMS Team for Action', " +
        "'P2 MMS Update', '06 WMS Team for Action', " +
        "'P2 TLM MMS Admin', '06 WMS Team for Action', " +
        "'Major P12 Closed', '07 Completed', " +
        "'Minor P12 Closed', '07 Completed', " +
        "'P1 Form Complete', '07 Completed', " +
        "'P10 Form Complete', '07 Completed', " +
        "'P2 Form Complete', '07 Completed', " +
        "'P3 Form Complete', '07 Completed', " +
        "'P6 Form Complete', '07 Completed', " +
        "'TLM MMS Admin Confirm Complete', '07 Completed', " +
        "'03 MIRQ') Status " +
        "from " +
        "( " +
        "   SELECT   'P1' process_id, " +
        "            CAST (ef.efolderid as integer) eFolderId, " +
        "            TO_CHAR (p1.txtsite) Site, " +
        "            TO_CHAR (ef.efoldername) Foldername, " +
        "            REPLACE(TO_CHAR (SUBSTR (p1.memreasonforchange, 1, 180)),chr(13),'') AS Description, " +
        "            TO_CHAR (ef.eoriginator) Originator, " +
        "            TO_CHAR (ef.ecreationtime) CreateDate, " +
        "            TO_CHAR (ef.estagename) OrigStatus,   " +
        "            TO_CHAR (ef.esubject) Subject, " +
        "            ef.eentrytime as EnteredStageDate " +
        "     FROM   metastorm.p1_tag_amendment p1, metastorm.efolder ef " +
        "    WHERE   p1.efolderid = ef.efolderid   " +
        "   UNION " +
        "   SELECT   'P2', " +
        "            CAST (ef.efolderid as integer) eFolderId, " +
        "            TO_CHAR (p2.txtsite), " +
        "            TO_CHAR (ef.efoldername), " +
        "            REPLACE(TO_CHAR (SUBSTR(txtafatitle,1,180)),chr(13),'') AS description, " +
        "            TO_CHAR (ef.eoriginator), " +
        "            TO_CHAR (ef.ecreationtime), " +
        "            TO_CHAR (ef.estagename),   " +
        "            TO_CHAR (ef.esubject), " +
        "            ef.eentrytime as EnteredStageDate " +
        "     FROM   metastorm.p2_afa_mms_update p2, metastorm.efolder ef " +
        "    WHERE   p2.efolderid = ef.efolderid  " +
        "   UNION " +
        "   SELECT   'P3', " +
        "            CAST (ef.efolderid as integer) eFolderId, " +
        "            TO_CHAR (p3.txtsite), " +
        "            TO_CHAR (ef.efoldername), " +
        "            REPLACE(TO_CHAR (SUBSTR (memreasonreq, 1, 180)),chr(13),'') AS description, " +
        "            TO_CHAR (ef.eoriginator), " +
        "            TO_CHAR (ef.ecreationtime), " +
        "            TO_CHAR (ef.estagename),   " +
        "             TO_CHAR (ef.esubject), " +
        "            ef.eentrytime as EnteredStageDate " +
        "     FROM   metastorm.p3_maintenance_amendment p3, metastorm.efolder ef " +
        "    WHERE   p3.efolderid = ef.efolderid     " +
        "   UNION " +
        "   SELECT   'P3WO', " +
        "            CAST (ef.efolderid as integer) eFolderId, " +
        "            TO_CHAR (p3.txtsite), " +
        "            TO_CHAR (ef.efoldername), " +
        "            REPLACE(TO_CHAR (SUBSTR (txtwop3reason, 1, 180)),chr(13),'') AS description, " +
        "            TO_CHAR (ef.eoriginator), " +
        "            TO_CHAR (ef.ecreationtime), " +
        "            TO_CHAR (ef.estagename),   " +
        "             TO_CHAR (ef.esubject), " +
        "            ef.eentrytime as EnteredStageDate " +
        "     FROM   metastorm.p3_maintenance_wo_deferral p3, metastorm.efolder ef " +
        "    WHERE   p3.efolderid = ef.efolderid     " +
        "    UNION " +
        "   SELECT   'P3PMJP', " +
        "            CAST (ef.efolderid as integer) eFolderId, " +
        "            TO_CHAR (p3.txtsite), " +
        "            TO_CHAR (ef.efoldername), " +
        "            REPLACE(TO_CHAR (SUBSTR (txtjpoverview || txtpmoverview, 1, 180)),chr(13),'') AS description, " +
        "            TO_CHAR (ef.eoriginator), " +
        "            TO_CHAR (ef.ecreationtime), " +
        "            TO_CHAR (ef.estagename),   " +
        "             TO_CHAR (ef.esubject), " +
        "            ef.eentrytime as EnteredStageDate " +
        "     FROM   metastorm.p3_maintenance_pm_jp_amendment p3, metastorm.efolder ef " +
        "    WHERE   p3.efolderid = ef.efolderid     " +
        "   UNION " +
        "   SELECT   'P6', " +
        "            CAST (ef.efolderid as integer) eFolderId, " +
        "            TO_CHAR (p6.txtsite), " +
        "            TO_CHAR (ef.efoldername), " +
        "            REPLACE(TO_CHAR (SUBSTR (p6.txtp6reason, 1, 180)),chr(13),'')as description, " +
        "            TO_CHAR (ef.eoriginator), " +
        "            TO_CHAR (ef.ecreationtime), " +
        "            TO_CHAR (ef.estagename),  " +
        "             TO_CHAR (ef.esubject), " +
        "            ef.eentrytime as EnteredStageDate " +
        "     FROM   metastorm.p6_inspection_deferral p6, metastorm.efolder ef " +
        "    WHERE   p6.efolderid = ef.efolderid  " +
        "   UNION " +
        "   SELECT   'P10', " +
        "            CAST (ef.efolderid as integer) eFolderId, " +
        "            TO_CHAR (p10.txtsite), " +
        "            TO_CHAR (ef.efoldername), " +
        "            REPLACE(TO_CHAR (SUBSTR(p10.txtp10reason,1,180)),chr(13),'') as description, " +
        "            TO_CHAR (ef.eoriginator), " +
        "            TO_CHAR (ef.ecreationtime), " +
        "            TO_CHAR (ef.estagename), " +
        "            TO_CHAR (ef.esubject), " +
        "            ef.eentrytime as EnteredStageDate " +
        "     FROM   metastorm.p10_set_point_amendment p10, metastorm.efolder ef " +
        "    WHERE   p10.efolderid = ef.efolderid " +
        " UNION " +
        " SELECT   'P12', " +
        "            CAST (ef.efolderid as integer) eFolderId, " +
        "            TO_CHAR (p12.txtsite), " +
        "            TO_CHAR (ef.efoldername), " +
        "            REPLACE(TO_CHAR (SUBSTR(p12.txtSystem,1,180)),chr(13),'') AS description, " +
        "            TO_CHAR (ef.eoriginator), " +
        "            TO_CHAR (ef.ecreationtime), " +
        "            TO_CHAR (ef.estagename), " +
        "            TO_CHAR (ef.esubject), " +
        "            ef.eentrytime as EnteredStageDate " +
        "     FROM   metastorm.p12_software_change_control p12, metastorm.efolder ef " +
        "     WHERE   p12.efolderid = ef.efolderid  " +
        ")) eworkstatus " +
        "where (  " +
        "                   status not in ('04 Cancelled', '07 Completed') " +
        "             OR  (status in ('04 Cancelled', '07 Completed') and (SYSDATE - EnteredStageDate) < 60) " +
        "           ) " +
        "and origstatus is not null";
    }
  }
}
