
ALTER TABLE bb_clients 
	ADD ratetype CHAR(1) NOT NULL AFTER tax_code,
	ADD rate FLOAT NOT NULL AFTER ratetype;

update bb_clients set ratetype = 'H', rate = 25;

UPDATE bb_clients 
	SET ratetype = 'D', rate = '600' 
WHERE id=1034;

