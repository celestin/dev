-- --------------------------------------------------------
-- iKnit (iknit.biz)
-- Copyright (c) 2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------

-- CAM  11-Dec-2010  10998  Add ChangeDate to detect new products

ALTER TABLE sirdar_yarn ADD changedate DATE NULL;
ALTER TABLE sirdar_yarn_leaflet ADD changedate DATE NULL;
ALTER TABLE sirdar_yarn_shade ADD changedate DATE NULL;

insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F077','DMY-1000','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F070','DMY-1001','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F118','DMY-1002','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F069','DMY-1003','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F081','DMY-1004','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F060','DMY-1005','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F091','DMY-1006','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F055','DMY-1007','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F095','DMY-1008','EXC');
insert into sirdar_yarn_leaflet (yarn_code, leaflet_code, leaflet_status) values ('F035','DMY-1009','EXC');

-- EOF #10998
