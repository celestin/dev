-- --------------------------------------------------------
-- DS Glasscraft
-- Copyright (c) 2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  19-Mar-2010  10610 : Created diff.
-- --------------------------------------------------------

UPDATE piece SET cat = 'FISHING' WHERE cat = 'FISH';
UPDATE category SET cat = 'FISHING' WHERE cat = 'FISH';

INSERT INTO category (cat, catName, section) VALUES ('FISH', 'fish', 2);

INSERT INTO piece (piece,cat,name) VALUES ('andean_bear','BEAR','Andean or Spectacled Bear');
INSERT INTO piece (piece,cat,name) VALUES ('blue_butterfly','BFLY','Blue Butterfly');
INSERT INTO piece (piece,cat,name) VALUES ('yellow_black_butterfly','BFLY','Yellow & Black Butterfly');
INSERT INTO piece (piece,cat,name) VALUES ('capercaillie','BIRD','Capercaillie');
INSERT INTO piece (piece,cat,name) VALUES ('cheetah_running','CAT','Running Cheetah');
INSERT INTO piece (piece,cat,name) VALUES ('cheetah_walking','CAT','Walking Cheetah');
INSERT INTO piece (piece,cat,name) VALUES ('clown_fish_anemone','FISH','Clown Fish & Anemone');
INSERT INTO piece (piece,cat,name) VALUES ('clown_fish_pair','FISH','Pair of Clown Fish');
INSERT INTO piece (piece,cat,name) VALUES ('fishing_fly','FISHING','Fishing Fly');
INSERT INTO piece (piece,cat,name) VALUES ('frogs_waterfall','WATER','Frogs & Waterfall');
INSERT INTO piece (piece,cat,name) VALUES ('golden_damselfish_blue_tang','FISH','Golden Damselfish & Blue Tang');
INSERT INTO piece (piece,cat,name) VALUES ('golden_damselfish_pair','FISH','Pair of Golden Damselfish');
INSERT INTO piece (piece,cat,name) VALUES ('golden_damselfish1','FISH','Golden Damselfish 1');
INSERT INTO piece (piece,cat,name) VALUES ('golden_damselfish2','FISH','Golden Damselfish 2');
INSERT INTO piece (piece,cat,name) VALUES ('orangutan','PRIMATE','Orang-utan');
INSERT INTO piece (piece,cat,name) VALUES ('reef_fish','FISH','Reef Fish');
INSERT INTO piece (piece,cat,name) VALUES ('sea_trout','FISHING','Sea Trout');
INSERT INTO piece (piece,cat,name) VALUES ('seahorse_amber','FISH','Amber Seahorse');
INSERT INTO piece (piece,cat,name) VALUES ('seahorse_green','FISH','Green Seahorse');
INSERT INTO piece (piece,cat,name) VALUES ('seahorse_ruby','FISH','Ruby Seahorse');

UPDATE piece SET cat='FISH' piece='goldfish';

