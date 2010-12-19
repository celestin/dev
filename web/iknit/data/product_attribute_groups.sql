-- Firstly we insert product_options
-- Then we insert product_options_values
-- Then we use both of these IDs in the table above
-- Next, we insert into products_to_attributes_group to assign products to a group
-- Finally, we use this SQL to create products_attributes values

delete from products_attributes pa using products_attributes pa inner join products_attributes_group pag on pag.options_id = pa.options_id AND pag.options_values_id = pa.options_values_id;                  ;

insert into products_attributes (products_id, options_id, options_values_id, options_values_price, price_prefix)
select ptag.products_id, pag.options_id, pag.options_values_id, pag.options_values_price, pag.price_prefix
from products_attributes_group pag inner join products_to_attributes_group ptag on ptag.options_id = pag.options_id;


-- Finally, SQL to insert into the group table all the products in a particular category (18) for a particular option (10)
insert into products_to_attributes_group
SELECT p.products_id, 10 FROM products p inner join products_to_categories ptc on ptc.products_id = p.products_id
where ptc.categories_id = 18
and not exists (
select 1
from products_to_attributes_group ptag
where ptag.products_id = p.products_id
and ptag.options_id = 10);

