

-- After running the greasemonkey script to copy a yarn (with shades and leaflets) to the hidden sirdar* tables
-- run these scripts to indicate which are already existing products

update sirdar_yarn sy
set yarn_status = 'INC'
where yarn_status = 'NEW'
and exists (select 1 from products where left(products_model,length(sy.yarn_code)) = sy.yarn_code);

update sirdar_yarn_shade sy
set shade_status = 'INC'
where shade_status = 'NEW'
and exists (select 1 from products where products_model = sy.shade_code);

update sirdar_yarn_leaflet syl
set leaflet_status = 'INC'
where leaflet_status = 'NEW'
and exists (select 1 from products where products_model = syl.leaflet_code);

