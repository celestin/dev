select count(*)
from tabs;

select *
from locoper;

select *
from ind;

select l.location, l.description locdescription, lo.failurecode, l.classstructureid, csl.classificationid, ac.description classdescription
from locations l, locoper lo, classstructlink csl, assetclass ac
where lo.location = l.location
and csl.classstructureid (+)= l.classstructureid
and ac.classificationid = csl.classificationid
and l.location = '5-02-P400A';

select *
from assetattribute;

select ls.assetattrid, ls.displaysequence, aa.description, 
decode(aa.datatype, 'ALN', ls.alnvalue, cast(ls.numvalue as varchar2(100))) attrvalue
from locationspec ls, assetattribute aa
where aa.assetattrid = ls.assetattrid
and ls.location = '5-02-P400A'
and ls.classstructureid = '1098'
order by ls.displaysequence;

select ls.assetattrid, ls.displaysequence, aa.description, decode(aa.datatype, 'ALN', ls.alnvalue, cast(ls.numvalue as varchar2(100))) attrvalue from locationspec ls, assetattribute aa where aa.assetattrid = ls.assetattrid and ls.location = '5-02-P400A' and ls.classstructureid = '1098' order by ls.displaysequence;


select *
from cols 
where column_name = 'CLASSSTRUCTUREID';

select *
from classstructure
where classstructureid = '1098';

select *
from classstructlink
where classstructureid = '1098';

SELECT ROWSTAMP,
  CLASSSTRUCTUREID,
  L1CLASSIFICATIONID,
  L2CLASSIFICATIONID,
  L3CLASSIFICATIONID,
  L4CLASSIFICATIONID,
  L5CLASSIFICATIONID,
  DESCRIPTION,
  GENASSETDESC,
  USEL1CLASSINDESC,
  USEL2CLASSINDESC,
  USEL3CLASSINDESC,
  USEL4CLASSINDESC,
  USEL5CLASSINDESC,
  LDKEY,
  ACS01,
  ACS02,
  ACS03,
  ACS04,
  ACS05
FROM CLASSSTRUCTURE ;

select *
from locationspec where location = '5-02-P400A';

select ldownertable, count(*) orphans from longdescription ld where ldownertable = 'WORKORDER' and not exists (select 1 from workorder where ldkey = ld.ldkey) group by ldownertable
union all
select ldownertable, count(*) orphans from longdescription ld where ldownertable = 'PM' and not exists (select 1 from pm where ldkey = ld.ldkey) group by ldownertable;


select *
from locations
where location like '5-%C%';

select wonum,crewid
from workorder
where crewid is not null
and historyflag = 'N';