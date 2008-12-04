-- --------------------------------------------------------
-- ASRC
-- Copyright (c) 2008 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  04-Dec-2008  10316 : Enable Junior booking of 16:40 slot.
-- --------------------------------------------------------

UPDATE member_limit SET time_end='17:20:00' WHERE member_type='J' AND day=0 AND time_start='09:00:00';
UPDATE member_limit SET time_end='17:20:00' WHERE member_type='J' AND day=1 AND time_start='09:00:00';
UPDATE member_limit SET time_end='17:20:00' WHERE member_type='J' AND day=2 AND time_start='09:00:00';
UPDATE member_limit SET time_end='17:20:00' WHERE member_type='J' AND day=3 AND time_start='09:00:00';
UPDATE member_limit SET time_end='17:20:00' WHERE member_type='J' AND day=4 AND time_start='09:00:00';

