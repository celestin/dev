-- --------------------------------------------------------
-- ASRC
-- Copyright (c) 2011 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  03-Sep-2011  11013
-- --------------------------------------------------------

-- --------------------------------------------------------
-- COURTS 1 and 2
-- --------------------------------------------------------

UPDATE slot set slot=24 WHERE court IN (1,2) AND slot=23;
UPDATE slot set slot=23 WHERE court IN (1,2) AND slot=22;
UPDATE slot set slot=22 WHERE court IN (1,2) AND slot=21;
UPDATE slot set slot=21 WHERE court IN (1,2) AND slot=20;
UPDATE slot set slot=20 WHERE court IN (1,2) AND slot=19;
UPDATE slot set slot=19 WHERE court IN (1,2) AND slot=18;
UPDATE slot set slot=18 WHERE court IN (1,2) AND slot=17;
UPDATE slot set slot=17 WHERE court IN (1,2) AND slot=16;
UPDATE slot set slot=16 WHERE court IN (1,2) AND slot=15;
UPDATE slot set slot=15 WHERE court IN (1,2) AND slot=14;
UPDATE slot set slot=14 WHERE court IN (1,2) AND slot=13;
UPDATE slot set slot=13 WHERE court IN (1,2) AND slot=12;
UPDATE slot set slot=12 WHERE court IN (1,2) AND slot=11;
UPDATE slot set slot=11 WHERE court IN (1,2) AND slot=10;
UPDATE slot set slot=10 WHERE court IN (1,2) AND slot=9;
UPDATE slot set slot=9 WHERE court IN (1,2) AND slot=8;
UPDATE slot set slot=8 WHERE court IN (1,2) AND slot=7;
UPDATE slot set slot=7 WHERE court IN (1,2) AND slot=6;
UPDATE slot set slot=6 WHERE court IN (1,2) AND slot=5;
UPDATE slot set slot=5 WHERE court IN (1,2) AND slot=4;
UPDATE slot set slot=4 WHERE court IN (1,2) AND slot=3;
UPDATE slot set slot=3 WHERE court IN (1,2) AND slot=2;
UPDATE slot set slot=2 WHERE court IN (1,2) AND slot=1;

UPDATE booking set slot=24 WHERE court IN (1,2) AND slot=23;
UPDATE booking set slot=23 WHERE court IN (1,2) AND slot=22;
UPDATE booking set slot=22 WHERE court IN (1,2) AND slot=21;
UPDATE booking set slot=21 WHERE court IN (1,2) AND slot=20;
UPDATE booking set slot=20 WHERE court IN (1,2) AND slot=19;
UPDATE booking set slot=19 WHERE court IN (1,2) AND slot=18;
UPDATE booking set slot=18 WHERE court IN (1,2) AND slot=17;
UPDATE booking set slot=17 WHERE court IN (1,2) AND slot=16;
UPDATE booking set slot=16 WHERE court IN (1,2) AND slot=15;
UPDATE booking set slot=15 WHERE court IN (1,2) AND slot=14;
UPDATE booking set slot=14 WHERE court IN (1,2) AND slot=13;
UPDATE booking set slot=13 WHERE court IN (1,2) AND slot=12;
UPDATE booking set slot=12 WHERE court IN (1,2) AND slot=11;
UPDATE booking set slot=11 WHERE court IN (1,2) AND slot=10;
UPDATE booking set slot=10 WHERE court IN (1,2) AND slot=9;
UPDATE booking set slot=9 WHERE court IN (1,2) AND slot=8;
UPDATE booking set slot=8 WHERE court IN (1,2) AND slot=7;
UPDATE booking set slot=7 WHERE court IN (1,2) AND slot=6;
UPDATE booking set slot=6 WHERE court IN (1,2) AND slot=5;
UPDATE booking set slot=5 WHERE court IN (1,2) AND slot=4;
UPDATE booking set slot=4 WHERE court IN (1,2) AND slot=3;
UPDATE booking set slot=3 WHERE court IN (1,2) AND slot=2;
UPDATE booking set slot=2 WHERE court IN (1,2) AND slot=1;

