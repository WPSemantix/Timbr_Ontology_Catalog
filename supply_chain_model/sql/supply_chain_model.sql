CREATE OR REPLACE PROPERTY `plant_id` integer;
CREATE OR REPLACE PROPERTY `price_per_1_kg` integer;
CREATE OR REPLACE PROPERTY `shipping_date` date;
CREATE OR REPLACE PROPERTY `shipment_year_month` string AS SELECT  DATE_FORMAT(`shipping_date`, '%Y/%m');
CREATE OR REPLACE PROPERTY `ratio_material_1` decimal;
CREATE OR REPLACE PROPERTY `delivery_time_per_5_kg` integer;
CREATE OR REPLACE PROPERTY `price_per_10_kg` integer;
CREATE OR REPLACE PROPERTY `ratio_material_2` decimal;
CREATE OR REPLACE PROPERTY `ratio_material_3` decimal;
CREATE OR REPLACE PROPERTY `order_profit` decimal;
CREATE OR REPLACE PROPERTY `order_region` string;
CREATE OR REPLACE PROPERTY `product_price` decimal;
CREATE OR REPLACE PROPERTY `inventory_name` string;
CREATE OR REPLACE PROPERTY `sales` decimal;
CREATE OR REPLACE PROPERTY `supplier_location` string;
CREATE OR REPLACE PROPERTY `inventory_city` string;
CREATE OR REPLACE PROPERTY `order_status` string;
CREATE OR REPLACE PROPERTY `delivery_time_per_1_kg` integer;
CREATE OR REPLACE PROPERTY `material_2` string DESCRIPTION = 'Restricted';
CREATE OR REPLACE PROPERTY `material_3` string;
CREATE OR REPLACE PROPERTY `inventory_country` string;
CREATE OR REPLACE PROPERTY `order_date` date;
CREATE OR REPLACE PROPERTY `order_year` integer AS SELECT YEAR(order_date);
CREATE OR REPLACE PROPERTY `price` decimal;
CREATE OR REPLACE PROPERTY `material_1` string DESCRIPTION = 'Confidential';
CREATE OR REPLACE PROPERTY `order_item_discount` decimal;
CREATE OR REPLACE PROPERTY `product_id` integer;
CREATE OR REPLACE PROPERTY `id` integer;
CREATE OR REPLACE PROPERTY `order_zipcode` string;
CREATE OR REPLACE PROPERTY `image` string;
CREATE OR REPLACE PROPERTY `plant_city` string;
CREATE OR REPLACE PROPERTY `delivery_time_per_10_kg` integer;
CREATE OR REPLACE PROPERTY `inventory_id` integer;
CREATE OR REPLACE PROPERTY `customer_first_name` string;
CREATE OR REPLACE PROPERTY `producing_product_id` string;
CREATE OR REPLACE PROPERTY `shipment_id` integer;
CREATE OR REPLACE PROPERTY `product_name` string;
CREATE OR REPLACE PROPERTY `market` string;
CREATE OR REPLACE PROPERTY `order_city` string;
CREATE OR REPLACE PROPERTY `order_item_profit_ratio` decimal;
CREATE OR REPLACE PROPERTY `materials` string;
CREATE OR REPLACE PROPERTY `internal_storage_id` integer;
CREATE OR REPLACE PROPERTY `customer_email` string;
CREATE OR REPLACE PROPERTY `scheduled_days_for_shipment` integer;
CREATE OR REPLACE PROPERTY `order_id` integer WITH TAGS (`mdx.label` = 'Order ID',`classification` = 'PII',`mdx.visibility` = 'true');
CREATE OR REPLACE PROPERTY `item_quantity` integer;
CREATE OR REPLACE PROPERTY `real_days_for_shipment` integer;
CREATE OR REPLACE PROPERTY `order_item_quantity` bigint;
CREATE OR REPLACE PROPERTY `order_item_discount_rate` decimal;
CREATE OR REPLACE PROPERTY `order_item_number` integer;
CREATE OR REPLACE PROPERTY `customer_last_name` string;
CREATE OR REPLACE PROPERTY `inventory_state` string;
CREATE OR REPLACE PROPERTY `final_price` float AS SELECT product_price - order_item_discount;
CREATE OR REPLACE PROPERTY `department` string;
CREATE OR REPLACE PROPERTY `order_item_total` decimal;
CREATE OR REPLACE PROPERTY `quantity_material_2` integer;
CREATE OR REPLACE PROPERTY `supplier_name` string;
CREATE OR REPLACE PROPERTY `material_name` string;
CREATE OR REPLACE PROPERTY `quantity_material_3` integer;
CREATE OR REPLACE PROPERTY `quantity_material_1` integer;
CREATE OR REPLACE PROPERTY `plant_description` string;
CREATE OR REPLACE PROPERTY `plant_country` string;
CREATE OR REPLACE PROPERTY `customer_segment` string;
CREATE OR REPLACE PROPERTY `late_delivery_risk` integer;
CREATE OR REPLACE PROPERTY `referral` string;
CREATE OR REPLACE PROPERTY `shipping_mode` string;
CREATE OR REPLACE PROPERTY `material_id` integer WITH TAGS (`length` = 'max length 10 characters');
CREATE OR REPLACE PROPERTY `customer_name` string AS SELECT CONCAT(customer_first_name, ' ', customer_last_name);
CREATE OR REPLACE PROPERTY `category` string DESCRIPTION = 'Product category';
CREATE OR REPLACE PROPERTY `customer_id` integer;
CREATE OR REPLACE PROPERTY `order_state` string;
CREATE OR REPLACE PROPERTY `price_per_5_kg` integer;
CREATE OR REPLACE PROPERTY `delivery_status` string;
CREATE OR REPLACE PROPERTY `order_country` string;
CREATE OR REPLACE PROPERTY `plant_name` string;
CREATE OR REPLACE MEASURE `total_item_quantity` double DESCRIPTION = 'The total amount of Item Quantity' AS SELECT SUM(`item_quantity`);
CREATE OR REPLACE MEASURE `count_of_shipment` bigint DESCRIPTION = 'The total number of unique Shipment' AS SELECT COUNT(DISTINCT `shipment_id`);
CREATE OR REPLACE MEASURE `maximum_product_price` decimal DESCRIPTION = 'The highest Product Price value' AS SELECT MAX(`product_price`);
CREATE OR REPLACE MEASURE `average_product_price` decimal DESCRIPTION = 'The average Product Price value' AS SELECT AVG(`product_price`);
CREATE OR REPLACE MEASURE `count_of_customer` bigint DESCRIPTION = 'The total number of unique Customer' AS SELECT COUNT(DISTINCT `customer_id`);
CREATE OR REPLACE MEASURE `count_of_order` bigint DESCRIPTION = 'The total number of unique Order' AS SELECT COUNT(DISTINCT `order_id`);
CREATE OR REPLACE MEASURE `count_of_late_shipment` bigint AS SELECT count_of_shipment WHERE `delivery_status` = 'Late delivery';
CREATE OR REPLACE MEASURE `late_shipment_ratio` double AS SELECT (count_of_shipment - count_of_late_shipment) / count_of_shipment;
CREATE OR REPLACE MEASURE `total_order_item_discount` double DESCRIPTION = 'The total amount of Order Item Discount' AS SELECT SUM(`order_item_discount`);
CREATE OR REPLACE MEASURE `total_sales` double DESCRIPTION = 'The total amount of Sales' AS SELECT SUM(`sales`);
CREATE OR REPLACE MEASURE `total_revenue` double AS SELECT total_sales - total_order_item_discount;
CREATE OR REPLACE MEASURE `total_price_per_1_kg` double DESCRIPTION = 'The total amount of Price Per 1 Kg' AS SELECT SUM(`price_per_1_kg`);
CREATE OR REPLACE MEASURE `count_of_product` bigint DESCRIPTION = 'The total number of unique Product' AS SELECT COUNT(DISTINCT `product_id`);
CREATE OR REPLACE CONCEPT `shipment` (`shipment_year_month` string, `late_delivery_risk` integer, `shipping_mode` string, `delivery_status` string, `customer_id` integer, `shipping_date` date, `scheduled_days_for_shipment` integer, `shipment_id` integer, `order_id` integer, `real_days_for_shipment` integer, `count_of_order` measure bigint, `count_of_shipment` measure bigint, `count_of_customer` measure bigint, `count_of_late_shipment` measure bigint, `late_shipment_ratio` measure double, PRIMARY KEY (`shipment_id`, `order_id`), LABEL (`shipping_mode`, `delivery_status`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-shipping-fast');
CREATE OR REPLACE CONCEPT `product` (`image` string, `category` string, `price` decimal, `department` string, `product_name` string, `product_id` integer, `count_of_product` measure bigint, `material_name` string, PRIMARY KEY (`product_id`), LABEL (`product_name`), CONSTRAINT `contains` MULTIREFERENCE `material` INVERSEOF `used_in` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-box-open');
CREATE OR REPLACE CONCEPT `plant` (`plant_id` integer, `id` integer, `plant_country` string, `plant_city` string, `producing_product_id` string, `plant_description` string, `plant_name` string, `inventory_id` integer, PRIMARY KEY (`plant_id`), LABEL (`plant_name`), CONSTRAINT `shipped_to` MULTIREFERENCE `inventory` INVERSEOF `made_in_plant` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-city');
CREATE OR REPLACE CONCEPT `order` (`product_price` decimal, `order_status` string, `order_region` string, `order_item_number` integer, `order_year` integer, `customer_id` integer, `order_profit` decimal, `order_city` string, `final_price` float, `order_item_discount` decimal, `order_item_total` decimal, `order_zipcode` string, `sales` decimal, `referral` string, `market` string, `order_country` string, `order_item_discount_rate` decimal, `order_date` date, `order_state` string, `order_id` integer, `order_item_profit_ratio` decimal, `product_id` integer, `order_item_quantity` bigint, `count_of_order` measure bigint, `total_revenue` measure double, `count_of_product` measure bigint, `count_of_customer` measure bigint, `total_sales` measure double, `maximum_product_price` measure decimal, `average_product_price` measure decimal, `total_order_item_discount` measure double, PRIMARY KEY (`order_id`, `product_id`), CONSTRAINT `includes_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) INVERSEOF `of_order` , CONSTRAINT `in_shipment` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`order_id`) INVERSEOF `of_order` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-sheet-plastic',`hierarchy.location` = 'market,order_region,order_country');
CREATE OR REPLACE CONCEPT `material` (`price_per_1_kg` integer, `delivery_time_per_1_kg` integer, `materials` string, `id` integer, `material_name` string, `supplier_location` string, `delivery_time_per_5_kg` integer, `price_per_5_kg` integer, `delivery_time_per_10_kg` integer, `price_per_10_kg` integer, `supplier_name` string, `material_id` integer, `total_price_per_1_kg` measure double, PRIMARY KEY (`id`), LABEL (`material_name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-fill-drip');
CREATE OR REPLACE CONCEPT `inventory` (`item_quantity` integer, `category` string, `inventory_name` string, `id` integer, `inventory_city` string, `inventory_country` string, `inventory_state` string, `department` string, `product_name` string, `inventory_id` integer, `product_id` integer, `internal_storage_id` integer, `count_of_product` measure bigint, `total_item_quantity` measure double, PRIMARY KEY (`inventory_id`, `product_id`), LABEL (`inventory_name`), CONSTRAINT `of_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) INVERSEOF `in_inventory` , CONSTRAINT `of_order` FOREIGN KEY (`product_id`) REFERENCES `order` (`product_id`) INVERSEOF `of_inventory` ) INHERITS (`thing`) DESCRIPTION 'Inventory data' WITH TAGS (`icon` = 'fa-warehouse');
CREATE OR REPLACE CONCEPT `customer` (`customer_first_name` string, `customer_email` string, `customer_last_name` string, `customer_name` string, `customer_segment` string, `customer_id` integer, `count_of_customer` measure bigint, PRIMARY KEY (`customer_id`), LABEL (`customer_first_name`, `customer_last_name`), CONSTRAINT `received_shipment` FOREIGN KEY (`customer_id`) REFERENCES `shipment` (`customer_id`) INVERSEOF `of_customer` , CONSTRAINT `made_order` FOREIGN KEY (`customer_id`) REFERENCES `order` (`customer_id`) INVERSEOF `of_customer` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-user');
CREATE OR REPLACE CONCEPT `bill_of_material` (`id` integer, `ratio_material_1` decimal, `material_1` string, `ratio_material_3` decimal, `quantity_material_2` integer, `material_3` string, `ratio_material_2` decimal, `material_2` string, `product_name` string, `quantity_material_1` integer, `product_id` integer, `quantity_material_3` integer, `count_of_product` measure bigint, PRIMARY KEY (`product_id`), LABEL (`product_name`), CONSTRAINT `of_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) INVERSEOF `has_bill_of_material` , CONSTRAINT `in_inventory` FOREIGN KEY (`product_id`) REFERENCES `inventory` (`product_id`) INVERSEOF `has_bill_of_material` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-table-list');
CREATE OR REPLACE CONCEPT `standard_class_shipment`  INHERITS (`shipment`) FROM timbr.`shipment` WHERE `shipping_mode` = 'Standard Class';
CREATE OR REPLACE CONCEPT `second_class_shipment`  INHERITS (`shipment`) FROM timbr.`shipment` WHERE `shipping_mode` = 'Second Class';
CREATE OR REPLACE CONCEPT `same_day_shipment`  INHERITS (`shipment`) FROM timbr.`shipment` WHERE `shipping_mode` = 'Same Day';
CREATE OR REPLACE CONCEPT `late_delivery_shipment`  INHERITS (`shipment`) FROM timbr.`shipment` WHERE `delivery_status` = 'Late delivery';
CREATE OR REPLACE CONCEPT `first_class_shipment`  INHERITS (`shipment`) FROM timbr.`shipment` WHERE `shipping_mode` = 'First Class';
CREATE OR REPLACE CONCEPT `outdoors_product`  INHERITS (`product`) FROM timbr.`product` WHERE `department` = 'Outdoors';
CREATE OR REPLACE CONCEPT `golf_product`  INHERITS (`product`) FROM timbr.`product` WHERE `department` = 'Golf';
CREATE OR REPLACE CONCEPT `footwear_product`  INHERITS (`product`) FROM timbr.`product` WHERE `department` = 'Footwear';
CREATE OR REPLACE CONCEPT `fitness_product`  INHERITS (`product`) FROM timbr.`product` WHERE `department` = 'Fitness';
CREATE OR REPLACE CONCEPT `fan_shop_product`  INHERITS (`product`) FROM timbr.`product` WHERE `department` = 'Fan Shop';
CREATE OR REPLACE CONCEPT `apparel_product`  INHERITS (`product`) FROM timbr.`product` WHERE `department` = 'Apparel';
CREATE OR REPLACE CONCEPT `usca_order`  INHERITS (`order`) FROM timbr.`order` WHERE `market` = 'USCA';
CREATE OR REPLACE CONCEPT `pacific_asia_order`  INHERITS (`order`) FROM timbr.`order` WHERE `market` = 'Pacific Asia';
CREATE OR REPLACE CONCEPT `latam_order`  INHERITS (`order`) FROM timbr.`order` WHERE `market` = 'LATAM';
CREATE OR REPLACE CONCEPT `europe_order`  INHERITS (`order`) FROM timbr.`order` WHERE `market` = 'Europe';
CREATE OR REPLACE CONCEPT `africa_order`  INHERITS (`order`) FROM timbr.`order` WHERE `market` = 'Africa';
CREATE OR REPLACE CONCEPT `home_office_customer`  INHERITS (`customer`) FROM timbr.`customer` WHERE `customer_segment` = 'Home Office';
CREATE OR REPLACE CONCEPT `customer_with_high_value_orders`  INHERITS (`customer`) FROM dtimbr.`customer` WHERE `made_order[order].order_profit` > 50.3800011;
CREATE OR REPLACE CONCEPT `corporate_customer`  INHERITS (`customer`) FROM timbr.`customer` WHERE `customer_segment` = 'Corporate';
CREATE OR REPLACE CONCEPT `consumer_customer`  INHERITS (`customer`) FROM timbr.`customer` WHERE `customer_segment` = 'Consumer';
CREATE OR REPLACE MAPPING `map_order_q_xnra8zpb` INTO (`order`) USING `mysql` AS SELECT
  `product_id` AS `product_id`,
  `customer_id` AS `customer_id`,
  `order_city` AS `order_city`,
  `order_country` AS `order_country`,
  `order_date` AS `order_date`,
  `order_id` AS `order_id`,
  `order_item_discount` AS `order_item_discount`,
  `order_item_discount_rate` AS `order_item_discount_rate`,
  `order_item_profit_ratio` AS `order_item_profit_ratio`,
  `order_item_quantity` AS `order_item_quantity`,
  `sales` AS `sales`,
  `order_item_total` AS `order_item_total`,
  `order_profit` AS `order_profit`,
  `order_region` AS `order_region`,
  `order_state` AS `order_state`,
  `order_status` AS `order_status`,
  `order_zipcode` AS `order_zipcode`,
  `market` AS `market`,
  `product_price` AS `product_price`,
  `order_item_number` AS `order_item_number`
FROM `scdata_demo`.`order`;
CREATE OR REPLACE MAPPING `map_shipment_sumlxdz3gj` INTO (`shipment`) USING `mysql` AS SELECT
  `customer_id` AS `customer_id`,
  `order_id` AS `order_id`,
  `real_days_for_shipment` AS `real_days_for_shipment`,
  `scheduled_days_for_shipment` AS `scheduled_days_for_shipment`,
  `delivery_status` AS `delivery_status`,
  `late_delivery_risk` AS `late_delivery_risk`,
  `shipping_date` AS `shipping_date`,
  `shipping_mode` AS `shipping_mode`,
  `shipment_id` AS `shipment_id`
FROM `scdata_demo`.`shipment`;
CREATE OR REPLACE MAPPING `map_material_q5m0x9hyws` INTO (`material`) USING `mysql` AS SELECT
  `material_id` AS `material_id`,
  `supplier_name` AS `supplier_name`,
  `supplier_location` AS `supplier_location`,
  `price_per_1_kg` AS `price_per_1_kg`,
  `price_per_5_kg` AS `price_per_5_kg`,
  `price_per_10_kg` AS `price_per_10_kg`,
  `delivery_time_per_1_kg` AS `delivery_time_per_1_kg`,
  `delivery_time_per_5_kg` AS `delivery_time_per_5_kg`,
  `delivery_time_per_10_kg` AS `delivery_time_per_10_kg`,
  `materials` AS `material_name`
FROM `scdata_demo`.`material`;
CREATE OR REPLACE MAPPING `map_customer_fdxexka7jr` INTO (`customer`) USING `mysql` AS SELECT
  `customer_id` AS `customer_id`,
  `customer_email` AS `customer_email`,
  `customer_first_name` AS `customer_first_name`,
  `customer_last_name` AS `customer_last_name`,
  `customer_password` AS `customer_password`,
  `customer_segment` AS `customer_segment`
FROM `scdata_demo`.`customer`;
CREATE OR REPLACE MAPPING `map_bill_of_material_33wsfjnh4q` INTO (`bill_of_material`) USING `mysql` AS SELECT
  `product_id` AS `product_id`,
  `product_name` AS `product_name`,
  `material_1` AS `material_1`,
  `material_2` AS `material_2`,
  `material_3` AS `material_3`,
  `ratio_material_1` AS `ratio_material_1`,
  `ratio_material_2` AS `ratio_material_2`,
  `ratio_material_3` AS `ratio_material_3`,
  `quantity_material_1` AS `quantity_material_1`,
  `quantity_material_2` AS `quantity_material_2`,
  `quantity_material_3` AS `quantity_material_3`
FROM `scdata_demo`.`bill_of_material`;
CREATE OR REPLACE MAPPING `map_product_snmjqdr7c8` INTO (`product`) USING `mysql` AS SELECT
  `product_id` AS `product_id`,
  `product_name` AS `product_name`,
  `category` AS `category`,
  `department` AS `department`,
  `Image` AS `image`,
  `price` AS `price`
FROM `scdata_demo`.`product`;
CREATE OR REPLACE MAPPING `map_inventory_36b7cfb_ph` INTO (`inventory`) USING `mysql` AS SELECT
  `Product_id` AS `product_id`,
  `Product_name` AS `product_name`,
  `Inventory_id` AS `inventory_id`,
  `Inventory_name` AS `inventory_name`,
  `Inventory_country` AS `inventory_country`,
  `Inventory_state` AS `inventory_state`,
  `Inventory_city` AS `inventory_city`,
  `Category` AS `category`,
  `Department` AS `department`,
  `Item_quantity` AS `item_quantity`,
  `Internal_storage_id` AS `internal_storage_id`
FROM `scdata_demo`.`inventory`;
CREATE OR REPLACE MAPPING `map_plant_m6crxpdtw8` INTO (`plant`) USING `mysql` AS SELECT
  `plant_id` AS `plant_id`,
  `plant_city` AS `plant_city`,
  `plant_name` AS `plant_name`,
  `plant_country` AS `plant_country`,
  `plant_description` AS `plant_description`
FROM `scdata_demo`.`plant`;
CREATE OR REPLACE MAPPING `map_plant_shipped_to_inventory` (constraint `shipped_to` foreign key (`inventory_id`) references `inventory` (`inventory_id`) , constraint `made_in_plant` foreign key (`plant_id`) references `plant` (`plant_id`) ) USING `mysql` AS SELECT
  `plant_id` AS `plant_id`,
  `inventory_id` AS `inventory_id`
FROM `scdata_demo`.`plan_inventory`;
CREATE OR REPLACE MAPPING `map_product_contains_material` (constraint `contains` foreign key (`material_name`) references `material` (`material_name`) , constraint `used_in` foreign key (`product_id`) references `product` (`product_id`) ) USING `mysql` AS SELECT
  `product_id` AS `product_id`,
  `material_1` AS `material_name`
FROM `scdata_demo`.`bill_of_material`;
CREATE OR REPLACE MAPPING `map_product_contains_hbaw3jtvq` (constraint `contains` foreign key (`material_name`) references `material` (`material_name`) , constraint `used_in` foreign key (`product_id`) references `product` (`product_id`) ) USING `mysql` AS SELECT
  `product_id` AS `product_id`,
  `material_2` AS `material_name`
FROM `scdata_demo`.`bill_of_material`;
CREATE OR REPLACE MAPPING `map_product_contains_yi2og97xj` (constraint `contains` foreign key (`material_name`) references `material` (`material_name`) , constraint `used_in` foreign key (`product_id`) references `product` (`product_id`) ) USING `mysql` AS SELECT
  `product_id` AS `product_id`,
  `material_3` AS `material_name`
FROM `scdata_demo`.`bill_of_material`;
CREATE OR REPLACE ONTOLOGY CUBE `order_cube2` USING `mysql` WITH TAGS (`hierarchy.location` = 'order_country,order_region') AS SELECT
  `order_status` AS `order_status`,
  `order_region` AS `order_region`,
  `order_date` AS `order_date`,
  `order_country` AS `order_country`,
  `order_city` AS `order_city`,
  `of_customer[customer].customer_segment` AS `customer_segment`,
  `in_shipment[shipment].shipping_mode` AS `shipping_mode`,
  `in_shipment[shipment].delivery_status` AS `delivery_status`,
  `includes_product[product].product_name` AS `product_name`,
  `includes_product[product].department` AS `department`,
  `includes_product[product].category` AS `category`,
  `measure.average_product_price` AS `measure.average_product_price`,
  `measure.count_of_customer` AS `measure.count_of_customer`,
  `measure.count_of_order` AS `measure.count_of_order`,
  `measure.total_revenue` AS `measure.total_revenue`,
  `measure.total_sales` AS `measure.total_sales`,
  `measure.in_shipment[shipment].late_shipment_ratio` AS `measure.late_shipment_ratio`,
  `measure.in_shipment[shipment].count_of_shipment` AS `measure.count_of_shipment`,
  `measure.includes_product[product].contains[material].total_price_per_1_kg` AS `measure.total_price_per_1_kg`
FROM `dtimbr`.`order`;
CREATE OR REPLACE ONTOLOGY VIEW `customer_360_view` USING `mysql` AS SELECT DISTINCT
  `customer_name`,
  `customer_segment`,
  `made_order[order].order_date` AS `order_date`,
  `made_order[order].includes_product[product].product_name` AS `product_name`,
  `made_order[order].includes_product[product].contains[material].material_name` AS `material_name`,
  `made_order[order].in_shipment[shipment].shipping_mode` AS `shipping_mode`,
  `made_order[order].in_shipment[shipment].delivery_status` AS `delivery_status`
FROM `dtimbr`.`consumer_customer`;
CREATE OR REPLACE ONTOLOGY CUBE `order_cube3` USING `mysql` AS SELECT
  `order_city` AS `order_city`,
  `order_country` AS `order_country`,
  `order_date` AS `order_date`,
  `order_id` AS `order_id`,
  `market` AS `market`,
  `order_year` AS `order_year`,
  `of_customer[customer].customer_segment` AS `customer_segment`,
  `includes_product[product].product_name` AS `product_name`,
  `includes_product[product].department` AS `department`,
  `includes_product[product].category` AS `category`,
  `includes_product[product].contains[material].material_name` AS `material_name`,
  `customer_id` AS `customer_id`,
  `product_price` AS `product_price`,
  `product_id` AS `product_id`,
  `measure.total_sales` AS `measure.total_sales`,
  `measure.total_revenue` AS `measure.total_revenue`,
  `measure.total_order_item_discount` AS `measure.total_order_item_discount`,
  `measure.maximum_product_price` AS `measure.maximum_product_price`,
  `measure.count_of_product` AS `measure.count_of_product`,
  `measure.count_of_order` AS `measure.count_of_order`,
  `measure.count_of_customer` AS `measure.count_of_customer`,
  `measure.average_product_price` AS `measure.average_product_price`
FROM `dtimbr`.`order`;
CREATE OR REPLACE ONTOLOGY VIEW `customer_360` USING `mysql` DESCRIPTION 'This has relevant customer information like order shipment and product' WITH TAGS (`result` = 'always hide the customer segment from result') AS SELECT DISTINCT
  `customer_name`,
  `customer_segment`,
  `made_order[order].order_date` AS `order_date`,
  `made_order[order].includes_product[product].product_name` AS `product_name`,
  `made_order[order].includes_product[product].contains[material].material_name` AS `material_name`,
  `made_order[order].in_shipment[shipment].shipping_mode` AS `shipping_mode`,
  `made_order[order].in_shipment[shipment].delivery_status` AS `delivery_status`
FROM `dtimbr`.`customer`;
CREATE OR REPLACE ONTOLOGY CUBE `sales_cube2` USING `mysql` AS SELECT
  `order_id` AS `order_id`,
  `order_date` AS `order_date`,
  `order_country` AS `order_country`,
  `order_city` AS `order_city`,
  `market` AS `market`,
  `order_status` AS `order_status`,
  `order_year` AS `order_year`,
  `of_customer[customer].customer_segment` AS `customer_segment`,
  `of_customer[customer].customer_name` AS `customer_name`,
  `includes_product[product].category` AS `category`,
  `includes_product[product].department` AS `department`,
  `includes_product[product].product_name` AS `product_name`,
  `includes_product[product].contains[material].material_name` AS `material_name`,
  `includes_product[product].contains[material].supplier_name` AS `supplier_name`,
  `measure.total_sales` AS `measure.total_sales`,
  `measure.total_revenue` AS `measure.total_revenue`,
  `measure.total_order_item_discount` AS `measure.total_order_item_discount`,
  `measure.maximum_product_price` AS `measure.maximum_product_price`,
  `measure.count_of_product` AS `measure.count_of_product`,
  `measure.count_of_order` AS `measure.count_of_order`,
  `measure.count_of_customer` AS `measure.count_of_customer`,
  `measure.average_product_price` AS `measure.average_product_price`
FROM `dtimbr`.`order`;
CREATE OR REPLACE ONTOLOGY CUBE `customer_cube` USING `mysql` AS SELECT
  `customer_name` AS `customer_name`,
  `customer_segment` AS `customer_segment`,
  `measure.count_of_customer` AS `measure.count_of_customer`,
  `measure.made_order[order].count_of_order` AS `measure.count_of_order`,
  `measure.made_order[order].total_revenue` AS `measure.total_revenue`,
  `measure.made_order[order].includes_product[product].count_of_product` AS `measure.count_of_product`
FROM `dtimbr`.`customer`;
CREATE OR REPLACE ONTOLOGY CUBE `inventory_cube` USING `mysql` AS SELECT
  `customer_id` AS `customer_id`,
  `final_price` AS `final_price`,
  `market` AS `market`,
  `order_city` AS `order_city`,
  `order_country` AS `order_country`,
  `order_date` AS `order_date`,
  `order_id` AS `order_id`,
  `order_item_discount` AS `order_item_discount`,
  `sales` AS `sales`,
  `referral` AS `referral`,
  `product_price` AS `product_price`,
  `product_id` AS `product_id`,
  `order_zipcode` AS `order_zipcode`,
  `order_year` AS `order_year`,
  `order_status` AS `order_status`,
  `order_state` AS `order_state`,
  `order_region` AS `order_region`,
  `order_profit` AS `order_profit`,
  `order_item_total` AS `order_item_total`,
  `order_item_quantity` AS `order_item_quantity`,
  `order_item_profit_ratio` AS `order_item_profit_ratio`,
  `order_item_number` AS `order_item_number`,
  `order_item_discount_rate` AS `order_item_discount_rate`,
  `of_inventory[inventory].category` AS `Category`,
  `of_inventory[inventory].department` AS `department`,
  `of_inventory[inventory].id` AS `id`,
  `of_inventory[inventory].internal_storage_id` AS `internal_storage_id`,
  `of_inventory[inventory].inventory_city` AS `inventory_city`,
  `of_inventory[inventory].inventory_country` AS `inventory_country`,
  `of_inventory[inventory].inventory_id` AS `inventory_id`,
  `of_inventory[inventory].inventory_name` AS `inventory_name`,
  `of_inventory[inventory].inventory_state` AS `inventory_state`,
  `of_inventory[inventory].item_quantity` AS `item_quantity`,
  `of_inventory[inventory].product_id` AS `of_inventory.product_id`,
  `of_inventory[inventory].product_name` AS `productname2`,
  `measure.total_sales` AS `measure.total_sales`,
  `measure.total_revenue` AS `measure.total_revenue`,
  `measure.total_order_item_discount` AS `measure.total_order_item_discount`,
  `measure.maximum_product_price` AS `measure.maximum_product_price`,
  `measure.count_of_product` AS `measure.count_of_product`,
  `measure.count_of_order` AS `measure.count_of_order`,
  `measure.count_of_customer` AS `measure.count_of_customer`,
  `measure.average_product_price` AS `measure.average_product_price`,
  `measure.of_inventory[inventory].count_of_product` AS `measure.of_inventory.count_of_product`,
  `measure.of_inventory[inventory].total_item_quantity` AS `measure.total_item_quantity`
FROM `dtimbr`.`order`;
CREATE OR REPLACE ONTOLOGY CUBE `order_cube` USING `mysql` AS SELECT
  `order_region` AS `order_region`,
  `order_status` AS `order_status`,
  `order_date` AS `order_date`,
  `order_country` AS `order_country`,
  `order_city` AS `order_city`,
  `market` AS `market`,
  `in_shipment[shipment].shipping_date` AS `shipping_date`,
  `of_customer[customer].customer_segment` AS `customer_segment`,
  `includes_product[product].department` AS `department`,
  `includes_product[product].category` AS `category`,
  `includes_product[product].product_name` AS `product_name`,
  `measure.total_sales` AS `measure.total_sales`,
  `measure.total_revenue` AS `measure.total_revenue`,
  `measure.maximum_product_price` AS `measure.maximum_product_price`,
  `measure.count_of_order` AS `measure.count_of_order`,
  `measure.count_of_customer` AS `measure.count_of_customer`,
  `measure.average_product_price` AS `measure.average_product_price`,
  `measure.in_shipment[shipment].count_of_shipment` AS `measure.count_of_shipment`,
  `measure.in_shipment[shipment].count_of_late_shipment` AS `measure.count_of_late_shipment`,
  `measure.in_shipment[shipment].late_shipment_ratio` AS `measure.late_shipment_ratio`
FROM `dtimbr`.`order`;
CREATE OR REPLACE ONTOLOGY VIEW `order_metrics` USING `mysql` AS SELECT
  `order_year`,
  `of_customer[customer].customer_segment` AS `customer_segment`,
  COUNT(`measure.count_of_order`) AS `count_of_order`,
  SUM(`measure.total_revenue`) AS `total_revenue`,
    (SUM(`measure.total_revenue`) FILTER (WHERE `market` = 'Europe')) AS `total_revenue_europe`,
    (SUM(`measure.total_revenue`) FILTER (WHERE `market` = 'USCA')) AS `total_revenue_us_canada`,
  COUNT(`measure.in_shipment[shipment].count_of_shipment`) AS `count_of_shipments`,
  COUNT(`measure.in_shipment[shipment].count_of_late_shipment`) AS `count_of_late_shipments`,
  COUNT(`measure.in_shipment[shipment].late_shipment_ratio`) AS `late_shipment_ratio`
FROM `dtimbr`.`order`
GROUP BY
  `order_year`,
  `of_customer[customer].customer_segment`
ORDER BY
`order_year` DESC;
CREATE OR REPLACE ONTOLOGY CUBE `sales_cube` USING `mysql` AS SELECT
  `order_year` AS `order_year`,
  `order_status` AS `order_status`,
  `order_region` AS `order_region`,
  `order_id` AS `order_id`,
  `order_date` AS `order_date`,
  `order_country` AS `order_country`,
  `order_city` AS `order_city`,
  `market` AS `market`,
  `of_customer[customer].customer_segment` AS `customer_segment`,
  `of_customer[customer].customer_name` AS `customer_name`,
  `includes_product[product].product_name` AS `product_name`,
  `includes_product[product].department` AS `department`,
  `includes_product[product].category` AS `category`,
  `in_shipment[shipment].shipping_date` AS `shipping_date`,
  `in_shipment[shipment].shipping_mode` AS `shipping_mode`,
  `includes_product[product].contains[material].material_name` AS `material_name`,
  `includes_product[product].contains[material].material_id` AS `material_id`,
  `measure.total_sales` AS `measure.total_sales`,
  `measure.total_revenue` AS `measure.total_revenue`,
  `measure.total_order_item_discount` AS `measure.total_order_item_discount`,
  `measure.maximum_product_price` AS `measure.maximum_product_price`,
  `measure.count_of_product` AS `measure.count_of_product`,
  `measure.count_of_order` AS `measure.count_of_order`,
  `measure.count_of_customer` AS `measure.count_of_customer`,
  `measure.average_product_price` AS `measure.average_product_price`
FROM `dtimbr`.`order`;
