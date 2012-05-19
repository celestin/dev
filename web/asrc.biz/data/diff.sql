-- --------------------------------------------------------
-- ASRC
-- Copyright (c) 2011 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  19-May-2012  11122 - Xodus Group Court naming.
-- --------------------------------------------------------

-- --------------------------------------------------------
-- Court naming
-- --------------------------------------------------------

UPDATE court SET name='Court One' WHERE court=1;
UPDATE court SET name='Court Two' WHERE court=2;
UPDATE court SET name='Court Three' WHERE court=3;
UPDATE court SET name='Court Four' WHERE court=4;
UPDATE court SET name='Court Five' WHERE court=5;
UPDATE court SET name='Court Six' WHERE court=6;
UPDATE court SET name='Xodus Group Court' WHERE court=7;

ALTER TABLE court ADD shortname VARCHAR(20) NULL AFTER name;

UPDATE court SET shortname='Xodus' WHERE court=7;

