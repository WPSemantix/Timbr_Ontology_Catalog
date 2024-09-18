CREATE OR REPLACE PROPERTY `months_inactive_12_mon` bigint;
CREATE OR REPLACE PROPERTY `country` string;
CREATE OR REPLACE PROPERTY `credit_score` integer;
CREATE OR REPLACE PROPERTY `treatment` string;
CREATE OR REPLACE PROPERTY `other_debt_thousands` float;
CREATE OR REPLACE PROPERTY `churn_score_2` float;
CREATE OR REPLACE PROPERTY `gender` string;
CREATE OR REPLACE PROPERTY `churn_score_1` float;
CREATE OR REPLACE PROPERTY `churn` string;
CREATE OR REPLACE PROPERTY `balance_group` string;
CREATE OR REPLACE PROPERTY `total_trans_amt` bigint;
CREATE OR REPLACE PROPERTY `credit_limit_upgrade` string;
CREATE OR REPLACE PROPERTY `defaulted_flag` boolean;
CREATE OR REPLACE PROPERTY `avg_utilization_ratio` float;
CREATE OR REPLACE PROPERTY `products_number` integer;
CREATE OR REPLACE PROPERTY `apr_up` string;
CREATE OR REPLACE PROPERTY `avg_open_to_buy` float;
CREATE OR REPLACE PROPERTY `balance` float;
CREATE OR REPLACE PROPERTY `total_amt_chng_q4_q1` float;
CREATE OR REPLACE PROPERTY `total_revolving_bal` bigint;
CREATE OR REPLACE PROPERTY `cc_upgrade` string;
CREATE OR REPLACE PROPERTY `credit_limit` float;
CREATE OR REPLACE PROPERTY `active_member` boolean;
CREATE OR REPLACE PROPERTY `tenure` string;
CREATE OR REPLACE PROPERTY `card_debt_thousands` float;
CREATE OR REPLACE PROPERTY `contacts_count_12_mon` bigint;
CREATE OR REPLACE PROPERTY `age_group` string;
CREATE OR REPLACE PROPERTY `card_category` string;
CREATE OR REPLACE PROPERTY `debtincomeratio` float;
CREATE OR REPLACE PROPERTY `total_trans_ct` bigint;
CREATE OR REPLACE PROPERTY `credit_score_group` string;
CREATE OR REPLACE PROPERTY `customer_age` bigint;
CREATE OR REPLACE PROPERTY `total_ct_chng_q4_q1` float;
CREATE OR REPLACE PROPERTY `credit_card` boolean;
CREATE OR REPLACE PROPERTY `marital_status` string;
CREATE OR REPLACE PROPERTY `months_on_book` bigint;
CREATE OR REPLACE PROPERTY `estimated_salary` float;
CREATE OR REPLACE PROPERTY `income_thousands` integer;
CREATE OR REPLACE PROPERTY `customerid` string;
CREATE OR REPLACE PROPERTY `prediction` integer;
CREATE OR REPLACE PROPERTY `education_level` string;
CREATE OR REPLACE PROPERTY `age` integer;
CREATE OR REPLACE PROPERTY `rewards` integer;
CREATE OR REPLACE CONCEPT `treatment` (`apr_up` string, `cc_upgrade` string, `credit_limit_upgrade` string, `treatment` string, PRIMARY KEY (`treatment`), LABEL (`treatment`)) INHERITS (`thing`) DESCRIPTION 'The action(s) that are appropriate for preventing a churn of a customer account due to the Churn Reason.' WITH TAGS (`icon` = 'fa-wrench');
CREATE OR REPLACE CONCEPT `customeraccount` (`card_debt_thousands` float, `customerid` string, `other_debt_thousands` float, `debtincomeratio` float, `defaulted_flag` boolean, `income_thousands` integer, PRIMARY KEY (`customerid`), LABEL (`customerid`), CONSTRAINT `of_customer` FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerid`) INVERSEOF `has_account` ) INHERITS (`thing`) DESCRIPTION 'An account is an administrative means of defining one or more relationships between the customer and the selling or service-providing organization.' WITH TAGS (`icon` = 'fa-folder-open');
CREATE OR REPLACE CONCEPT `customer` (`marital_status` string, `gender` string, `customerid` string, `education_level` string, `customer_age` bigint, PRIMARY KEY (`customerid`), LABEL (`customerid`), CONSTRAINT `has_churn_info` FOREIGN KEY (`customerid`) REFERENCES `churn_info` (`customerid`) INVERSEOF `of_customer` , CONSTRAINT `churn_prediction` FOREIGN KEY (`customerid`) REFERENCES `churn_prediction` (`customerid`) INVERSEOF `of_customer` ) INHERITS (`thing`) DESCRIPTION 'A customer is an individual or legal entity that has or has purchased a product or service. A potential customer is an individual or legal entity that has the desire to acquire a product or service, the financial ability to pay for that product or service and is located in a location in which the product or service can be delivered to them.' WITH TAGS (`icon` = 'fa-user');
CREATE OR REPLACE CONCEPT `churn_prediction` (`rewards` integer, `prediction` integer, `customerid` string, PRIMARY KEY (`customerid`), LABEL (`prediction`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-chart-line');
CREATE OR REPLACE CONCEPT `churn_info` (`credit_card` boolean, `customerid` string, `estimated_salary` float, `tenure` string, `balance` float, `age` integer, `churn` string, `country` string, `active_member` boolean, `gender` string, `balance_group` string, `credit_score` integer, `age_group` string, `products_number` integer, `treatment` string, `credit_score_group` string, PRIMARY KEY (`customerid`), LABEL (`customerid`), CONSTRAINT `has_treatment` FOREIGN KEY (`treatment`) REFERENCES `treatment` (`treatment`) INVERSEOF `of_churned` ) INHERITS (`thing`) DESCRIPTION 'The reason associated with a churn.  Ex: - Customer Service - Product/Service Quality - Product Costs/Pricing - Billing Accuracy - Move To New Location - Prior Complaints' WITH TAGS (`icon` = 'fa-circle-info');
CREATE OR REPLACE CONCEPT `churnriskrating` (`churn_score_2` float, `churn_score_1` float, `customerid` string, PRIMARY KEY (`customerid`), LABEL (`customerid`), CONSTRAINT `of_customer` FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerid`) INVERSEOF `risk_of_churn` ) INHERITS (`thing`) DESCRIPTION 'The rating or likelihood that a customer account will churn based on the associated risk(s).' WITH TAGS (`icon` = 'fa-gauge');
CREATE OR REPLACE CONCEPT `accounttransactions` (`card_category` string, `credit_limit` float, `customerid` string, `months_on_book` bigint, `contacts_count_12_mon` bigint, `total_revolving_bal` bigint, `avg_utilization_ratio` float, `total_trans_ct` bigint, `total_trans_amt` bigint, `total_amt_chng_q4_q1` float, `avg_open_to_buy` float, `months_inactive_12_mon` bigint, `total_ct_chng_q4_q1` float, PRIMARY KEY (`customerid`), LABEL (`customerid`), CONSTRAINT `of_account` FOREIGN KEY (`customerid`) REFERENCES `customeraccount` (`customerid`) INVERSEOF `has_transactions` ) INHERITS (`thing`) DESCRIPTION 'A transaction is the smallest or most granular business activity recorded.  It is a mechanism to group a series of service invocations into a single operation.   Transactions are used to make sure that either the entire series of service invocations take effect, or that none of them do.' WITH TAGS (`icon` = 'fa-dollar-sign');
CREATE OR REPLACE CONCEPT `mid_value_customer_account`  INHERITS (`customeraccount`) DESCRIPTION 'Any customer account with an income more than 30K and less than 60K' FROM timbr.`customeraccount` WHERE `income_thousands` >= 30 AND `income_thousands` < 60;
CREATE OR REPLACE CONCEPT `low_value_customer_account`  INHERITS (`customeraccount`) DESCRIPTION 'Any customer account with an income of less than 30K' FROM timbr.`customeraccount` WHERE `income_thousands` < 30;
CREATE OR REPLACE CONCEPT `high_value_customer_account`  INHERITS (`customeraccount`) DESCRIPTION 'Any customer account with an income of more than 60K' FROM timbr.`customeraccount` WHERE `income_thousands` > 60;
CREATE OR REPLACE CONCEPT `churn_low_risk_rating`  INHERITS (`churnriskrating`) FROM timbr.`churnriskrating` WHERE `churn_score_1` + `churn_score_2` < 1.0000000352;
CREATE OR REPLACE CONCEPT `churn_high_risk_rating`  INHERITS (`churnriskrating`) FROM timbr.`churnriskrating` WHERE `churn_score_1` + `churn_score_2` >= 1.0000000352;