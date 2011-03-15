-- --------------------------------------------------------
-- J.Mitchell & Son (jmitchellandson.co.uk)
-- Copyright (c) 2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------


-- CAM  15-Mar-2011  10935 : Added box image.

ALTER TABLE categories ADD box_image VARCHAR(64) NULL AFTER categories_image;

UPDATE categories SET box_image = 'citizen2.jpg' WHERE categories.categories_id=12;
UPDATE categories SET box_image = 'accurist1.jpg' WHERE categories.categories_id=24;
UPDATE categories SET box_image = 'accurist2.jpg' WHERE categories.categories_id=25;

-- EOF #10935