UPDATE booking_arc set slot=24 WHERE court IN (1,2) AND slot=23;
UPDATE booking_arc set slot=23 WHERE court IN (1,2) AND slot=22;
UPDATE booking_arc set slot=22 WHERE court IN (1,2) AND slot=21;
UPDATE booking_arc set slot=21 WHERE court IN (1,2) AND slot=20;
UPDATE booking_arc set slot=20 WHERE court IN (1,2) AND slot=19;
UPDATE booking_arc set slot=19 WHERE court IN (1,2) AND slot=18;
UPDATE booking_arc set slot=18 WHERE court IN (1,2) AND slot=17;
UPDATE booking_arc set slot=17 WHERE court IN (1,2) AND slot=16;
UPDATE booking_arc set slot=16 WHERE court IN (1,2) AND slot=15;
UPDATE booking_arc set slot=15 WHERE court IN (1,2) AND slot=14;
UPDATE booking_arc set slot=14 WHERE court IN (1,2) AND slot=13;
UPDATE booking_arc set slot=13 WHERE court IN (1,2) AND slot=12;
UPDATE booking_arc set slot=12 WHERE court IN (1,2) AND slot=11;
UPDATE booking_arc set slot=11 WHERE court IN (1,2) AND slot=10;
UPDATE booking_arc set slot=10 WHERE court IN (1,2) AND slot=9;
UPDATE booking_arc set slot=9 WHERE court IN (1,2) AND slot=8;
UPDATE booking_arc set slot=8 WHERE court IN (1,2) AND slot=7;
UPDATE booking_arc set slot=7 WHERE court IN (1,2) AND slot=6;
UPDATE booking_arc set slot=6 WHERE court IN (1,2) AND slot=5;
UPDATE booking_arc set slot=5 WHERE court IN (1,2) AND slot=4;
UPDATE booking_arc set slot=4 WHERE court IN (1,2) AND slot=3;
UPDATE booking_arc set slot=3 WHERE court IN (1,2) AND slot=2;
UPDATE booking_arc set slot=2 WHERE court IN (1,2) AND slot=1;

INSERT INTO slot (court, slot, start_time, duration) VALUES ('1', '1', '08:20:00', '40'), ('2', '1', '08:20:00', '40');

-- --------------------------------------------------------
-- End of COURTS 1 and 2
-- --------------------------------------------------------


-- --------------------------------------------------------
-- COURTS 3,4,5,6 and 7
-- --------------------------------------------------------

UPDATE slot set slot=23 WHERE court NOT IN (1,2) AND slot=21;
UPDATE slot set slot=22 WHERE court NOT IN (1,2) AND slot=20;
UPDATE slot set slot=21 WHERE court NOT IN (1,2) AND slot=19;
UPDATE slot set slot=20 WHERE court NOT IN (1,2) AND slot=18;
UPDATE slot set slot=19 WHERE court NOT IN (1,2) AND slot=17;
UPDATE slot set slot=18 WHERE court NOT IN (1,2) AND slot=16;
UPDATE slot set slot=17 WHERE court NOT IN (1,2) AND slot=15;
UPDATE slot set slot=16 WHERE court NOT IN (1,2) AND slot=14;
UPDATE slot set slot=15 WHERE court NOT IN (1,2) AND slot=13;
UPDATE slot set slot=14 WHERE court NOT IN (1,2) AND slot=12;
UPDATE slot set slot=13 WHERE court NOT IN (1,2) AND slot=11;
UPDATE slot set slot=12 WHERE court NOT IN (1,2) AND slot=10;
UPDATE slot set slot=11 WHERE court NOT IN (1,2) AND slot=9;
UPDATE slot set slot=10 WHERE court NOT IN (1,2) AND slot=8;
UPDATE slot set slot=9 WHERE court NOT IN (1,2) AND slot=7;
UPDATE slot set slot=8 WHERE court NOT IN (1,2) AND slot=6;
UPDATE slot set slot=7 WHERE court NOT IN (1,2) AND slot=5;
UPDATE slot set slot=6 WHERE court NOT IN (1,2) AND slot=4;
UPDATE slot set slot=5 WHERE court NOT IN (1,2) AND slot=3;
UPDATE slot set slot=4 WHERE court NOT IN (1,2) AND slot=2;
UPDATE slot set slot=3 WHERE court NOT IN (1,2) AND slot=1;

UPDATE booking set slot=23 WHERE court NOT IN (1,2) AND slot=21;
UPDATE booking set slot=22 WHERE court NOT IN (1,2) AND slot=20;
UPDATE booking set slot=21 WHERE court NOT IN (1,2) AND slot=19;
UPDATE booking set slot=20 WHERE court NOT IN (1,2) AND slot=18;
UPDATE booking set slot=19 WHERE court NOT IN (1,2) AND slot=17;
UPDATE booking set slot=18 WHERE court NOT IN (1,2) AND slot=16;
UPDATE booking set slot=17 WHERE court NOT IN (1,2) AND slot=15;
UPDATE booking set slot=16 WHERE court NOT IN (1,2) AND slot=14;
UPDATE booking set slot=15 WHERE court NOT IN (1,2) AND slot=13;
UPDATE booking set slot=14 WHERE court NOT IN (1,2) AND slot=12;
UPDATE booking set slot=13 WHERE court NOT IN (1,2) AND slot=11;
UPDATE booking set slot=12 WHERE court NOT IN (1,2) AND slot=10;
UPDATE booking set slot=11 WHERE court NOT IN (1,2) AND slot=9;
UPDATE booking set slot=10 WHERE court NOT IN (1,2) AND slot=8;
UPDATE booking set slot=9 WHERE court NOT IN (1,2) AND slot=7;
UPDATE booking set slot=8 WHERE court NOT IN (1,2) AND slot=6;
UPDATE booking set slot=7 WHERE court NOT IN (1,2) AND slot=5;
UPDATE booking set slot=6 WHERE court NOT IN (1,2) AND slot=4;
UPDATE booking set slot=5 WHERE court NOT IN (1,2) AND slot=3;
UPDATE booking set slot=4 WHERE court NOT IN (1,2) AND slot=2;
UPDATE booking set slot=3 WHERE court NOT IN (1,2) AND slot=1;

