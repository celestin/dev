-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2007,2008 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
-- CAM  11-May-2008  10263 : Added missing tables/columns for development.
-- CAM  18-May-2008  10267 : Added mse_release_history.
-- CAM  28-Mar-2009  10407 : Added member and member_type.
-- --------------------------------------------------------


--
-- Table structure for table mse_article
--

CREATE TABLE mse_article (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page smallint(6) NOT NULL default '0',
  localrow int(4) NOT NULL default '0',
  article varchar(255) default NULL,
  scriptures varchar(255) default NULL,
  bypass tinyint(4) default NULL,
  PRIMARY KEY  (author,vol,page)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_author
--

CREATE TABLE mse_author (
  author char(3) NOT NULL default '',
  name varchar(50) NOT NULL default '',
  PRIMARY KEY  (author)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_book
--

CREATE TABLE mse_bible_book (
  bookid int(11) NOT NULL default '0',
  bookname varchar(255) default NULL,
  testament char(2) default NULL,
  testbook int(11) default NULL,
  singlechap tinyint(4) default NULL,
  firstverse varchar(255) default NULL,
  PRIMARY KEY  (bookid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_ref
--

CREATE TABLE mse_bible_ref (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page int(4) NOT NULL default '0',
  para int(2) NOT NULL default '0',
  ref int(11) NOT NULL default '0',
  bookid int(11) NOT NULL default '0',
  chapter int(11) NOT NULL default '0',
  vstart int(11) NOT NULL default '0',
  vend int(11) NOT NULL default '0',
  PRIMARY KEY  (author,vol,page,para,ref)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_ref_error
--

CREATE TABLE mse_bible_ref_error (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page int(4) NOT NULL default '0',
  para int(2) NOT NULL default '0',
  ref int(11) NOT NULL default '0',
  error_code varchar(200) default NULL,
  text varchar(2000) default NULL,
  PRIMARY KEY  (author,vol,page,para,ref)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_release_history
--

CREATE TABLE mse_release_history (
  release_no varchar(10) NOT NULL,
  task_id varchar(10) NOT NULL,
  description varchar(255) default NULL,
  completion_date datetime default NULL,
  PRIMARY KEY  (release_no,task_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Release History';

-- --------------------------------------------------------

--
-- Table structure for table mse_text
--

CREATE TABLE mse_text (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page int(4) NOT NULL default '0',
  para int(2) NOT NULL default '0',
  localrow int(4) NOT NULL default '0',
  article_page int(4) NOT NULL default '0',
  inits varchar(20) default NULL,
  text longtext NOT NULL,
  newpages varchar(100) default NULL,
  PRIMARY KEY  (author,vol,page,para),
  KEY inits (inits),
  FULLTEXT KEY ft (text)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_volume
--

CREATE TABLE mse_volume (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  title varchar(255) default NULL,
  added datetime default NULL,
  localfile varchar(255) NOT NULL default '',
  PRIMARY KEY  (author,vol)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Dumping data for table mse_author
--

INSERT INTO mse_author (author, name) VALUES
('CAC', 'C. A. Coates'),
('FER', 'F. E. Raven'),
('JBS', 'J. B. Stoney'),
('JND', 'J. N. Darby'),
('JT', 'J. Taylor, Snr');

-- --------------------------------------------------------

--
-- Dumping data for table mse_bible_book
--

INSERT INTO mse_bible_book (bookid, bookname, testament, testbook, singlechap, firstverse) VALUES
(1, 'Genesis', 'OT', 1, NULL, 'In the beginning God created the heavens and the earth.'),
(2, 'Exodus', 'OT', 2, NULL, 'And these are the names of the sons of Israel who had come into Egypt; with Jacob had they come, each with his household:'),
(3, 'Leviticus', 'OT', 3, NULL, 'And Jehovah called to Moses and spoke to him out of the tent of meeting, saying,'),
(4, 'Numbers', 'OT', 4, NULL, 'And Jehovah spoke to Moses in the wilderness of Sinai in the tent of meeting, on the first of the second month, in the second year after their departure from the land of Egypt, saying,'),
(5, 'Deuteronomy', 'OT', 5, NULL, 'These are the words which Moses spoke to all Israel on this side the Jordan, in the wilderness, in the plain, opposite to Suph, between Paran and Tophel, Laban, Hazeroth, and Dizahab.'),
(6, 'Joshua', 'OT', 6, NULL, 'And it came to pass after the death of Moses the servant of Jehovah, that Jehovah spoke to Joshua the son of Nun, Moses'' attendant, saying,'),
(7, 'Judges', 'OT', 7, NULL, 'After the death of Joshua the people of Israel inquired of the LORD, "Who shall go up first for us against the Canaanites, to fight against them?"'),
(8, 'Ruth', 'OT', 8, NULL, 'And it came to pass in the days when the judges ruled, that there was a famine in the land. And a certain man went from Bethlehem-Judah, to sojourn in the country of Moab, he, and his wife, and his two sons.'),
(9, '1 Samuel', 'OT', 9, NULL, 'And there was a certain man of Ramathaim-zophim, of mount Ephraim, and his name was Elkanah, the son of Jeroham, the son of Elihu, the son of Tohu, the son of Zuph, an Ephrathite.'),
(10, '2 Samuel', 'OT', 10, NULL, 'And it came to pass after the death of Saul, when David had returned from the slaughter of the Amalekites, that David abode two days in Ziklag.'),
(11, '1 Kings', 'OT', 11, NULL, 'And king David was old [and] advanced in age; and they covered him with clothes, but he obtained no warmth.'),
(12, '2 Kings', 'OT', 12, NULL, 'And Moab rebelled against Israel after the death of Ahab.'),
(13, '1 Chronicles', 'OT', 13, NULL, 'Adam, Seth, Enosh,'),
(14, '2 Chronicles', 'OT', 14, NULL, 'And Solomon the son of David was strengthened in his kingdom, and Jehovah his God was with him and magnified him exceedingly.'),
(15, 'Ezra', 'OT', 15, NULL, 'And in the first year of Cyrus king of Persia, that the word of Jehovah by the mouth of Jeremiah might be accomplished, Jehovah stirred up the spirit of Cyrus king of Persia, and he made a proclamation throughout his kingdom, and also in writing, saying,'),
(16, 'Nehemiah', 'OT', 16, NULL, 'The words of Nehemiah the son of Hachaliah. And it came to pass in the month Chislev, in the twentieth year, as I was in Shushan the fortress,'),
(17, 'Esther', 'OT', 17, NULL, 'And it came to pass in the days of Ahasuerus (that is, the Ahasuerus that reigned from India even to Ethiopia, over a hundred and twenty-seven provinces),'),
(18, 'Job', 'OT', 18, NULL, 'There was a man in the land of Uz whose name was Job; and this man was perfect and upright, and one that feared God and abstained from evil.'),
(19, 'Psalm', 'OT', 19, NULL, 'Blessed is the man that walketh not in the counsel of the wicked, and standeth not in the way of sinners, and sitteth not in the seat of scorners;'),
(20, 'Proverbs', 'OT', 20, NULL, 'Proverbs of Solomon, son of David, king of Israel:'),
(21, 'Ecclesiastes', 'OT', 21, NULL, 'The words of the Preacher, the son of David, king in Jerusalem.'),
(22, 'Song of Songs', 'OT', 22, NULL, 'The song of songs, which is Solomon''s.'),
(23, 'Isaiah', 'OT', 23, NULL, 'The vision of Isaiah the son of Amos, which he saw concerning Judah and Jerusalem in the days of Uzziah, Jotham, Ahaz, Hezekiah, kings of Judah.'),
(24, 'Jeremiah', 'OT', 24, NULL, 'The words of Jeremiah the son of Hilkijah, of the priests that were in Anathoth in the land of Benjamin:'),
(25, 'Lamentations', 'OT', 25, NULL, 'How doth the city sit solitary [that] was full of people! She that was great among the nations is become as a widow; the princess among the provinces is become tributary!'),
(26, 'Ezekiel', 'OT', 26, NULL, 'Now it came to pass in the thirtieth year, in the fourth [month], on the fifth of the month, as I was among the captives by the river Chebar, the heavens were opened, and I saw visions of God.'),
(27, 'Daniel', 'OT', 27, NULL, 'In the third year of the reign of Jehoiakim king of Judah came Nebuchadnezzar king of Babylon unto Jerusalem, and besieged it.'),
(28, 'Hosea', 'OT', 28, NULL, 'The word of Jehovah that came unto Hosea, the son of Beeri, in the days of Uzziah, Jotham, Ahaz, Hezekiah, kings of Judah, and in the days of Jeroboam the son of Joash, king of Israel.'),
(29, 'Joel', 'OT', 29, NULL, 'The word of Jehovah that came to Joel the son of Pethuel.'),
(30, 'Amos', 'OT', 30, NULL, 'The words of Amos, who was among the herdmen of Tekoa, which he saw concerning Israel in the days of Uzziah king of Judah, and in the days of Jeroboam the son of Joash, king of Israel, two years before the earthquake.'),
(31, 'Obadiah', 'OT', 31, 1, 'The vision of Obadiah. Thus saith the Lord Jehovah concerning Edom: We have heard a report from Jehovah, and an ambassador is sent among the nations. Arise ye, and let us rise up against her in battle.'),
(32, 'Jonah', 'OT', 32, NULL, 'And the word of Jehovah came unto Jonah the son of Amittai, saying,'),
(33, 'Micah', 'OT', 33, NULL, 'The word of Jehovah that came to Micah the Morasthite in the days of Jotham, Ahaz, [and] Hezekiah, kings of Judah, which he saw concerning Samaria and Jerusalem.'),
(34, 'Nahum', 'OT', 34, NULL, 'The burden of Nineveh. The book of the vision of Nahum the Elkoshite.'),
(35, 'Habakkuk', 'OT', 35, NULL, 'The burden which Habakkuk the prophet did see.'),
(36, 'Zephaniah', 'OT', 36, NULL, 'The word of Jehovah that came unto Zephaniah the son of Cushi, the son of Gedaliah, the son of Amariah, the son of Hezekiah, in the days of Josiah the son of Amon, king of Judah.'),
(37, 'Haggai', 'OT', 37, NULL, 'In the second year of Darius the king, in the sixth month, on the first day of the month, came the word of Jehovah by the prophet Haggai unto Zerubbabel the son of Shealtiel, governor of Judah, and to Joshua the son of Jehozadak, the high priest, saying,'),
(38, 'Zechariah', 'OT', 38, NULL, 'In the eighth month, in the second year of Darius, came the word of Jehovah unto Zechariah the prophet, the son of Berechiah, the son of Iddo, saying,'),
(39, 'Malachi', 'OT', 39, NULL, 'The burden of the word of Jehovah to Israel by Malachi.'),
(40, 'Matthew', 'NT', 1, NULL, 'Book of the generation of Jesus Christ, Son of David, Son of Abraham.'),
(41, 'Mark', 'NT', 2, NULL, 'Beginning of the glad tidings of Jesus Christ, Son of God;'),
(42, 'Luke', 'NT', 3, NULL, 'Forasmuch as many have undertaken to draw up a relation concerning the matters fully believed among us,'),
(43, 'John', 'NT', 3, NULL, 'In [the] beginning was the Word, and the Word was with God, and the Word was God.'),
(44, 'Acts', 'NT', 4, NULL, 'I composed the first discourse, O Theophilus, concerning all things which Jesus began both to do and to teach,'),
(45, 'Romans', 'NT', 5, NULL, 'Paul, bondman of Jesus Christ, [a] called apostle, separated to God''s glad tidings,'),
(46, '1 Corinthians', 'NT', 6, NULL, 'Paul, [a] called apostle of Jesus Christ, by God''s will, and Sosthenes the brother,'),
(47, '2 Corinthians', 'NT', 7, NULL, 'Paul, apostle of Jesus Christ by God''s will, and the brother Timotheus, to the assembly of God which is in Corinth, with all the saints who are in the whole of Achaia.'),
(48, 'Galatians', 'NT', 8, NULL, 'Paul, apostle, not from men nor through man, but through Jesus Christ, and God [the] Father who raised him from among [the] dead,'),
(49, 'Ephesians', 'NT', 9, NULL, 'Paul, apostle of Jesus Christ by God''s will, to the saints and faithful in Christ Jesus who are at Ephesus.'),
(50, 'Philippians', 'NT', 10, NULL, 'Paul and Timotheus, bondmen of Jesus Christ, to all the saints in Christ Jesus who are in Philippi, with [the] overseers and ministers;'),
(51, 'Colossians', 'NT', 11, NULL, 'Paul, apostle of Christ Jesus, by God''s will, and Timotheus the brother,'),
(52, '1 Thessalonians', 'NT', 12, NULL, 'Paul and Silvanus and Timotheus to the assembly of Thessalonians in God [the] Father and [the] Lord Jesus Christ. Grace to you and peace.'),
(53, '2 Thessalonians', 'NT', 13, NULL, 'Paul and Silvanus and Timotheus to the assembly of Thessalonians in God our Father and [the] Lord Jesus Christ.'),
(54, '1 Timothy', 'NT', 14, NULL, 'Paul, apostle of Jesus Christ, according to [the] command of God our Saviour, and of Christ Jesus our hope,'),
(55, '2 Timothy', 'NT', 15, NULL, 'Paul, apostle of Jesus Christ by God''s will, according to promise of life, the [life] which [is] in Christ Jesus,'),
(56, 'Titus', 'NT', 16, NULL, 'Paul, bondman of God, and apostle of Jesus Christ according to [the] faith of God''s elect, and knowledge of [the] truth which [is] according to piety;'),
(57, 'Philemon', 'NT', 17, 1, 'Paul, prisoner of Christ Jesus, and Timotheus the brother, to Philemon the beloved and our fellow-workman,'),
(58, 'Hebrews', 'NT', 18, NULL, 'God having spoken in many parts and in many ways formerly to the fathers in the prophets,'),
(59, 'James', 'NT', 19, NULL, 'James, bondman of God and of [the] Lord Jesus Christ, to the twelve tribes which [are] in the dispersion, greeting.'),
(60, '1 Peter', 'NT', 20, NULL, 'Peter, apostle of Jesus Christ, to [the] sojourners of [the] dispersion of Pontus, Galatia, Cappadocia, Asia, and Bithynia,'),
(61, '2 Peter', 'NT', 21, NULL, 'Simon Peter, bondman and apostle of Jesus Christ, to them that have received like precious faith with us through [the] righteousness of our God and Saviour Jesus Christ:'),
(62, '1 John', 'NT', 22, NULL, 'That which was from [the] beginning, that which we have heard, which we have seen with our eyes; that which we contemplated, and our hands handled, concerning the word of life;'),
(63, '2 John', 'NT', 23, 1, 'The elder to [the] elect lady and her children, whom *I* love in truth, and not *I* only but also all who have known the truth,'),
(64, '3 John', 'NT', 24, 1, 'The elder to the beloved Gaius, whom I love in truth.'),
(65, 'Jude', 'NT', 25, 1, 'Jude, bondman of Jesus Christ, and brother of James, to the called ones beloved in God [the] Father and preserved in Jesus Christ:'),
(66, 'Revelation', 'NT', 26, NULL, 'Revelation of Jesus Christ, which God gave to him, to shew to his bondmen what must shortly take place; and he signified [it], sending by his angel, to his bondman John,');

-- --------------------------------------------------------

--
-- Dumping data for table mse_volume
--

INSERT INTO mse_volume VALUES ('CAC', 1, 'Volume 1 - An Outline of Genesis', '2007-10-22 17:11:24', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac1.doc');
INSERT INTO mse_volume VALUES ('CAC', 2, 'Volume 2 - An Outline of Exodus\r\n', '2007-10-22 17:11:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac2.doc');
INSERT INTO mse_volume VALUES ('CAC', 3, 'Volume 3 - An Outline of Leviticus\r\n', '2007-10-22 17:11:28', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac3.doc');
INSERT INTO mse_volume VALUES ('CAC', 4, 'Volume 4 - An Outline of the Book of Numbers\r\n', '2007-10-22 17:11:30', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac4.doc');
INSERT INTO mse_volume VALUES ('CAC', 5, 'Volume 5 - An Outline of the Book of Deuteronomy\r\n', '2007-10-22 17:11:33', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac5.doc');
INSERT INTO mse_volume VALUES ('CAC', 6, 'Volume 6 - An Outline of Joshua, Judges and Ruth\r\n', '2007-10-22 17:11:36', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac6.doc');
INSERT INTO mse_volume VALUES ('CAC', 7, 'Volume 7 - An Outline of The Song of Songs\r\n', '2007-10-22 17:11:39', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac7.doc');
INSERT INTO mse_volume VALUES ('CAC', 8, 'Volume 8 - Outline of the Minor Prophets\r\n', '2007-10-22 17:11:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac8.doc');
INSERT INTO mse_volume VALUES ('CAC', 9, '', '2007-10-22 17:11:41', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac9.doc');
INSERT INTO mse_volume VALUES ('CAC', 10, '', '2007-10-22 17:11:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac10.doc');
INSERT INTO mse_volume VALUES ('CAC', 11, 'Volume 11 - An Outline of Romans\r\n', '2007-10-22 17:11:48', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac11.doc');
INSERT INTO mse_volume VALUES ('CAC', 12, 'Volume 12 - An Outline of the Epistle of James\r\n', '2007-10-22 17:11:51', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac12.doc');
INSERT INTO mse_volume VALUES ('CAC', 13, 'Volume 13 - An Outline of "The Revelation"\r\n', '2007-10-22 17:11:54', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac13.doc');
INSERT INTO mse_volume VALUES ('CAC', 14, 'Volume 14 - The True Grace of God\r\n', '2007-10-22 17:11:56', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac14.doc');
INSERT INTO mse_volume VALUES ('CAC', 15, 'Volume 15 - The Believer Established\r\n', '2007-10-22 17:11:59', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac15.doc');
INSERT INTO mse_volume VALUES ('CAC', 16, 'Volume 16 - Favour and Freedom\r\n', '2007-10-22 17:12:02', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac16.doc');
INSERT INTO mse_volume VALUES ('CAC', 17, 'Volume 17 - The Food of Life\r\n', '2007-10-22 17:12:03', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac17.doc');
INSERT INTO mse_volume VALUES ('CAC', 18, 'Volume 18 - The House of God\r\n', '2007-10-22 17:12:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac18.doc');
INSERT INTO mse_volume VALUES ('CAC', 19, 'Volume 19 - The Paths of Life\r\n', '2007-10-22 17:12:05', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac19.doc');
INSERT INTO mse_volume VALUES ('CAC', 20, 'Volume 20 - Spiritual Blessings\r\n', '2007-10-22 17:12:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac20.doc');
INSERT INTO mse_volume VALUES ('CAC', 21, 'Volume 21 - A Sure Foundation\r\n', '2007-10-22 17:12:09', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac21.doc');
INSERT INTO mse_volume VALUES ('CAC', 22, 'Volume 22 - Letters of C.A. Coates\r\n', '2007-10-22 17:12:10', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac22.doc');
INSERT INTO mse_volume VALUES ('CAC', 23, 'Volume 23 - An Outline of the Epistle to the Hebrews\r\n', '2007-10-22 17:12:14', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac23.doc');
INSERT INTO mse_volume VALUES ('CAC', 24, '', '2007-10-22 17:12:16', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac24.doc');
INSERT INTO mse_volume VALUES ('CAC', 25, 'Volume 25 - Outlines of the Epistles of Paul to the Corinthians\r\n', '2007-10-22 17:12:16', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac25.doc');
INSERT INTO mse_volume VALUES ('CAC', 26, 'Volume 26 - Outline of Ephesians\r\n', '2007-10-22 17:12:19', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac26.doc');
INSERT INTO mse_volume VALUES ('CAC', 27, 'Volume 27 - Outlines of Samuel, Kings and the Chronicles\r\n', '2007-10-22 17:12:20', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac27.doc');
INSERT INTO mse_volume VALUES ('CAC', 28, '', '2007-10-22 17:12:22', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac28.doc');
INSERT INTO mse_volume VALUES ('CAC', 29, '', '2007-10-22 17:12:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac29.doc');
INSERT INTO mse_volume VALUES ('CAC', 30, 'Volume 30 - Miscellaneous Ministry on the Old Testament\r\n', '2007-10-22 17:12:26', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac30.doc');
INSERT INTO mse_volume VALUES ('CAC', 31, 'Volume 31 - Miscellaneous Ministry on the New Testament Matthew-Romans\r\n', '2007-10-22 17:12:30', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac31.doc');
INSERT INTO mse_volume VALUES ('CAC', 32, 'Volume 32 - Miscellaneous Ministry on the New Testament Corinthians-Colossians\r\n', '2007-10-22 17:12:34', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac32.doc');
INSERT INTO mse_volume VALUES ('CAC', 33, 'Volume 33 - Miscellaneous Ministry on the New Testament Thessalonians-Revelation\r\n', '2007-10-22 17:12:39', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac33.doc');
INSERT INTO mse_volume VALUES ('CAC', 34, 'Volume 34 - Words in Season\r\n', '2007-10-22 17:12:43', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac34.doc');
INSERT INTO mse_volume VALUES ('CAC', 35, 'Volume 27a - Outlines of the Books of the Chronicles\r\n', '2007-10-22 17:12:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac35.doc');
INSERT INTO mse_volume VALUES ('CAC', 36, 'Remarks on a pamphlet by A. J. Pollock entitled "The Eternal Son"\r\n', '2007-10-22 17:12:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac36.doc');
INSERT INTO mse_volume VALUES ('CAC', 37, 'A Message for You\r\n', '2007-10-22 17:12:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac37.doc');
INSERT INTO mse_volume VALUES ('FER', 1, '', '2007-10-22 17:12:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer1.doc');
INSERT INTO mse_volume VALUES ('FER', 2, '', '2007-10-22 17:12:51', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer2.doc');
INSERT INTO mse_volume VALUES ('FER', 3, '', '2007-10-22 17:12:55', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer3.doc');
INSERT INTO mse_volume VALUES ('FER', 4, '', '2007-10-22 17:12:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer4.doc');
INSERT INTO mse_volume VALUES ('FER', 5, '', '2007-10-22 17:13:01', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer5.doc');
INSERT INTO mse_volume VALUES ('FER', 6, '', '2007-10-22 17:13:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer6.doc');
INSERT INTO mse_volume VALUES ('FER', 7, '', '2007-10-22 17:13:07', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer7.doc');
INSERT INTO mse_volume VALUES ('FER', 8, '', '2007-10-22 17:13:10', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer8.doc');
INSERT INTO mse_volume VALUES ('FER', 9, '', '2007-10-22 17:13:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer9.doc');
INSERT INTO mse_volume VALUES ('FER', 10, '', '2007-10-22 17:13:16', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer10.doc');
INSERT INTO mse_volume VALUES ('FER', 11, '', '2007-10-22 17:13:20', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer11.doc');
INSERT INTO mse_volume VALUES ('FER', 12, '', '2007-10-22 17:13:23', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer12.doc');
INSERT INTO mse_volume VALUES ('FER', 13, '', '2007-10-22 17:13:26', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer13.doc');
INSERT INTO mse_volume VALUES ('FER', 14, '', '2007-10-22 17:13:28', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer14.doc');
INSERT INTO mse_volume VALUES ('FER', 15, '', '2007-10-22 17:13:32', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer15.doc');
INSERT INTO mse_volume VALUES ('FER', 16, '', '2007-10-22 17:13:35', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer16.doc');
INSERT INTO mse_volume VALUES ('FER', 17, '', '2007-10-22 17:13:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer17.doc');
INSERT INTO mse_volume VALUES ('FER', 18, '', '2007-10-22 17:13:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer18.doc');
INSERT INTO mse_volume VALUES ('FER', 19, '', '2007-10-22 17:13:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer19.doc');
INSERT INTO mse_volume VALUES ('FER', 20, '', '2007-10-22 17:13:44', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer20.doc');
INSERT INTO mse_volume VALUES ('FER', 21, 'Letters\r\n', '2007-10-22 17:13:45', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer21.doc');
INSERT INTO mse_volume VALUES ('JBS', 1, '', '2007-10-22 17:13:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs1.doc');
INSERT INTO mse_volume VALUES ('JBS', 2, '', '2007-10-22 17:13:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs2.doc');
INSERT INTO mse_volume VALUES ('JBS', 3, '', '2007-10-22 17:13:56', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs3.doc');
INSERT INTO mse_volume VALUES ('JBS', 4, '', '2007-10-22 17:13:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs4.doc');
INSERT INTO mse_volume VALUES ('JBS', 5, '', '2007-10-22 17:14:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs5.doc');
INSERT INTO mse_volume VALUES ('JBS', 6, '', '2007-10-22 17:14:03', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs6.doc');
INSERT INTO mse_volume VALUES ('JBS', 7, '', '2007-10-22 17:14:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs7.doc');
INSERT INTO mse_volume VALUES ('JBS', 8, '', '2007-10-22 17:14:09', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs8.doc');
INSERT INTO mse_volume VALUES ('JBS', 9, '', '2007-10-22 17:14:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs9.doc');
INSERT INTO mse_volume VALUES ('JBS', 10, '', '2007-10-22 17:14:15', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs10.doc');
INSERT INTO mse_volume VALUES ('JBS', 11, '', '2007-10-22 17:14:17', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs11.doc');
INSERT INTO mse_volume VALUES ('JBS', 12, '', '2007-10-22 17:14:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs12.doc');
INSERT INTO mse_volume VALUES ('JBS', 13, '', '2007-10-22 17:14:24', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs13.doc');
INSERT INTO mse_volume VALUES ('JBS', 14, 'Letters 1\r\n', '2007-10-22 17:14:27', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs14.doc');
INSERT INTO mse_volume VALUES ('JBS', 15, 'Letters 2\r\n', '2007-10-22 17:14:29', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs15.doc');
INSERT INTO mse_volume VALUES ('JBS', 16, 'Letters 3\r\n', '2007-10-22 17:14:33', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs16.doc');
INSERT INTO mse_volume VALUES ('JBS', 17, 'From Glory to Glory\r\n', '2007-10-22 17:14:36', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs17.doc');
INSERT INTO mse_volume VALUES ('JT', 1, '', '2007-10-22 17:14:37', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt1.doc');
INSERT INTO mse_volume VALUES ('JT', 2, '', '2007-10-22 17:14:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt2.doc');
INSERT INTO mse_volume VALUES ('JT', 3, '', '2007-10-22 17:14:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt3.doc');
INSERT INTO mse_volume VALUES ('JT', 4, '', '2007-10-22 17:14:54', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt4.doc');
INSERT INTO mse_volume VALUES ('JT', 5, '', '2007-10-22 17:20:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt5.doc');
INSERT INTO mse_volume VALUES ('JT', 6, '', '2007-10-22 17:20:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt6.doc');
INSERT INTO mse_volume VALUES ('JT', 7, '', '2007-10-22 17:20:17', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt7.doc');
INSERT INTO mse_volume VALUES ('JT', 8, '', '2007-10-22 17:20:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt8.doc');
INSERT INTO mse_volume VALUES ('JT', 9, '', '2007-10-22 17:20:28', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt9.doc');
INSERT INTO mse_volume VALUES ('JT', 10, '', '2007-10-22 17:14:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt10.doc');
INSERT INTO mse_volume VALUES ('JT', 11, '', '2007-10-22 17:15:02', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt11.doc');
INSERT INTO mse_volume VALUES ('JT', 12, '', '2007-10-22 17:15:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt12.doc');
INSERT INTO mse_volume VALUES ('JT', 13, '', '2007-10-22 17:15:07', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt13.doc');
INSERT INTO mse_volume VALUES ('JT', 14, '', '2007-10-22 17:15:14', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt14.doc');
INSERT INTO mse_volume VALUES ('JT', 15, '', '2007-10-22 17:15:17', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt15.doc');
INSERT INTO mse_volume VALUES ('JT', 16, '', '2007-10-22 17:15:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt16.doc');
INSERT INTO mse_volume VALUES ('JT', 17, '', '2007-10-22 17:15:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt17.doc');
INSERT INTO mse_volume VALUES ('JT', 18, '', '2007-10-22 17:15:31', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt18.doc');
INSERT INTO mse_volume VALUES ('JT', 19, '', '2007-10-22 17:15:34', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt19.doc');
INSERT INTO mse_volume VALUES ('JT', 20, '', '2007-10-22 17:15:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt20.doc');
INSERT INTO mse_volume VALUES ('JT', 21, '', '2007-10-22 17:15:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt21.doc');
INSERT INTO mse_volume VALUES ('JT', 22, '', '2007-10-22 17:15:44', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt22.doc');
INSERT INTO mse_volume VALUES ('JT', 23, '', '2007-10-22 17:15:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt23.doc');
INSERT INTO mse_volume VALUES ('JT', 24, '', '2007-10-22 17:15:50', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt24.doc');
INSERT INTO mse_volume VALUES ('JT', 25, '', '2007-10-22 17:15:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt25.doc');
INSERT INTO mse_volume VALUES ('JT', 26, '', '2007-10-22 17:15:56', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt26.doc');
INSERT INTO mse_volume VALUES ('JT', 27, '', '2007-10-22 17:15:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt27.doc');
INSERT INTO mse_volume VALUES ('JT', 28, '', '2007-10-22 17:16:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt28.doc');
INSERT INTO mse_volume VALUES ('JT', 29, '', '2007-10-22 17:16:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt29.doc');
INSERT INTO mse_volume VALUES ('JT', 30, '', '2007-10-22 17:16:09', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt30.doc');
INSERT INTO mse_volume VALUES ('JT', 31, '', '2007-10-22 17:16:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt31.doc');
INSERT INTO mse_volume VALUES ('JT', 32, '', '2007-10-22 17:16:16', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt32.doc');
INSERT INTO mse_volume VALUES ('JT', 33, '', '2007-10-22 17:16:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt33.doc');
INSERT INTO mse_volume VALUES ('JT', 34, '', '2007-10-22 17:16:27', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt34.doc');
INSERT INTO mse_volume VALUES ('JT', 35, '', '2007-10-22 17:16:31', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt35.doc');
INSERT INTO mse_volume VALUES ('JT', 36, '', '2007-10-22 17:16:34', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt36.doc');
INSERT INTO mse_volume VALUES ('JT', 37, '', '2007-10-22 17:16:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt37.doc');
INSERT INTO mse_volume VALUES ('JT', 38, '', '2007-10-22 17:16:44', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt38.doc');
INSERT INTO mse_volume VALUES ('JT', 39, '', '2007-10-22 17:16:47', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt39.doc');
INSERT INTO mse_volume VALUES ('JT', 40, '', '2007-10-22 17:16:51', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt40.doc');
INSERT INTO mse_volume VALUES ('JT', 41, '', '2007-10-22 17:16:54', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt41.doc');
INSERT INTO mse_volume VALUES ('JT', 42, '', '2007-10-22 17:16:57', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt42.doc');
INSERT INTO mse_volume VALUES ('JT', 43, '', '2007-10-22 17:17:02', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt43.doc');
INSERT INTO mse_volume VALUES ('JT', 44, '', '2007-10-22 17:17:05', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt44.doc');
INSERT INTO mse_volume VALUES ('JT', 45, '', '2007-10-22 17:17:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt45.doc');
INSERT INTO mse_volume VALUES ('JT', 46, '', '2007-10-22 17:17:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt46.doc');
INSERT INTO mse_volume VALUES ('JT', 47, '', '2007-10-22 17:17:15', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt47.doc');
INSERT INTO mse_volume VALUES ('JT', 48, '', '2007-10-22 17:17:19', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt48.doc');
INSERT INTO mse_volume VALUES ('JT', 49, '', '2007-10-22 17:17:22', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt49.doc');
INSERT INTO mse_volume VALUES ('JT', 50, '', '2007-10-22 17:17:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt50.doc');
INSERT INTO mse_volume VALUES ('JT', 51, '', '2007-10-22 17:17:29', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt51.doc');
INSERT INTO mse_volume VALUES ('JT', 52, '', '2007-10-22 17:17:32', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt52.doc');
INSERT INTO mse_volume VALUES ('JT', 53, '', '2007-10-22 17:17:36', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt53.doc');
INSERT INTO mse_volume VALUES ('JT', 54, '', '2007-10-22 17:17:39', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt54.doc');
INSERT INTO mse_volume VALUES ('JT', 55, '', '2007-10-22 17:17:44', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt55.doc');
INSERT INTO mse_volume VALUES ('JT', 56, '', '2007-10-22 17:17:47', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt56.doc');
INSERT INTO mse_volume VALUES ('JT', 57, '', '2007-10-22 17:17:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt57.doc');
INSERT INTO mse_volume VALUES ('JT', 58, '', '2007-10-22 17:17:55', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt58.doc');
INSERT INTO mse_volume VALUES ('JT', 59, '', '2007-10-22 17:17:59', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt59.doc');
INSERT INTO mse_volume VALUES ('JT', 60, '', '2007-10-22 17:18:01', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt60.doc');
INSERT INTO mse_volume VALUES ('JT', 61, '', '2007-10-22 17:18:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt61.doc');
INSERT INTO mse_volume VALUES ('JT', 62, '', '2007-10-22 17:18:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt62.doc');
INSERT INTO mse_volume VALUES ('JT', 63, '', '2007-10-22 17:18:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt63.doc');
INSERT INTO mse_volume VALUES ('JT', 64, '', '2007-10-22 17:18:15', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt64.doc');
INSERT INTO mse_volume VALUES ('JT', 65, '', '2007-10-22 17:18:19', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt65.doc');
INSERT INTO mse_volume VALUES ('JT', 66, '', '2007-10-22 17:18:23', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt66.doc');
INSERT INTO mse_volume VALUES ('JT', 67, '', '2007-10-22 17:18:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt67.doc');
INSERT INTO mse_volume VALUES ('JT', 68, '', '2007-10-22 17:18:31', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt68.doc');
INSERT INTO mse_volume VALUES ('JT', 69, '', '2007-10-22 17:18:35', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt69.doc');
INSERT INTO mse_volume VALUES ('JT', 70, '', '2007-10-22 17:18:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt70.doc');
INSERT INTO mse_volume VALUES ('JT', 71, '', '2007-10-22 17:18:42', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt71.doc');
INSERT INTO mse_volume VALUES ('JT', 72, '', '2007-10-22 17:18:50', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt72.doc');
INSERT INTO mse_volume VALUES ('JT', 73, '', '2007-10-22 17:18:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt73.doc');
INSERT INTO mse_volume VALUES ('JT', 74, '', '2007-10-22 17:18:54', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt74.doc');
INSERT INTO mse_volume VALUES ('JT', 75, '', '2007-10-22 17:18:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt75.doc');
INSERT INTO mse_volume VALUES ('JT', 76, '', '2007-10-22 17:19:01', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt76.doc');
INSERT INTO mse_volume VALUES ('JT', 77, '', '2007-10-22 17:19:05', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt77.doc');
INSERT INTO mse_volume VALUES ('JT', 78, '', '2007-10-22 17:19:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt78.doc');
INSERT INTO mse_volume VALUES ('JT', 79, '', '2007-10-22 17:19:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt79.doc');
INSERT INTO mse_volume VALUES ('JT', 80, '', '2007-10-22 17:19:15', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt80.doc');
INSERT INTO mse_volume VALUES ('JT', 81, '', '2007-10-22 17:19:19', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt81.doc');
INSERT INTO mse_volume VALUES ('JT', 82, '', '2007-10-22 17:19:23', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt82.doc');
INSERT INTO mse_volume VALUES ('JT', 83, '', '2007-10-22 17:19:26', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt83.doc');
INSERT INTO mse_volume VALUES ('JT', 84, '', '2007-10-22 17:20:37', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt84.doc');
INSERT INTO mse_volume VALUES ('JT', 85, '', '2007-10-22 17:19:30', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt85.doc');
INSERT INTO mse_volume VALUES ('JT', 86, '', '2007-10-22 17:20:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt86.doc');
INSERT INTO mse_volume VALUES ('JT', 87, '', '2007-10-22 17:20:43', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt87.doc');
INSERT INTO mse_volume VALUES ('JT', 88, '', '2007-10-22 17:20:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt88.doc');
INSERT INTO mse_volume VALUES ('JT', 89, '', '2007-10-22 17:20:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt89.doc');
INSERT INTO mse_volume VALUES ('JT', 90, '', '2007-10-22 17:20:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt90.doc');
INSERT INTO mse_volume VALUES ('JT', 91, '', '2007-10-22 17:20:57', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt91.doc');
INSERT INTO mse_volume VALUES ('JT', 92, '', '2007-10-22 17:21:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt92.doc');
INSERT INTO mse_volume VALUES ('JT', 93, '', '2007-10-22 17:21:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt93.doc');
INSERT INTO mse_volume VALUES ('JT', 94, '', '2007-10-22 17:21:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt94.doc');
INSERT INTO mse_volume VALUES ('JT', 95, '', '2007-10-22 17:21:14', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt95.doc');
INSERT INTO mse_volume VALUES ('JT', 96, '', '2007-10-22 17:21:17', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt96.doc');
INSERT INTO mse_volume VALUES ('JT', 97, '', '2007-10-22 17:21:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt97.doc');
INSERT INTO mse_volume VALUES ('JT', 98, '', '2007-10-22 17:21:24', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt98.doc');
INSERT INTO mse_volume VALUES ('JT', 99, '', '2007-10-22 17:21:29', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt99.doc');
INSERT INTO mse_volume VALUES ('JT', 100, '', '2007-10-22 17:19:34', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt100.doc');
INSERT INTO mse_volume VALUES ('JT', 101, 'Volume 100a\r\n', '2007-10-22 17:19:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt101.doc');
INSERT INTO mse_volume VALUES ('JT', 102, 'Letters - Volume 1\r\n', '2007-10-22 17:19:39', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt102.doc');
INSERT INTO mse_volume VALUES ('JT', 103, 'Letters - Volume 2\r\n', '2007-10-22 17:19:45', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt103.doc');
INSERT INTO mse_volume VALUES ('JND', 1, 'Ecclesiastical No. 1 - Vol 1', NULL, 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd_001.doc');
INSERT INTO mse_volume VALUES ('JND', 2, 'Prophetic No. 1 - Vol 2', NULL, 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd_002.doc');

--
-- Dumping data for table mse_release_history
--

INSERT INTO mse_release_history VALUES ('V0.04A', '10202', 'Migrate to goodteaching.org', '2007-11-24 08:06:55');
INSERT INTO mse_release_history VALUES ('V0.05A', '10203', 'Correct ''onclick'' bug in IE6 - remember to "return false;"', '2007-11-24 08:07:35');
INSERT INTO mse_release_history VALUES ('V0.05A', '10204', 'Add intelligence to Servant checkboxes', '2007-11-24 08:08:09');
INSERT INTO mse_release_history VALUES ('V0.05A', '10205', 'Bug - Limiting a search on a different tab should reset the Current Page to 1', '2007-11-24 08:08:39');
INSERT INTO mse_release_history VALUES ('V0.06A', '10214', 'Consider Greater-Than char to be an acceptable end paragraph character', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('V0.06A', '10213', 'Change colour of Scripture links', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('V0.06A', '10210', 'Show New Page indicator in text Results', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('V0.06A', '10208', 'Add New Page Indicators to Mse_Text', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('V0.06A', '10188', 'Calculate the Article Page for MseText', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('V0.07A', '10206', 'Add Pagination to Volume Preview pane', '2008-05-18 17:26:18');
INSERT INTO mse_release_history VALUES ('V0.08A', '10211', 'Highlight Search Terms in Results and Preview', '2008-05-18 17:26:18');
INSERT INTO mse_release_history VALUES ('V0.09A', '10267', 'Add Release History', '2008-05-18 19:39:50');
INSERT INTO mse_release_history VALUES ('V0.04A', '10201', 'Bug - Pagination does not work if you start immediately with Scriptures', '2007-11-24 08:06:20');
INSERT INTO mse_release_history VALUES ('V0.03A', '10200', 'Add Search Results Pagination', '2007-11-24 08:05:41');
INSERT INTO mse_release_history VALUES ('V0.03A', '10187', 'Add Scripture Search', '2007-11-24 08:05:07');
INSERT INTO mse_release_history VALUES ('V0.02A', '10189', 'Catch all Initials like *Ques* and S.McC.', '2007-11-24 08:03:56');
INSERT INTO mse_release_history VALUES ('V0.01A', '10186', 'Create Export Scripts', '2007-11-24 08:03:14');

-- --------------------------------------------------------

-- 
-- Table structure for table member
-- 

CREATE TABLE member (
  memberid varchar(20) NOT NULL default '',
  first_name varchar(25) NOT NULL default '',
  last_name varchar(25) NOT NULL default '',
  email_address varchar(255) default NULL,
  password varchar(50) NOT NULL default '',
  admin int(1) default '0',
  member_type char(2) NOT NULL default 'N',
  verify_code varchar(100) NOT NULL default '',
  active int(1) NOT NULL default '0',
  dob date NOT NULL default '0000-00-00',
  signup_date datetime NOT NULL default '0000-00-00 00:00:00',
  last_login datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (memberid),
  KEY i_email_address (email_address)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Information';

-- 
-- Dumping data for table member
-- 

INSERT INTO member VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '0954bfb4e59e3d85ff989944a65f6955', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2007-08-11 16:23:56');

-- --------------------------------------------------------

-- 
-- Table structure for table member_type
-- 

CREATE TABLE member_type (
  member_type char(2) NOT NULL default '',
  type_name varchar(50) default NULL,
  comments varchar(255) default NULL,
  disp_order int(11) NOT NULL default '0',
  PRIMARY KEY  (member_type)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Types';

-- 
-- Dumping data for table member_type
-- 

INSERT INTO member_type VALUES ('U', 'User', 'Ability to View all details on the site', 1);
INSERT INTO member_type VALUES ('N', 'New User', 'No permissions yet - waiting verification', 3);
INSERT INTO member_type VALUES ('A', 'Administrator', 'Full Administrative capabilities', 2);
