-- --------------------------------------------------------
-- J.Mitchell & Son (jmitchellandson.co.uk)
-- Copyright (c) 2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------


-- CAM  27-Dec-2010  10907 : Update VAT to 20%.

UPDATE tax_rates SET tax_rate = '20.0', tax_description = 'VAT (20%)' WHERE tax_rates.tax_rates_id = 1;

UPDATE products set products_tax_class_id = 1 WHERE products_tax_class_id = 0;

UPDATE products set products_price = products_price * 1.175 / 1.200 WHERE products_tax_class_id = 1;

-- EOF #10907

