/** Populate products from shades */
INSERT INTO products (
  products_quantity, products_model, products_image, products_price, products_date_added,
  products_last_modified, products_date_available,
  products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered,dataload_price_rrp,dataload_gender)
select 1, shade_code, shade_image, 5.00, '2010-10-30 21:00:00', '2010-10-30 21:00:00', NULL, sy.weight, 1, 0, 2, 0,8.00,'Sirdar'
from sirdar_yarn sy, sirdar_yarn_shade sys
where sys.yarn_code = sy.yarn_code
and sys.shade_status = 'INC'
and sy.yarn_status = 'INC';

/*
/** If required, remove descriptions */
DELETE FROM products_description WHERE EXISTS (
SELECT 1
FROM products p, sirdar_yarn sy, sirdar_yarn_shade sys
WHERE p.products_id = products_description.products_id
AND sys.shade_code = p.products_model
AND sys.yarn_code = sy.yarn_code
);
*/

/** Insert description */
INSERT INTO products_description( products_id, language_id, products_name, products_description, products_viewed )
SELECT p.products_id, 1, concat(sys.shade_name, ' - ', sy.yarn_name), sy.yarn_desc, 1
FROM products p, sirdar_yarn sy, sirdar_yarn_shade sys
WHERE sys.shade_code = p.products_model
AND sys.yarn_code = sy.yarn_code
AND NOT EXISTS (
  SELECT 1
  FROM products_description
  WHERE products_id = p.products_id
)


/** Assign to correct yarn category */
INSERT INTO products_to_categories (
  products_id, categories_id
)
select p.products_id, sy.yarn_cat
from products p, sirdar_yarn sy, sirdar_yarn_shade sys
where sys.shade_code = p.products_model
and sys.yarn_code = sy.yarn_code;


/** RRP */

/** if required
delete from products_to_products_extra_fields;
*/

INSERT INTO products_to_products_extra_fields (products_id, products_extra_fields_id, products_extra_fields_value)
SELECT p.products_id, 1, 8
from products p, sirdar_yarn sy, sirdar_yarn_shade sys
where sys.shade_code = p.products_model
and sys.yarn_code = sy.yarn_code
AND NOT EXISTS (SELECT 1 FROM products_to_products_extra_fields WHERE products_id = p.products_id and products_extra_fields_id=1);

/** Yardage */
INSERT INTO products_to_products_extra_fields (products_id, products_extra_fields_id, products_extra_fields_value)
SELECT p.products_id, 2, pe_yard
from products p, sirdar_yarn sy, sirdar_yarn_shade sys
where sys.shade_code = p.products_model
and sys.yarn_code = sy.yarn_code
AND NOT EXISTS (SELECT 1 FROM products_to_products_extra_fields WHERE products_id = p.products_id and products_extra_fields_id=2);

/** Blend */
INSERT INTO products_to_products_extra_fields (products_id, products_extra_fields_id, products_extra_fields_value)
SELECT p.products_id, 3, pe_blend
from products p, sirdar_yarn sy, sirdar_yarn_shade sys
where sys.shade_code = p.products_model
and sys.yarn_code = sy.yarn_code
AND NOT EXISTS (SELECT 1 FROM products_to_products_extra_fields WHERE products_id = p.products_id and products_extra_fields_id=3);


/** Ball weight */
INSERT INTO products_attributes (products_id, options_id, options_values_id, options_values_price, price_prefix)
SELECT p.products_id, 1 options_id, sy.pa_weight options_values_id, '0.0000' options_values_price, '+' price_prefix
from products p, sirdar_yarn sy, sirdar_yarn_shade sys
where sys.shade_code = p.products_model
and sys.yarn_code = sy.yarn_code
AND NOT EXISTS (SELECT 1 FROM products_attributes WHERE products_id = p.products_id and options_id=1);

/** Needle size */
INSERT INTO products_attributes (products_id, options_id, options_values_id, options_values_price, price_prefix)
SELECT p.products_id, 2 options_id, sy.pa_needle options_values_id, '0.0000' options_values_price, '+' price_prefix
from products p, sirdar_yarn sy, sirdar_yarn_shade sys
where sys.shade_code = p.products_model
and sys.yarn_code = sy.yarn_code
AND NOT EXISTS (SELECT 1 FROM products_attributes WHERE products_id = p.products_id and options_id=2);
