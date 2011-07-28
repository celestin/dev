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

-- EOF #10828
