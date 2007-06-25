-- --------------------------------------------------------
-- ASRC
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: diff.sql 199 2006-07-14 15:51:13Z craig $
--
-- Who  When         Why
-- CAM  22-Jun-2007  10130 : Diff created.
-- --------------------------------------------------------

INSERT INTO member_type (member_type, type_name, comments1, comments2, valid, limits, disp_order) VALUES 
('Y', 'Unspecified', NULL, NULL, NULL, NULL, '0'), 
('Z', 'Unknown', NULL, NULL, NULL, NULL, '0');


DELETE FROM court;
INSERT INTO court (court, week_cutoff, name, online) VALUES (1, 13, 'One', 1),
(3, 22, 'Three', 1),
(2, 13, 'Two', 1),
(4, 21, 'Four', 1),
(5, 0, 'Five', 1),
(6, 0, 'Six', 1),
(7, 0, 'Seven', 1);


DELETE FROM slot;
INSERT INTO slot VALUES (2, 23, '22:20:00', 40);
INSERT INTO slot VALUES (2, 22, '21:40:00', 40);
INSERT INTO slot VALUES (2, 21, '21:00:00', 40);
INSERT INTO slot VALUES (2, 20, '20:20:00', 40);
INSERT INTO slot VALUES (2, 19, '19:40:00', 40);
INSERT INTO slot VALUES (2, 18, '19:00:00', 40);
INSERT INTO slot VALUES (2, 17, '18:20:00', 40);
INSERT INTO slot VALUES (2, 16, '17:40:00', 40);
INSERT INTO slot VALUES (2, 15, '17:00:00', 40);
INSERT INTO slot VALUES (2, 14, '16:20:00', 40);
INSERT INTO slot VALUES (2, 13, '15:40:00', 40);
INSERT INTO slot VALUES (2, 12, '15:00:00', 40);
INSERT INTO slot VALUES (2, 11, '14:30:00', 30);
INSERT INTO slot VALUES (2, 10, '14:00:00', 30);
INSERT INTO slot VALUES (2, 9, '13:30:00', 30);
INSERT INTO slot VALUES (2, 8, '13:00:00', 30);
INSERT INTO slot VALUES (2, 7, '12:30:00', 30);
INSERT INTO slot VALUES (2, 6, '12:00:00', 30);
INSERT INTO slot VALUES (2, 5, '11:30:00', 30);
INSERT INTO slot VALUES (2, 4, '11:00:00', 40);
INSERT INTO slot VALUES (2, 3, '10:20:00', 40);
INSERT INTO slot VALUES (2, 2, '09:40:00', 40);
INSERT INTO slot VALUES (2, 1, '09:00:00', 40);
INSERT INTO slot VALUES (3, 21, '22:00:00', 40);
INSERT INTO slot VALUES (3, 20, '21:20:00', 40);
INSERT INTO slot VALUES (3, 19, '20:40:00', 40);
INSERT INTO slot VALUES (3, 18, '20:00:00', 40);
INSERT INTO slot VALUES (3, 17, '19:20:00', 40);
INSERT INTO slot VALUES (3, 16, '18:40:00', 40);
INSERT INTO slot VALUES (3, 15, '18:00:00', 40);
INSERT INTO slot VALUES (3, 14, '17:20:00', 40);
INSERT INTO slot VALUES (3, 13, '16:40:00', 40);
INSERT INTO slot VALUES (3, 12, '16:00:00', 40);
INSERT INTO slot VALUES (3, 11, '15:20:00', 40);
INSERT INTO slot VALUES (3, 10, '14:40:00', 40);
INSERT INTO slot VALUES (3, 9, '14:00:00', 40);
INSERT INTO slot VALUES (3, 8, '13:30:00', 30);
INSERT INTO slot VALUES (3, 7, '13:00:00', 30);
INSERT INTO slot VALUES (3, 6, '12:30:00', 30);
INSERT INTO slot VALUES (3, 5, '12:00:00', 30);
INSERT INTO slot VALUES (3, 4, '11:20:00', 40);
INSERT INTO slot VALUES (3, 3, '10:40:00', 40);
INSERT INTO slot VALUES (3, 2, '10:00:00', 40);
INSERT INTO slot VALUES (3, 1, '09:20:00', 40);
INSERT INTO slot VALUES (1, 23, '22:20:00', 40);
INSERT INTO slot VALUES (1, 22, '21:40:00', 40);
INSERT INTO slot VALUES (1, 21, '21:00:00', 40);
INSERT INTO slot VALUES (1, 20, '20:20:00', 40);
INSERT INTO slot VALUES (1, 19, '19:40:00', 40);
INSERT INTO slot VALUES (1, 18, '19:00:00', 40);
INSERT INTO slot VALUES (1, 17, '18:20:00', 40);
INSERT INTO slot VALUES (1, 16, '17:40:00', 40);
INSERT INTO slot VALUES (1, 15, '17:00:00', 40);
INSERT INTO slot VALUES (1, 14, '16:20:00', 40);
INSERT INTO slot VALUES (1, 13, '15:40:00', 40);
INSERT INTO slot VALUES (1, 12, '15:00:00', 40);
INSERT INTO slot VALUES (1, 11, '14:30:00', 30);
INSERT INTO slot VALUES (1, 10, '14:00:00', 30);
INSERT INTO slot VALUES (1, 9, '13:30:00', 30);
INSERT INTO slot VALUES (1, 8, '13:00:00', 30);
INSERT INTO slot VALUES (1, 7, '12:30:00', 30);
INSERT INTO slot VALUES (1, 6, '12:00:00', 30);
INSERT INTO slot VALUES (1, 5, '11:30:00', 30);
INSERT INTO slot VALUES (1, 4, '11:00:00', 40);
INSERT INTO slot VALUES (1, 3, '10:20:00', 40);
INSERT INTO slot VALUES (1, 2, '09:40:00', 40);
INSERT INTO slot VALUES (1, 1, '09:00:00', 40);
INSERT INTO slot VALUES (4, 1, '09:20:00', 40);
INSERT INTO slot VALUES (4, 3, '10:40:00', 40);
INSERT INTO slot VALUES (4, 4, '11:20:00', 40);
INSERT INTO slot VALUES (4, 5, '12:00:00', 30);
INSERT INTO slot VALUES (4, 2, '10:00:00', 40);
INSERT INTO slot VALUES (4, 6, '12:30:00', 30);
INSERT INTO slot VALUES (4, 7, '13:00:00', 30);
INSERT INTO slot VALUES (4, 8, '13:30:00', 30);
INSERT INTO slot VALUES (4, 9, '14:00:00', 40);
INSERT INTO slot VALUES (4, 10, '14:40:00', 40);
INSERT INTO slot VALUES (4, 11, '15:20:00', 40);
INSERT INTO slot VALUES (4, 12, '16:00:00', 40);
INSERT INTO slot VALUES (4, 13, '16:40:00', 40);
INSERT INTO slot VALUES (4, 14, '17:20:00', 40);
INSERT INTO slot VALUES (4, 15, '18:00:00', 40);
INSERT INTO slot VALUES (4, 16, '18:40:00', 40);
INSERT INTO slot VALUES (4, 17, '19:20:00', 40);
INSERT INTO slot VALUES (4, 18, '20:00:00', 40);
INSERT INTO slot VALUES (4, 19, '20:40:00', 40);
INSERT INTO slot VALUES (4, 20, '21:20:00', 40);
INSERT INTO slot VALUES (4, 21, '22:00:00', 40);
INSERT INTO slot VALUES (5, 1, '09:20:00', 40);
INSERT INTO slot VALUES (5, 3, '10:40:00', 40);
INSERT INTO slot VALUES (5, 4, '11:20:00', 40);
INSERT INTO slot VALUES (5, 5, '12:00:00', 30);
INSERT INTO slot VALUES (5, 2, '10:00:00', 40);
INSERT INTO slot VALUES (5, 6, '12:30:00', 30);
INSERT INTO slot VALUES (5, 7, '13:00:00', 30);
INSERT INTO slot VALUES (5, 8, '13:30:00', 30);
INSERT INTO slot VALUES (5, 9, '14:00:00', 40);
INSERT INTO slot VALUES (5, 10, '14:40:00', 40);
INSERT INTO slot VALUES (5, 11, '15:20:00', 40);
INSERT INTO slot VALUES (5, 12, '16:00:00', 40);
INSERT INTO slot VALUES (5, 13, '16:40:00', 40);
INSERT INTO slot VALUES (5, 14, '17:20:00', 40);
INSERT INTO slot VALUES (5, 15, '18:00:00', 40);
INSERT INTO slot VALUES (5, 16, '18:40:00', 40);
INSERT INTO slot VALUES (5, 17, '19:20:00', 40);
INSERT INTO slot VALUES (5, 18, '20:00:00', 40);
INSERT INTO slot VALUES (5, 19, '20:40:00', 40);
INSERT INTO slot VALUES (5, 20, '21:20:00', 40);
INSERT INTO slot VALUES (5, 21, '22:00:00', 40);
INSERT INTO slot VALUES (6, 1, '09:20:00', 40);
INSERT INTO slot VALUES (6, 3, '10:40:00', 40);
INSERT INTO slot VALUES (6, 4, '11:20:00', 40);
INSERT INTO slot VALUES (6, 5, '12:00:00', 40);
INSERT INTO slot VALUES (6, 2, '10:00:00', 40);
INSERT INTO slot VALUES (6, 6, '12:40:00', 40);
INSERT INTO slot VALUES (6, 7, '13:20:00', 40);
INSERT INTO slot VALUES (6, 8, '14:00:00', 40);
INSERT INTO slot VALUES (6, 9, '14:40:00', 40);
INSERT INTO slot VALUES (6, 10, '15:20:00', 40);
INSERT INTO slot VALUES (6, 11, '16:00:00', 40);
INSERT INTO slot VALUES (6, 12, '16:40:00', 40);
INSERT INTO slot VALUES (6, 13, '17:20:00', 40);
INSERT INTO slot VALUES (6, 14, '18:00:00', 40);
INSERT INTO slot VALUES (6, 15, '18:40:00', 40);
INSERT INTO slot VALUES (6, 16, '19:20:00', 40);
INSERT INTO slot VALUES (6, 17, '20:00:00', 40);
INSERT INTO slot VALUES (6, 18, '20:40:00', 40);
INSERT INTO slot VALUES (6, 19, '21:20:00', 40);
INSERT INTO slot VALUES (6, 20, '22:00:00', 40);
INSERT INTO slot VALUES (7, 1, '09:20:00', 40);
INSERT INTO slot VALUES (7, 3, '10:40:00', 40);
INSERT INTO slot VALUES (7, 4, '11:20:00', 40);
INSERT INTO slot VALUES (7, 5, '12:00:00', 40);
INSERT INTO slot VALUES (7, 2, '10:00:00', 40);
INSERT INTO slot VALUES (7, 6, '12:40:00', 40);
INSERT INTO slot VALUES (7, 7, '13:20:00', 40);
INSERT INTO slot VALUES (7, 8, '14:00:00', 40);
INSERT INTO slot VALUES (7, 9, '14:40:00', 40);
INSERT INTO slot VALUES (7, 10, '15:20:00', 40);
INSERT INTO slot VALUES (7, 11, '16:00:00', 40);
INSERT INTO slot VALUES (7, 12, '16:40:00', 40);
INSERT INTO slot VALUES (7, 13, '17:20:00', 40);
INSERT INTO slot VALUES (7, 14, '18:00:00', 40);
INSERT INTO slot VALUES (7, 15, '18:40:00', 40);
INSERT INTO slot VALUES (7, 16, '19:20:00', 40);
INSERT INTO slot VALUES (7, 17, '20:00:00', 40);
INSERT INTO slot VALUES (7, 18, '20:40:00', 40);
INSERT INTO slot VALUES (7, 19, '21:20:00', 40);
INSERT INTO slot VALUES (7, 20, '22:00:00', 40);

