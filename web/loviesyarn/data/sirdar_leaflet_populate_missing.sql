-- Leaflets

insert into products (products_model, products_image, products_status, products_tax_class_id, products_price, dataload_gender)
SELECT leaflet_code, leaflet_image, 1, 1, 2.3333, '2013-03-30-A'
FROM sirdar_yarn_leaflet sys
WHERE not exists (select 1 from products where products_model = sys.leaflet_code)
and leaflet_status = 'INC';

INSERT INTO products_description( products_id, language_id, products_name, products_description, products_viewed )
SELECT p.products_id, 1, MIN(CONCAT(sy.yarn_name, ' (', syl.leaflet_code, ')')), NULL, 1
FROM products p, sirdar_yarn sy, sirdar_yarn_leaflet syl
WHERE syl.leaflet_code = p.products_model
AND dataload_gender = '2013-03-30-A'
AND syl.yarn_code = sy.yarn_code
AND NOT EXISTS (
  SELECT 1
  FROM products_description
  WHERE products_id = p.products_id
)
GROUP BY p.products_id;

INSERT INTO products_to_categories (
  products_id, categories_id
)
select p.products_id, sys.categories_id
from products p, sirdar_yarn sy, sirdar_yarn_leaflet sys
where sys.leaflet_code = p.products_model
AND dataload_gender = '2013-03-30-A'
and sys.yarn_code = sy.yarn_code
and not exists (select 1
                from products_to_categories
                where products_id = p.products_id);

-- RRP (not normally used)
INSERT INTO products_to_products_extra_fields (products_id, products_extra_fields_id, products_extra_fields_value)
SELECT p.products_id, 1, NULL
from products p
where dataload_gender = '2013-03-30-A'
AND NOT EXISTS (SELECT 1 FROM products_to_products_extra_fields WHERE products_id = p.products_id and products_extra_fields_id=1);

-- Needle Size
INSERT INTO products_to_products_extra_fields (products_id, products_extra_fields_id, products_extra_fields_value)
SELECT p.products_id, 4, syl.needle_Size
FROM products p, sirdar_yarn_leaflet syl
WHERE syl.leaflet_code = p.products_model
AND dataload_gender = '2013-03-30-A'
AND syl.needle_Size IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM products_to_products_extra_fields WHERE products_id = p.products_id and products_extra_fields_id=4);


DELETE FROM products_to_products_extra_fields pef
WHERE EXISTS (SELECT 1 FROM products p WHERE pef.products_id = p.products_id and p.dataload_gender = '2013-03-30-A');



