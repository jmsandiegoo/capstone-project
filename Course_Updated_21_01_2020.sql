  /*======================================================*/
/*  Module: Capstone                                    */
/*  Database Script for setting up the MySQL database   */
/*  tables required for Open House Capstone Proj        */
/*  Creation Date: 10/25/2019.                         */
/*======================================================*/

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

/*******************************************************************************/
/***                         Delete tables before creating                   ***/
/*******************************************************************************/
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS PwdReset;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS CategoryModule;
DROP TABLE IF EXISTS ModuleJob;
DROP TABLE IF EXISTS CourseModule;
DROP TABLE IF EXISTS ElectiveModule;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Module;
DROP TABLE IF EXISTS Elective;
DROP TABLE IF EXISTS CategoryJob;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Job;
DROP TABLE IF EXISTS CourseReq;
DROP TABLE IF EXISTS Requirement;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS FAQ;
/*******************************************************************************/
/***                              Create the tables                          ***/
/*******************************************************************************/

CREATE TABLE Account (
  id INT(11) NOT NULL AUTO_INCREMENT,
  email TEXT NOT NULL,
  password VARCHAR(500) NOT NULL,
  is_admin TINYINT(1) NOT NULL,
  first_name VARCHAR(50) DEFAULT NULL,
  last_name VARCHAR(50) DEFAULT NULL,
  phone_number VARCHAR(50) DEFAULT NULL,
  CONSTRAINT pk_account PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE PwdReset (
  id int(11) NOT NULL AUTO_INCREMENT,
  reset_email TEXT NOT NULL,
  reset_selector TEXT NOT NULL,
  reset_token TEXT NOT NULL,
  reset_expires TEXT NOT NULL,
  CONSTRAINT pk_pwdreset PRIMARY KEY (id)
) ENGINE=InnoDB CHARSET=latin1;

CREATE TABLE Course 
(
  id INT(4) NOT NULL AUTO_INCREMENT,
  course_id VARCHAR(4) NOT NULL,
  course_name VARCHAR(50) NOT NULL,
  course_abbreviations VARCHAR(10) NOT NULL,
  course_short_description TEXT DEFAULT NULL,
  course_description TEXT DEFAULT NULL,
  course_year1_description TEXT DEFAULT NULL,
  course_year2_description TEXT DEFAULT NULL,
  course_year3_description TEXT DEFAULT NULL,
  course_elective_description TEXT DEFAULT NULL,
  course_requirements VARCHAR(500) DEFAULT NULL,
  course_intake INT(4) NOT NULL,
  CONSTRAINT pk_course PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Requirement
(
  req_id INT(4) NOT NULL,
  req_subject VARCHAR(500) NOT NULL,
  req_grade VARCHAR(10) NOT NULL,
  CONSTRAINT pk_coursereq PRIMARY KEY (req_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE CourseReq
(
  course_id INT(4) NOT NULL,
  req_id INT(4) NOT NULL,
  CONSTRAINT fk_coursereq_course_id FOREIGN KEY (course_id) REFERENCES Course(id),
  CONSTRAINT fk_coursereq_req_id FOREIGN KEY (req_id) REFERENCES Requirement(req_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Job
(
  job_id INT(4) NOT NULL AUTO_INCREMENT,
  job_name VARCHAR(500) NOT NULL,
  CONSTRAINT pk_job PRIMARY KEY (job_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Category
(
  category_id INT(4) NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(500) NOT NULL,
  id INT(4) NOT NULL,
  CONSTRAINT pk_category PRIMARY KEY (category_id),
  CONSTRAINT fk_category_course_id FOREIGN KEY (id) REFERENCES Course(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE CategoryJob
(
  category_id INT(4) NOT NULL,
  job_id INT(4) NOT NULL,
  CONSTRAINT fk_categoryjob_category_id FOREIGN KEY (category_id) REFERENCES Category(category_id),
  CONSTRAINT fk_categoryjob_job_id FOREIGN KEY (job_id) REFERENCES Job(job_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Elective
(
  elective_id INT(4) NOT NULL AUTO_INCREMENT,
  elective_name VARCHAR(50) NOT NULL,
  CONSTRAINT pk_elective PRIMARY KEY (elective_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Module 
(
  module_id INT(4) NOT NULL AUTO_INCREMENT,
  module_name VARCHAR(50) NOT NULL,
  module_description TEXT DEFAULT NULL,
  CONSTRAINT pk_module PRIMARY KEY (module_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Project
(
  project_id INT(4) NOT NULL AUTO_INCREMENT,
  project_name VARCHAR(50) NOT NULL,
  project_desc TEXT DEFAULT NULL,
  id INT(4) NOT NULL,
  CONSTRAINT pk_project PRIMARY KEY (project_id),
  CONSTRAINT fk_project_id FOREIGN KEY (id) REFERENCES Course(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE ElectiveModule
(
  module_id INT(4) NOT NULL,
  elective_id INT(4) NOT NULL,
  CONSTRAINT fk_electivemodule_module_module_id FOREIGN KEY (module_id) REFERENCES Module(module_id),
  CONSTRAINT fk_electivemodule_elective_elective_id FOREIGN KEY (elective_id) REFERENCES Elective(elective_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE CourseModule
(
  id INT(4) NOT NULL,
  module_id INT(4) NOT NULL,
  module_year VARCHAR(10) NOT NULL,
  CONSTRAINT fk_coursemodule_course_id FOREIGN KEY (id) REFERENCES Course(id),
  CONSTRAINT fk_coursemodule_module_module_id FOREIGN KEY (module_id) REFERENCES Module(module_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE ModuleJob
(
  job_id INT(4) NOT NULL, 
  module_id INT(4) NOT NULL,
  CONSTRAINT fk_modulejob_job_job_id FOREIGN KEY (job_id) REFERENCES Job(job_id),
  CONSTRAINT fk_modulejob_module_module_id FOREIGN KEY (module_id) REFERENCES Module(module_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE CategoryModule
(
  category_id INT(4) NOT NULL,
  module_id INT(4) NOT NULL,
  CONSTRAINT fk_categorymodule_category_id FOREIGN KEY (category_id) REFERENCES Category(category_id),
  CONSTRAINT fk_categorymodule_module_id FOREIGN KEY (module_id) REFERENCES Module(module_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE Item 
(
  item_id INT(4) NOT NULL AUTO_INCREMENT,
  item_path VARCHAR(512) NOT NULL,
  item_type VARCHAR(20) NOT NULL,
  module_id INT(4) DEFAULT NULL,
  course_id INT(4) DEFAULT NULL,
  project_id INT(4) DEFAULT NULL,
  category_id INT(4) DEFAULT NULL,
  CONSTRAINT pk_item PRIMARY KEY (item_id),
  CONSTRAINT fk_item_module_id FOREIGN KEY (module_id) REFERENCES Module(module_id),
  CONSTRAINT fk_item_course_id FOREIGN KEY (course_id) REFERENCES Course(id),
  CONSTRAINT fk_item_project_id FOREIGN KEY (project_id) REFERENCES Project(project_id),
  CONSTRAINT fk_item_category_id FOREIGN KEY (category_id) REFERENCES Category(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*******************************************************************************/
/***                              TG Bot                          ***/
/*******************************************************************************/

CREATE TABLE Appointment
(
  appointment_id INT(4) NOT NULL AUTO_INCREMENT,
  user_id bigint NULL DEFAULT NULL COMMENT 'Unique user identifier',
  chat_id bigint NULL DEFAULT NULL COMMENT 'Unique user or chat identifier',
  is_general TINYINT(1) NOT NULL,
  appointment_name VARCHAR(100) NOT NULL,
  appointment_status ENUM('Pending', 'Now Serving', 'Finished', 'Cancelled') DEFAULT 'Pending' NOT NULL,
  appointment_createdate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  appointment_lastcalled DATETIME DEFAULT NULL,
  appointment_calls INT(4) DEFAULT 0 NOT NULL,
  course_id INT(4) DEFAULT NULL,
  phoneNumber varchar(20) DEFAULT NULL COMMENT 'User phone number',
  CONSTRAINT pk_appointment PRIMARY KEY (appointment_id),
  CONSTRAINT fk_appointment_course_id FOREIGN KEY (course_id) REFERENCES Course(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint COMMENT 'Unique identifier for this user or bot',
  `is_bot` tinyint(1) DEFAULT 0 COMMENT 'True, if this user is a bot',
  `first_name` CHAR(255) NOT NULL DEFAULT '' COMMENT 'User''s or bot''s first name',
  `last_name` CHAR(255) DEFAULT NULL COMMENT 'User''s or bot''s last name',
  `username` CHAR(191) DEFAULT NULL COMMENT 'User''s or bot''s username',
  `language_code` CHAR(10) DEFAULT NULL COMMENT 'IETF language tag of the user''s language',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update',

  PRIMARY KEY (`id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `chat` (
  `id` bigint COMMENT 'Unique identifier for this chat',
  `type` ENUM('private', 'group', 'supergroup', 'channel') NOT NULL COMMENT 'Type of chat, can be either private, group, supergroup or channel',
  `title` CHAR(255) DEFAULT '' COMMENT 'Title, for supergroups, channels and group chats',
  `username` CHAR(255) DEFAULT NULL COMMENT 'Username, for private chats, supergroups and channels if available',
  `first_name` CHAR(255) DEFAULT NULL COMMENT 'First name of the other party in a private chat',
  `last_name` CHAR(255) DEFAULT NULL COMMENT 'Last name of the other party in a private chat',
  `all_members_are_administrators` tinyint(1) DEFAULT 0 COMMENT 'True if a all members of this group are admins',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update',
  `old_id` bigint DEFAULT NULL COMMENT 'Unique chat identifier, this is filled when a group is converted to a supergroup',

  PRIMARY KEY (`id`),
  KEY `old_id` (`old_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `user_chat` (
  `user_id` bigint COMMENT 'Unique user identifier',
  `chat_id` bigint COMMENT 'Unique user or chat identifier',

  PRIMARY KEY (`user_id`, `chat_id`),

  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `inline_query` (
  `id` bigint UNSIGNED COMMENT 'Unique identifier for this query',
  `user_id` bigint NULL COMMENT 'Unique user identifier',
  `location` CHAR(255) NULL DEFAULT NULL COMMENT 'Location of the user',
  `query` TEXT NOT NULL COMMENT 'Text of the query',
  `offset` CHAR(255) NULL DEFAULT NULL COMMENT 'Offset of the result',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',

  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),

  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `chosen_inline_result` (
  `id` bigint UNSIGNED AUTO_INCREMENT COMMENT 'Unique identifier for this entry',
  `result_id` CHAR(255) NOT NULL DEFAULT '' COMMENT 'The unique identifier for the result that was chosen',
  `user_id` bigint NULL COMMENT 'The user that chose the result',
  `location` CHAR(255) NULL DEFAULT NULL COMMENT 'Sender location, only for bots that require user location',
  `inline_message_id` CHAR(255) NULL DEFAULT NULL COMMENT 'Identifier of the sent inline message',
  `query` TEXT NOT NULL COMMENT 'The query that was used to obtain the result',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',

  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),

  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `message` (
  `chat_id` bigint COMMENT 'Unique chat identifier',
  `id` bigint UNSIGNED COMMENT 'Unique message identifier',
  `user_id` bigint NULL COMMENT 'Unique user identifier',
  `date` timestamp NULL DEFAULT NULL COMMENT 'Date the message was sent in timestamp format',
  `forward_from` bigint NULL DEFAULT NULL COMMENT 'Unique user identifier, sender of the original message',
  `forward_from_chat` bigint NULL DEFAULT NULL COMMENT 'Unique chat identifier, chat the original message belongs to',
  `forward_from_message_id` bigint NULL DEFAULT NULL COMMENT 'Unique chat identifier of the original message in the channel',
  `forward_signature` TEXT NULL DEFAULT NULL COMMENT 'For messages forwarded from channels, signature of the post author if present',
  `forward_sender_name` TEXT NULL DEFAULT NULL COMMENT 'Sender''s name for messages forwarded from users who disallow adding a link to their account in forwarded messages',
  `forward_date` timestamp NULL DEFAULT NULL COMMENT 'date the original message was sent in timestamp format',
  `reply_to_chat` bigint NULL DEFAULT NULL COMMENT 'Unique chat identifier',
  `reply_to_message` bigint UNSIGNED DEFAULT NULL COMMENT 'Message that this message is reply to',
  `edit_date` bigint UNSIGNED DEFAULT NULL COMMENT 'Date the message was last edited in Unix time',
  `media_group_id` TEXT COMMENT 'The unique identifier of a media message group this message belongs to',
  `author_signature` TEXT COMMENT 'Signature of the post author for messages in channels',
  `text` TEXT COMMENT 'For text messages, the actual UTF-8 text of the message max message length 4096 char utf8mb4',
  `entities` TEXT COMMENT 'For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text',
  `caption_entities` TEXT COMMENT 'For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption',
  `audio` TEXT COMMENT 'Audio object. Message is an audio file, information about the file',
  `document` TEXT COMMENT 'Document object. Message is a general file, information about the file',
  `animation` TEXT COMMENT 'Message is an animation, information about the animation',
  `game` TEXT COMMENT 'Game object. Message is a game, information about the game',
  `photo` TEXT COMMENT 'Array of PhotoSize objects. Message is a photo, available sizes of the photo',
  `sticker` TEXT COMMENT 'Sticker object. Message is a sticker, information about the sticker',
  `video` TEXT COMMENT 'Video object. Message is a video, information about the video',
  `voice` TEXT COMMENT 'Voice Object. Message is a Voice, information about the Voice',
  `video_note` TEXT COMMENT 'VoiceNote Object. Message is a Video Note, information about the Video Note',
  `caption` TEXT COMMENT  'For message with caption, the actual UTF-8 text of the caption',
  `contact` TEXT COMMENT 'Contact object. Message is a shared contact, information about the contact',
  `location` TEXT COMMENT 'Location object. Message is a shared location, information about the location',
  `venue` TEXT COMMENT 'Venue object. Message is a Venue, information about the Venue',
  `poll` TEXT COMMENT 'Poll object. Message is a native poll, information about the poll',
  `new_chat_members` TEXT COMMENT 'List of unique user identifiers, new member(s) were added to the group, information about them (one of these members may be the bot itself)',
  `left_chat_member` bigint NULL DEFAULT NULL COMMENT 'Unique user identifier, a member was removed from the group, information about them (this member may be the bot itself)',
  `new_chat_title` CHAR(255) DEFAULT NULL COMMENT 'A chat title was changed to this value',
  `new_chat_photo` TEXT COMMENT 'Array of PhotoSize objects. A chat photo was change to this value',
  `delete_chat_photo` tinyint(1) DEFAULT 0 COMMENT 'Informs that the chat photo was deleted',
  `group_chat_created` tinyint(1) DEFAULT 0 COMMENT 'Informs that the group has been created',
  `supergroup_chat_created` tinyint(1) DEFAULT 0 COMMENT 'Informs that the supergroup has been created',
  `channel_chat_created` tinyint(1) DEFAULT 0 COMMENT 'Informs that the channel chat has been created',
  `migrate_to_chat_id` bigint NULL DEFAULT NULL COMMENT 'Migrate to chat identifier. The group has been migrated to a supergroup with the specified identifier',
  `migrate_from_chat_id` bigint NULL DEFAULT NULL COMMENT 'Migrate from chat identifier. The supergroup has been migrated from a group with the specified identifier',
  `pinned_message` TEXT NULL COMMENT 'Message object. Specified message was pinned',
  `invoice` TEXT NULL COMMENT 'Message is an invoice for a payment, information about the invoice',
  `successful_payment` TEXT NULL COMMENT 'Message is a service message about a successful payment, information about the payment',
  `connected_website` TEXT NULL COMMENT 'The domain name of the website on which the user has logged in.',
  `passport_data` TEXT NULL COMMENT 'Telegram Passport data',
  `reply_markup` TEXT NULL COMMENT 'Inline keyboard attached to the message',

  PRIMARY KEY (`chat_id`, `id`),
  KEY `user_id` (`user_id`),
  KEY `forward_from` (`forward_from`),
  KEY `forward_from_chat` (`forward_from_chat`),
  KEY `reply_to_chat` (`reply_to_chat`),
  KEY `reply_to_message` (`reply_to_message`),
  KEY `left_chat_member` (`left_chat_member`),
  KEY `migrate_from_chat_id` (`migrate_from_chat_id`),
  KEY `migrate_to_chat_id` (`migrate_to_chat_id`),

  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  FOREIGN KEY (`forward_from`) REFERENCES `user` (`id`),
  FOREIGN KEY (`forward_from_chat`) REFERENCES `chat` (`id`),
  FOREIGN KEY (`reply_to_chat`, `reply_to_message`) REFERENCES `message` (`chat_id`, `id`),
  FOREIGN KEY (`forward_from`) REFERENCES `user` (`id`),
  FOREIGN KEY (`left_chat_member`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `edited_message` (
  `id` bigint UNSIGNED AUTO_INCREMENT COMMENT 'Unique identifier for this entry',
  `chat_id` bigint COMMENT 'Unique chat identifier',
  `message_id` bigint UNSIGNED COMMENT 'Unique message identifier',
  `user_id` bigint NULL COMMENT 'Unique user identifier',
  `edit_date` timestamp NULL DEFAULT NULL COMMENT 'Date the message was edited in timestamp format',
  `text` TEXT COMMENT 'For text messages, the actual UTF-8 text of the message max message length 4096 char utf8',
  `entities` TEXT COMMENT 'For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text',
  `caption` TEXT COMMENT  'For message with caption, the actual UTF-8 text of the caption',

  PRIMARY KEY (`id`),
  KEY `chat_id` (`chat_id`),
  KEY `message_id` (`message_id`),
  KEY `user_id` (`user_id`),

  FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  FOREIGN KEY (`chat_id`, `message_id`) REFERENCES `message` (`chat_id`, `id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `callback_query` (
  `id` bigint UNSIGNED COMMENT 'Unique identifier for this query',
  `user_id` bigint NULL COMMENT 'Unique user identifier',
  `chat_id` bigint NULL COMMENT 'Unique chat identifier',
  `message_id` bigint UNSIGNED COMMENT 'Unique message identifier',
  `inline_message_id` CHAR(255) NULL DEFAULT NULL COMMENT 'Identifier of the message sent via the bot in inline mode, that originated the query',
  `chat_instance` CHAR(255) NOT NULL DEFAULT '' COMMENT 'Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent',
  `data` CHAR(255) NOT NULL DEFAULT '' COMMENT 'Data associated with the callback button',
  `game_short_name` CHAR(255) NOT NULL DEFAULT '' COMMENT 'Short name of a Game to be returned, serves as the unique identifier for the game',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',

  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `chat_id` (`chat_id`),
  KEY `message_id` (`message_id`),

  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  FOREIGN KEY (`chat_id`, `message_id`) REFERENCES `message` (`chat_id`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `shipping_query` (
  `id` bigint UNSIGNED COMMENT 'Unique query identifier',
  `user_id` bigint COMMENT 'User who sent the query',
  `invoice_payload` CHAR(255) NOT NULL DEFAULT '' COMMENT 'Bot specified invoice payload',
  `shipping_address` CHAR(255) NOT NULL DEFAULT '' COMMENT 'User specified shipping address',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',

  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),

  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `pre_checkout_query` (
  `id` bigint UNSIGNED COMMENT 'Unique query identifier',
  `user_id` bigint COMMENT 'User who sent the query',
  `currency` CHAR(3) COMMENT 'Three-letter ISO 4217 currency code',
  `total_amount` bigint COMMENT 'Total price in the smallest units of the currency',
  `invoice_payload` CHAR(255) NOT NULL DEFAULT '' COMMENT 'Bot specified invoice payload',
  `shipping_option_id` CHAR(255) NULL COMMENT 'Identifier of the shipping option chosen by the user',
  `order_info` TEXT NULL COMMENT 'Order info provided by the user',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',

  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),

  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `poll` (
  `id` bigint UNSIGNED COMMENT 'Unique poll identifier',
  `question` char(255) NOT NULL COMMENT 'Poll question',
  `options` text NOT NULL COMMENT 'List of poll options',
  `is_closed` tinyint(1) DEFAULT 0 COMMENT 'True, if the poll is closed',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `telegram_update` (
  `id` bigint UNSIGNED COMMENT 'Update''s unique identifier',
  `chat_id` bigint NULL DEFAULT NULL COMMENT 'Unique chat identifier',
  `message_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New incoming message of any kind - text, photo, sticker, etc.',
  `edited_message_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New version of a message that is known to the bot and was edited',
  `channel_post_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New incoming channel post of any kind - text, photo, sticker, etc.',
  `edited_channel_post_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New version of a channel post that is known to the bot and was edited',
  `inline_query_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New incoming inline query',
  `chosen_inline_result_id` bigint UNSIGNED DEFAULT NULL COMMENT 'The result of an inline query that was chosen by a user and sent to their chat partner',
  `callback_query_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New incoming callback query',
  `shipping_query_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New incoming shipping query. Only for invoices with flexible price',
  `pre_checkout_query_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New incoming pre-checkout query. Contains full information about checkout',
  `poll_id` bigint UNSIGNED DEFAULT NULL COMMENT 'New poll state. Bots receive only updates about polls, which are sent or stopped by the bot',

  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`),
  KEY `chat_message_id` (`chat_id`, `message_id`),
  KEY `edited_message_id` (`edited_message_id`),
  KEY `channel_post_id` (`channel_post_id`),
  KEY `edited_channel_post_id` (`edited_channel_post_id`),
  KEY `inline_query_id` (`inline_query_id`),
  KEY `chosen_inline_result_id` (`chosen_inline_result_id`),
  KEY `callback_query_id` (`callback_query_id`),
  KEY `shipping_query_id` (`shipping_query_id`),
  KEY `pre_checkout_query_id` (`pre_checkout_query_id`),
  KEY `poll_id` (`poll_id`),

  FOREIGN KEY (`chat_id`, `message_id`) REFERENCES `message` (`chat_id`, `id`),
  FOREIGN KEY (`edited_message_id`) REFERENCES `edited_message` (`id`),
  FOREIGN KEY (`chat_id`, `channel_post_id`) REFERENCES `message` (`chat_id`, `id`),
  FOREIGN KEY (`edited_channel_post_id`) REFERENCES `edited_message` (`id`),
  FOREIGN KEY (`inline_query_id`) REFERENCES `inline_query` (`id`),
  FOREIGN KEY (`chosen_inline_result_id`) REFERENCES `chosen_inline_result` (`id`),
  FOREIGN KEY (`callback_query_id`) REFERENCES `callback_query` (`id`),
  FOREIGN KEY (`shipping_query_id`) REFERENCES `shipping_query` (`id`),
  FOREIGN KEY (`pre_checkout_query_id`) REFERENCES `pre_checkout_query` (`id`),
  FOREIGN KEY (`poll_id`) REFERENCES `poll` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `conversation` (
  `id` bigint(20) unsigned AUTO_INCREMENT COMMENT 'Unique identifier for this entry',
  `user_id` bigint NULL DEFAULT NULL COMMENT 'Unique user identifier',
  `chat_id` bigint NULL DEFAULT NULL COMMENT 'Unique user or chat identifier',
  `status` ENUM('active', 'cancelled', 'stopped') NOT NULL DEFAULT 'active' COMMENT 'Conversation state',
  `command` varchar(160) DEFAULT '' COMMENT 'Default command to execute',
  `notes` text DEFAULT NULL COMMENT 'Data stored from command',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update',

  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `chat_id` (`chat_id`),
  KEY `status` (`status`),

  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `request_limiter` (
  `id` bigint UNSIGNED AUTO_INCREMENT COMMENT 'Unique identifier for this entry',
  `chat_id` char(255) NULL DEFAULT NULL COMMENT 'Unique chat identifier',
  `inline_message_id` char(255) NULL DEFAULT NULL COMMENT 'Identifier of the sent inline message',
  `method` char(255) DEFAULT NULL COMMENT 'Request method',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE FAQ
(
  question_id INT(4) NOT NULL,
  question_text TEXT DEFAULT NULL,
  question_answer TEXT DEFAULT NULL,
  CONSTRAINT pk_item PRIMARY KEY (question_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*******************************************************************************/
/***                              Add data to table                          ***/
/*******************************************************************************/

/*------ Account -------*/
INSERT INTO Account(id, email, password, is_admin, first_name, last_name, phone_number) VALUES
(1, 's10180780@connect.np.edu.sg', '$2y$10$hber0w8mVVSfzC8F8vCSjeRwqXwQEwt2cnnkgljeRjBl9/Mu4ZXya', 1, 'John Michael', 'San Diego', '69696969'),
(2, 'rongk4ii@gmail.com', 'alibaba123', 1, 'John Cena', 'California', '61262916');

/*------ Course -------*/
INSERT INTO Course(id, course_id, course_name, course_abbreviations,course_short_description, course_description, course_year1_description, course_year2_description, course_year3_description ,course_elective_description, course_requirements, course_intake) VALUES
(1, 'N54', 'Information Technology','IT','Be an All-Rounded Tech Pro', 'Develop innovative IT solutions that increases business competitiveness, enhance the quality of life, or even start your very own online business. We follow a "Learn by Doing" Experiential Learning pedagogy. We let students have a Self-directed approach to acquire real-world skills that meet industry needs, have Exciting internships with industry leaders like Microsoft and IBM, give students Opportunities to develop IT business ideas and apps at ICT technology hubs and also let students have the Freedom to build your portfolio from seven areas of interest.', 'Build a solid foundation in IT, programming, computing mathematics and cyber security during the first semester. Develop your understanding in core computing skills such as databases as well as operating systems and networking fundamentals.' , 'Choose from a variety of electives that suit your interest and passions. Research IT-related topics to develop your digital portfolio.', 'Go on a six-month local or overseas internship, develop your own IT business and ideas, and work on a capstone project.','Select a wide range of modules that suits your interests, offered to you as elective during your study here!' ,'5 - 10', 75),
(2, 'N81', 'Financial Informatics','FI', 'Bank on Fintech', 'Get a strong foundation in IT training, reinforced with exciting modules from these three areas: Financial analytics, banking & finance and enterprise computing. Financial analytics is an increasingly important tool to financial institutions as it helps them stay competitive, identify new business opportunities and detect frauds. In banking & finance, financial technology is also a growth area. There will be exciting internships with industry leaders like DBS, OCBC, or with FinTech start-ups, accelerators and incubators during the final year of your course.', 'Build a solid foundation in IT, programming, computing mathematics and cyber security during the first semester. You''ll also get to conduct independent research on IT or fintech-related topics right from your first year.' , 'Develop applications for the banking and finance industry, and understand business strategies used in organisations while implementing business processes. Learn how to analyse financial data, and design business processes and applications.' , 'Get an overview of business processes and transaction workflows in banking and financial institutions. Sharpen your analytical skills through industry-based projects and internship. Plus, you''ll get to choose to either work on a capstone project to solve real-world challenges or take up two elective modules offered by the school.' ,'Select a wide range of modules that suits your interests, offered to you as elective during your study here!' ,'4 - 10', 50),
(3, 'N55', 'Immersive Media','IM', 'Create Awesome User Experiences', 'AR/VR/MR are enabled the creation of engaging content to transport users to other world beyond the confines of their flat screens. Through the Diploma in Immersive Media,you strongly focus learn the immersive media and User Experience and User Interface (UX/UI). You can choose to broaden your skills with a variety of electives offered by the School.As well as you get trained in sought-after areas such as design that open doors to exciting career pathways and a Industry-standard graduation portfolio to beef up your resume.', 'Receive strong fundamental training in design and programming through modules such as Applied Design, Interactive Development and Programming 1.' , 'Learn about spatial concepts and how to design interactive media content and applications on different platforms.', 'Put your skills to the test by going for a six-month internship and working on your capstone project.' ,'Select a wide range of modules that suits your interests, offered to you as elective during your study here!' ,'7 - 13', 0),
(4, 'N94', 'Cybersecurity & Digital Forensics','CDF', 'Fight Cybercrime', 'Mitigate cyber threats Singapore faces in our quest to be a smart nation. With rapid growth in the area of Financial Technology, information security will be even more critical to protect our financial institutions. 
You will get the most comprehensive training & curriculum in secure software development and go for exciting internships with IT Security leaders. You will also perform penetration tests and work on projects in our cutting-edge CSF labs, get to attend masterclasses by information security professionals and attain highly sought-after CompTIA Security+ professional certifications.', 'Build a solid foundation in IT, programming, computing mathematics and cyber security during the first semester. You''ll also get to learn about cryptography, databases and front-end development.', 'Develop skills in the areas of network security, software security and digital forensics. Learn to set up computer networks, develop secure software applications and conduct malware analysis.' , 'Perform penetration tests on software, systems and networks, and get in-depth knowledge on network security. You''ll also get to work on industry-driven project, a technopreneurship project or an IT-related project with a local or overseas organisation.','Select a wide range of modules that suits your interests, offered to you as elective during your study here!' , '4 - 8', 50),
(5, 'N95', 'Common ICT Programme','CICT', 'Explore Infocomm Frontiers', 'Interested in the world of IT but unsure about which course to choose? With the Common ICT Programme (CICTP), you will have more time to explore different disciplines before making a more informed choice. You will gain an introduction to the field of IT by understanding the roles, practices and career paths of IT professionals. You will also learn the fundamentals of programming and cyber security, as well as an overview of enterprise information systems that use data analytics for decision making. You will get to choose your preferred discipline at the end of your first semester.', 'Get an introduction to the field of IT by understanding the roles, practices and career paths of IT professionals. Learn the fundamentals of programming and cyber security, as well as an overview of enterprise information systems that use data analytics for decision making. Choose your preferred discipline at the end of your first semester.' , 'Pursue modules from one of the four diplomas - Information Technology, Financial Informatics, Cybersecurity & Digital Forensics or Immersive Media.', 'Deepen your skills and knowledge in one of the four diplomas you''ve chosen - Information Technology, Financial Informatics, Cybersecurity & Digital Forensics and Immersive Media.','Select a wide range of modules that suits your interests, offered to you as elective during your study here!' , '5 - 13', 100)
;




/*------ Requirement -------*/
INSERT INTO Requirement VALUES
(1, 'English Language as First Language', '1 - 7'),
(2, 'Mathematics', '1 - 6'),
(3, 'Any two other subjects', '1 - 6')
;

/*------ CourseReq -------*/
INSERT INTO CourseReq VALUES
(1, 1),(1, 2),(1, 3),
(2, 1),(2, 2),(2, 3),
(3, 1),(3, 2),(3, 3),
(4, 1),(4, 2),(4, 3),
(5, 1),(5, 2),(5, 3);

/*------ Job -------*/
INSERT INTO Job(job_id, job_name) VALUES
/*--IT--*/
(1,'Application Developer'),(2,'Software Architect'),(3,'Front End Developer'),

(4,'Customer Support Administrator'),(5,'Desktop Support Manager'),(6,'Help Desk Specialist'),

(7,'Cloud Engineer'),(8,'Cloud Services Developer'),(10,'Cloud System Administrator'),

(11,'Cyber Security Specialist'),(12,'IT Security Consultant'),(13,'IT Security Officer'),

/*--IM--*/
(14, 'Interaction Designer'), (15, 'UX Designer'), (16,'Usability Analyst'), (17,'Visual Designer'),

(20,'Game Designer'),(21,'Game Interface Designer'), (22,'Game Animator'),(23,'Game Audio Engineer'),

(24,'3D Artist'),(25,'Interactive 3D/VR Artists'),(26,'Cartoonist'),

(27,'Producer'),(28,'Level Designer'),(29,'Junior Programmer'),

/*--FI--*/
(30,'Accountant Technician'), (31, 'Brand Consultant'), (32,'Bank Manager'),

(33,'Data Architect '), (34, 'Business Intelligence'), (35, 'Application Architect'),

(36,'Customer Due Diligence Manager'), (37,'Customer Service Order Manager'),

(38,'Project Manager'), (39,'Business Consultant'), (40,'IT Business Analyst'),

/*--CSF--*/

(41,'Security Architect'), (42,'Security Engineer'), (43,'Security Manager'), 

(48, 'Security Penetration Specialist'), (47, 'Security Penetration Tester'), (49, 'Web Application Security Tester'), 

(50,'Cyber Risk Analyst'), (52,'Risk Control Specialist'), (53, 'Risk Consultant'), 

(55, 'Cyber Forensic Analyst'), (56, 'Private Investigators'), (58,'Law Enforcer');

/*------ Category -------*/
INSERT INTO Category(category_id, category_name, id) VALUES
/*--IT--*/
(1, 'Programmer', 1), 
(2, 'Helpdesk', 1), 
(3, 'Cloud Technology', 1), 
(4, 'Information Security', 1), 

/*--IM--*/
(5, 'User Experience', 3), 
(6, 'Game Designer', 3), 
(7, 'Graphics, 3D/Sketch', 3), 
(8, 'Digital Work', 3),

/*--FI--*/
(9, 'Banking & Finance', 2), 
(10, 'Data Science', 2),
(11, 'Customer Service', 2), 
(12, 'Consultant',2),

/*--CSF--*/
(13, 'Security Analyst', 4), 
(14, 'Ethical Hacker', 4), 
(15, 'Security Risk', 4), 
(16, 'Cyber Forensics', 4);

/*--CategoryJob--*/
INSERT INTO CategoryJob(category_id, job_id) VALUES
/*--Coding--*/
(1, 1), (1, 2), (1, 3),

/*--Customer Support--*/
(2, 4), (2, 5), (2, 6), 

/*--Cloud Computing Engineers--*/
(3, 7), (3, 8),  (3, 10), 

/*--Information Security Specialist--*/
(4, 11), (4, 12), (4, 13), 

/*--UX--*/
(5, 14), (5, 15), (5, 16), (5, 17), 

/*--Game Designer--*/
(6, 20), (6, 21), (6, 22), (6, 23),

/*--3D/Sketch--*/
(7, 24), (7, 25), (7, 26),

/*--'Digital'--*/
(8, 27), (8, 28), (8, 29), 

/*--Banking & Finance--*/
(9, 30), (9, 31), (9, 32), 

/*--Data Science--*/
(10, 33), (10, 34), (10, 35),

/*--Customer Service--*/
(11, 36), (11, 37), 

/*--Enterprise--*/
(12, 38), (12, 39), (12, 40), 

/*--Security Analyst [Network/Server] --*/
(13, 41), (13, 42), (13, 43),

/*--Penetration Tester--*/
(14, 47), (14, 48), (14, 49),

/*--Security Risk Management--*/
(15, 50), (15, 52), (15, 53), 

/*--Forensics--*/
 (16, 55), (16, 56), (16, 58);

/*------ Electives -------*/
INSERT INTO Elective(elective_id, elective_name) VALUES
(1, 'Banking and Finance'),
(2, 'Data Science & Analytics'),
(3, 'Cloud Computing'),
(4, 'Enterprise Solutioning & Marketing'),
(5, 'Game Programming'),
(6, 'Solution Architect'),
(7, 'General IT Electives'),
(8, 'Elective Module')
;
/*------ Module -------*/
INSERT INTO Module(module_id, module_name, module_description) VALUES
(1,'3D Environments','This module introduces students to advanced real-time environment design workflow. Students will practice modular organic 3D asset production workflow integrating basic real-time tech art, effects, lighting, and post processing with focus on exterior spatial layout design for immersive media.'),
(2,'3D for Real-time','This module introduces students to basic real-time environment design workflow. Students will practice modular hard-surface modelling integrating real-time engine graphics optimization techniques with focus on interior spatial layout design & lighting for immersive media.'),
(3,'3D Fundamentals ','This module introduces students to basic digital 3D production workflow to create assets for interactive projects. Students will practice basic modeling, UV unwrapping, digital sculpting, high-poly detail onto low-poly mapping, texturing, rigging, animation, real-time lighting and rendering. Students will learn to produce hard-surface virtual objects for real-time engine.'),
(4,'Accounting','This module introduces the basic theory and concepts of accounting through the introduction of Business Structures and Financial Institutions. Basic accounting concepts and principles form the foundation of the module and students will be taught the complete accounting cycle; setting up the chart of accounts, balancing the trial balance and preparing financial statements. It also introduces risk and controls and accounting standards and regulations governing the financial services industry. Students will also learn about the differences between financial and management accounting as well as funding methods and financial ratios for business and banks'),
(5,'Applied Analytics','This module provides students with an introduction to unsupervised machine learning methods such as Clustering. Students are taught how these methods are used to segment customers for targeted cross-sell, up-sell and pricing. The module also introduces students to supervised machine learning methods such as Decision Trees and how these methods are used to predict customer churn, credit risk etc. Open-source tools like R and/or Python will be used for data analysis and modelling. Students will also be exposed to enterprise analytics tools for interactive data visualization and data wrangling. Data from various domains (Retail, Banking & Finance, Telcos etc) will be used to provide students with an introduction to domain-specific analytics.'),
(6,'Applied Design','This module introduces students to design application through digital props and environment concept illustration. Students will practice perspective drawing, constructive drawing, color rendering, and compositional design. Students will learn to produce visual plans essential in real-time immersive production workflow.'),
(7,'Artificial Intelligence for Games','This module introduces the various approaches for injecting intelligence into games. Topics covered include AI architecture (e.g. rule-based systems, finite state machines), movement, pathfinding and planning (both strategic and tactical). AI-related game design issues such as realistic non-player character behaviour and game difficulty will also be taught.'),
(8,'Banking & Financial Products','For banks and financial institutions to gain an edge over their competitors, many are providing consumers and corporates with a wide range of products and services. Many are harnessing information technology in their day- today operations to provide multiple channels and greater efficiency and effectiveness in banking and financial services to enhance overall customer experience. This module provides a macro overview of the financial services industry, including financial intermediaries and allows students to understand the operational structure and the roles and responsibilities of different departments in banks at a high level. Subsequently, a myriad of banking and financial products that are widely available in commercial and investment banks and insurance companies would be discussed. Students will learn about the fundamentals of retail, wholesale and investment products as well as risk associated with them and the mitigating controls that banks put in place to manage the risks. The role of Information Technology is intertwined into the module, allowing students to appreciate the use of IT to increase operational efficiency and effectiveness in financial institutions'),
(9,'Banking Applications & Processes','This module aims to provide students with an overview of the business processes and transaction workflows in banking and financial institutions. The module begins with a look at the various organizational structures within different types of banking and financial institutions, and the roles and responsibilities of key front office and back office functions across various business lines. Students will subsequently explore the end-to-end workflow processes for banking and financial transactions, and their supporting IT applications and systems.'),
(10,'Big Data','This introductory module covers the fundamentals of elements of Big Data: volume, velocity and variety. Students will learn various technologies & tools used to create a big data ecosystem which is able to handle storing, indexing & search. This module also covers the whole technology stack of Big Data: infrastructure, data management and analytics. Tools such as Hadoop, HDFS, and MapReduce will be taught in this module'),
(11,'Capstone Project','In this module, students are required to complete a substantial project that is the culmination of their education in the School of InfoComm Technology. The project can be a real-world problem proposed by a client, or it can be proposed by the student in pursuit of their personal interests.'),
(12,'Cloud Architecture & Technologies','This module gives insight into the key concepts and technologies of cloud computing which include cloud characteristics, service models (SaaS, PaaS, and IaaS), deployment models (Public cloud, Private cloud, Community cloud, and Hybrid cloud), and the features of cloud computing technologies. It also covers the cloud computing architecture, emerging trends and issues such as clouds for mobile applications, cloud portability and interoperability, scalability, manageability, and service delivery in terms of design and implementation issues. The module discusses the benefits and challenges of cloud computing, standards of cloud computing service delivery, and Service Level Agreement (SLAs) for cloud services. Hands-on activities are included to expose students to various cloud computing services offered by major cloud computing providers such as Amazon Web Services (AWS), Google App Engine (GAE), and Microsoft Windows Azure.'),
(13,'Communication Essentials','Communication Essentials purpose to develop written and spoken communicative competence in you by exposing you to a range of recently issues from different disciplinary perspectives. Learn to carry out research, read critically, more effectively write and express yourself with confidence while developing a global view, an awareness of cultural intelligence and of self in relation to society.'),
(14,'Computing Mathematics','This module introduces the basic concepts of relations and functions, matrices and methods of statistics and their applications relevant to IT professionals. The main emphasis in this module is to develop students'' ability in solving quantitative problems in computing mathematics, probability and statistics. Topics covered include fundamentals of statistics and probability, discrete and continuous probability distributions.'),
(15,'Cryptography','This module covers the essential concepts of Cryptography, including Public Key Infrastructure (PKI), Digital Signature and Certificate, and the various encryption/decryption algorithms. Students will understand how Symmetric and Asymmetric (Public- Key) cryptographic techniques are used to support different security implementations, and the encryption/ decryption algorithms used in these techniques. The role of the Certificate Authority, how the digital certificates are generated, managed and distributed will also be covered in detail.'),
(16,'Customer Decision Making & Negotiation Skills','Students will be introduced to soft skills in understanding customer biases and concerns, building rapport, handling objections, identifying informal and formal decision makers, selling functions/features/ benefits, negotiating and closing sales techniques. They will also learn about reference selling and proofs of concept as well as pick up presentation and communication skills. The module offers opportunities to role play and develop value proposition in sales calls within the context of ICT.'),
(17,'Customer Experience Management','With SMAC (Social, Mobility, Analytics and Cloud) technologies resulting in a new competitive environment, the control has shifted from the seller to buyer. This module provides students with the knowledge and understanding of Customer Experience Management (CXM) as a business strategy in this new environment. The buyer’s experience is not limited to a single transaction but includes the sum of all experiences across all touch points and channels between a buyer and a seller over the duration of their relationship. This strategy aims to achieve a sustainable competitive advantage to help sellers manage the buyer’s experience that is both collaborative and personalized. Students will have an opportunity to have hands-on experience with customer management systems used by sellers that collect and create customer data, segment that data into manageable data sets, make sense of the data and make it available for timely delivery. This allows companies to deliver consistent customer experiences that delight customers or achieve other organisational goals'),
(18,'Cyber Security Fundamentals','This module provides an overview of the various domains of cyber security. It helps develop an understanding of the importance of cyber security in today’s digital world. It aims to provide an appreciation of cyber security from an end-to-end perspective. It covers fundamental security concepts, tools and techniques in domains such as data, end-user, software, system, network, physical, organisation, and digital forensics. It also helps develop knowledge and skills in identifying common cyber threats and vulnerabilities, and to apply techniques to tackle these issues. In this module, students are assessed by coursework only.'),
(19,'Data Structures & Algorithms','This module aims to provide students with the knowledge and skills to analyse, design, implement, test and document programmes involving data structures. It teaches basic data structures and algorithms within the conceptual framework of abstract data types. The emphasis here is to use the class feature of an Object-Oriented language platform to give the concrete implementation of various abstract data types.'),
(20,'Databases','Today’s business organisations depend on information systems in virtually all aspects of their businesses. Corporate databases are set up to hold the voluminous business transactions generated by these information systems. This module introduces students to the underlying concepts of database systems and how to model and design database systems that reflect business requirements. Students will be taught how to analyse data needs, model the relationships amongst the data entities, apply normalisation process to relations and create the physical database. Skills to be taught include data modelling technique, transformation of data model to relations, normalisation technique and SQL (Structured Query Language).'),
(21,'Descriptive Analytics','Descriptive Analytics refers to a discipline used by many companies to analyse their data for improved decision making. Descriptive Analytics describes what happened in the past. It can include various forms of reports, queries and dashboards. This module aims to teach students the descriptive analytics lifecycle. Students will learn to ask the appropriate analytics questions, identify and aggregate data sources and create data models. They will apply techniques to analyse the data captured in these models. They will also create appropriate visualisation components to gain insights from the data. These visualisation components will be synthesized into dashboards that add value and can be readily consumed by business users.'),
(22,'Design Principles','This module introduces students to basic elements and principles of design. Students will practice visual communication and self-branding through aesthetic use of line, shape, form, color, texture, typography, scale, contrast, rhythm and balance. Students will be trained in the usage of digital design tools and application of modern industrial practices to communicate the concepts, designs and solutions.'),
(23,'Designing User Experience','This module aims to equip students with skills and techniques to fulfil the various stages of the UX design process, leading to optimum user-centric digital products. Exposure to various problem statements will aid students in developing critical, analytical perspectives for framing their approaches in problem-solving. Other major topics include: Research methods, Inclusive Design, Interaction Design, Rapid Prototyping, Measuring User Experience and Usability Testing. Students are also guided on how to compile a proper UX portfolio.'),
(24,'Developing Cloud Applications','This module covers the analysis of business and technical requirements of a cloud-based system, implementation of a cloud strategy with appropriate programming tools, deployment, and testing and debugging the cloud application. Analysis of business requirements to determine how they can be mapped into a cloud environment is discussed in this module. The module extends its discussion to cloud computing design patterns, best practices, cloud migration issues and considerations. Students are exposed to a cloud computing platform such as Windows Azure to get extensive hands-on practice to build, migrate, host and scale web applications and services through the vendor’s data centres.'),
(25,'Developing Dynamic Applications','This module aims to broaden the students’ skillsets by introducing server-side development to create a digital product. This module covers various client-server architectural concepts that involves rich client, application server and database. Students will hone their programming skills by learning server-side programming, object-oriented programming, database design and development. In addition, students will experience the development production process and workflow.'),
(26,'Digital Forensics','This module gives an insight into the process of forensics investigation. It covers the various types of computer related crimes, techniques of gathering electronic evidence, and the recovering of deleted, damaged or encrypted data. Students will also make use of advanced forensic tools to perform forensic investigation. Besides the tools and techniques of investigation, students will be taught sound forensic investigation methodology and the proper handling of evidence. The module will also cover aspects of law and policies applicable to digital forensics.'),
(27,'eCommerce Applications Development','This module aims to provide students with the technical skills as well as an appreciation of the business perspective on electronic commerce (eCommerce). The main focus will be on building a Business-to Consumer (B2C) eCommerce website. Students will be taught the building blocks and enabling technologies for building eCommerce applications, the processes of eCommerce transactions and some business issues on eCommerce. The module will also provide hands-on experiences for students to build a simple B2C eCommerce website on their own'),
(28,'Emerging Trends in IT','The revolution in computing and communications has spurred the rapid advancement of IT in modern societies, and there is little to suggest that its proliferation will slow down in the near future. In light of this trend, this module is designed to help students keep abreast of the latest IT developments to stay current and relevant in the fast moving industry. To achieve this objective, the syllabus for this module will be guided by technology research and feedback from industry partners, and both seminar-style and hands- on workshop teaching approaches may be adopted depending on the nature of the topic covered.'),
(29,'English Language Express','English Language Express can help you get a better grounding in the English Language and to strengthen the written and oral communications skills that you will need in your academic and professional careers. You will be engaged in writing, reading, listening and speaking activities that will improve your ability to speak and write grammatically, coherently and clearly. You will also refine prefect your reading and listening comprehension skills.*This module is only offered to students who are weaker in the English Language.'),
(30,'Enterprise Business Processes','Business processes are a set of activities that are designed to produce a specific output for an organisation. Processes can be cross-functional or even spanning across organisations. For today’s businesses, especially for large and complex organisations with complex products and services, they very much rely on the efficiency and effectiveness of their business operations to compete with competitors, often with the help of IT systems. However, these business processes need to be agile and flexible in order to adapt to changes in business needs. Organisations which are unable to do this will be at a disadvantage. The study of enterprise business processes will illustrate to students the key business processes in typical organisations. Students will learn about the business strategies used in organisations while implementing business processes, the typical deliverables for a business process that each organisation adopts, the importance of integration of information across different departments or organisations and the relationship between the banks and organisations for all payments with customer and vendors. In addition, students are expected to draw detailed activity diagrams for the major business processes. At the end of the module, students will be able to appreciate the complexity of business processes, how IT can help organisations to be more competitive and gain basic management skills required to manage business processes in an organisation.'),
(31,'Enterprise Information Systems','Companies today are adopting the use of technology not just to assist them in their day-to-day operations but also gaining an advantage over their competitors. Many of them are implementing enterprise-wide information systems that provide them with platforms to integrate and coordinate their business processes. The use of enterprise information systems has become a necessity in multinational companies (MNCs) as well as small and medium enterprises (SMEs). Within an enterprise information system, there is an intricate relationship between business strategy, organizational structure, business processes and technology resulting in challenges and issues during implementation. This module introduces students to the different components that build up an enterprise information system. Different types of information systems are used for business processes, from communication and order processing to data analysis for decision making, and in almost all business functions ranging from marketing, sales, procurement, and human resource, to product development and manufacturing, accounting and finance'),
(32,'Enterprise Resource Planning ','This module provides a training learn how to use the software allows an organization to use a system of integrated applications to manage the business, and automate many back office functions such as technology, services and human resources'),
(33,'Ethical Hacking','This module aims to develop Penetration Testers for the information security industry. They will be taught to follow a process model to locate and establish targets, find vulnerabilities, and exploit the flaws to determine potential impact and business risk with the goal of helping the owner improve security practices. Students will learn the techniques hackers use to hack a system, and the steps to secure it. Students will have hands- on practice on actual pen-testing that involves reconnaissance to map out IT infrastructure, scanning vulnerable systems, and developing attack vectors to exploit loopholes in a system. Students will also be taught the necessary countermeasures to mitigate risks of exploitation through system hardening, intrusion detection and prevention.'),
(34,'Experiential Design','This module exposes and introduce students to designing media content and applications for various platforms. It covers the concept of designing extended reality (XR) products with heavy emphasis on the User Experience (UX) for the respective platforms. Students will be tested on their observational, research and problem-solving skills to seek out current/future technological advancements, and to come up with proposals and prototypes for actual implementation.'),
(35,'Financial Analysis & Modelling','The form of a spreadsheet creating a summary of a company’s expenses and earnings. The students can be used to calculate the impact of a future event or decision. Many company executives uses the finanical model. The students will learn how to use it to analyze and anticipate how a company’s stock performance might be affected by future events or executive decisions.'),
(36,'Financial Ecosystem','This module provides a macro overview of the network of organisations involved in the delivery of financial services through both competition and cooperation. Students will be introduced to the various participants in the financial ecosystem, which includes financial intermediaries, regulators, market operators, industry associations and customers. Subsequently, students would also learn about the market microstructures, interactions and interdependencies underlying the relationships intertwining these participants. Additionally, students would learn about the on-going digital evolution in the financial sector and its future implications for all participants.'),
(37,'Front-End Development','This module teaches the fundamental skills required to develop responsive websites that are optimised for mobile and desktop viewing. The students would attain skills and knowledge in programming languages such as HTML, CSS, JavaScript, jQuery, and AJAX which are used to develop interactive websites. This allows students to develop a website with interactive elements, providing them with a tangible product that they can develop into an interactive resume application and e-Portfolio website.'),
(38,'Fundamentals for IT Professionals I','This module provides a broad introduction to the field of IT by exploring the roles, professional practice, ethical expectations and career development paths of IT professionals. Through a guided inculcation of interpersonal and team work skills with strong team bonding spirit, the module aims to deepen students’ commitment to the sector that the course prepares them for. In addition, students will be required to begin charting their career path in the IT industry by considering crucial aspects such as personal preferences and aptitude, job roles and responsibilities, skills needed and further education.'),
(39,'Fundamentals for IT Professionals II','This module gives a course-based experience in which students can engage with the local community and industry. This includes participation in community service events or in Service-Learning projects that leverage students’ discipline knowledge and skills to meet identified needs. Through iterative and guided reflection on the service experience, students gain a broader appreciation of their discipline and an enhanced sense of personal voice, empathy and civic responsibility. Industry talks and seminars are organised to keep students up-to-date on emerging trends so as to build up their interpersonal, team and networking skills with the community and industry.'),
(40,'Fundamentals for IT Professionals III','This module provides a stepping stone to the students in their IT career. Students are given an insight into the infocomm industries and are kept updated with the latest skill sets required in their IT career path. They also have the opportunity to be exposed to various institutes of higher learning to further acquire their skill sets.'),
(41,'Game Interactivity','This module introduces game interactivity and the various game interaction devices to the students. Topics include current and experimental game devices, console usability, player profiling and psychology, measuring playability and testing techniques. Students will be required to research and develop a game prototype demonstrating their understanding of game interactivity'),
(42,'Game Production','This module provides an overview of the game development process and introduces game design. Key concepts of game design such as storytelling, game mechanics and level design will be covered. Students will have the opportunity to design and prototype a game using an industry standard game creation system.'),
(43,'Gameplay Programming','This module presents fundamental concepts of game implementation and architecture, such as the game loop, gamesystem component separation, the game state manager, input/output handling and frame rate control. Basic concepts in computer graphics, such as collision detection and back buffering, will also be introduced. Consequently, students will have the opportunity to develop a game prototype without the use of a game engine.'),
(44,'Gamification Concepts','This module studies the game mechanics – the rules intended to produce an enjoyable gameplay and introduces the principles and methodologies behind the rules and play of games. Once students have mastered the basics of game-design elements and game principles, they will learn to apply them in nongame contexts to improve user engagement, organizational productivity and learning.'),
(45,'Governance & Data Protection','This module examines the relevant frameworks to ensure that information assets are protected within an organisation. It includes the processes and policies for administering and managing a company’s IT systems that follow the compliance framework. Concepts on risk management process, risk analysis and mitigation will also be introduced. Students will learn to evaluate risks against the company’s critical assets and deploy safeguards to mitigate them. Control frameworks such as PCI (Payment Card Industry), ISO 17799/27002, and COBIT will be covered.'),
(46,'Immersive Technology Development','This module provides an overview of emerging technologies with emphasis in interactive and immersive technologies, and the impact they have on the users. It is designed to help students keep abreast of the latest immersive experiences or technology developments to stay current and relevant in the fast-moving industry. To achieve this objective, the syllabus for this module will be guided by technology research and feedback from industry partners, and both seminar-style and hands-on workshop teaching approaches may be adopted depending on the nature of the topic covered.'),
(47,'Infocomm Sales & Marketing Strategies','This module will introduce students to the concept of market segmentation and the development of sales and marketing strategies for each segment. They will acquire an understanding of industry and customer segmentation from corporate, small and medium businesses to consumers. They will also delve into the different go-to-market strategies and selling techniques required in the context of ICT (such as consultative selling, major account selling and management, territory selling and management, partner management and consumer marketing).'),
(48,'Innovation Made Possible','Apply to build the creative confidence with Design Thinking framework. The module will sensitize you to the process of user-centric problem solving and allow you to discover & hone your innate ability to think creatively, appear with innovations to tackle problems and explore new ideas for your studies and beyond.'),
(49,'Interactive 3D Experience','This module continues to develop students’ ability to design and author highly interactive experience applications. The programming focuses on interactivity authoring through the eyes of designers for animation, visual effects, multimedia and games. It covers advanced authoring, digital storytelling techniques, user experience design, and project management techniques. Additionally, students will utilise a real-time engine and create prototypes for.'),
(50,'Interactive Development','This module widens students’ programming knowledge by covering programming concepts through the creation of interactive media applications. Students refine their knowledge of programming by decomposing their programs into classes and objects. Students learn to understand, design and build modern interfaces, moving on to create interactive elements. The focus of this module is to incorporate interaction design and methodology to build interactive applications around it.'),
(51,'Internship or Project','This module provides students with the opportunity to apply the knowledge and skills gained to develop an IT solution to solve a practical problem. Students may undertake an in-house industry-driven project or a real- life IT project in a local or overseas organisation. These projects may include problem definition, requirements analysis, design, development and testing, delivery and presentation of the solution. Through the project, students will learn to appreciate the finer points of project planning and control issues relating to IT project development.'),
(52,'Malware Analysis Tools and Techniques','This module teaches a repeatable malware analysis methodology, which includes static analysis, code analysis, and behavioural analysis. Students are taught how to write a malware analysis report on a target malware. Students will be able to determine the malware’s indicators of compromise needed to perform incident response triage. This module trains students to efficiently use network and system monitoring tools to examine how malware interacts with the file system, registry, network, and other processes in an OS environment. Students are also trained to decrypt and analyse malicious script components of web pages, identify and examine the behaviour of malicious documents, and apply memory forensics techniques to analyse complex malware and rootkit infections. This module carries a prerequisite: Reverse Engineering Malware (REM).'),
(53,'Mathematics for Games','This module provides an in-depth examination of the various mathematical concepts that are relevant to games programming. Topics covered may include vector geometry (e.g., vector arithmetic, dot product, cross product), linear transformations (e.g., rotations, reflections), matrices, trigonometry (e.g., trajectory) and physics (e.g., acceleration/deceleration, gravity).'),
(54,'Mobile Applications Development','This module focuses on the design and development of applications for mobile devices like hand phones, personal digital assistants (PDAs) and handheld computers. Due to the nature of these handheld devices, issues such as memory storage, user interface and data input methods require more careful consideration and planning. At the end of this module, students will be able to develop applications that can run on mobile devices and interact wirelessly with server side programmes.'),
(55,'Mobile Applications Development II','This module builds upon the skills and knowledge that students have acquired from the Mobile Applications Development module. It will focus on the development of advanced applications and emerging mobile operating systems. For example, students could develop applications for industries such as entertainment, games and healthcare. They will learn to develop applications for emerging operating systems such as the iPhone OS and Android.'),
(56,'Mobile Device Security & Forensics','This module covers techniques and tools in the context of a forensic methodology to extract and utilise digital evidence on mobile devices. Students will learn how to use current forensic tools to preserve, acquire and examine data stored in a mobile device. The module covers basic SIM Card examination and cell phone forensics on multiple platforms such as iPhone, Android and Windows Mobile. The module takes a practice- oriented approach to performing forensics investigation on mobile phones.'),
(57,'Network Forensics','Network equipment, such as web proxies, firewalls, IDS, routers, and switches, contain evidence that can make or break a case. This module provides students with the knowledge and skills to recover evidence from network-based devices. It will begin with an introduction of different network devices and the type of data that are useful from a forensic point of view. It then moves on to the most common and fundamental network protocols that the forensic investigators will likely face during an investigation. These include the Dynamic Host Configuration Protocol (DHCP), Network Time Protocol (NTP) and Microsoft Remote Procedure Call (RPC) protocol. The students will learn a variety of techniques and tools to perform sniffing and log analysis on the network. Commercial and Open Source tools will be used to perform deep packet analysis while SIEM tools such as Splunk will be used to perform log analysis on network devices.'),
(58,'Network Security','This module provides an in-depth knowledge on network security in a defensive view. It covers various types of firewall technologies, Virtual Private Networks (VPNs), and Intrusion Detection/Prevention Systems (IDS/IPS). Students will have a chance to configure and deploy state-of-the-art networking devices in a typical computer network. Students will be taught skills to identify the internal and external threats against a network and to propose appropriate security policies that will protect an organisation’s information. Students will also learn how to implement successful security policies and firewall strategies in this module.'),
(59,'Networking Infrastructure','This module covers basic Local Area Network (LAN) and Wide Area Network (WAN) infrastructures including physical cabling systems used for an enterprise network, and how hardware platforms such as switches, routers and servers are deployed in typical networks. The module also introduces students to major networking protocols such as Ethernet, RIP, PPP, OSPF and HDLC, network operating systems and applications that run on LANs/WANs. Students will learn to configure switches and routers, and will be taught the techniques to configure and troubleshoot LANs and WANs.'),
(60,'Object-Oriented Analysis & Design','This module leverages the skills acquired in Object- Oriented Programming to introduce software design and requirements analysis, so that students experience the full cycle of software development. An overview of various Software Development Life Cycles as well as an in-depth look at software development methodologies will be provided. In particular, students will learn about requirements gathering techniques and the primary artefacts of system design. They will be able to specify, design and document simple software systems using appropriate modelling tools.'),
(61,'Operating Systems & Networking Fundamentals','This module focuses on the fundamentals and principles of operating systems. It explains what general operating systems are and what they do. The module teaches concepts that are applicable to a variety of operating systems such as Windows and Linux. Students will learn about the different number and character representation methods such as binary, hexadecimal and ASCII. Concepts including processes, physical and virtual memory, files and directories, file systems, shell and OS commands will be covered. The module also covers the terminology and technologies in current networking environments and provides a general overview of the field of networking as a basis for subsequent related modules in the course. Topics relating to types of networks, network topologies, network technologies and layered protocol architectures will be taught. In addition, the students will also learn the OSI model to understand data networks and understand commonly used network systems such as Ethernet. As TCP/IP is deployed in most of today’s network architecture, the topic will be discussed in detail. An overview of internetworking will also be presented to allow students to have a global picture of how local area and wide area networks are interconnected in the real world.'),
(62,'Production Management','This module introduces the interactive digital media & game industry, the production pipeline, and various professional roles and career paths, and exposes students to various documents required in the production of interactive experience & games. It examines the roles of different participants in the development process and how the technical development and the artistic development proceed in tandem.'),
(63,'Programming I','This module introduces the fundamentals of programming and how to develop programs using appropriate problem solving techniques in a modular style. In this practice-oriented module, students are taught how to apply problem solving skills using a top- down structured programming methodology and given ample practice in translating solutions into computer programs, then test and debug the programs. Topics include data types, variables, expressions, statements, selection structures, loops, simple computation and algorithms, and the use of libraries. Students will also practise the use of pseudocodes, best practices of programming, debugging techniques with the help of tools, development of test cases, and suitable program documentation. In addition, they will study various areas where application software plays a prominent part in helping organisations solve problems. Students will be given ample opportunity for independent and self- directed learning. Students will learn about the organisations and mapping the business processes to draw the activity diagram flows. It is essential for students to understand how information systems are used to help organisations and they are expected to suggest solutions and new uses of information systems to solve business problems. This will enhance their IT and business processes knowledge to prepare them for future modules, future employment or even future entrepreneurship.'),
(64,'Programming II','This module builds upon the knowledge and skills acquired in Programming 1 (PRG1). It aims to provide opportunities for the students to develop medium- scale applications based on the Object-Oriented (OO) approach. A suitable object oriented high-level programming language will be used for students to continuously apply their problem-solving skills. The main concepts of OO and the implementation of applications using the OO approach will be taught in this module. The module may also cover the concepts of Abstract Data Types (ADTs) and the implementation of some selected ADTs using the OO approach. Suitable sorting and search algorithms and the use of Application Protocol Interface (API) will be introduced when required. Other key topics include the introduction of system design concepts such as the class diagram. Software robustness and correctness, and good programming practices will be emphasised throughout the module. Independent and self-directed learning will also be encouraged.'),
(65,'Project ID: Connecting the Dots','Project ID aims to prepare for the students an increasingly globalized and interconnected world where problems are multi-faceted and require interdisciplinary research and collaborative to solve. With project-based learning, multi-disciplinary team will have work together to investigate and propose comprehensive recommendations for a pressing real-world problem affecting Singapore. They get benefitted to be guided to step out of their disciplinary silos and effectively communicate and collaborate with peers from the different backgrouns. They will be developed to become independent learning skills. Their ability of knowledge to solve a complex problem, and then impressing on them the importance of being a responsible global citizen.'),
(66,'Quantitative Analysis','This module aims to introduce students to the statistical concepts and methods that are used to analyse and interpret business or financial data. Students will be equipped with the technical know-how to formulate statistical models, and make informed decisions by evaluating the statistical models using software tools. Topics covered include frequency distribution, probability distribution, quantitative modelling, correlation analysis and linear regression analysis'),
(67,'Risk Management','This module aims to teach the students analyzes and attempts to quantify the potential for losses in an investment when risk management occurs. They will learn how take appropriate action given their investment objectvies and risk tolerance.'),
(68,'Server & Cloud Security','This module aims to teach students the concepts and knowledge related to securing web servers and cloud models. It covers topics such as how a web server is installed and optimized securely, the various methods of attacking web servers and the appropriate countermeasures. The specific tools used to test for vulnerabilities in web servers, their applications and databases will also be covered. Cloud security topics will cover an introduction to the various delivery models of cloud computing ranging from Software as a Service (SaaS) to Infrastructure as a Service (IaaS). Each of these delivery models presents an entirely separate set of security conditions to consider. An overview of security issues within each of these models will be covered with in-depth discussions of risks to consider.'),
(69,'Software Engineering','This module covers the design artifacts and analysis techniques required to model, document and design complex software systems. Students will learn how to model system states and apply design patterns when developing software. Students will also learn design principles for maintainable and extensible software, as well as appropriate testing and deployment methodologies in relation to the best practices that the industry recommends. This module leverages on the core analysis and design skills acquired in Object Oriented Analysis & Design (OOAD) to introduce complex design artifacts and relevant methodologies, enabling the student to appreciate the design, deployment and management of complex software systems.'),
(70,'Spatial Theory & Level Design','This module introduces the fundamental spatial concepts and how to leverage on it to create spaces and flow for an immersive experience. It covers the design of environments and levels from the start at a conceptual beginning and arrives at a polished end to build multiple levels and engaging flow for the users in an immersive simulated environment for training and simulation.'),
(71,'Technopreneurship','The rapid emergence of new infocomm technologies is empowering new capabilities as well as opportunities for creativity and entrepreneurship. This module focuses on the processes and mechanisms by which new ideas and inventions can be commercialised in the market. Students will examine case studies of real- world examples of technopreneurship. They will also learn about the issues and challenges of transforming a technological innovation into a successful product or service in the market place'),
(72,'User Experience','This module focuses on the principles and techniques for designing good user experience in software applications and other products such as ATMs, kiosks, etc. Students will learn to apply business requirement gathering techniques as well as the analysis, design and validation phases of the user experience design life cycle, with emphasis on building empathy with users. They learn to communicate designs through deliverables such as personas, sitemaps and wireframes. Practical hands-on design activities will be guided by concepts such as information architecture, content strategy, formulation of user needs, and the application of design principles in interface, navigation, interaction and usability. The student will apply these concepts and techniques to design and prototype a web/ mobile application, and to present and critique design decisions.'),
(73,'Virtualisation & Data Centre Management','This module introduces the foundations of virtualisation, and creating and managing virtual machines for cost efficiency and agility in delivering IT services. Hands-on sessions are included to give students practical experience in virtualisation tools such as Windows Server and VMWare. It will also explore the impact of virtualisation technologies on cloud database development. The module will then proceed to provide an understanding of basic data centre design principles, and physical infrastructure, and a framework for managing a data centre using appropriate tools. Tools and methods for usage metering and billing in a cloud environment are also covered in this module.'),
(74,'Web Application Development','This module provides students with the knowledge and skills needed to develop web applications and web application protocol interface (API). Students will be introduced to an integrated development environment that will enable them to design and develop web applications and web API over the Internet. They will learn how to make use of web development technologies such as ASP.NET framework, jQuery for rich internet applications, data interchange formats such as JSON AJAX, source code version control systems such as GIT or SVN to develop effective web applications, and web API targeting both mobile web and unified web experience. This module aims to provide students with a good understanding of the web development architecture and service layer as well as the various issues related to Web Application Development.'),
(75,'Web Application Pen-Testing','This module provides a thorough understanding of major web application vulnerabilities and their potential impact on people and organisations. The module teaches a repeatable web pen-testing methodology, which includes reconnaissance, mapping, discovery, and exploitation of web application vulnerabilities and flaws. Students are taught how to write a web application pen-test report. The module teaches students the pen-tester’s perspective of web applications. It trains students on building a profile of the machines that host the target web application and come up with a map of the web application’s pages and features. Students are also trained in web application attack tools and interception proxies that are used to discover and exploit key web application vulnerabilities.'),
(76,'World Issues: A Singapore Perspective','This module develops a student’s ability to think critically on world issues. Students will discuss a wide range of social, political and cultural issues from the Singapore perspective. It also looks at how city-state Singapore defied the odds and witnessed close to half a century of rapid economic growth, strong political ties and social harmony.'),
(77,'Technologies for Financial Industry','This module aims give opportunity the students who will be exposed to systems and technologies which are employed by financial organizations, including robotic process automiation (RPA).') ,
(78, 'Solution Design & Development', 'This module trains the students to view information systems from the perspective of business needs and participate in the design of IT solutions to solve the identified business problems. They will be exposed to work process such as Design Thinking that facilities problem identification to prototyping. Team work together to experience a real-life application development cycle. Elements of project management, automated testing and source version controls will be introducted in relevant phases of the application development cycle. Students will be exposed to current development; Agile.'), 
(79, 'Portfolio Development', 'This module provides students with the opportunity to apply the knowledge and skills gained from the various modules in the course to date, and explore topics in IT that they have a personal interest. Students may choose to undertake a real- life IT project, a competition- based project or a research and development project. The chosen project should result in the subsequent deliverable of artefacts that are suitable for their personal portfolios. Through the project, students have opportunities to work in teams, work on real-world problems, and build up their personal portfolios.'),
(80, 'Spreadsheet Engineering','The spreadsheet is an indispensable tool for professionals, especially in the banking and finance industry, to solve business problems and make better informed decisions. This module will introduce students to the use of spreadsheets as a reporting and modelling tool in the areas of business and finance. Through hands-on Excel practical sessions in class, students will explore various spreadsheet functions and simple macros used for analysing, formatting and presenting data. Students will also be equipped with an understanding of best practices in spreadsheet usage and design.'),
(81, 'Deep Learning', 'The students will learn the increasingly important field of artificial intelligence and neural networks.'),
(83, 'Machine Learning', 'With the introduction of Fundamentals Machine Learning and its Applications, the students will be provided the essential context and background knowledge of Machine Learning. They will gain exposure to both supervised and unsupervised learning models such as Linear & Logistic Regressopm, Decision Tree, K-means Clustering and more. Using leading software and associated libraries, they will be able to implements and train Machine Learning models to address business challenges.'),
(84, 'Advance Databases', 'This module covers analysis, design, and implementation of polygot persistence for modern software applications. Latest Key-Values, Document, Column-Oriented, Graph, Blob, and Queue storages in data storage methods and techniques will be discussed. Students will be exposed to de-normalisation transactions, concurrency control, and database recovery techniques. Stored Procedtures and how to migrate and deploy an on-premises database to a cloud database will be teach. Additional, parallel and distributed database technologies will be introduced. Factors relating to data partitioning and placement across regions will be discussed. The students will have hand-on practical activities using Microsoft Azure. This module will further explore data security, laws and regulations governing data access, usage, storage and transmission.'),
(85, 'DevOps', 'This module is mainly focus to teach the set of software development practices that automates the process between software development and IT operatins. Building upon their knowledge on agile methodology and software development, students will be taught how to leverage the concepts of continuous integration and continuous delivery (CI/CD) to deliver value faster. The module will provide hands-on practice for students to experience the CI/CD pipeline with the use of popular open-source tools.'),
(86, 'Data Visualization','This module discusses the techniques and algorithms for creating effective visualizations based on principles and techniques from graphic design, visual art, perceptual psychology and cognitive science. The students will using visualization in their own work, and building better visualization tools and systems. They are assessed by coursework and examination in this module.'),
(87, 'Distributed Ledger Technology','This module allows students to learn distributed ledger concepts and how these are being applied using industry use cases, which is a fundamental application of blockchain in Fintech. Opportunities given the students gain hands-on experience in blockchain prototypes and blockchain transactions to better understand the underlying concepts of blockchain.'),
(88, 'Data Wrangling', 'This module aims to equip the students with the tools and skills sets to handle, clean and prepare large curated data sets for data analytics purposes. They should minimally have basic programming knowledge and able to understand and decipher simple syntaxes. The processed data sets will allow for meaningful statistical analysis data modelling, and machine learning to be easily performed. Emphasis will be placed on the Extraction, Transformation and Loading (ETL) of data sets. Using the programming libraries for Missing and Time Series Data will be explored. The students will experience the process of exploratory data analysis, normalisation of data and data distribution, which be important for subsequence understanding of machine learning concepts and models.'),
(89, 'Final-Year Project', 'The Final Year Project is the culmination of the Immersive Media Diploma. It gives students a chance to demonstrate all they have learned. Although they are supervised, they will be defined the problem boundaries, investigate possible solutions and present the showcase.'),
(90, '6-Month Internship', 'The students will take 6-month Internship in order to gain relevant skills and experience in a particular field.'),
(91, 'Technopreneurship Innovation Programme', 'Similar to Technopreneurship concept, this module aim to teach the students about the issues, and challenges of transforming a technological innovation into a successful product or service in the market place.'),
(92, 'Secure Software Development','This module provides students with the knowledge of the secure software development lifecycle. It trains students to incorporate security throughout the entire process of software development. With the knowledge gained from this module, students would be able to design, code, test and deploy software with a security mindset. The module begins with training students on how to identify, gather and record security requirements for a software. Students will learn secure software design, where various security frameworks, considerations and methodologies are taught. Students will understand how software vulnerabilities can be exploited and how to address the risks. Students are trained to write secure code that is resilient against critical web application attacks. Finally, students are trained in secure software testing and how to securely deploy software.')
;

/*------ Project -------*/
INSERT INTO Project(project_id, project_name, project_desc, id) VALUES
/*------ Information Technology -------*/
(1, 'Patch', 'A mobile application that encourages interaction by matching them up with other elderly users who have similar hobbies and interests to  connect and socialize with new friends.', 1),
(2, 'Clip Go', 'Our team will be inventing a product that addresses the issues faced by working adults when using the Healthy 365 mobile application and HPB Steps Tracker, as well as the National Steps Challenge, to better suit the needs of its users. We brainstormed and integrated ideas on how to implement all users’ requirements into creating a product that works similarly to the Healthy 365 mobile application, the HPB Steps Tracker, as well as the National Steps Challenge.', 1),
(3, 'Purple Project', 'Work with Bethesda care to minimize manual processes by simplifying then with a few clicks. Through a website, we are trying to achieve higher productivity rates',1),
(4, 'Pincii','The module portfolio that the students of year 1 had showcase their creative works with Research & Development or Programming codes of Products. My partner and I decided to do a research & development project. ',1),

/*------ Financial Informatics -------*/
(5, '-', 'Team had to come up with a poster for our sales strategy within a simulation game; Enterprise Business Processes Assignment.',2),

/*------ Immersive Media -------*/
(6, 'KWSH Heritage Trail', 'Kwong Wai Shiu Hospital (KWSH) has a rich history of over 100 years since they first started and they would like to share the history to the public, especially to the younger generations. Our client, KWSH came to us with the problem where their heritage trail is too dry and heavy content, especially for children to young adults with short attention spans. Additionally, they hope that our application could be user friendly to elderlies as well. Therefore, with our application, different users will be able to learn the history of KWSH in a more fun and engaging way rather than just reading plain text in the heritage trail.',3),

/*------ Cybersecurity & Digital Forensics -------*/
(7, 'Honeypot', 'The aim of our honeypot is to deter attackers from accessing the actual network by creating a subnet and luring them there using fake devices. This is helpful as it will distract them, disrupt their breach progression and may even discourage the attacker from continuing with the attack.',4),
(8, 'OSSEC', 'For our Network Security assignment, we had to research on an Intrusion Detection/Prevention tool. The poster shows the main features of the IDS tool, OSSEC, and how these features can be used. I demonstrated how the features can be used and had put some test cases like detecting XSS attacks and Telnet remote Login attempts.',4),
(9, 'EBP', 'For our EBP assignment, we were required to come up with strategies to sell Muselli and manage the stocks in order to gain a profit. This poster shows an overview of the whole simulation.',4),
(10, 'Wazuh', 'Wazuh is a fork of OSSEC, which is an IDS that allows for the detection of potential threats by generating alerts. Such alerts are generated through rulesets which can be customised according to an organisation’s needs. This poster shows two examples of how Wazuh is able to detect two different kind of attacks.',4),

/*------ Common ICT Programme -------*/
(11, 'Patch','A mobile application that encourages interaction by matching them up with other elderly users who have similar hobbies and interests to  connect and socialize with new friends.', 5),
(12, '-','Team had to come up with a poster for our sales strategy within a simulation game; Enterprise Business Processes Assignment.',5),
(13,'KWSH Heritage Trail', 'Kwong Wai Shiu Hospital (KWSH) has a rich history of over 100 years since they first started and they would like to share the history to the public, especially to the younger generations. Our client, KWSH came to us with the problem where their heritage trail is too dry and heavy content, especially for children to young adults with short attention spans. Additionally, they hope that our application could be user friendly to elderlies as well. Therefore, with our application, different users will be able to learn the history of KWSH in a more fun and engaging way rather than just reading plain text in the heritage trail.',5),
(14,'Honeypot', 'The aim of our honeypot is to deter attackers from accessing the actual network by creating a subnet and luring them there using fake devices. This is helpful as it will distract them, disrupt their breach progression and may even discourage the attacker from continuing with the attack.',5)
;

/*------ ElectiveModule -------*/
INSERT INTO ElectiveModule(elective_id,module_id) VALUES

/*------ Banking & Finance (FI) -------*/
(1,67),(1,35),

/*------ Data Science & Analytics (IT, FI) -------*/
(2,10),(2,86),(2,66),(2,81),(2,83),(2,84),(2,85),(2,88),

/*------ Clouding Computing (IT) -------*/
(3,12),(4,24),(3,68),(3,73),(3,84),

/*------ Enterprise Solutioning & Marketing (IT, FI) -------*/
(4,16),(4,17),(4,32),(4,47),(4,77),(4,30),(4,72),(4,71),

/*------ Game Programming (IT) -------*/
(5,7),(5,41),(5,42),(5,43),(5,44),

/*------ Solution Architect (IT) -------*/
(6,19),(6,27),(6,54),(6,55),(6,69),(6,85),

/*------ General IT Electives (IT) -------*/
(7,28),(7, 26), (7,59),(7,71),(7,72),

/*------ Elective Module (CSF) -------*/
(8,45),(8,56),(8,57),(8,24),(8,54),(8,19),(8,81),(8,83);


/*------ CourseModule -------*/
INSERT INTO CourseModule(id, module_id, module_year) VALUES
/*------ Information Technology -------*/
(1, 7,'Elective'),(1, 10,'Elective'),(1, 11,'3'),(1, 12,'Elective'),(1, 13,'1'),(1,14,'1'),
(1, 17,'Elective'),(1, 18,'1'),(1, 19,'Elective'),(1, 20,'1'),(1, 21,'Elective'),
(1, 22,'1'),(1,24,'Elective'),(1,26,'Elective'),(1, 27,'Elective'),(1, 28,'Elective'),
(1, 29,'1'),(1, 31,'1'),(1,32,'Elective'),(1, 38,'1'),(1, 39,'2'),(1, 40,'2'),
(1, 41,'Elective'),(1, 42,'Elective'),(1, 43,'Elective'),(1, 47,'Elective'),
(1, 48,'1'),(1,50,'1'),(1, 51,'3'),(1, 53,'Elective'),(1, 54,'Elective'),
(1, 55,'Elective'),(1,59,'Elective'),(1, 60,'2'),(1, 61,'1'),(1, 63,'1'),
(1, 64,'1'),(1, 65,'3'),(1, 66,'Elective'),(1,68,'Elective'),(1, 69,'Elective'),
(1, 71,'Elective'),(1, 72,'Elective'),(1, 73,'Elective'),(1, 74,'2'),(1, 76,'2'),(1,77,'Elective'),(1,78,'2'),
(1,79, '2'), (1,80,'2'),(1,81,'Elective'),(1,83,'Elective'),(1,84,'Elective'),(1,85,'Elective'),

/*------ Financial Informatics -------*/
(2, 4,'1'),(2,5,'3'),(2,8,'2'),(2,9,'2'),(2,10,'Elective'),(2,11,'3'),
(2, 13,'1'),(2,14,'1'),(2,16,'Elective'),(2,17,'Elective'),(2, 18,'1'),
(2, 20, '1'), (2,21,'Elective'),(2, 22,'1'),(2, 29,'1'),(2,30,'Elective'),
(2,31,'1'),(2,32,'2'),(2,35,'Elective'),(2,36,'1'),(2,38,'1'),(2,39,'2'),
(2,40,'3'),(2,48,'1'),(2,51,'3'),(2,63,'1'),(2,64,'1'),(2,65,'3'),
(2,66,'Elective'),(2,67,'Elective'), (2, 71,'Elective'), (2,76,'2'),(2,77,'3'),(2,78,'2'),
(2,79,'2'),(2,80,'2'),(2,86,'2'),(2,87,'2'),(2,88, 'Elective'),

/*------ Immersive Media -------*/
(3,1,'2'),(3,2,'2'),(3,3,'1'),(3,6,'1'),(3,11,'3'),(3, 13,'1'),(3,14,'1'),
(3,18,'1'),(3, 22,'1'),(3,23,'2'),(3,25,'2'),(3, 29,'1'),(3,31,'1'),(3,34,'2'),
(3,38,'1'),(3,39,'2'),(3,40,'3'),(3,44,'1'),(3,46,'2'),(3,48,'1'),(3,49,'2'),
(3,50,'1'), (3,51,'3'),(3,62,'1'),(3,63,'1'),(3,65,'3'),(3,70,'2'),(3,71,'3'),
(3,76,'2'), (3, 89, '3'), (3, 90, '3'), (3, 91, '3'),

/*------ Cybersecurity & Digital Forensics -------*/
(4,11,'3'),(4, 13,'1'),(4,14,'1'),(4,15,'1'),(4,18,'1'),(4,19,'Elective'),
(4, 20, '1'),(4, 22,'1'),(4,24,'Elective'),(4,26,'2'),(4, 29,'1'),(4,31,'1'),(4,33,'3'),
(4,37,'1'),(4,38,'1'),(4,39,'2'),(4,40,'3'),(4,45,'Elective'),(4,48,'1'),(4,51,'3'),
(4,52,'2'),(4, 54,'Elective'),(4,56,'Elective'),(4,57,'Elective'),(4,58,'2'),(4,59,'2'),
(4,61,'1'),(4,63,'1'),(4,64,'1'),(4,65,'3'),(4,68,'2'),(4,75,'2'),(4,76,'2'),(4,92,'2'),

/*------ Common ICT Programme -------*/
(5,13,'1'),(5,14,'1'),(5,18,'1'),(5, 22,'1'),(5, 29,'1'),(5,31,'1'),(5,38,'1'),
(5,48,'1'),(5,63,'1'),

(5,1,'Elective'),(5,2,'Elective'),(5,3,'Elective'),(5,4,'Elective'),(5,5,'Elective'),
(5,6,'Elective'),(5,7,'Elective'),(5,8,'Elective'),(5,9,'Elective'),(5,10,'Elective'),
(5,11,'Elective'),(5,12,'Elective'),(5,15,'Elective'),(5,16,'Elective'),(5,19,'Elective'),
(5,20,'Elective'),(5,21,'Elective'),(5,23,'Elective'),(5,24,'Elective'),(5,25,'Elective'),
(5,26,'Elective'),(5,27,'Elective'),(5,28,'Elective'),(5,30,'Elective'),(5,31,'Elective'),
(5,32,'Elective'),(5,33,'Elective'),(5,34,'Elective'),(5,35,'Elective'),(5,36,'Elective'),
(5,37,'Elective'),(5,39,'Elective'),(5,40,'Elective'),(5,42,'Elective'),(5,43,'Elective'),
(5,44,'Elective'),(5,45,'Elective'),(5,46,'Elective'),(5,47,'Elective'),(5,49,'Elective'),
(5,50,'Elective'),(5,53,'Elective'),(5,54,'Elective'),(5,55,'Elective'),(5,56,'Elective'),
(5,57,'Elective'),(5,58,'Elective'),(5,59,'Elective'),(5,60,'Elective'),(5,61,'Elective'),
(5,64,'Elective'),(5,66,'Elective'),(5,67,'Elective'),(5,68,'Elective'),(5,69,'Elective'),
(5,70,'Elective'),(5,71,'Elective'),(5,72,'Elective'),(5,73,'Elective'),(5,74,'Elective'),
(5,75,'Elective'),(5,76,'Elective'),(5,77,'Elective');

/*------ Item (Courses) -------*/
INSERT INTO Item(item_id, item_path, item_type, course_id) VALUES
(1, 'assets/img/FI/BG_1.jpg', 'Image', '2'),
(2, 'assets/img/CIT/BG_1.jpg', 'Image', '5'),
(3, 'assets/img/IT/BG_1.jpg', 'Image', '1'),
(4, 'assets/img/IM/BG_1.jpg', 'Image', '3'),
(5, 'assets/img/CDF/BG_1.jpg', 'Image', '4'),
(6, 'assets/img/FI/BG_Card.png', 'Image', '2'),
(7, 'assets/img/CIT/BG_Card.png', 'Image', '5'),
(8, 'assets/img/IT/BG_Card.png', 'Image', '1'),
(9, 'assets/img/IM/BG_Card.png', 'Image', '3'),
(10, 'assets/img/CDF/BG_Card.png', 'Image', '4');

/*------ Item (Modules) -------*/
INSERT INTO Item(item_id, item_path, item_type, module_id) VALUES
(11,'assets/img/modules/3E_icon.png','Image','1'),
(12,'assets/img/modules/3R_icon.png','Image','2'),
(13,'assets/img/modules/3F_icon.png','Image','3'),
(14,'assets/img/modules/Accounting_icon.png','Image','4'),
(15,'assets/img/modules/AA_icon.png','Image','5'),
(16,'assets/img/modules/AD_icon.png','Image','6'),
(17,'assets/img/modules/AIG_icon.png','Image','7'),
(18,'assets/img/modules/BFP_icon.png','Image','8'),
(19,'assets/img/modules/BAP_icon.png','Image','9'),
(20,'assets/img/modules/BD_icon.png','Image','10'),
(21,'assets/img/modules/CP_icon.png','Image','11'),
(22,'assets/img/modules/CAT_icon.png','Image','12'),
(23,'assets/img/modules/CE_icon.png','Image','13'),
(24,'assets/img/modules/CM_icon.png','Image','14'),
(25,'assets/img/modules/Cryptography_icon.png','Image','15'),
(26,'assets/img/modules/CDMNS_icon.png','Image','16'),
(27,'assets/img/modules/CEM_icon.png','Image','17'),
(28,'assets/img/modules/CSF_icon.png','Image','18'),
(29,'assets/img/modules/DSA_icon.png','Image','19'),
(30,'assets/img/modules/Databases_icon.png','Image','20'),
(31,'assets/img/modules/DA_icon.png','Image','21'),
(32,'assets/img/modules/DP_icon.png','Image','22'),
(33,'assets/img/modules/DUX_icon.png','Image','23'),
(34,'assets/img/modules/DCA_icon.png','Image','24'),
(35,'assets/img/modules/DDA_icon.png','Image','25'),
(36,'assets/img/modules/DF_icon.png','Image','26'),
(37,'assets/img/modules/ECAD_icon.png','Image','27'),
(38,'assets/img/modules/ETI_icon.png','Image','28'),
(39,'assets/img/modules/ELE_icon.png','Image','29'),
(40,'assets/img/modules/EBP_icon.png','Image','30'),
(41,'assets/img/modules/EIS_icon.png','Image','31'),
(42,'assets/img/modules/ERP_icon.png','Image','32'),
(43,'assets/img/modules/EH_icon.png','Image','33'),
(44,'assets/img/modules/ED_icon.png','Image','34'),
(45,'assets/img/modules/FAM_icon.png','Image','35'),
(46,'assets/img/modules/FE_icon.png','Image','36'),
(47,'assets/img/modules/FED_icon.png','Image','37'),
(48,'assets/img/modules/FIP1_icon.png','Image','38'),
(49,'assets/img/modules/FIP2_icon.png','Image','39'),
(50,'assets/img/modules/FIP3_icon.png','Image','40'),
(51,'assets/img/modules/GI_icon.png','Image','42'),
(52,'assets/img/modules/GP_icon.png','Image','43'),
(53,'assets/img/modules/GPP_icon.png','Image','44'),
(54,'assets/img/modules/GC_icon.png','Image','44'),
(55,'assets/img/modules/GDP_icon.png','Image','45'),
(56,'assets/img/modules/ITD_icon.png','Image','46'),
(57,'assets/img/modules/ISMS_icon.png','Image','47'),
(58,'assets/img/modules/IMP_icon.png','Image','48'),
(59,'assets/img/modules/I3E_icon.png','Image','49'),
(60,'assets/img/modules/ID_icon.png','Image','50'),
(61,'assets/img/modules/IP_icon.png','Image','51'),
(62,'assets/img/modules/MATT_icon.png','Image','52'),
(63,'assets/img/modules/MG_icon.png','Image','53'),
(64,'assets/img/modules/MAD1_icon.png','Image','54'),
(65,'assets/img/modules/MAD2_icon.png','Image','55'),
(66,'assets/img/modules/MDSF_icon.png','Image','56'),
(77,'assets/img/modules/NF_icon.png','Image','57'),
(78,'assets/img/modules/NS_icon.png','Image','58'),
(79,'assets/img/modules/NI_icon.png','Image','59'),
(80,'assets/img/modules/OOAD_icon.png','Image','60'),
(81,'assets/img/modules/OSNF_icon.png','Image','61'),
(82,'assets/img/modules/PM_icon.png','Image','62'),
(83,'assets/img/modules/PRG1_icon.png','Image','63'),
(84,'assets/img/modules/PRG2_icon.png','Image','64'),
(85,'assets/img/modules/PICD_icon.png','Image','65'),
(86,'assets/img/modules/QA_icon.png','Image','66'),
(87,'assets/img/modules/RM_icon.png','Image','67'),
(88,'assets/img/modules/SCS_icon.png','Image','68'),
(89,'assets/img/modules/SE_icon.png','Image','69'),
(90,'assets/img/modules/STLD_icon.png','Image','70'),
(91,'assets/img/modules/Technopreneurship_icon.png','Image','71'),
(92,'assets/img/modules/UE_icon.png','Image','72'),
(93,'assets/img/modules/VDCM_icon.png','Image','73'),
(94,'assets/img/modules/WAD_icon.png','Image','74'),
(95,'assets/img/modules/WAPT_icon.png','Image','75'),
(96,'assets/img/modules/WISP_icon.png','Image','76'),
(97,'assets/img/modules/TFI_icon.png','Image','77'),
(98,'assets/img/modules/SSD_icon.png','Image','78'),
(99,'assets/img/modules/PD_icon.png','Image', '79'),
(100,'assets/img/modules/FSE_icon.png','Image', '80'),
(101,'assets/img/modules/DL_icon.png','Image', '81'),
(103,'assets/img/modules/ML_icon.png','Image', '83'),
(104,'assets/img/modules/ADa_icon.png','Image', '84'),
(105,'assets/img/modules/DevOps_icon.png','Image', '85'),
(106,'assets/img/modules/DV_icon.png','Image', '86'),
(107,'assets/img/modules/DLT_icon.png','Image', '87'),
(108,'assets/img/modules/DW_icon.png','Image','88'),
(109,'assets/img/modules/FYP_icon.png','Image','89'),
(110,'assets/img/modules/6I_icon.png','Image','90'),
(111,'assets/img/modules/TIP_icon.png','Image','91'),
(112,'assets/img/modules/SSD_icon.png','Image','92');

/*------ Item (Project) -------*/
INSERT INTO Item(item_id, item_path, item_type, Project_id) VALUES 
/*------ Information Technology-------*/
(113, 'assets/img/projects/IT1.png', 'Image', 1),
(114, 'assets/img/projects/IT2.jpg', 'Image', 2),
(115, 'assets/img/projects/IT3.png', 'Image', 3),
(116, 'assets/img/projects/IT3.png', 'Image', 4),

/*------ Financial Information-------*/
(117, 'assets/img/projects/FI1.jpg', 'Image', 5),

/*------ Immersive Media-------*/
(118, 'assets/img/projects/IM1.png', 'Image', 6),

/*------ Cybersecurity & Digital Forensics-------*/
(119, 'assets/img/projects/CSF1.png', 'Image', 7),
(120, 'assets/img/projects/CSF2.jpeg', 'Image', 8),
(121, 'assets/img/projects/CSF3.jpg', 'Image', 9),
(122, 'assets/img/projects/CSF4.jpg', 'Image', 10),

/*------ Common ICT-------*/
(123, 'assets/img/projects/IT1.png', 'Image', 11),
(124, 'assets/img/projects/FI1.jpg', 'Image', 12),
(125, 'assets/img/projects/IM1.png', 'Image', 13),
(126, 'assets/img/projects/CSF1.png', 'Image',14);

/*------ Item (Category) -------*/
INSERT INTO Item(item_id, item_path, item_type, category_id) VALUES 
(123, 'assets/img/category/coding.png', 'Image', 1), 
(124, 'assets/img/category/support.png', 'Image',2), 
(125, 'assets/img/category/cloud.png', 'Image',3), 
(126, 'assets/img/category/security.png', 'Image',4), 
(127, 'assets/img/category/interactivemedia.png', 'Image',5), 
(128, 'assets/img/category/gamedesigner.png', 'Image',6), 
(129, 'assets/img/category/3d.png', 'Image',7), 
(130, 'assets/img/category/digital.png', 'Image',8),
(131, 'assets/img/category/banking.png', 'Image',9), 
(132, 'assets/img/category/data.png', 'Image',10),
(133, 'assets/img/category/customer.png', 'Image',11), 
(134,'assets/img/category/enterprise.png', 'Image',12),
(135, 'assets/img/category/Infrastructure.png', 'Image',13), 
(136, 'assets/img/category/qa.png', 'Image',14), 
(137, 'assets/img/category/risk.png', 'Image',15), 
(138, 'assets/img/category/forensic.png', 'Image',16);

/*------ Modules with Jobs-------*/
INSERT INTO CategoryModule(category_id, module_id) VALUES
/*------ Information Technology-------*/
(1,12), (1,19), (1,20), (1,22), (1,23), (1,37), (1,25), (1,24), (1,27), (1,54), (1,55), (1,60), (1,63), (1,64), (1,74), (1,85), (1,92), (1,84),

(2,13), (2, 16), (2,17), (2,28), (2,30), (2,31),(2,32),(2,36),(2,45),(2,47),(2,71),(2,79),(2,80),(2,87),(2,91),

(3,12), (3,19), (3,20), (3,24), (3,25), (3,28), (3,30), (3,31),(3,32),(3,59),(3,61),(3,68),(3,67),(3,73),(3,83),

(4,12), (4,15), (4,18), (4,52), (4,19), (4,20), (4,26), (4,28), (4,33), (4,52), (4,56), (4,57), (4,58), (4,66),(4,67),(4,68),(4,75) ,(4,37), (4,25), (4,24), (4,27), (4,54), (4,55), (4,60), (4,63), (4,64), (4,74), (4,85), (4,92), (4,84),

(5,6), (5,20), (5,22), (5,23), (5,37), (5,25), (5,49), (5,24), (5,27), (5,54), (5,55), (5,60), (5,63), (5,64), (5,74), (5,85), (5,92), (5,84),

(6,1), (6,2), (6,3), (6,7),(6,14),(6,41),(6,42),(6,43),(6,44),(6,85),(6,69),(6,60),(6,72),

(7,1),(7,2),(7,3),(7,6),(7,22),(7,23),(7,34),(7,49),(7,72),

(8,1), (8,2), (8,3), (8,7),(8,14),(8,41),(8,42),(8,43),(8,44),(8,85),(8,69),(8,60),(8,72),

(9,4),(9,5),(9,8),(9,9),(9,10),(9,21),(9,35),(9,36),(9,47),(9,86),(9,87),

(10,10), (10,20), (10,21), (10,28), (10,32), (10,35), (10,86),(10,84),(10,88),

(11,13), (11, 16), (11,17), (11,28), (11,30), (11,31),(11,32),(11,36),(11,45),(11,47),(11,71),(11,79),(11,80),(11,87),(11,91),

(12,10), (12,20), (12,21), (12,28), (12,32), (12,35), (12,86),(12,84),(12,88),(12,13), (12, 16), (12,17), (12,28), (12,30), (12,31),(12,32),(12,36),(12,45),(12,47),(12,71),(12,79),(12,80),(12,87),(12,91),

(13,12),(13,15),(13,18),(13,24),(13,52),(13,58),(13,59),(13,68),
(14,12),(14,15),(14,18),(14,24),(14,33),(14,58),
(15,12),(15,15),(15,18),(15,24),(15,58),(15,59),(15,67),(15,68),
(16,12),(16,15),(16,18),(16,24),(16,26),(16,57),(16,58);





INSERT INTO FAQ(question_id,question_text,question_answer) VALUES
(1,'What are the internship opportunities if I enter this school?','Answer 1'),
(2,'What will the course structure of the school be like? What will I learn in (IT/FI/IM/CDF)?','Answer 2'),
(3,'What are the possible FYPs or Capstone Projects that students will be asked to do in the school?','Answer 3'),
(4,'What scholarship opportunities does your school offer?','Answer 4'),
(5,'What University degrees/courses will I be able to apply to after I graduate?','Answer 5'),
(6,'What are the Further Progression opportunities are there upon graduation?','Answer 6'),
(7,'Difference between games in IM and games in IT','Answer 7'),
(8,'Which course in the school should I enter?','Answer 8'),
(9,'why should i choose this school?','Answer 9');