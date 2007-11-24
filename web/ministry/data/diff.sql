-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  24-Nov-2007  10208 : Added newpages field.
-- --------------------------------------------------------

ALTER TABLE mse_text ADD newpages VARCHAR(100) NULL;
