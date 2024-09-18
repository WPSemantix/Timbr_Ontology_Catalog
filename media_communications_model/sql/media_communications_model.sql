CREATE OR REPLACE PROPERTY `date` date;
CREATE OR REPLACE PROPERTY `rating` string;
CREATE OR REPLACE PROPERTY `type` string;
CREATE OR REPLACE PROPERTY `license_end_date` date;
CREATE OR REPLACE PROPERTY `episode_number` integer;
CREATE OR REPLACE PROPERTY `episode_id` integer;
CREATE OR REPLACE PROPERTY `subscriber_id` integer;
CREATE OR REPLACE PROPERTY `terms` string;
CREATE OR REPLACE PROPERTY `price` decimal;
CREATE OR REPLACE PROPERTY `campaign_id` integer;
CREATE OR REPLACE PROPERTY `statistic_id` integer;
CREATE OR REPLACE PROPERTY `budget` decimal;
CREATE OR REPLACE PROPERTY `target_audience` string;
CREATE OR REPLACE PROPERTY `license_start_date` date;
CREATE OR REPLACE PROPERTY `ad_id` integer;
CREATE OR REPLACE PROPERTY `revenue_amount` decimal;
CREATE OR REPLACE PROPERTY `release_date` date;
CREATE OR REPLACE PROPERTY `revenue_id` integer;
CREATE OR REPLACE PROPERTY `name` string;
CREATE OR REPLACE PROPERTY `subscription_type` string;
CREATE OR REPLACE PROPERTY `broadcast_time` time;
CREATE OR REPLACE PROPERTY `channel_id` integer;
CREATE OR REPLACE PROPERTY `end_date` date;
CREATE OR REPLACE PROPERTY `role` string;
CREATE OR REPLACE PROPERTY `description` string;
CREATE OR REPLACE PROPERTY `feedback_id` integer;
CREATE OR REPLACE PROPERTY `contact_info` string;
CREATE OR REPLACE PROPERTY `title` string;
CREATE OR REPLACE PROPERTY `average_watch_duration` integer;
CREATE OR REPLACE PROPERTY `duration` integer;
CREATE OR REPLACE PROPERTY `subscription_start_date` date;
CREATE OR REPLACE PROPERTY `genre` string;
CREATE OR REPLACE PROPERTY `broadcast_date` date;
CREATE OR REPLACE PROPERTY `first_name` string;
CREATE OR REPLACE PROPERTY `email` string;
CREATE OR REPLACE PROPERTY `start_date` date;
CREATE OR REPLACE PROPERTY `advertiser` string;
CREATE OR REPLACE PROPERTY `crew_id` integer;
CREATE OR REPLACE PROPERTY `comments` string;
CREATE OR REPLACE PROPERTY `licensee` string;
CREATE OR REPLACE PROPERTY `content_id` integer;
CREATE OR REPLACE PROPERTY `last_name` string;
CREATE OR REPLACE PROPERTY `feedback_date` date;
CREATE OR REPLACE PROPERTY `series_id` integer;
CREATE OR REPLACE PROPERTY `assignment_id` integer;
CREATE OR REPLACE PROPERTY `license_id` integer;
CREATE OR REPLACE PROPERTY `broadcast_id` integer;
CREATE OR REPLACE PROPERTY `plan_id` integer;
CREATE OR REPLACE PROPERTY `view_count` integer;
CREATE OR REPLACE CONCEPT `viewing_statistics` (`average_watch_duration` integer, `content_id` integer, `view_count` integer, `date` date, `statistic_id` integer, PRIMARY KEY (`statistic_id`), LABEL (`statistic_id`), CONSTRAINT `statistics_for_content` FOREIGN KEY (`content_id`) REFERENCES `content_item` (`content_id`) INVERSEOF `~statistics_for_content` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-chart-simple');
CREATE OR REPLACE CONCEPT `subscription_plan` (`description` string, `price` decimal, `plan_id` integer, `name` string, PRIMARY KEY (`plan_id`), LABEL (`name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-clipboard-check');
CREATE OR REPLACE CONCEPT `subscriber` (`subscriber_id` integer, `subscription_start_date` date, `last_name` string, `email` string, `subscription_type` string, `first_name` string, PRIMARY KEY (`subscriber_id`), LABEL (`first_name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-user-tag');
CREATE OR REPLACE CONCEPT `series` (`description` string, `genre` string, `title` string, `series_id` integer, PRIMARY KEY (`series_id`), LABEL (`title`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-server');
CREATE OR REPLACE CONCEPT `revenue_tracking` (`revenue_amount` decimal, `content_id` integer, `revenue_id` integer, `date` date, PRIMARY KEY (`revenue_id`), LABEL (`revenue_id`), CONSTRAINT `revenue_from_content` FOREIGN KEY (`content_id`) REFERENCES `content_item` (`content_id`) INVERSEOF `~revenue_from_content` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-line-chart');
CREATE OR REPLACE CONCEPT `production_crew` (`role` string, `contact_info` string, `crew_id` integer, `name` string, PRIMARY KEY (`crew_id`), LABEL (`name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-user-group');
CREATE OR REPLACE CONCEPT `episode` (`release_date` date, `title` string, `episode_id` integer, `series_id` integer, `episode_number` integer, PRIMARY KEY (`episode_id`), LABEL (`title`), CONSTRAINT `episode_belongs_to_series` FOREIGN KEY (`series_id`) REFERENCES `series` (`series_id`) INVERSEOF `~episode_belongs_to_series` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-list-ol');
CREATE OR REPLACE CONCEPT `customer_feedback` (`comments` string, `subscriber_id` integer, `feedback_id` integer, `feedback_date` date, `content_id` integer, `rating` string, PRIMARY KEY (`feedback_id`), LABEL (`comments`), CONSTRAINT `feedback_on_content` FOREIGN KEY (`content_id`) REFERENCES `content_item` (`content_id`) INVERSEOF `~feedback_on_content` , CONSTRAINT `feedback_from_subscriber` FOREIGN KEY (`subscriber_id`) REFERENCES `subscriber` (`subscriber_id`) INVERSEOF `~feedback_from_subscriber` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-thumbs-up');
CREATE OR REPLACE CONCEPT `content_licensing` (`terms` string, `license_end_date` date, `content_id` integer, `license_id` integer, `license_start_date` date, `licensee` string, PRIMARY KEY (`license_id`), LABEL (`license_id`), CONSTRAINT `licensing_for_content` FOREIGN KEY (`content_id`) REFERENCES `content_item` (`content_id`) INVERSEOF `~licensing_for_content` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-file-contract');
CREATE OR REPLACE CONCEPT `content_item` (`description` string, `type` string, `release_date` date, `title` string, `duration` integer, `content_id` integer, `rating` string, PRIMARY KEY (`content_id`), LABEL (`title`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-film');
CREATE OR REPLACE CONCEPT `content_crew_assignment` (`assignment_id` integer, `end_date` date, `role` string, `content_id` integer, `crew_id` integer, `start_date` date, PRIMARY KEY (`assignment_id`), LABEL (`role`), CONSTRAINT `assignment_to_content` FOREIGN KEY (`content_id`) REFERENCES `content_item` (`content_id`) INVERSEOF `~assignment_to_content` , CONSTRAINT `crew_for_assignment` FOREIGN KEY (`crew_id`) REFERENCES `production_crew` (`crew_id`) INVERSEOF `~crew_for_assignment` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-user-check');
CREATE OR REPLACE CONCEPT `channel` (`description` string, `channel_id` integer, `name` string, PRIMARY KEY (`channel_id`), LABEL (`name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-chromecast');
CREATE OR REPLACE CONCEPT `broadcast` (`broadcast_time` time, `broadcast_id` integer, `channel_id` integer, `content_id` integer, `broadcast_date` date, PRIMARY KEY (`broadcast_id`), LABEL (`broadcast_id`), CONSTRAINT `broadcast_of_content` FOREIGN KEY (`content_id`) REFERENCES `content_item` (`content_id`) INVERSEOF `~broadcast_of_content` , CONSTRAINT `broadcast_on_channel` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`channel_id`) INVERSEOF `~broadcast_on_channel` ) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-broadcast-tower');
CREATE OR REPLACE CONCEPT `advertising_campaign` (`end_date` date, `budget` decimal, `name` string, `start_date` date, `campaign_id` integer, PRIMARY KEY (`campaign_id`), LABEL (`name`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-bullhorn');
CREATE OR REPLACE CONCEPT `advertisement` (`advertiser` string, `title` string, `ad_id` integer, `duration` integer, `target_audience` string, PRIMARY KEY (`ad_id`), LABEL (`title`)) INHERITS (`thing`) WITH TAGS (`icon` = 'fa-chalkboard');