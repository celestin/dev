-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
-- --------------------------------------------------------

ALTER TABLE mse_text DROP INDEX inits;
ALTER TABLE mse_text DROP INDEX ft;


ALTER TABLE mse_text ADD INDEX inits (inits);
ALTER TABLE mse_text ADD FULLTEXT ft (text);