UPDATE booking_arc set slot=23 WHERE court NOT IN (1,2) AND slot=21;
UPDATE booking_arc set slot=22 WHERE court NOT IN (1,2) AND slot=20;
UPDATE booking_arc set slot=21 WHERE court NOT IN (1,2) AND slot=19;
UPDATE booking_arc set slot=20 WHERE court NOT IN (1,2) AND slot=18;
UPDATE booking_arc set slot=19 WHERE court NOT IN (1,2) AND slot=17;
UPDATE booking_arc set slot=18 WHERE court NOT IN (1,2) AND slot=16;
UPDATE booking_arc set slot=17 WHERE court NOT IN (1,2) AND slot=15;
UPDATE booking_arc set slot=16 WHERE court NOT IN (1,2) AND slot=14;
UPDATE booking_arc set slot=15 WHERE court NOT IN (1,2) AND slot=13;
UPDATE booking_arc set slot=14 WHERE court NOT IN (1,2) AND slot=12;
UPDATE booking_arc set slot=13 WHERE court NOT IN (1,2) AND slot=11;
UPDATE booking_arc set slot=12 WHERE court NOT IN (1,2) AND slot=10;
UPDATE booking_arc set slot=11 WHERE court NOT IN (1,2) AND slot=9;
UPDATE booking_arc set slot=10 WHERE court NOT IN (1,2) AND slot=8;
UPDATE booking_arc set slot=9 WHERE court NOT IN (1,2) AND slot=7;
UPDATE booking_arc set slot=8 WHERE court NOT IN (1,2) AND slot=6;
UPDATE booking_arc set slot=7 WHERE court NOT IN (1,2) AND slot=5;
UPDATE booking_arc set slot=6 WHERE court NOT IN (1,2) AND slot=4;
UPDATE booking_arc set slot=5 WHERE court NOT IN (1,2) AND slot=3;
UPDATE booking_arc set slot=4 WHERE court NOT IN (1,2) AND slot=2;
UPDATE booking_arc set slot=3 WHERE court NOT IN (1,2) AND slot=1;

INSERT INTO slot (court, slot, start_time, duration) VALUES (3,1,'08:00:00',40),(4,1,'08:00:00',40),(5,1,'08:00:00',40),(6,1,'08:00:00',40),(7,1,'08:00:00',40);
INSERT INTO slot (court, slot, start_time, duration) VALUES (3,2,'08:40:00',40),(4,2,'08:40:00',40),(5,2,'08:40:00',40),(6,2,'08:40:00',40),(7,2,'08:40:00',40);

-- --------------------------------------------------------
-- COURTS 3,4,5,6 and 7
-- --------------------------------------------------------



-- --------------------------------------------------------
-- Member Limits
-- --------------------------------------------------------

TRUNCATE TABLE member_limit;

INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',0, '08:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',1, '08:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',2, '08:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',3, '08:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',4, '08:00:00', '17:20:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('J',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',0, '08:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',0, '14:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',1, '08:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',1, '14:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',2, '08:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',2, '14:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',3, '08:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',3, '14:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',4, '08:00:00', '12:00:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',4, '14:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('OP',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',0, '08:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',0, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',1, '08:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',1, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',2, '08:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',2, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',3, '08:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',3, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',4, '08:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',4, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',5, '10:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',5, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',6, '10:00:00', '16:40:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('ST',6, '20:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',0, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',1, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',2, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',3, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',4, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('BG',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',0, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',1, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',2, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',3, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',4, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('F',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',0, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',1, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',2, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',3, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',4, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('I',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',0, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',1, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',2, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',3, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',4, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('O',6, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',0, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',1, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',2, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',3, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',4, '08:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',5, '10:00:00', '22:30:00');
INSERT INTO member_limit (member_type, day, time_start, time_end) VALUES('A',6, '10:00:00', '22:30:00');

-- --------------------------------------------------------
-- End of Member Limits
-- --------------------------------------------------------

