


-- Remove ppef

DELETE FROM products_to_products_extra_fields
WHERE EXISTS (SELECT 1
FROM products p, sirdar_yarn_leaflet sl
WHERE p.products_id = products_to_products_extra_fields.products_id
AND sl.leaflet_code = p.products_model)
AND products_extra_fields_id = 1


-- Leaflets where this Shade is explicitly mentioned
SELECT pl.products_id, pdl.products_name, pl.products_image
FROM sirdar_yarn_leaflet_shade sls, products ps, products_description pds, products pl, products_description pdl
WHERE ps.products_model = sls.shade_code
AND pl.products_model = sls.leaflet_code
AND pds.products_id = ps.products_id
AND pdl.products_id = pl.products_id
AND ps.products_id =400


-- Leaflets for the all the Shades of this Yarn, where this Shade is NOT explicitly mentioned (because they are shown above)
SELECT pl.products_id, pdl.products_name, pl.products_image
FROM products pl, products_description pdl
WHERE pdl.products_id = pl.products_id
AND NOT EXISTS (SELECT 1 FROM sirdar_yarn_leaflet_shade sls, products ps
                WHERE ps.products_model = sls.shade_code
                AND pl.products_model = sls.leaflet_code
                AND ps.products_id =400)
AND EXISTS (SELECT 1
            FROM sirdar_yarn_leaflet_shade sls, products ps, sirdar_yarn_shade ss1, sirdar_yarn sy, sirdar_yarn_shade ss2
            WHERE ss1.yarn_code = sy.yarn_code
            AND ss2.shade_code = sls.shade_code
            AND ss2.yarn_code = sy.yarn_code
            AND ps.products_model = ss1.shade_code
            AND pl.products_model = sls.leaflet_code
            AND ps.products_id =400)



-- Shades that may suit this leaflet
SELECT ps.products_id, pds.products_name, ps.products_image
FROM sirdar_yarn_leaflet_shade sls, products pl, sirdar_yarn_shade ss1, sirdar_yarn_shade ss2, products ps, products_description pds
WHERE pl.products_model = sls.leaflet_code
AND ss1.shade_code = sls.shade_code
AND ss2.yarn_code = ss1.yarn_code
AND ps.products_model = ss2.shade_code
AND pds.products_id = ps.products_id
AND pl.products_id=658
