-- --------------------------------------------------------
-- ASRC
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  09-Aug-2007  10157 : Recreated for Unconfirmed bookings.
-- --------------------------------------------------------

ALTER TABLE booking ADD expiry_date DATETIME NULL AFTER status;

DELETE FROM news;
INSERT INTO news VALUES ('2006-02-06 00:00:00', 'You can now choose opponent ''GUEST''', '<p>To distinguish between an unspecified opponent (i.e. when you don''t specify your opponent after booking your court) and a Guest, we have created a GUEST user that you should use when you know you are playing a guest.</p>\r\n\r\n<p>Just type <b>GUEST</b> into either the <u>Member ID</u> or <u>Member Name</u> boxes when asked to search for your opponent, and then click on <u>Guest to the club (GUEST)</u>.\r\n\r\n<p>Coming soon - ability to set/change your opponent <i>after</i> you have made the booking...</p>');
INSERT INTO news VALUES ('2006-04-26 00:00:00', 'At-a-glance Courts View', '<p>A new view has been added to the system so that you can see <i>at a glance</i> all courts that have been booked up to two hours previously, and for the next five hours.</p>\r\n\r\n<p>This view is activated every time you log out, and also as an option to the Administrators.</p>\r\n\r\n<p>Once on the screen, the view will refresh every minute.</p>');
INSERT INTO news VALUES ('2007-06-25 00:00:00', 'Fine Board', '<p>If you are on the "Fine Board" <i>(i.e. you have an outstanding fine(s) on the system)</i> you cannot book any new games, although you can continue to play those you have already booked.</p>\r\n\r\n<p>You can pay your fines at Reception, and they can register them as having been paid within the system.</p>\r\n\r\n<p>The Bookings view now looks very colourful!  Alternate times are highlighted using white/orange and Members are coloured according to their Membership Type.  If you would like to know more about the types, click on ''help''.</p>');
INSERT INTO news VALUES ('2007-08-01 00:00:00', 'Seven Courts Online!', '<p>All Seven Courts are now online.  You can book Courts 1-3 for games on 8th August 2007 onwards.</p>');
INSERT INTO news VALUES ('2007-08-12 00:00:00', 'Out of Hours games', '<p>When you play out of hours games, you will no longer be immediately fined because there is no one to Confirm your game.  Instead, these games will be reviewed the next working day and confirmed against the sheet at Reception.  If there is no record of a confirmation, you will be placed on the Fine Board and you will not be able to book any more games until these fines are paid.</p>');


CREATE TABLE shift (
  member_type char(2) NOT NULL,
  day int(1) NOT NULL,
  start_time time NOT NULL,
  end_time time NOT NULL,
  PRIMARY KEY  (member_type,day)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Shift Hours';

INSERT INTO shift VALUES ('A', 0, '09:00:00', '19:00:00');
INSERT INTO shift VALUES ('A', 1, '09:00:00', '19:00:00');
INSERT INTO shift VALUES ('A', 2, '09:00:00', '19:00:00');
INSERT INTO shift VALUES ('A', 3, '09:00:00', '19:00:00');
INSERT INTO shift VALUES ('A', 4, '09:00:00', '19:00:00');
