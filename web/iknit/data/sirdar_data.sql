CREATE TABLE sirdar_yarn (
  yarn_code varchar(30) NOT NULL default '',
  yarn_name varchar(60) NOT NULL,
  ply_name varchar(60) default NULL,
  style_name varchar(60) default NULL,
  yarn_image varchar(250) default NULL,
  PRIMARY KEY  (yarn_code)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Sirdar Yarns';

CREATE TABLE sirdar_yarn_shade (
  yarn_code varchar(30) NOT NULL default '',
  shade_code varchar(30) NOT NULL default '',
  shade_name varchar(60) NOT NULL,
  shade_image varchar(250) NOT NULL,
  PRIMARY KEY  (yarn_code,shade_code)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Sirdar Yarn Shades';




DELETE FROM sirdar_yarn WHERE yarn_code = 'F072';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F072';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F072', 'Snuggly 2 Ply', '2 ply/Quick Knit', 'Baby', 'f072-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F072', 'F072-0251', 'White', 'f072-0251.jpg');



DELETE FROM sirdar_yarn WHERE yarn_code = 'F077';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F077';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F077', 'Snuggly QK ', '2 ply/Quick Knit', 'Baby', 'f077-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F077', 'F077-0251', 'White', 'f077-0251.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F073';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F073';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F073', 'Snuggly 3 Ply 50g', '3 ply', 'Baby', 'f073-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F073', 'F073-0251', 'White', 'f073-0251.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F073', 'F073-0302', 'Pearly Pink', 'f073-0302.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F073', 'F073-0320', 'Pastel Lemon', 'f073-0320.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F073', 'F073-0321', 'Pastel Blue', 'f073-0321.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F073', 'F073-0303', 'Cream', 'f073-0303.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F070';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F070';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F070', 'Snuggly 3 Ply 100g', '3 ply', 'Baby', 'f070-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F070', 'F070-0251', 'White', 'f070-0251.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F074';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F074';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F074', 'Snuggly 4 Ply 50g', '4 ply', 'Baby', 'f074-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0267', 'Stawberry Mousse', 'f074-0267.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0326', 'Denim', 'f074-0326.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0268', 'Blueberry Mousse', 'f074-0268.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0302', 'Pearly Pink', 'f074-0302.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0320', 'Pastel Lemon', 'f074-0320.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0304', 'Pearly Green', 'f074-0304.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0321', 'Pastel Blue', 'f074-0321.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0219', 'Lilac', 'f074-0219.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0212', 'Petal Pink', 'f074-0212.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0394', 'Hyacinth Mix', 'f074-0394.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0303', 'Cream', 'f074-0303.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0251', 'White', 'f074-0251.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0257', 'Cherub Pink', 'f074-0257.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0265', 'Speckle', 'f074-0265.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0403', 'Wobble', 'f074-0403.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0406', 'Blink', 'f074-0406.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0408', 'Sugar Cookie', 'f074-0408.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0410', 'Chuckle', 'f074-0410.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0405', 'Bubble', 'f074-0405.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F074', 'F074-0407', 'Toddle', 'f074-0407.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F083';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F083';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F083', 'Snuggly 4 Ply 100g', '4 ply', 'Baby', 'f083-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F083', 'F083-0251', 'White', 'f083-0251.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F083', 'F083-0303', 'Cream', 'f083-0303.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F118';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F118';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F118', 'Baby Bonus 4 Ply', '4 ply', 'Baby', 'f118-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F118', 'F118-0851', 'Baby Pink', 'f118-0851.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F118', 'F118-0852', 'Baby Lemon', 'f118-0852.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F118', 'F118-0853', 'Baby Mint', 'f118-0853.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F118', 'F118-0854', 'Baby Blue', 'f118-0854.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F118', 'F118-0855', 'Baby Cream', 'f118-0855.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F118', 'F118-0856', 'Baby White', 'f118-0856.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F086';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F086';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F086', 'Snuggly Baby Crofter Dk', 'DK', 'Baby', 'f086-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F086', 'F086-0155', 'Pinkie', 'f086-0155.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F086', 'F086-0156', 'Hamish', 'f086-0156.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F086', 'F086-0157', 'Dougal', 'f086-0157.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F086', 'F086-0150', 'Bonnie', 'f086-0150.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F086', 'F086-0151', 'Keltie', 'f086-0151.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F086', 'F086-0152', 'Scottie', 'f086-0152.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F086', 'F086-0153', 'Hickory', 'f086-0153.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F086', 'F086-0154', 'Nessie', 'f086-0154.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F023';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F023';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F023', 'Snuggly Snowflake Dk', 'DK', 'Baby', 'f023-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0653', 'Bright Purple', 'f023-0653.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0654', 'Bright Pink', 'f023-0654.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0630', 'Milky', 'f023-0630.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0631', 'Creamy', 'f023-0631.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0642', 'Beige', 'f023-0642.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0643', 'Lime', 'f023-0643.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0644', 'Pink', 'f023-0644.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0645', 'Lilac', 'f023-0645.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0646', 'Aqua', 'f023-0646.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0647', 'Lemon', 'f023-0647.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0648', 'Iced Blue', 'f023-0648.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0649', 'Angel Pink', 'f023-0649.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0650', 'Candy Pink', 'f023-0650.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F023', 'F023-0651', 'Spearmint', 'f023-0651.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F096';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F096';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F096', 'Snuggly Kisses Dk', 'DK', 'Baby', 'f096-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0758', 'Princess Pink', 'f096-0758.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0757', 'Doodle', 'f096-0757.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0754', 'Bonbon', 'f096-0754.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0752', 'Giddy', 'f096-0752.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0753', 'Skippy', 'f096-0753.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0750', 'Hushed', 'f096-0750.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0751', 'Twiggy', 'f096-0751.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0755', 'Patter Pink', 'f096-0755.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F096', 'F096-0756', 'Twinkle', 'f096-0756.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F069';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F069';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F069', 'Baby Bonus Lustre Dk', 'DK', 'Baby', 'f069-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F069', 'F069-0856', 'Baby White', 'f069-0856.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F069', 'F069-0855', 'Baby Cream', 'f069-0855.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F069', 'F069-0854', 'Baby Blue', 'f069-0854.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F069', 'F069-0852', 'Baby Lemon', 'f069-0852.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F069', 'F069-0851', 'Baby Pink', 'f069-0851.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F069', 'F069-0850', 'Baby Lilac', 'f069-0850.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F071';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F071';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F071', 'Snuggly Baby Bamboo Dk', 'DK', 'Baby', 'f071-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0159', 'Jack In A Box', 'f071-0159.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0160', 'Paintbox Pink', 'f071-0160.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0162', 'Toy Box Red', 'f071-0162.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0161', 'Baby Berries', 'f071-0161.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0132', 'Putty', 'f071-0132.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0133', 'Willow', 'f071-0133.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0134', 'Babe', 'f071-0134.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0131', 'Cream', 'f071-0131.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0140', 'Minky', 'f071-0140.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0148', 'Coo', 'f071-0148.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0145', 'Happy', 'f071-0145.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0149', 'Scooter Blue', 'f071-0149.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0150', 'Dungaree Denim', 'f071-0150.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0153', 'Jellybaby', 'f071-0153.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0154', 'Poppy', 'f071-0154.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0126', 'Rocking Horse', 'f071-0126.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0127', 'Skittle', 'f071-0127.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0128', 'Tigger', 'f071-0128.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0129', 'Banjo Blue', 'f071-0129.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0130', 'Wigwam', 'f071-0130.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0155', 'Limey', 'f071-0155.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0158', 'Rinky Dinky Pink', 'f071-0158.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0156', 'Sailboat', 'f071-0156.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F071', 'F071-0157', 'Yellow Submarine', 'f071-0157.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F075';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F075';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F075', 'Snuggly Dk 50g', 'DK', 'Baby', 'f075-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0416', 'Baby Bear', 'f075-0416.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0418', 'Duckling', 'f075-0418.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0419', 'Choo Choo Train', 'f075-0419.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0417', 'Little Frog', 'f075-0417.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0344', 'Oatmeal', 'f075-0344.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0240', 'Stonewash', 'f075-0240.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0353', 'Indigo Mix', 'f075-0353.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0224', 'Light Navy', 'f075-0224.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0251', 'White', 'f075-0251.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0320', 'Pastel Lemon', 'f075-0320.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0350', 'Spicy Pink', 'f075-0350.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0347', 'Brick Red', 'f075-0347.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0242', 'Flamenco', 'f075-0242.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0354', 'Bluebell Mix', 'f075-0354.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0326', 'Denim', 'f075-0326.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0213', 'Angelica', 'f075-0213.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0212', 'Petal Pink', 'f075-0212.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0219', 'Lilac', 'f075-0219.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0216', 'Sky', 'f075-0216.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0303', 'Cream', 'f075-0303.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0302', 'Pearly Pink', 'f075-0302.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0321', 'Pastel Blue', 'f075-0321.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0304', 'Pearly Green', 'f075-0304.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0252', 'Lemon', 'f075-0252.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0372', 'Cherub', 'f075-0372.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0255', 'Mellow Pink', 'f075-0255.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0254', 'Clover', 'f075-0254.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0261', 'Playful Pink', 'f075-0261.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0260', 'Summer Lime', 'f075-0260.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0259', 'Daisy', 'f075-0259.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0265', 'Speckle', 'f075-0265.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0268', 'Blueberry Mousse', 'f075-0268.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0267', 'Strawberry Mousse', 'f075-0267.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0312', 'Black', 'f075-0312.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0403', 'Wobble', 'f075-0403.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0404', 'Blush Baby', 'f075-0404.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0405', 'Bubble', 'f075-0405.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0406', 'Blink', 'f075-0406.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0407', 'Toddle', 'f075-0407.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0408', 'Sugar Cookie', 'f075-0408.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0409', 'Twinkle Toes', 'f075-0409.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0410', 'Chuckle', 'f075-0410.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0414', 'Elf', 'f075-0414.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0413', 'Engine Red', 'f075-0413.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0415', 'Pixie', 'f075-0415.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F075', 'F075-0412', 'Soldier Blue', 'f075-0412.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F081';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F081';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F081', 'Snuggly Dk 100g', 'DK', 'Baby', 'f081-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F081', 'F081-0251', 'White', 'f081-0251.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F081', 'F081-0303', 'Cream', 'f081-0303.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F082';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F082';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F082', 'Snuggly Pearls Dk', 'DK', 'Baby', 'f082-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F082', 'F082-0251', 'White', 'f082-0251.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F082', 'F082-0303', 'Cream', 'f082-0303.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F082', 'F082-0302', 'Pearly Pink', 'f082-0302.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F014';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F014';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F014', 'Baby Bonus Dk', 'DK', 'Baby', 'f014-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F014', 'F014-0850', 'Baby Lilac', 'f014-0850.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F014', 'F014-0851', 'Baby Pink', 'f014-0851.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F014', 'F014-0852', 'Baby Lemon', 'f014-0852.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F014', 'F014-0853', 'Baby Mint', 'f014-0853.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F014', 'F014-0854', 'Baby Blue', 'f014-0854.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F014', 'F014-0855', 'Baby Cream', 'f014-0855.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F014', 'F014-0856', 'Baby White', 'f014-0856.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F022';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F022';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F022', 'Supersoft Aran', 'Aran', 'Baby', 'f022-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0823', 'Chestnut', 'f022-0823.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0824', 'Red Poppy', 'f022-0824.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0825', 'Mustard', 'f022-0825.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0826', 'Minty', 'f022-0826.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0831', 'Cream', 'f022-0831.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0859', 'Oatmeal', 'f022-0859.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0870', 'Denim', 'f022-0870.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0830', 'White', 'f022-0830.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0844', 'Pretty Blue', 'f022-0844.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0842', 'Pretty Pink', 'f022-0842.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0878', 'Cargo', 'f022-0878.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0877', 'Riverblue', 'f022-0877.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0876', 'Ming', 'f022-0876.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0882', 'Baby Blush', 'f022-0882.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0885', 'Jellybabe', 'f022-0885.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0886', 'Sweetie', 'f022-0886.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0887', 'Dolly', 'f022-0887.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0888', 'Pip', 'f022-0888.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0890', 'Lollipop', 'f022-0890.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0891', 'Plummy', 'f022-0891.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0892', 'Peeka Blue', 'f022-0892.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0893', 'Grassy', 'f022-0893.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0828', 'Nougat', 'f022-0828.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0827', 'Marina', 'f022-0827.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F022', 'F022-0829', 'Buster Blue', 'f022-0829.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F047';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F047';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F047', 'Baby Snowball', 'Fashion', 'Baby', 'f047-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F047', 'F047-0100', 'Snowman', 'f047-0100.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F047', 'F047-0101', 'Ice Cream', 'f047-0101.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F047', 'F047-0102', 'Frostie Pink', 'f047-0102.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F047', 'F047-0103', 'Frostie Blue', 'f047-0103.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F047', 'F047-0104', 'Frostie Lime', 'f047-0104.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F047', 'F047-0105', 'Frostie Lilac', 'f047-0105.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F050';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F050';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F050', 'Snuggly Tiny Tots Dk', 'Fashion', 'Baby', 'f050-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0985', 'Grey Bunny', 'f050-0985.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0986', 'Little Bee', 'f050-0986.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0987', 'Little Duck', 'f050-0987.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0988', 'Pink Pony', 'f050-0988.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0948', 'Candy', 'f050-0948.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0945', 'Soft Pink', 'f050-0945.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0958', 'Oatmeal', 'f050-0958.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0957', 'Stone', 'f050-0957.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0976', 'Crystal Blue', 'f050-0976.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0941', 'Indigo', 'f050-0941.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0936', 'Pink Pearl', 'f050-0936.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0935', 'Oyster Blue', 'f050-0935.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0934', 'Damson', 'f050-0934.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0929', 'Hush', 'f050-0929.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0933', 'Cosy', 'f050-0933.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0930', 'Bliss', 'f050-0930.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0928', 'Tender', 'f050-0928.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0931', 'Coy', 'f050-0931.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0932', 'Snug', 'f050-0932.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0924', 'Domino', 'f050-0924.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0925', 'Smoothie', 'f050-0925.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0926', 'Crumbly', 'f050-0926.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0927', 'Hedgehog', 'f050-0927.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0920', 'Baby Green', 'f050-0920.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0921', 'Baby Peach', 'f050-0921.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0922', 'Baby Pink', 'f050-0922.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F050', 'F050-0923', 'Baby Blue', 'f050-0923.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F017';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F017';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F017', 'Snuggly Snowdrops Chunky', 'Chunky', 'Baby', 'f017-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F017', 'F017-0350', 'Snow White', 'f017-0350.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F017', 'F017-0354', 'Sugar Puffs', 'f017-0354.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F017', 'F017-0353', 'Minty Fizz', 'f017-0353.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F017', 'F017-0351', 'Cream Puffs', 'f017-0351.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F017', 'F017-0352', 'Lemon Drops', 'f017-0352.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F017', 'F017-0355', 'Lilac Fizz', 'f017-0355.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F017', 'F017-0356', 'Bluebells', 'f017-0356.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F017', 'F017-0357', 'Candy Pops', 'f017-0357.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F084';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F084';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F084', 'Snuggly Snowflake Chunky', 'Chunky', 'Baby', 'f084-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0653', 'Bright Purple', 'f084-0653.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0654', 'Bright Pink', 'f084-0654.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0630', 'Milky', 'f084-0630.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0631', 'Creamy', 'f084-0631.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0636', 'Rosy Cheeks', 'f084-0636.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0632', 'Berry', 'f084-0632.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0637', 'Cuddle Plum', 'f084-0637.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0633', 'Snuggle Blue', 'f084-0633.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0635', 'Rusk', 'f084-0635.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0634', 'Teddy', 'f084-0634.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F023-0645', 'Lilac', 'f023-0645.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0403', 'Rainbow Spray', 'f084-0403.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0643', 'Lime', 'f084-0643.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0644', 'Pink', 'f084-0644.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0645', 'Lilac', 'f084-0645.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0647', 'Lemon', 'f084-0647.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0650', 'Candy Pink', 'f084-0650.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0652', 'Lagoon', 'f084-0652.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F084', 'F084-0651', 'Spearmint', 'f084-0651.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F051';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F051';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F051', 'Country Style 4 Ply', '4 ply', 'Classics', 'f051-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0605', 'Hollyhock', 'f051-0605.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0606', 'Crocus', 'f051-0606.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0607', 'Anemone', 'f051-0607.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0501', 'Magenta', 'f051-0501.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0428', 'Sage Green', 'f051-0428.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0527', 'Rosehip', 'f051-0527.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0441', 'Light Navy', 'f051-0441.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0417', 'Black', 'f051-0417.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0411', 'Cream', 'f051-0411.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0412', 'White', 'f051-0412.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0460', 'Thistle', 'f051-0460.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0404', 'Parchment', 'f051-0404.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F051', 'F051-0429', 'Lupin', 'f051-0429.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F065';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F065';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F065', 'Luxury Soft Cotton 4 Ply', '4 ply', 'Classics', 'f065-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0652', 'White', 'f065-0652.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0653', 'Vanilla Cream', 'f065-0653.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0656', 'Walnut', 'f065-0656.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0664', 'Bermuda Blue', 'f065-0664.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0657', 'Sage', 'f065-0657.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0659', 'Lilac Blossom', 'f065-0659.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0661', 'Pretty Pink', 'f065-0661.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0663', 'Raspberry', 'f065-0663.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F065', 'F065-0660', 'Calico', 'f065-0660.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F120';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F120';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F120', 'Bonus Toytime Dk', 'DK', 'Classics', 'f120-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0832', 'Shocking Pink', 'f120-0832.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0836', 'Airforce Blue', 'f120-0836.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0838', 'Silver Grey', 'f120-0838.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0839', 'Bottle Green', 'f120-0839.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0884', 'Neon', 'f120-0884.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0886', 'Bright Green', 'f120-0886.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0888', 'Peaches', 'f120-0888.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0889', 'Stone', 'f120-0889.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0916', 'Emerald', 'f120-0916.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0947', 'Chocolate', 'f120-0947.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0961', 'White', 'f120-0961.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0965', 'Black', 'f120-0965.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0969', 'Bluebell', 'f120-0969.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0971', 'Navy', 'f120-0971.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0977', 'Signal Red', 'f120-0977.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0978', 'Sunflower', 'f120-0978.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0979', 'Royal', 'f120-0979.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0981', 'Bright Orange', 'f120-0981.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F120', 'F120-0992', 'Pink', 'f120-0992.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F026';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F026';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F026', 'Crofter Dk', 'DK', 'Classics', 'f026-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0042', 'Skerry', 'f026-0042.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0045', 'Seagrass', 'f026-0045.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0044', 'Hebrides', 'f026-0044.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0043', 'Iona', 'f026-0043.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0050', 'Bracken', 'f026-0050.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0051', 'Shetland', 'f026-0051.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0052', 'Thistle', 'f026-0052.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0053', 'Hound Dog', 'f026-0053.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0054', 'Fairisle', 'f026-0054.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0055', 'Plaid', 'f026-0055.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0056', 'Hedgerow', 'f026-0056.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0057', 'Granary', 'f026-0057.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0058', 'Moorland', 'f026-0058.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0059', 'Rambler Rose', 'f026-0059.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0060', 'Loganberry', 'f026-0060.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0046', 'Heathery', 'f026-0046.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0047', 'Skye', 'f026-0047.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0048', 'Munroe', 'f026-0048.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F026', 'F026-0049', 'Plumage', 'f026-0049.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F006';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F006';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F006', 'Balmoral Dk', 'DK', 'Classics', 'f006-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0472', 'Corgi', 'f006-0472.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0473', 'Pheasant', 'f006-0473.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0478', 'Wedgwood', 'f006-0478.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0477', 'Taffeta', 'f006-0477.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0481', 'Royal Velvet', 'f006-0481.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0484', 'Butler Black', 'f006-0484.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0470', 'Glamis Cream', 'f006-0470.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0471', 'Sandringham', 'f006-0471.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0476', 'Damask', 'f006-0476.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0475', 'Polo Pink', 'f006-0475.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0479', 'Deersalker', 'f006-0479.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0480', 'Buckingham Blue', 'f006-0480.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0485', 'Banquet Red', 'f006-0485.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0486', 'Highlander', 'f006-0486.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F006', 'F006-0487', 'Windsor Purple', 'f006-0487.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F063';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F063';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F063', 'Click Dk', 'DK', 'Classics', 'f063-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0167', 'Peppercorn', 'f063-0167.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0169', 'Wild Cherry', 'f063-0169.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0168', 'Woodland', 'f063-0168.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0147', 'Loom Blue', 'f063-0147.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0133', 'Watermill', 'f063-0133.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0128', 'Tarn', 'f063-0128.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0132', 'Fern', 'f063-0132.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0142', 'Lamb', 'f063-0142.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0144', 'Downy', 'f063-0144.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0129', 'Cobble', 'f063-0129.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0131', 'Heather', 'f063-0131.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0137', 'Blueberry', 'f063-0137.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0130', 'Cranberry', 'f063-0130.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0138', 'Black Sheep', 'f063-0138.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0125', 'Lavender', 'f063-0125.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0123', 'Deep Blue', 'f063-0123.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0120', 'Bracken', 'f063-0120.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0121', 'Harbour', 'f063-0121.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0122', 'Kilt', 'f063-0122.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0119', 'Flinty', 'f063-0119.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0117', 'Pistachio', 'f063-0117.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0112', 'Wild', 'f063-0112.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0110', 'Verve', 'f063-0110.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F063', 'F063-0111', 'Blazer', 'f063-0111.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F009';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F009';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F009', 'Country Style Dk', 'DK', 'Classics', 'f009-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0608', 'Oakleaf', 'f009-0608.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0609', 'Pillarbox', 'f009-0609.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0610', 'Village Green', 'f009-0610.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0429', 'Lupin', 'f009-0429.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0529', 'Heather', 'f009-0529.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0423', 'Dusky Pink', 'f009-0423.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0402', 'Cherry  ', 'f009-0402.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0412', 'White', 'f009-0412.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0527', 'Rosehip', 'f009-0527.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0418', 'Garnet', 'f009-0418.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0500', 'Hazel', 'f009-0500.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0530', 'Chocolate  ', 'f009-0530.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0434', 'Silver Cloud', 'f009-0434.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0408', 'Greystone', 'f009-0408.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0409', 'Naturelle', 'f009-0409.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0417', 'Black', 'f009-0417.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0411', 'Cream', 'f009-0411.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0502', 'Gemini', 'f009-0502.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0501', 'Magenta', 'f009-0501.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0441', 'Light Navy', 'f009-0441.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0595', 'Highland Burn', 'f009-0595.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0591', 'Wild Thistle', 'f009-0591.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0589', 'Mountain Ash', 'f009-0589.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0593', 'Cowslip', 'f009-0593.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0596', 'Berber', 'f009-0596.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0598', 'Donegal', 'f009-0598.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0597', 'Hopsack', 'f009-0597.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0599', 'Apples', 'f009-0599.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0600', 'Dewberry', 'f009-0600.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0601', 'Flutter', 'f009-0601.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0602', 'Soft Teal', 'f009-0602.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0603', 'Dark Purple', 'f009-0603.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F009', 'F009-0604', 'Damson', 'f009-0604.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F039';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F039';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F039', 'Wash ''n'' Wear Double Crepe Dk', 'DK', 'Classics', 'f039-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0361', 'Coffee', 'f039-0361.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0362', 'Rustic Rose', 'f039-0362.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0363', 'Spearmint', 'f039-0363.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0251', 'White', 'f039-0251.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0239', 'Cream', 'f039-0239.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0327', 'Atlantic  ', 'f039-0327.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0283', 'Beige', 'f039-0283.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0259', 'Starling', 'f039-0259.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0260', 'Oatmeal Nep', 'f039-0260.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0282', 'Silver Cloud', 'f039-0282.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0318', 'Duck Egg', 'f039-0318.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0264', 'Hydrangea Blue', 'f039-0264.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0300', 'Original Denim', 'f039-0300.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0224', 'Light Navy', 'f039-0224.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0326', 'Dusky Pink', 'f039-0326.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0315', 'Blush Pink', 'f039-0315.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0275', 'Black', 'f039-0275.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0278', 'Cherry', 'f039-0278.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0242', 'Flamenco', 'f039-0242.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0209', 'Watery', 'f039-0209.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0210', 'Zest', 'f039-0210.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0358', 'Cassis', 'f039-0358.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0359', 'Kir', 'f039-0359.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F039', 'F039-0360', 'Parsley', 'f039-0360.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F016';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F016';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F016', 'Denim Tweed Dk', 'DK', 'Classics', 'f016-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0508', 'Ivory Cream', 'f016-0508.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0507', 'Starling', 'f016-0507.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0502', 'Denim Blue', 'f016-0502.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0644', 'Vintage', 'f016-0644.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0649', 'Nutmeg Marl', 'f016-0649.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0648', 'Plum Duff', 'f016-0648.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0651', 'Lavender', 'f016-0651.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0652', 'Hazelnut', 'f016-0652.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0653', 'Blue Suede', 'f016-0653.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0655', 'Bakery', 'f016-0655.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F016', 'F016-0656', 'Aspen Blue', 'f016-0656.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F013';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F013';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F013', 'Bonus Dk', 'DK', 'Classics', 'f013-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0836', 'Airforce Blue', 'f013-0836.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0833', 'Classic Red', 'f013-0833.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0834', 'Green', 'f013-0834.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0835', 'Merlot', 'f013-0835.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0987', 'Starling', 'f013-0987.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0964', 'Oatmeal', 'f013-0964.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0947', 'Chocolate', 'f013-0947.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0984', 'Cerise', 'f013-0984.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0971', 'Navy', 'f013-0971.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0994', 'Denim  ', 'f013-0994.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0963', 'Flesh Tone', 'f013-0963.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0993', 'Aran', 'f013-0993.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0957', 'Primrose', 'f013-0957.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0961', 'White', 'f013-0961.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0958', 'Iced Pink', 'f013-0958.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0959', 'Lilac', 'f013-0959.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0906', 'Velvet Plum', 'f013-0906.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0960', 'Powder Blue', 'f013-0960.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0956', 'Mint  ', 'f013-0956.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0992', 'Pink', 'f013-0992.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0969', 'Bluebell', 'f013-0969.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0979', 'Royal', 'f013-0979.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0944', 'Cupid', 'f013-0944.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0998', 'Turquoise', 'f013-0998.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0977', 'Signal Red', 'f013-0977.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0904', 'Orchard', 'f013-0904.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0965', 'Black', 'f013-0965.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0891', 'Rustic Red', 'f013-0891.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0916', 'Emerald', 'f013-0916.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0978', 'Sunflower', 'f013-0978.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0981', 'Bright Orange', 'f013-0981.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0886', 'Bright Green', 'f013-0886.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0887', 'Bright Pink', 'f013-0887.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0840', 'Purple', 'f013-0840.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0841', 'Claret', 'f013-0841.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0842', 'Alpine', 'f013-0842.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0843', 'Copper', 'f013-0843.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0882', 'Lime', 'f013-0882.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0884', 'Neon', 'f013-0884.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0885', 'Electra', 'f013-0885.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0839', 'Bottle Green', 'f013-0839.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0838', 'Charcoal', 'f013-0838.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0828', 'Bright Purple', 'f013-0828.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0829', 'Petrol', 'f013-0829.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0930', 'Sandstorm', 'f013-0930.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F013', 'F013-0931', 'Stormcloud', 'f013-0931.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F033';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F033';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F033', 'Denim Aran', 'Aran', 'Classics', 'f033-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F033', 'F033-0508', 'Ivory Cream', 'f033-0508.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F033', 'F033-0507', 'Starling', 'f033-0507.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F033', 'F033-0502', 'Denim Blue', 'f033-0502.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F119';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F119';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F119', 'Bonus Aran 400g with Wool', 'Aran', 'Classics', 'f119-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0847', 'Eau de Nil', 'f119-0847.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0842', 'Alpine', 'f119-0842.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0830', 'Deep Red', 'f119-0830.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0831', 'Millstone Tweed', 'f119-0831.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0965', 'Black', 'f119-0965.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0994', 'Denim  ', 'f119-0994.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0950', 'Cherry', 'f119-0950.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0962', 'Ivory Cream', 'f119-0962.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0931', 'Stormcloud', 'f119-0931.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0930', 'Sandstorm', 'f119-0930.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0934', 'Green Heather', 'f119-0934.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0933', 'Blue Heather', 'f119-0933.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0932', 'Soft Blue', 'f119-0932.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0936', 'Light Natural', 'f119-0936.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0905', 'Tudor Rose', 'f119-0905.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0929', 'Glen Coe', 'f119-0929.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0872', 'Barley', 'f119-0872.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0871', 'Purple Heather', 'f119-0871.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0870', 'Rose Brown', 'f119-0870.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0867', 'Lilac Tweed', 'f119-0867.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0868', 'Island Tweed', 'f119-0868.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0869', 'Granite Tweed', 'f119-0869.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0995', 'Navy', 'f119-0995.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0996', 'Violet', 'f119-0996.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F119', 'F119-0997', 'Celtic Grey', 'f119-0997.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F037';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F037';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F037', 'Click Aran with Wool', 'Aran', 'Classics', 'f037-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0142', 'Lamb', 'f037-0142.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0162', 'Shepherd', 'f037-0162.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0144', 'Downy', 'f037-0144.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0151', 'Rustique', 'f037-0151.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0161', 'Crofter', 'f037-0161.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0147', 'Loom Blue', 'f037-0147.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0128', 'Tarn', 'f037-0128.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0127', 'Spruce', 'f037-0127.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0136', 'Foxglove', 'f037-0136.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0148', 'Bud', 'f037-0148.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0113', 'Rush', 'f037-0113.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0110', 'Verve', 'f037-0110.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0115', 'Cove Blue', 'f037-0115.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F037', 'F037-0123', 'Deep Blue', 'f037-0123.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F087';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F087';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F087', 'Crofter Chunky', 'Chunky', 'Classics', 'f087-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0042', 'Skerry', 'f087-0042.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0045', 'Seagrass', 'f087-0045.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0044', 'Hebrides', 'f087-0044.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0043', 'Iona', 'f087-0043.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0050', 'Bracken', 'f087-0050.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0052', 'Thistle', 'f087-0052.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0053', 'Hound Dog', 'f087-0053.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0059', 'Rambler Rose', 'f087-0059.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0060', 'Loganberry', 'f087-0060.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0061', 'Misty Moor', 'f087-0061.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0046', 'Heathery', 'f087-0046.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0047', 'Skye', 'f087-0047.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0048', 'Munroe', 'f087-0048.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F087', 'F087-0049', 'Plumage', 'f087-0049.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F045';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F045';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F045', 'Click Chunky with Wool', 'Chunky', 'Classics', 'f045-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0167', 'Peppercorn', 'f045-0167.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0169', 'Wild Cherry', 'f045-0169.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0166', 'Winter Violet', 'f045-0166.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0168', 'Woodland', 'f045-0168.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0144', 'Downy', 'f045-0144.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0151', 'Rustique', 'f045-0151.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0147', 'Loom Blue', 'f045-0147.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0146', 'Bloom', 'f045-0146.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0142', 'Lamb', 'f045-0142.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0143', 'Duffler', 'f045-0143.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0141', 'Indy', 'f045-0141.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0148', 'Bud', 'f045-0148.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0160', 'Flock', 'f045-0160.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F063-0128', 'Tarn', 'f063-0128.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0138', 'Black Sheep', 'f045-0138.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0131', 'Heather', 'f045-0131.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0130', 'Cranberry', 'f045-0130.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0129', 'Cobble', 'f045-0129.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0132', 'Fern', 'f045-0132.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0112', 'Wild', 'f045-0112.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0110', 'Verve', 'f045-0110.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0111', 'Blazer', 'f045-0111.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0163', 'Really Red', 'f045-0163.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0164', 'Botany Blue', 'f045-0164.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F045', 'F045-0165', 'Marine Blue', 'f045-0165.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F032';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F032';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F032', 'Denim Chunky', 'Chunky', 'Classics', 'f032-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F032', 'F032-0502', 'Denim Blue', 'f032-0502.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F032', 'F032-0507', 'Starling', 'f032-0507.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F032', 'F032-0508', 'Ivory Cream', 'f032-0508.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F032', 'F032-0644', 'Vintage', 'f032-0644.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F060';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F060';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F060', 'Bonus Chunky', 'Chunky', 'Classics', 'f060-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0930', 'Sandstorm', 'f060-0930.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0936', 'Light Natural', 'f060-0936.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0828', 'Bright Purple', 'f060-0828.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0829', 'Petrol', 'f060-0829.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0987', 'Starling', 'f060-0987.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0993', 'Aran', 'f060-0993.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0977', 'Signal Red', 'f060-0977.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0971', 'Navy', 'f060-0971.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0961', 'White', 'f060-0961.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0965', 'Black', 'f060-0965.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0845', 'Thomas Blue', 'f060-0845.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0846', 'Raspberry', 'f060-0846.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0847', 'Eau de Nil', 'f060-0847.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0892', 'Antique Rose', 'f060-0892.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0851', 'Pastel Pink', 'f060-0851.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0852', 'Pastel Lemon', 'f060-0852.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0854', 'Pastel Blue', 'f060-0854.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0873', 'Floss', 'f060-0873.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0876', 'Firecracker', 'f060-0876.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0884', 'Neon', 'f060-0884.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0885', 'Electra', 'f060-0885.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F060', 'F060-0931', 'Stormcloud', 'f060-0931.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F025';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F025';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F025', 'Denim Ultra', 'Super Chunky', 'Classics', 'f025-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0657', 'Red Flare', 'f025-0657.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0658', 'Union Green', 'f025-0658.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0508', 'Ivory Cream', 'f025-0508.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0507', 'Starling', 'f025-0507.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0636', 'Walnut', 'f025-0636.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0645', 'Madder Pink', 'f025-0645.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0502', 'Denim Blue', 'f025-0502.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0644', 'Vintage', 'f025-0644.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0637', 'Seaspray', 'f025-0637.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0649', 'Nutmeg Marl', 'f025-0649.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0650', 'Husky Grey', 'f025-0650.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0648', 'Plum Duff', 'f025-0648.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0653', 'Blue Suede', 'f025-0653.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0655', 'Bakery', 'f025-0655.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F025', 'F025-0656', 'Aspen Blue', 'f025-0656.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F042';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F042';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F042', 'Connemara Chunky', '', 'Fashion', 'f042-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F042', 'F042-0350', 'Wheatsheaf', 'f042-0350.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F042', 'F042-0351', 'Carrow Brown', 'f042-0351.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F042', 'F042-0352', 'Homestead', 'f042-0352.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F042', 'F042-0353', 'Wayfarer', 'f042-0353.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F042', 'F042-0354', 'Heartland', 'f042-0354.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F042', 'F042-0355', 'Hornpipe', 'f042-0355.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F062';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F062';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F062', 'Indie', '', 'Fashion', 'f062-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F062', 'F062-0150', 'Apache', 'f062-0150.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F062', 'F062-0151', 'Navajo', 'f062-0151.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F062', 'F062-0152', 'Arizona', 'f062-0152.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F062', 'F062-0153', 'Pioneer', 'f062-0153.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F062', 'F062-0154', 'Montana', 'f062-0154.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F062', 'F062-0155', 'Prairie', 'f062-0155.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F062', 'F062-0156', 'Little Bighorn', 'f062-0156.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F062', 'F062-0157', 'Crazy Horse', 'f062-0157.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F053';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F053';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F053', 'Flirt Dk', '', 'Fashion', 'f053-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0220', 'White Diamonds', 'f053-0220.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0221', 'Champers', 'f053-0221.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0222', 'Slinky Silver', 'f053-0222.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0223', 'Burnished Bronze', 'f053-0223.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0224', 'Rouge', 'f053-0224.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0225', 'Hypnotic', 'f053-0225.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0226', 'Sassy Black', 'f053-0226.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0227', 'Creme', 'f053-0227.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0228', 'Cosmopolitan', 'f053-0228.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F053', 'F053-0229', 'Flirtini', 'f053-0229.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F091';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F091';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F091', 'Snowball', '', 'Fashion', 'f091-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0001', 'Snow White', 'f091-0001.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0002', 'Bunny Tail', 'f091-0002.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0003', 'Hot Pink', 'f091-0003.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0004', 'Glamour Red', 'f091-0004.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0005', 'Berry', 'f091-0005.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0006', 'Rosie Pink', 'f091-0006.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0007', 'Vivid Violet', 'f091-0007.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0008', 'Neon Blue', 'f091-0008.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0009', 'Black Velvet', 'f091-0009.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0010', 'Magpie', 'f091-0010.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0011', 'Tutti Frutti', 'f091-0011.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F091', 'F091-0012', 'Leopard', 'f091-0012.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F055';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F055';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F055', 'One Hour Scarf', '', 'Fashion', 'f055-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F055', 'F055-0402', 'Bambi', 'f055-0402.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F055', 'F055-0409', 'Dream Green', 'f055-0409.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F055', 'F055-0403', 'Dashing Red', 'f055-0403.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F055', 'F055-0405', 'Black Jack', 'f055-0405.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F055', 'F055-0408', 'Igloo', 'f055-0408.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F055', 'F055-0407', 'Polar Bear', 'f055-0407.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F055', 'F055-0401', 'Boogie Woogie', 'f055-0401.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F055', 'F055-0400', 'Velvetina', 'f055-0400.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F041';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F041';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F041', 'Persia Chunky', '', 'Fashion', 'f041-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0400', 'Byzantine', 'f041-0400.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0399', 'Empire Red', 'f041-0399.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0401', 'Sultan', 'f041-0401.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0390', 'Moscow', 'f041-0390.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0391', 'Vladimir', 'f041-0391.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0392', 'Karenina', 'f041-0392.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0393', 'Black Russian', 'f041-0393.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0394', 'Pavlova', 'f041-0394.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0395', 'Ottoman', 'f041-0395.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0396', 'Imperial', 'f041-0396.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0397', 'Faberge', 'f041-0397.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F041', 'F041-0398', 'Beluga', 'f041-0398.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F038';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F038';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F038', 'Escape Chunky', '', 'Fashion', 'f038-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0179', 'Endeavour', 'f038-0179.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0178', 'Loud', 'f038-0178.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0184', 'Tranquil', 'f038-0184.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0195', 'Tease', 'f038-0195.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0196', 'Forbidden', 'f038-0196.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0192', 'Luscious', 'f038-0192.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0193', 'Fever', 'f038-0193.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0194', 'Temptation', 'f038-0194.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0183', 'Euphoria', 'f038-0183.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0180', 'Fury', 'f038-0180.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0187', 'Ecstasy', 'f038-0187.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0197', 'Ravishing', 'f038-0197.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F038', 'F038-0198', 'Destiny', 'f038-0198.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F052';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F052';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F052', 'Nomad', '', 'Fashion', 'f052-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F052', 'F052-0016', 'Katmandu', 'f052-0016.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F052', 'F052-0010', 'Alaska', 'f052-0010.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F052', 'F052-0011', 'Elk', 'f052-0011.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F052', 'F052-0012', 'Tibet', 'f052-0012.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F052', 'F052-0013', 'Himalaya', 'f052-0013.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F052', 'F052-0014', 'Tundra', 'f052-0014.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F052', 'F052-0015', 'Reindeer', 'f052-0015.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F046';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F046';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F046', 'Tweedie Chunky', '', 'Fashion', 'f046-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F046', 'F046-0280', 'Buckwheat', 'f046-0280.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F046', 'F046-0281', 'Truffle', 'f046-0281.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F046', 'F046-0282', 'Wood Pigeon', 'f046-0282.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F046', 'F046-0283', 'Grouse', 'f046-0283.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F046', 'F046-0284', 'Roasted Berry', 'f046-0284.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F046', 'F046-0285', 'Cedar', 'f046-0285.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F046', 'F046-0286', 'Fleck', 'f046-0286.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F046', 'F046-0287', 'Mallard', 'f046-0287.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F040';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F040';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F040', 'Big Softie', '', 'Fashion', 'f040-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0345', 'Vivid', 'f040-0345.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0346', 'Bling Blue', 'f040-0346.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0347', 'Wink Pink', 'f040-0347.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0348', 'Jazzy', 'f040-0348.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0330', 'Meringue', 'f040-0330.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0331', 'Muffin', 'f040-0331.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0333', 'Souffle', 'f040-0333.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0335', 'Blancmange', 'f040-0335.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0332', 'Marshmallow', 'f040-0332.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0334', 'Cupcake', 'f040-0334.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0336', 'Foam', 'f040-0336.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0337', 'Teddy', 'f040-0337.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0338', 'Kitten', 'f040-0338.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0339', 'Cherry Pie', 'f040-0339.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0340', 'Flossie', 'f040-0340.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0341', 'Mitten', 'f040-0341.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0342', 'Muffler', 'f040-0342.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0344', 'Boho', 'f040-0344.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F040', 'F040-0343', 'Puffball', 'f040-0343.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F049';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F049';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F049', 'Escape Dk', '', 'Fashion', 'f049-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0179', 'Endeavour', 'f049-0179.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0178', 'Loud', 'f049-0178.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0186', 'Innocence', 'f049-0186.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0182', 'Vibe', 'f049-0182.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0184', 'Tranquil', 'f049-0184.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0183', 'Euphoria', 'f049-0183.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0181', 'Fervour', 'f049-0181.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0180', 'Fury', 'f049-0180.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0187', 'Ecstasy', 'f049-0187.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0185', 'Passion', 'f049-0185.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0188', 'Smoulder', 'f049-0188.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0189', 'Desire', 'f049-0189.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0190', 'Freespirit', 'f049-0190.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0191', 'Fascination', 'f049-0191.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0192', 'Luscious', 'f049-0192.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0193', 'Fever', 'f049-0193.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0194', 'Temptation', 'f049-0194.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0200', 'Frolic', 'f049-0200.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0197', 'Ravishing', 'f049-0197.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F049', 'F049-0199', 'Vivacious', 'f049-0199.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F028';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F028';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F028', 'Calico Dk', '', 'Fashion', 'f028-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0728', 'Bandana', 'f028-0728.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0729', 'Oasis', 'f028-0729.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0730', 'Panama Pink', 'f028-0730.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0731', 'South Beach', 'f028-0731.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0723', 'Cotton White', 'f028-0723.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0721', 'Linen', 'f028-0721.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0724', 'Muslin', 'f028-0724.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0727', 'Lime Canvas', 'f028-0727.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0725', 'Washed Gingham', 'f028-0725.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0720', 'Chambray', 'f028-0720.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0717', 'Clamdigger', 'f028-0717.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0718', 'Splash', 'f028-0718.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0719', 'Bikini', 'f028-0719.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0714', 'Amber', 'f028-0714.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0716', 'Spicy', 'f028-0716.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F028', 'F028-0715', 'Lobster', 'f028-0715.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F012';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F012';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F012', 'Eco Wool Dk', '', 'Fashion', 'f012-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F012', 'F012-0200', 'Ecru', 'f012-0200.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F012', 'F012-0201', 'Natural', 'f012-0201.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F012', 'F012-0202', 'Clay', 'f012-0202.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F012', 'F012-0203', 'Earth', 'f012-0203.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F012', 'F012-0204', 'Flint', 'f012-0204.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F012', 'F012-0205', 'Cobblestones', 'f012-0205.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F012', 'F012-0206', 'Shale', 'f012-0206.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F005';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F005';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F005', 'Yo Yo', '', 'Fashion', 'f005-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F005', 'F005-0002', 'Plume', 'f005-0002.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F005', 'F005-0001', 'Smokey', 'f005-0001.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F005', 'F005-0018', 'Sable', 'f005-0018.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F005', 'F005-0019', 'Peacock', 'f005-0019.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F005', 'F005-0006', 'Moss', 'f005-0006.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F005', 'F005-0017', 'Fudge', 'f005-0017.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F005', 'F005-0015', 'Storm Cloud', 'f005-0015.jpg');




DELETE FROM sirdar_yarn WHERE yarn_code = 'F095';
DELETE FROM sirdar_yarn_shade WHERE yarn_code = 'F095';

INSERT INTO sirdar_yarn (yarn_code, yarn_name, ply_name, style_name, yarn_image) VALUES ('F095', 'Funky Fur', '', 'Fashion', 'f095-large.jpg');

INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F095', 'F095-0533', 'Angel Pink', 'f095-0533.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F095', 'F095-0512', 'White', 'f095-0512.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F095', 'F095-0511', 'Cream', 'f095-0511.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F095', 'F095-0550', 'Latte', 'f095-0550.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F095', 'F095-0549', 'Walnut', 'f095-0549.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F095', 'F095-0548', 'Chocolate', 'f095-0548.jpg');
INSERT INTO sirdar_yarn_shade (yarn_code, shade_code, shade_name, shade_image) VALUES ('F095', 'F095-0510', 'Jet Black', 'f095-0510.jpg');




