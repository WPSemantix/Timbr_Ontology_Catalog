CREATE OR REPLACE PROPERTY `end_date` timestamp;
CREATE OR REPLACE PROPERTY `closed_date` timestamp;
CREATE OR REPLACE PROPERTY `notes` string;
CREATE OR REPLACE PROPERTY `subject` string;
CREATE OR REPLACE PROPERTY `description` string;
CREATE OR REPLACE PROPERTY `feedback_id` integer;
CREATE OR REPLACE PROPERTY `industry` string;
CREATE OR REPLACE PROPERTY `skills` string;
CREATE OR REPLACE PROPERTY `customer_satisfaction` integer;
CREATE OR REPLACE PROPERTY `price` decimal;
CREATE OR REPLACE PROPERTY `account_name` string;
CREATE OR REPLACE PROPERTY `activity_type` string;
CREATE OR REPLACE PROPERTY `product_id` integer;
CREATE OR REPLACE PROPERTY `activity_id` integer;
CREATE OR REPLACE PROPERTY `case_id` integer;
CREATE OR REPLACE PROPERTY `product_issue` string;
CREATE OR REPLACE PROPERTY `case_number` string;
CREATE OR REPLACE PROPERTY `first_name` string;
CREATE OR REPLACE PROPERTY `email` string;
CREATE OR REPLACE PROPERTY `outcome` string;
CREATE OR REPLACE PROPERTY `start_date` timestamp;
CREATE OR REPLACE PROPERTY `issue_description` string;
CREATE OR REPLACE PROPERTY `service_channel` string;
CREATE OR REPLACE PROPERTY `address` string;
CREATE OR REPLACE PROPERTY `comments` string;
CREATE OR REPLACE PROPERTY `resolution_details` string;
CREATE OR REPLACE PROPERTY `service_level` string;
CREATE OR REPLACE PROPERTY `last_name` string;
CREATE OR REPLACE PROPERTY `technician_id` integer;
CREATE OR REPLACE PROPERTY `feedback_date` timestamp;
CREATE OR REPLACE PROPERTY `priority` string;
CREATE OR REPLACE PROPERTY `primary_contact_id` integer;
CREATE OR REPLACE PROPERTY `account_id` integer;
CREATE OR REPLACE PROPERTY `preferred_contact_method` string;
CREATE OR REPLACE PROPERTY `name` string;
CREATE OR REPLACE PROPERTY `phone_number` string;
CREATE OR REPLACE PROPERTY `created_date` timestamp;
CREATE OR REPLACE PROPERTY `category` string;
CREATE OR REPLACE PROPERTY `customer_id` integer;
CREATE OR REPLACE PROPERTY `region` string;
CREATE OR REPLACE PROPERTY `status` string;
CREATE OR REPLACE CONCEPT `service_technician` (`phone_number` string, `region` string, `last_name` string, `technician_id` integer, `email` string, `skills` string, `first_name` string, PRIMARY KEY (`technician_id`), LABEL (`first_name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-screwdriver-wrench');
CREATE OR REPLACE CONCEPT `service_case` (`priority` string, `customer_id` integer, `service_channel` string, `case_number` string, `account_id` integer, `description` string, `closed_date` timestamp, `resolution_details` string, `subject` string, `case_id` integer, `status` string, `created_date` timestamp, `service_level` string, PRIMARY KEY (`case_id`), LABEL (`case_number`), CONSTRAINT `case_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) INVERSEOF `account_cases` , CONSTRAINT `case_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) INVERSEOF `customer_cases` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-briefcase');
CREATE OR REPLACE CONCEPT `service_activity` (`description` string, `outcome` string, `start_date` timestamp, `case_id` integer, `end_date` timestamp, `notes` string, `technician_id` integer, `activity_type` string, `activity_id` integer, PRIMARY KEY (`activity_id`), LABEL (`activity_type`), CONSTRAINT `activity_technician` FOREIGN KEY (`technician_id`) REFERENCES `service_technician` (`technician_id`) INVERSEOF `technician_activities` , CONSTRAINT `activity_case` FOREIGN KEY (`case_id`) REFERENCES `service_case` (`case_id`) INVERSEOF `case_activities` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-clipboard-list');
CREATE OR REPLACE CONCEPT `product` (`description` string, `category` string, `price` decimal, `name` string, `product_id` integer, PRIMARY KEY (`product_id`), LABEL (`name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-box-open');
CREATE OR REPLACE CONCEPT `feedback` (`comments` string, `feedback_date` timestamp, `feedback_id` integer, `case_id` integer, `customer_satisfaction` integer, PRIMARY KEY (`feedback_id`), LABEL (`feedback_id`), CONSTRAINT `feedback_case` FOREIGN KEY (`case_id`) REFERENCES `service_case` (`case_id`) INVERSEOF `case_feedback` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-thumbs-up');
CREATE OR REPLACE CONCEPT `customer` (`address` string, `phone_number` string, `preferred_contact_method` string, `last_name` string, `customer_id` integer, `email` string, `first_name` string, PRIMARY KEY (`customer_id`), LABEL (`first_name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-user');
CREATE OR REPLACE CONCEPT `case_product` (`product_issue` string, `case_id` integer, `issue_description` string, `product_id` integer, CONSTRAINT `product_case` FOREIGN KEY (`case_id`) REFERENCES `service_case` (`case_id`) INVERSEOF `~product_case` , CONSTRAINT `case_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) INVERSEOF `~case_product` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-magnifying-glass-dollar');
CREATE OR REPLACE CONCEPT `account` (`address` string, `industry` string, `phone_number` string, `primary_contact_id` integer, `account_id` integer, `account_name` string, PRIMARY KEY (`account_id`), LABEL (`account_name`), CONSTRAINT `account_contact` FOREIGN KEY (`primary_contact_id`) REFERENCES `customer` (`customer_id`) INVERSEOF `contact_account` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-contact-card');