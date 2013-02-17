-- --------------------------------------------------------
-- ASRC
-- Copyright (c) 2011 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  17-Feb-2013  11157 - Xodus Group Court naming.
-- --------------------------------------------------------

-- --------------------------------------------------------
-- Court naming
-- --------------------------------------------------------

UPDATE court SET name='Court One' WHERE court=1;
UPDATE court SET name='Court Two' WHERE court=2;
UPDATE court SET name='Court Three' WHERE court=3;
UPDATE court SET name='Court Four' WHERE court=4;
UPDATE court SET name='Court Five' WHERE court=5;
UPDATE court SET name='Xodus Group 6', shortname = 'Xodus 6' WHERE court=6;
UPDATE court SET name='Xodus Group 7', shortname = 'Xodus 7' WHERE court=7;
