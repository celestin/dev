-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  18-Nov-2007  10205 : Migrated to goodteaching.org.
-- --------------------------------------------------------

DELETE FROM mse_author;
INSERT INTO mse_author (author, name) VALUES
('CAC', 'C. A. Coates'),
('FER', 'F. E. Raven'),
('JBS', 'J. B. Stoney'),
('JND', 'J. N. Darby'),
('JT', 'J. Taylor, Snr');