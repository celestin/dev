-- --------------------------------------------------------
-- ASRC
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  02-Nov-2007  Recreated for bug Friday OP should finish at 23:00.
-- --------------------------------------------------------

UPDATE member_limit SET time_end = '23:00:00' WHERE member_type='OP' AND day=4 AND time_start = '14:00:00';

ALTER TABLE member ADD privs VARCHAR(100) NULL AFTER member_type;

