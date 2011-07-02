-- --------------------------------------------------------
-- DS Glasscraft
-- Copyright (c) 2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  02-Jul-2011  10981 : Added latest images.
-- --------------------------------------------------------

INSERT INTO category (cat, catName, section) VALUES ('RAPTOR', 'raptors', 2);
INSERT INTO category (cat, catName, section) VALUES ('SAFARI', 'safari', 2);

UPDATE piece SET cat = 'RAPTOR' WHERE cat = 'OWL';
UPDATE piece SET cat = 'RAPTOR' WHERE cat = 'EAGLE';
UPDATE piece SET cat = 'RAPTOR' WHERE piece = 'buzzard1';
UPDATE piece SET cat = 'RAPTOR' WHERE piece = 'stellar1';
UPDATE piece SET cat = 'RAPTOR' WHERE piece = 'stellar1';
DELETE FROM category WHERE cat IN ('OWL','EAGLE');

INSERT INTO piece (piece,cat,name) VALUES ('avocet2', 'BIRD', 'Avocet');
INSERT INTO piece (piece,cat,name) VALUES ('avocet3', 'BIRD', 'Avocet');
INSERT INTO piece (piece,cat,name) VALUES ('avocets1', 'BIRD', 'Avocets');
INSERT INTO piece (piece,cat,name) VALUES ('goldfinch1', 'BIRD', 'Goldfinch on Broom');
INSERT INTO piece (piece,cat,name) VALUES ('osprey1', 'RAPTOR', 'Osprey');
INSERT INTO piece (piece,cat,name) VALUES ('pheasant1', 'BIRD', 'Pheasant');
INSERT INTO piece (piece,cat,name) VALUES ('scarlet_macaw2', 'BIRD', 'Scarlet Macaw');
INSERT INTO piece (piece,cat,name) VALUES ('belted_kingfishers1', 'KFISH', 'Belted Kingfishers');
INSERT INTO piece (piece,cat,name) VALUES ('lemurs2', 'PRIMATE', 'Ring-tailed Lemur Family');
INSERT INTO piece (piece,cat,name) VALUES ('bearded_dragon1', 'REPTILE', 'Bearded Dragon');
INSERT INTO piece (piece,cat,name) VALUES ('zebras1', 'SAFARI', 'Zebras');
INSERT INTO piece (piece,cat,name) VALUES ('frog7', 'WATER', 'Frog');
INSERT INTO piece (piece,cat,name) VALUES ('frog8', 'WATER', 'Frog');
INSERT INTO piece (piece,cat,name) VALUES ('hare1', 'WOODLAND', 'Hare');
INSERT INTO piece (piece,cat,name) VALUES ('hare2', 'WOODLAND', 'Hare');
