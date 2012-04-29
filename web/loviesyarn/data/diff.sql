-- --------------------------------------------------------
-- iKnit (iknit.biz)
-- Copyright (c) 2011 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------

--
-- #11115 Rename site
--

UPDATE `loviesya_biz_site`.`configuration` SET `configuration_value` = 'Lovie&rsquo;s Yarn' WHERE `configuration`.`configuration_id` =1;
UPDATE `loviesya_biz_site`.`configuration` SET `configuration_value` = 'sales@loviesyarn.com' WHERE `configuration`.`configuration_id` =3;
UPDATE `loviesya_biz_site`.`configuration` SET `configuration_value` = '"Lovie''s Yarn" <sales@loviesyarn.com>' WHERE `configuration`.`configuration_id` =4;

UPDATE `loviesya_biz_site`.`configuration` SET `configuration_value` = 'LoviesYarn.com 36 West High Street Inverurie Aberdeenshire United Kingdom AB51 3QR 01467 620277 sales@loviesyarn.com' WHERE `configuration`.`configuration_id` =15;