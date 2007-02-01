INSERT INTO proddimensions (product_id, dimension_id, textvalue, numvalue, created, updated) VALUES
( 52, 41, 'Octagonal - Seating for 10 persons', 8, NULL, NULL),
( 52, 3, '0.37 m', 0.37, NULL, NULL),
( 52, 4, '40 mm double tongue and groove logs from Red Pine.', 40, NULL, NULL),
( 52, 5, 'Decking that can be removed for cleaning. 3.54m x 3.54m.', 0, NULL, NULL),
( 52, 6, '20 mm tongue and groove roof boards.', 20, NULL, NULL),
( 52, 42, '3.75 m', 3.75, NULL, NULL),
( 52, 7, '1 door at 146/61', 1, NULL, NULL),
( 52, 8, '4 windows 62/30, double glazed', 4, NULL, NULL);


INSERT INTO prodvariations ( variation, product_id, vlength, vbreadth, disporder, created_by, created_on, created_at, updated_by, updated_on, updated_at) VALUES
( NULL, 52, 3.81, 3.81, 20, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO prodprices (product_id, prodvariation_id, rangeoption_id, pivot, price, created_by, created_on, created_at, updated_by, updated_on, updated_at) VALUES
(52, 103, NULL, 40, 5675, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO prodprices (product_id, prodvariation_id, rangeoption_id, pivot, price, created_by, created_on, created_at, updated_by, updated_on, updated_at) VALUES
(52, 103, 11, NULL, -1, NULL, NULL, NULL, NULL, NULL, NULL);

