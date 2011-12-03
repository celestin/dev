-- --------------------------------------------------------
-- ASRC
-- Copyright (c) 2011 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  03-Sep-2011  11013 - New slots at the beginning of the day
-- CAM  03-Dec-2011  11013 - Backed out all of Ali's original requests and ensure 22:30 finish and 10:00 start at weekends.
-- --------------------------------------------------------

-- --------------------------------------------------------
-- Remove slots to ensure finish at 22:30
-- --------------------------------------------------------

DELETE FROM slot WHERE court IN (1,2) AND slot=23;
DELETE FROM slot WHERE court IN (3,4,5) AND slot=21;
DELETE FROM slot WHERE court IN (6,7) AND slot=20;

-- --------------------------------------------------------
-- Member Limits
-- --------------------------------------------------------

TRUNCATE TABLE member_limit;

INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',0, '09:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',1, '09:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',2, '09:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',3, '09:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',4, '09:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',0, '09:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',0, '14:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',1, '09:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',1, '14:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',2, '09:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',2, '14:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',3, '09:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',3, '14:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',4, '09:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',4, '14:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',0, '09:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',0, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',1, '09:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',1, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',2, '09:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',2, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',3, '09:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',3, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',4, '09:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',4, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',5, '10:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',5, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',6, '10:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',6, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',0, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',1, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',2, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',3, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',4, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',0, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',1, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',2, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',3, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',4, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',0, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',1, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',2, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',3, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',4, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',0, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',1, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',2, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',3, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',4, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',0, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',1, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',2, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',3, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',4, '09:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',6, '10:00:00', '22:30:00');

-- --------------------------------------------------------
-- End of Member Limits
-- --------------------------------------------------------

